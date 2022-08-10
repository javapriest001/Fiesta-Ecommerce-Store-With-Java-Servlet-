package com.example;

import Config.Db_Config;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;

import java.io.IOException;

@WebServlet(name = "ShowProductServlet", value = "/ShowProductServlet")
public class ShowProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
        Product product = customerDAO.getSingle(id);
        if (product != null){
            HttpSession session = request.getSession();
            session.setAttribute("product" , product);
            response.sendRedirect("user/product.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
