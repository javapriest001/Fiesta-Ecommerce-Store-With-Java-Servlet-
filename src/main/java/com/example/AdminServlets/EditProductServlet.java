package com.example.AdminServlets;

import Config.Db_Config;
import DAO.AdminDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;

import java.io.IOException;

@WebServlet(name = "EditProductServlet", value = "/EditProductServlet")
public class EditProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("Edit servlet id:" + id);
        AdminDAO adminDAO = new AdminDAO(Db_Config.connection());
        Product product = adminDAO.getSingle(id);
        if (product != null){
            HttpSession session = request.getSession();
            System.out.println(product);
            session.setAttribute("editProduct" , product );
            response.sendRedirect("admin/editProduct.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}
