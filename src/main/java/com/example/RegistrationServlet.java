package com.example;

import Config.Db_Config;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RegistrationServlet", value = "/registration-servlet")
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String avatar = request.getParameter("avatar");

        String register = customerDAO.registerCustomer(name, email , password , avatar);

        if (register.equalsIgnoreCase("registered")){
            response.sendRedirect("login.jsp");
        }else if (register.equalsIgnoreCase("user exists")){
           response.sendRedirect("index.jsp");
        }


    }
}
