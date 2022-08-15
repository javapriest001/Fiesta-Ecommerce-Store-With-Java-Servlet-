
<%@ page import="models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.AdminDAO" %>
<%@ page import="Config.Db_Config" %>
<%@ page import="DAO.CustomerDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@taglib prefix="" tagdir="" uri="" %>--%>
<%@taglib  uri ="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%
    int userId = (int) request.getSession().getAttribute("id");
    // User user = (User) request.getSession().getAttribute("user");
    CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
    List<Product> wishlists = customerDAO.getWishlists(userId);
    request.setAttribute("wishlist" , wishlists);
%>
<!DOCTYPE html>
<%@include file="includes/header.jsp" %>
<div class="container-fluid">
    <div class="row justify-content-space">
        <%@include file="includes/sidenav.jsp" %>
        <div class="col-md-9 mt-5">
            <div class="row justify-content-space mb-4">
                <div class="col-md-9">
                    <h6 class="text-muted">My Wishlist</h6>
                </div>
                <div class="col-md-3">
<%--                    <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="btn btn-primary">Add New Product</a>--%>
                </div>
            </div>
            <div class="row justify-content-space">
                <c:forEach var="product" items="${wishlist}">
                    <div class="col-md-4">
                        <div class="card product__card__avatar">
                            <div class="card-body">
                                <img src="${product.avatar}" class="card-img-top" alt="product">
                                <div class="row justify-content-space">
                                    <div class="col-9"><h6>${product.name}</h6></div>
                                </div>
                                <h5 class="text-muted mb-2">${product.price}</h5>
                                <div class="d-flex admin__action_container">

                                    <form id="deleteform${product.id}"  action="${pageContext.request.contextPath}/RemoveFromWishListServlet" method="POST">
                                        <input type="hidden" name="product_id" value="${product.id}">
                                        <input type="hidden" name="user_id" value="<%= request.getSession().getAttribute("id")%>">
<%--                                        <a  href="${pageContext.request.contextPath}/RemoveFromWishListServlet?id=${product.id}" onclick="confirm('Are You Sure You Want To Remove from Wishlist?!')" class=" admin__action text-muted" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Delete product"><i class="bi bi-trash"></i> </a>--%>

                                        <div class="col-3"><button class="deletewishlist" id="delete${product.id}"  data-bs-user-id="<%= request.getSession().getAttribute("id")%>" data-bs-product-id="${product.id}"  style="border: none; outline: none; background-color: transparent; color: red;" type="submit"> <i class="bi bi-trash"></i> </button></div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>
