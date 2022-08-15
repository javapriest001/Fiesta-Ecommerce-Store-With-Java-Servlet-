package com.example.AdminServlets;

import Config.Db_Config;
import DAO.AdminDAO;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminRegisterServlet", value = "/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {
    @Override
    protected void  doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminDAO adminDAO = new AdminDAO(Db_Config.connection());
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String register = adminDAO.registerCustomer(name, username , password);
        // request.getRequestDispatcher("index.jsp").forward(request, response);
        if (register.equalsIgnoreCase("registered")){
            request.setAttribute("message" , register);
            response.sendRedirect("admin/login.jsp");
        }else if (register.equalsIgnoreCase("user exists")){
            request.setAttribute("message" , register);
            //   getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            response.sendRedirect("admin/index.jsp");
        }
    }
}
