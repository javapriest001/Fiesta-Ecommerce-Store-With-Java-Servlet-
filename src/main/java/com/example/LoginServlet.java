package com.example;

import Config.Db_Config;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
        String login = customerDAO.loginCustomer(email, password, request);
        if (login.equalsIgnoreCase("success")){
            response.sendRedirect("user/dashboard.jsp");
        }else if (login.equalsIgnoreCase("incorrect password")){
            response.sendRedirect("login.jsp");
        }
    }
}
