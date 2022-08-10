package DAO;

import Services.CustomerServices;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import models.Product;
import models.User;

import java.sql.*;
import java.util.*;

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

    public String loginCustomer(String email, String password , HttpServletRequest request){
        String message = "";
        try{
            PreparedStatement User = connection.prepareStatement("SELECT * FROM users WHERE email = ?");
            User.setString(1, email);
            ResultSet user = User.executeQuery();
            if (user.next()){
                if (user.getString("password").equalsIgnoreCase(password)){
                    models.User loggedInUser = new User(user.getString("name") , user.getString("email"), user.getString("password") , user.getString("avatar")  );
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("email" , loggedInUser.getEmail());
                    httpSession.setAttribute("id" , loggedInUser.getId());
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

//    public Optional<Product> getProduct(int id){
//        PreparedStatement checkUser = null;
//        Optional<Product> product = null;
//        try {
//            PreparedStatement singleProduct = connection.prepareStatement("SELECT * FROM products WHERE id = ?");
//            singleProduct.setInt(1, id);
//            ResultSet resultSet = singleProduct.executeQuery();
//            while(resultSet.next()){
//                int productId = resultSet.getInt("id");
//                String name = resultSet.getString("name");
//                String description = resultSet.getString("description");
//                double price = resultSet.getDouble("price");
//                String category = resultSet.getString("category");
//                String avatar = resultSet.getString("avatar");
//                product = Optional.of(new Product(productId, name , description , price , avatar));
//            }
//        return  product;
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//    }

    public  List<Product> getAllProducts(String category){
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
//    public HashMap<Integer , Product> addToCart(int id){
//        HashMap<Integer , Product> cart = new HashMap<>();
//        if (getProduct(id).isPresent()){
//            Optional<Product> product = getProduct(id);
//
//        }
//    }

}
