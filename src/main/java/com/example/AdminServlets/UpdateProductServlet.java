package com.example.AdminServlets;

import Config.Db_Config;
import DAO.AdminDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;

import java.io.IOException;
@MultipartConfig
@WebServlet(name = "UpdateProductServlet", value = "/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
       AdminDAO adminDAO = new AdminDAO(Db_Config.connection());

        Product product = adminDAO.getSingle(id);
        product.setId(id);
        product.setName(request.getParameter("name"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setDesc(request.getParameter("desc"));
        product.setCategory(request.getParameter("category"));
        product.setAvatar(request.getParameter("file"));
        boolean isUpdated = adminDAO.updateProduct(product);
        if (isUpdated){
            response.sendRedirect("admin/dashboard.jsp");
        }
    }
}
