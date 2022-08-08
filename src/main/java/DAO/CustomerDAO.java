package DAO;

import Services.CustomerServices;
import models.Customer;

import java.sql.*;

public class CustomerDAO implements CustomerServices {
    private Connection connection;
    private ResultSet result;
    private PreparedStatement statement;

    public CustomerDAO(Connection connection) {
        this.connection = connection;
    }


    @Override
    public String registerCustomer(String name, String email, String password, String avatar) {
        String message = "";
        try {
            PreparedStatement checkUser = connection.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkUser.setString(1, email);
            ResultSet user = checkUser.executeQuery();
            if (!user.next()){
                statement = connection.prepareStatement("INSERT into  users(name , email , password , avatar) VALUES (?,?,?,?) ");
                statement.setString(1, name);
                statement.setString(2, email);
                statement.setString(3, password);
                statement.setString(4, avatar);
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


}
