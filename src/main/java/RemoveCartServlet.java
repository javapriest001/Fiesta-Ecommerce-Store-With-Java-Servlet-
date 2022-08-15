import Config.Db_Config;
import DAO.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import models.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "RemoveCartServlet", value = "/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("product_id"));
        CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
        Map<Integer, Product> cartP = (HashMap<Integer, Product>)request.getSession().getAttribute("cart");

        cartP = customerDAO.deleteFromCart(id, cartP);

    }
}
