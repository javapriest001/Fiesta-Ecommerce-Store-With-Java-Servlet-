package Config;

import java.sql.*;

public class Db_Config {

//    public static void main(String[] args) {
//        try{
//
//            PreparedStatement stmt = connection().prepareStatement("SELECT  * FROM users");
//            System.out.println(stmt.executeQuery());
//        }catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//    }
    public static Connection connection(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn =  DriverManager.getConnection("jdbc:mysql://localhost:3307/fiesta" , "root" , "");
            return  conn;
        }catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

    }
}
