package DAO;

import Services.AdminServices;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import models.Product;
import models.User;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public String addProduct(Product product){
        String message = "";
        try{
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO products(name, price, description, category ,  avatar) VALUES (?,?,?,?,?)");
            preparedStatement.setString(1, product.getName());
            preparedStatement.setDouble(2, product.getPrice());
            preparedStatement.setString(3, product.getDesc());
            preparedStatement.setString(4, product.getCategory());
            preparedStatement.setString(5, product.getAvatar());
            int affectedRows = preparedStatement.executeUpdate();
            if ((affectedRows > 0)){
                message = "product added";
            }else {
                message = "error";
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return  message;
    }

    public boolean uploadFile(InputStream input , String path){
        boolean isUploaded = false;

        try{
            byte[] count = new byte[input.available()];
            input.read();
            FileOutputStream fileOutputStream = new FileOutputStream(path);
            fileOutputStream.write(count);
            fileOutputStream.flush();
            fileOutputStream.close();
            isUploaded = true;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return  isUploaded;
    }

    public List<Product> getAllProducts(String category){
        List<Product> productList = new ArrayList<>();
        try {
            PreparedStatement products = connection.prepareStatement("SELECT * FROM products WHERE category = ?");
            products.setString(1 , category);
            ResultSet resultSet = products.executeQuery();
            while(resultSet.next()){
                int productId = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                double price = resultSet.getDouble("price");
                String productCategory = resultSet.getString("category");
                String avatar = resultSet.getString("avatar");

                productList.add(new Product(productId, name , description , productCategory,  price , avatar));


            }
            return  productList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Product getSingle(int id){
        PreparedStatement products = null;
        Product product = null;
        try {
            products = connection.prepareStatement("SELECT * FROM products WHERE id = ?");
            products.setInt(1 , id);
            ResultSet resultSet = products.executeQuery();
            if (resultSet.next()){
                int productId = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                double price = resultSet.getDouble("price");
                String productCategory = resultSet.getString("category");
                String avatar = resultSet.getString("avatar");

                product = new Product(productId, name , description , productCategory,  price , avatar);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return product;
    }

    public boolean updateProduct(Product product){
        boolean isUpdated = false;
        PreparedStatement products = null;
        try {
            products = connection.prepareStatement("UPDATE products SET name = ?, price = ?, description = ? , category = ? , avatar = ?  WHERE id = ?");
            products.setString(1 , product.getName());
            products.setDouble(2 , product.getPrice());
            products.setString(3 , product.getDesc());
            products.setString(4 , product.getCategory());
            products.setString(5 , product.getAvatar());
            products.setInt(6 , product.getId());

            int affectedCol = products.executeUpdate();
            if(affectedCol > 0){
                isUpdated = true;
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdated;
    }
    public boolean deleteProduct(int id){
        boolean isDeleted = false;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE  FROM products WHERE id= ?");
            preparedStatement.setInt(1 , id);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0){
                isDeleted = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        return isDeleted;
    }
}
