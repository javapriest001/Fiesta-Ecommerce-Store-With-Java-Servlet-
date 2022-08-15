package com.example.AdminServlets;

import Config.Db_Config;
import DAO.AdminDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DeleteProductServlet", value = "/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            int id = Integer.parseInt(request.getParameter("id"));
        AdminDAO adminDAO = new AdminDAO(Db_Config.connection());
        boolean isDeleted = adminDAO.deleteProduct(id);
        if(isDeleted){
            response.sendRedirect("admin/dashboard.jsp");
        }

    }
}
