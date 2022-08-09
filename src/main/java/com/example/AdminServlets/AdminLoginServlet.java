package com.example.AdminServlets;

import Config.Db_Config;
import DAO.AdminDAO;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminLoginServlet", value = "/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        AdminDAO adminDAO = new AdminDAO(Db_Config.connection());
        String login = adminDAO.loginCustomer(username, password, request);
        if (login.equalsIgnoreCase("success")){
            response.sendRedirect("admin/dashboard.jsp");
        }else if (login.equalsIgnoreCase("incorrect password")){
            response.sendRedirect("admin/login.jsp");
        }
    }
}
