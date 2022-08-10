package com.example.AdminServlets;

import Config.Db_Config;
import DAO.AdminDAO;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;

import java.io.IOException;

@WebServlet(name = "AdminShowProductServlet", value = "/AdminShowProductServlet")
public class AdminShowProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        AdminDAO adminDAO = new AdminDAO(Db_Config.connection());
        Product product = adminDAO.getSingle(id);
        if (product != null){
            HttpSession session = request.getSession();
            session.setAttribute("adminProduct" , product);
            response.sendRedirect("admin/product.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
