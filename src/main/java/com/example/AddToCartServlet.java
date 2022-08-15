package com.example;

import Config.Db_Config;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddToCartServlet", value = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("cart"));
        CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
        Map<Integer , Product> cart = customerDAO.addToCart(id);

            HttpSession session = request.getSession();
            session.setAttribute("cart" , cart);
            response.sendRedirect("user/dashboard.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
