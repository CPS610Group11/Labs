import java.io.*;
import java.sql.*;
import java.util.Scanner;
class lab01
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
        String dbacct, passwrd, name;
        char grade;
        int credit;
        Scanner scanner = new Scanner(System.in);
        dbacct = readEntry("Enter database account: ", scanner);
        passwrd = readEntry("Enter password: ", scanner);
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:"+dbacct+"/"+passwrd+"@localhost:1521:xe");
        String stmt1 = "SELECT G.Grade, C.Credit_Hours From STUDENT S, GRADE_REPORT G, SECTION SEC, COURSES C WHERE G.Student_Number=S.Student_Number AND G.Section_Identifier=SEC.Section_Identifier AND SEC.Course_Number=C.Course_Number AND S.Name = ?";
        PreparedStatement p = conn.prepareStatement(stmt1);

        name = readEntry("Please enter your name: ", scanner);

        p.clearParameters();
        p.setString(1, name);
        ResultSet r = p.executeQuery();
        double count=0, sum=0, avg=0;
        
        while(r.next())
        {
            grade = r.getString(1).charAt(0);
            credit = r.getInt(2);
            switch (grade)
            {
                case 'A': sum=sum+(4*credit); count=count+1; break;
                case 'B': sum=sum+(3*credit); count=count+1; break;
                case 'C': sum=sum+(2*credit); count=count+1; break;
                case 'D': sum=sum+(1*credit); count=count+1; break;
                case 'F': sum=sum+(0*credit); count=count+1; break;
                default: System.out.println("This grade "+grade+" will not be calculated."); break;
            }
        };
        avg = sum/count;
        System.out.println("Student named "+name+" has a grade point average "+avg+".");
        r.close();
    }

    private static String readEntry(String prompt, Scanner scanner)
    {
        System.out.println(prompt);
        String output = scanner.nextLine();
        return output;
    }
}
