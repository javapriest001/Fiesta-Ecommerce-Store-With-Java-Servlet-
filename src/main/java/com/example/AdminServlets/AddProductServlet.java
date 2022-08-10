package com.example.AdminServlets;

import Config.Db_Config;
import DAO.AdminDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@MultipartConfig
@WebServlet(name = "AddProductServlet", value = "/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filename = request.getParameter("file");
        String productName = request.getParameter("name");
        String description = request.getParameter("desc");
        double price = Double.parseDouble(request.getParameter("price"));
        String category = request.getParameter("category");


        AdminDAO adminDAO = new AdminDAO(Db_Config.connection());
        Product product = new Product();
        product.setName(productName);
        product.setDesc(description);
        product.setPrice(price);
        product.setCategory(category);
        product.setAvatar(filename);

            if (adminDAO.addProduct(product).equals("product added")){
                request.setAttribute("success" , "Successfully Added");
                response.sendRedirect("admin/addProduct.jsp");
            }

    }


}



