import java.io.*;
import java.sql.*;
import java.util.Scanner;
public class Lab04q2 {


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
        

        String stmtCheckLock = "SELECT * FROM Lock_Table WHERE Record = ?";
        String stmtAquireLock = "INSERT INTO Lock_Table VALUES (?, ?, ?)";

        // q2 //
        String stmtWrite = "UPDATE Records SET RecordValue = ? WHERE RecordIndex = ?";
        
        String stmtAquireLog = "INSERT INTO Log_Table VALUES (?, ?, ?, ?, ?, ?)";
        String stmtGetOldValue = "SELECT * FROM Records WHERE RecordIndex = ?";
        PreparedStatement pLog = conn.prepareStatement(stmtAquireLog);
        PreparedStatement PGetOldValue = conn.prepareStatement(stmtGetOldValue);
        //PreparedStatement pWrite = conn.prepareStatement(stmtWrite);
        // / / 

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

        Task[] transaction1Tasks = {new Task('W', 1, 5),new Task('R', 2),new Task('W', 2, 3), new Task('R', 1),new Task('C')};
        Transaction transaction1 = new Transaction(transaction1Tasks, 1);

        Task[] transaction2Tasks = {new Task('R', 1), new Task('W', 1, 2), new Task('C')};
        Transaction transaction2 = new Transaction(transaction2Tasks, 2);

        Transaction[] transactionList = {transaction1, transaction2};

        boolean moreWork = true;
        int countTasks = 0;

        while(moreWork)
        {
            moreWork = false;
            System.out.print("-------------------------------------------"); 
            for (Transaction transaction : transactionList)
            {
                while(transaction.currentTask < transaction.tasks.length)
                {
                    

                        if(transaction.tasks[transaction.currentTask].taskType == 'C'){
                            
                            
                            // pLog.setInt(3, 0);
                            // pLog.setInt(4, 0);
                            // pLog.setString(5, ("T"+Integer.toString(transaction.transactionNo)));
                            // pLog.setInt(6, (countTasks-1));
                            //pLog.executeQuery();
                            System.out.print("C: "); 
                            System.out.print(""+countTasks);
                            System.out.println(" T" + Integer.toString(transaction.transactionNo) + "  "+ ( countTasks-1));
                            System.out.println("Transaction " + Integer.toString(transaction.transactionNo) + " committed, releasing all locks.");
                            pReleaseAllLock.clearParameters();
                            pReleaseAllLock.setInt(1, transaction.transactionNo);
                            pReleaseAllLock.executeUpdate();
                            countTasks++;
                            transaction.currentTask += 1;

                        }else
                        {
                            // Saving record information into log_table
                            pLog.clearParameters();
                            //The TimeStampId:
                            pLog.setInt(1,countTasks);
                            // The RecordIndex
                            pLog.setInt(2, transaction.tasks[transaction.currentTask].recordIndex);
                            
                            // Geting the old value from the records Table.
                            PGetOldValue.clearParameters();
                            PGetOldValue.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                            ResultSet oldValue = PGetOldValue.executeQuery();
                            oldValue.next();
                            // The OldValue
                            pLog.setInt(3, oldValue.getInt(2));
                            

                            if(transaction.tasks[transaction.currentTask].taskType == 'R')
                            { 
                                System.out.print("R: ");
                                System.out.print(""+countTasks);
  
                                System.out.print(" T" + Integer.toString(transaction.transactionNo) );
                                System.out.print(" index " + Integer.toString(transaction.tasks[transaction.currentTask].recordIndex) );

                                pCheckLock.clearParameters();
                                pCheckLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                ResultSet rCheckLock = pCheckLock.executeQuery();

                                if(rCheckLock.next())
                                {
                                    if(rCheckLock.getString(2) == "shared")
                                    {
                                       // System.out.println("Record already has shared lock, proceeding with read.");

                                        pRead.clearParameters();
                                        pRead.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                        ResultSet rRead = pRead.executeQuery();
                                        rRead.next();
                                        //System.out.println("Record " + Integer.toString(rRead.getInt(1)) + " contains value: " + Integer.toString(rRead.getInt(2) ) );
                                        

                                        // Saving the value of the record into log table
                                        System.out.print(" value: " + Integer.toString(rRead.getInt(2) ));
                                        pLog.setInt(4, rRead.getInt(2) );
                                        //
                                        rRead.close();
                                        
                                    }
                                    else
                                    {   //if the lock owner is the same transaction -> proceede to read:
                                        if ( rCheckLock.getInt(3) == transaction.transactionNo  ){

                                            pRead.clearParameters();
                                            pRead.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                            ResultSet rRead = pRead.executeQuery();
                                            rRead.next();
                                            //System.out.println("Record " + Integer.toString(rRead.getInt(1)) + " contains value: " + Integer.toString(rRead.getInt(2)));
                                            
                                            // Saving the value of the record into log table
                                            System.out.print(" value: " + Integer.toString(rRead.getInt(2) ));
                                            pLog.setInt(4, rRead.getInt(2) );
                                            //
                                            rRead.close();
                                        }
                                    else{
                                        System.out.println("Record " + Integer.toString(transaction.tasks[transaction.currentTask].recordIndex) + " locked by transaction " + Integer.toString(rCheckLock.getInt(3)) + ", skipping transaction " + Integer.toString(transaction.transactionNo) + "'s task for this iteration.");
                                    } 
                                    }
                                }
                                else
                                {//when there is no lock on the record we put a shared lock and read
                                    pAquireLock.clearParameters();
                                    pAquireLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                    pAquireLock.setString(2, "shared");
                                    pAquireLock.setInt(3, transaction.transactionNo);

                                    pAquireLock.executeUpdate();

                                    pRead.clearParameters();
                                    pRead.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                    ResultSet rRead = pRead.executeQuery();
                                    rRead.next();

                                    // Saving the value of the record into log table
                                    System.out.print(" value " + Integer.toString(rRead.getInt(2) ));
                                    pLog.setInt(4, rRead.getInt(2) );
                                    // in R -> if newvalue = old value then only show one of them
                                    rRead.close();
                                    
                                }

                                rCheckLock.close();
                            }
                            else if(transaction.tasks[transaction.currentTask].taskType == 'W')
                            {   System.out.print("W: ");
                                System.out.print(""+countTasks);
                                System.out.print(" T" + Integer.toString(transaction.transactionNo) );
                                System.out.print(" index:" + Integer.toString(transaction.tasks[transaction.currentTask].recordIndex) );
                                System.out.print(" value: " + Integer.toString( oldValue.getInt(2) ));

                                pCheckLock.clearParameters();
                                pCheckLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                ResultSet rCheckLock = pCheckLock.executeQuery();

                                if(rCheckLock.next())
                                {
                                    if(rCheckLock.getInt(3) == transaction.transactionNo)
                                    {
                                        if(rCheckLock.getString(2).equalsIgnoreCase("shared"))
                                        {
                                            //System.out.println("Transaction has shared lock for record, upgrading to exclusive.");

                                            pUpgradeLock.clearParameters();
                                            pUpgradeLock.setInt(1, transaction.tasks[transaction.currentTask].recordIndex);
                                            pUpgradeLock.executeUpdate();
                                        }
                                    // System.out.println("Transaction has exclusive lock on record, writing value.");

                                        pWrite.clearParameters();
                                        pWrite.setInt(1, transaction.tasks[transaction.currentTask].recordValue);
                                        pWrite.setInt(2, transaction.tasks[transaction.currentTask].recordIndex);
                                        pWrite.executeUpdate();


                                        //Saving New value into the Log_table
                                        pLog.setInt(4,transaction.tasks[transaction.currentTask].recordValue);
                                        System.out.print(" new " + Integer.toString(transaction.tasks[transaction.currentTask].recordValue) );
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

                                    pAquireLock.executeUpdate();

                                    pWrite.clearParameters();
                                    pWrite.setInt(1, transaction.tasks[transaction.currentTask].recordValue);
                                    pWrite.setInt(2, transaction.tasks[transaction.currentTask].recordIndex);
                                    pWrite.executeUpdate();

  
                                    // Saving the value->newValueof in log table
                                    pLog.setInt(4,transaction.tasks[transaction.currentTask].recordValue);
                                    System.out.print(" new: " + Integer.toString(transaction.tasks[transaction.currentTask].recordValue) );
                                        // 
                                     oldValue.close();
                                }

                                rCheckLock.close();
                            }

                        
                            moreWork = true;
                            pLog.setInt(5, transaction.transactionNo);
                            
                            pLog.setInt(6, ( countTasks-1));
                            System.out.print(" prT: " + ( countTasks-1));
                            countTasks++;
                            System.out.println("  ");
                            pLog.executeQuery();
                            //pLog.close();

                            transaction.currentTask += 1;

                        }
                    
                }

                    
                    System.out.println("Transaction " + transaction.transactionNo + " is out of tasks. Moving on to next transaction.");
                
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