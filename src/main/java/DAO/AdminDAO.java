package DAO;

import Services.AdminServices;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import models.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO implements AdminServices {
    private Connection connection;
    private ResultSet result;
    private PreparedStatement statement;

    public AdminDAO(Connection connection) {
        this.connection = connection;
    }


    public String registerCustomer(String name, String username, String password) {

        String message = "";
        try {
            PreparedStatement checkUser = connection.prepareStatement("SELECT * FROM admin WHERE username = ?");
            checkUser.setString(1, username);
            ResultSet user = checkUser.executeQuery();
            if (!user.next()){
                statement = connection.prepareStatement("INSERT into  admin(name , username , password ) VALUES (?,?,?) ");
                statement.setString(1, name);
                statement.setString(2, username);
                statement.setString(3, password);
                int resultCount = statement.executeUpdate();
                if (resultCount > 0){
                    message = "registered";
                }else {
                    message = "failed";
                }
            }else{
                message = "user exists";
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return message;
    }

    public String loginCustomer(String username, String password , HttpServletRequest request){
        String message = "";
        try{
            PreparedStatement User = connection.prepareStatement("SELECT * FROM admin WHERE username = ?");
            User.setString(1, username);
            ResultSet user = User.executeQuery();
            if (user.next()){
                if (user.getString("password").equalsIgnoreCase(password)){
                    models.User loggedInUser = new User(user.getString("name") , user.getString("username"), user.getString("password"));
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("user" , loggedInUser);
                    message = "success";
                }else {
                    message = "incorrect password";
                }
            }else {
                message = "user not found";
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return  message;
    }
}
