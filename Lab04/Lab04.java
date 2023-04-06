import java.io.*;
import java.sql.*;
import java.util.Scanner;
class Lab04
{
    public static void main (String args[]) throws SQLException, IOException
    {
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }
        catch (ClassNotFoundException x)
        {
            System.out.println("Driver could not be loaded.");
        }
        String dbacct, passwrd;
        Scanner scanner = new Scanner(System.in);
        dbacct = readEntry("Enter database account: ", scanner);
        passwrd = readEntry("Enter password: ", scanner);
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:"+dbacct+"/"+passwrd+"@localhost:1521:xe");

        String stmtRead = "SELECT * FROM Records WHERE RecordIndex = ?";
        String stmtWrite = "UPDATE Records SET RecordValue = ? WHERE RecordIndex = ?";

        String stmtCheckLock = "SELECT * FROM Lock_Table WHERE Record = ?";
        String stmtAquireLock = "INSERT INTO Lock_Table VALUES (?, ?, ?)";
        String stmtUpgradeLock = "UPDATE Lock_Table SET LockType = 'exclusive' WHERE Record = ?";
        String stmtReleaseLock = "DELETE FROM Lock_Table WHERE Record = ?";
        String stmtReleaseAllLock = "DELETE FROM Lock_Table WHERE LockOwner = ?";
        
        PreparedStatement pRead = conn.prepareStatement(stmtRead);
        PreparedStatement pWrite = conn.prepareStatement(stmtWrite);

        PreparedStatement pCheckLock = conn.prepareStatement(stmtCheckLock);
        PreparedStatement pAquireLock = conn.prepareStatement(stmtAquireLock);
        PreparedStatement pUpgradeLock = conn.prepareStatement(stmtUpgradeLock);
        PreparedStatement pReleaseLock = conn.prepareStatement(stmtReleaseLock);
        PreparedStatement pReleaseAllLock = conn.prepareStatement(stmtReleaseAllLock);

        Task[] transaction1Tasks = {new Task('W', 1, 5), new Task('C')};
        Transaction transaction1 = new Transaction(transaction1Tasks, 1);

        Task[] transaction2Tasks = {new Task('R', 9), new Task('R', 7), new Task('C')};
        Transaction transaction2 = new Transaction(transaction2Tasks, 2);

        Task[] transaction3Tasks = {new Task('R', 1), new Task('C')};
        Transaction transaction3 = new Transaction(transaction3Tasks, 3);

        Transaction[] transactionList = {transaction1, transaction2, transaction3};

        boolean moreWork = true;

        while(moreWork)
        {
            moreWork = false;
            for (Transaction transaction : transactionList)
            {
                if(transaction.currentTask < transaction.tasks.length)
                {
                    if(transaction.tasks[transaction.currentTask].taskType == 'R')
                    {
                        pCheckLock.clearParameters();
                        pCheckLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                        ResultSet rCheckLock = pCheckLock.executeQuery();

                        if(rCheckLock.next())
                        {
                            if(rCheckLock.getString(2) == "shared")
                            {
                                System.out.println("Record already has shared lock, proceeding with read.");

                                pRead.clearParameters();
                                pRead.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);

                                ResultSet rRead = pRead.executeQuery();
                                rRead.next();
                                System.out.println("Record " + Integer.toString(rRead.getInt(1)) + " contains value: " + Integer.toString(rRead.getInt(2)));
                                rRead.close();

                                transaction.currentTask += 1;
                            }
                            else
                            {
                                System.out.println("Record " + Integer.toString(transaction.tasks[transaction.currentTask].recordIndex) + " locked by transaction " + Integer.toString(rCheckLock.getInt(3)) + ", skipping transaction " + Integer.toString(transaction.transactionNo) + "'s task for this iteration.");
                            }
                        }
                        else
                        {
                            pAquireLock.clearParameters();
                            pAquireLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                            pAquireLock.setString(2, "shared");
                            pAquireLock.setInt(3, transaction.transactionNo);

                            System.out.println("Transaction " + Integer.toString(transaction.transactionNo) + " aquiring shared lock on record " + transaction.tasks[transaction.currentTask].recordIndex);
                            pAquireLock.executeUpdate();

                            pRead.clearParameters();
                            pRead.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);

                            ResultSet rRead = pRead.executeQuery();
                            rRead.next();
                            System.out.println("Record " + Integer.toString(rRead.getInt(1)) + " contains value: " + Integer.toString(rRead.getInt(2)));
                            rRead.close();

                            transaction.currentTask += 1;
                        }

                        rCheckLock.close();
                    }
                    else if(transaction.tasks[transaction.currentTask].taskType == 'W')
                    {
                        pCheckLock.clearParameters();
                        pCheckLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                        ResultSet rCheckLock = pCheckLock.executeQuery();

                        if(rCheckLock.next())
                        {
                            if(rCheckLock.getInt(3) == transaction.transactionNo)
                            {
                                if(rCheckLock.getString(2) == "shared")
                                {
                                    System.out.println("Transaction has shared lock for record, upgrading to exclusive.");

                                    pUpgradeLock.clearParameters();
                                    pUpgradeLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                    pUpgradeLock.executeUpdate();
                                }
                                System.out.println("Transaction has exclusive lock on record, writing value.");

                                pWrite.clearParameters();
                                pWrite.setInt(1, transaction.tasks[transaction.currentTask].recordValue);
                                pWrite.setInt(2, transaction.tasks[transaction.currentTask].recordIndex);
                                pWrite.executeUpdate();

                                System.out.println("Value " + Integer.toString(transaction.tasks[transaction.currentTask].recordValue) + " written to record at index " + Integer.toString(transaction.tasks[transaction.currentTask].recordIndex) + ".");

                                transaction.currentTask += 1;
                            }
                            else
                            {
                                System.out.println("Record " + Integer.toString(transaction.tasks[transaction.currentTask].recordIndex) + " locked by transaction " + Integer.toString(rCheckLock.getInt(3)) + ", skipping transaction " + Integer.toString(transaction.transactionNo) + "'s task for this iteration.");
                            }
                        }
                        else
                        {
                            pAquireLock.clearParameters();
                            pAquireLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                            pAquireLock.setString(2, "exclusive");
                            pAquireLock.setInt(3, transaction.transactionNo);

                            System.out.println("Transaction " + Integer.toString(transaction.transactionNo) + " aquiring exclusive lock on record " + transaction.tasks[transaction.currentTask].recordIndex);
                            pAquireLock.executeUpdate();

                            pWrite.clearParameters();
                            pWrite.setInt(1, transaction.tasks[transaction.currentTask].recordValue);
                            pWrite.setInt(2, transaction.tasks[transaction.currentTask].recordIndex);
                            pWrite.executeUpdate();

                            System.out.println("Value " + Integer.toString(transaction.tasks[transaction.currentTask].recordValue) + " written to record at index " + Integer.toString(transaction.tasks[transaction.currentTask].recordIndex) + ".");

                            transaction.currentTask += 1;
                        }

                        rCheckLock.close();
                    }
                    else if(transaction.tasks[transaction.currentTask].taskType == 'C')
                    {
                        System.out.println("Transaction " + Integer.toString(transaction.transactionNo) + " committed, releasing all locks.");

                        pReleaseAllLock.clearParameters();
                        pReleaseAllLock.setInt(1, transaction.transactionNo);
                        pReleaseAllLock.executeUpdate();

                        transaction.currentTask += 1;
                    }
                    
                    moreWork = true;
                }
                else
                {
                    System.out.println("Transaction " + transaction.transactionNo + " is out of tasks. Moving on to next transaction.");
                }
            }
        }

        System.out.println("All transactions completed!");
    }

    private static String readEntry(String prompt, Scanner scanner)
    {
        System.out.println(prompt);
        String output = scanner.nextLine();
        return output;
    }
}

class Transaction
{
    public Task[] tasks;
    public int currentTask;
    public int transactionNo;

    public Transaction(Task[] tasks, int transactionNo)
    {
        this.tasks = tasks;
        this.currentTask = 0;
        this.transactionNo = transactionNo;
    }
}

class Task
{
    public char taskType;
    public int recordIndex;
    public int recordValue;

    public Task(char taskType)
    {
        this.taskType = taskType;
    }

    public Task(char taskType, int recordIndex)
    {
        this.taskType = taskType;
        this.recordIndex = recordIndex;
    }

    public Task(char taskType, int recordIndex, int recordValue)
    {
        this.taskType = taskType;
        this.recordIndex = recordIndex;
        this.recordValue = recordValue;
    }
}