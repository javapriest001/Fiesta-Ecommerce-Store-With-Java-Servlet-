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
    public String loginCustomer(String email, String password , HttpServletRequest request) {
        String message = "";
        try{
            PreparedStatement User = connection.prepareStatement("SELECT * FROM users WHERE email = ?");
            User.setString(1, email);
            ResultSet user = User.executeQuery();
            if (user.next()){
                if (user.getString("password").equalsIgnoreCase(password)){
                    models.User loggedInUser = new User(user.getInt("id") , user.getString("name") , user.getString("email"), user.getString("password") , user.getString("avatar") );
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

    public void addWishlist(int userId, int productId){
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO wishlist(user_id , product_id) VALUES(?,?) ");
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, productId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public boolean addToWishList(int user_id, int product_id){
        boolean isAdded = false;
        try {
            PreparedStatement duplicateEntry = connection.prepareStatement("SELECT * FROM wishlist WHERE user_id = ? AND product_id = ?");
            duplicateEntry.setInt(1, user_id);
            duplicateEntry.setInt(2, product_id);
            ResultSet resultSet = duplicateEntry.executeQuery();
            if (!resultSet.next()){
                PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO wishlist(user_id , product_id) VALUES(?,?)");
                preparedStatement.setInt(1, user_id);
                preparedStatement.setInt(2, product_id);
                preparedStatement.executeUpdate();
                isAdded =  preparedStatement.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return  isAdded;
    }
    public List<Product> getWishlists(int id){
        PreparedStatement wishlistProduct = null;
        List<Product> wishlist = new ArrayList<>();
        try {
            wishlistProduct = connection.prepareStatement("SELECT products.id , products.name, products.description , products.price , products.category , products.avatar FROM wishlist INNER JOIN products ON wishlist.product_id = products.id WHERE user_id = ?");
            wishlistProduct.setInt(1, id);
            ResultSet resultSet = wishlistProduct.executeQuery();
            while (resultSet.next()){
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDesc(resultSet.getString("description"));
                product.setPrice(Double.parseDouble(resultSet.getString("price")));
                product.setAvatar(resultSet.getString("avatar"));
                product.setCategory(resultSet.getString("category"));
                wishlist.add(product);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return wishlist;
    }

    public boolean removeWishList(int user_id, int product_id){
        boolean isDeleted = false;
        String query = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
        PreparedStatement singleProduct = null;
        try {
            singleProduct = connection.prepareStatement(query);
            singleProduct.setInt(1, user_id);
            singleProduct.setInt(2, product_id);
            int resultSet = singleProduct.executeUpdate();
            isDeleted = resultSet >0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return isDeleted;
    }

    public  List<Product> getAllProducts(String category) {
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

    public int findIndex(Product product, List<Product> cart){
        int index = -1;
        for (Product productInCart : cart){
            if (cart.contains(productInCart)){
                index = cart.indexOf(productInCart);
            }
        }
        return  index;
    }
    public  Map<Integer, Product> addToCart(int id){

        try {
            PreparedStatement cart = connection.prepareStatement("SELECT * FROM products WHERE id = ?");
            cart.setInt(1, id);
            ResultSet cartList = cart.executeQuery();
            while(cartList.next()){
                Product product = new Product();
                product.setId(cartList.getInt("id")); ;
                product.setName(cartList.getString("name"));
                product.setPrice(cartList.getDouble("price"));
                product.setDesc(cartList.getString("description"));
                product.setAvatar( cartList.getString("avatar"));
                product.setProductQty(1);

                if (User.cart.containsKey(cartList.getInt("id"))){
                    Product duplicate = User.cart.get(cartList.getInt("id"));
                    duplicate.setProductQty(duplicate.getProductQty() + 1);
                }else{
                    User.cart.put(cartList.getInt("id") , product);
                }


            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return User.cart;
    }

    public Map<Integer, Product> deleteFromCart(int id ,  Map<Integer, Product> cart){
        cart.remove(id);
        return cart;
    }

    public boolean findWishlist(int user_id, int product_id){
        boolean isAvailable = false;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM wishlist where user_id = ? AND product_id = ?");
            preparedStatement.setInt(1, user_id);
            preparedStatement.setInt(2, product_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                isAvailable = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isAvailable;
    }
}
