
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

    // User user = (User) request.getSession().getAttribute("user");
    CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
    List<Product> productList = customerDAO.getAllProducts("Console Controllers");
    request.setAttribute("productList" , productList);

%>
<!DOCTYPE html>


<%@include file="includes/header.jsp" %>

<script>
    $(document).ready(function () {
        $(".wishlist").click(function (e) {
            e.preventDefault();
            let userId = this.getAttribute("data-bs-user-id");
            let productId = this.getAttribute("data-bs-product-id");
            console.log(userId);
            console.log(productId);

            $.ajax({
                type : "POST",
                url : "${pageContext.request.contextPath}/WishlistServlet",
                data: {user_id : userId , product_id : productId},

                success: function (data) {
                    console.log($(".wishlist"));


                    sessionStorage.setItem("add"+productId , ""+productId);
                    sessionStorage.removeItem("delete"+productId);
                    let added = sessionStorage.getItem("add"+productId );
                    console.log(added)
                    if (added != null){
                        $("#deleteform"+productId).css("display" , "block")
                        $("#addform"+productId).css("display" , "none");
                    }
                }
            })
        })
        $(".deletewishlist").click(function (e) {
            e.preventDefault();
            let userId = this.getAttribute("data-bs-user-id");
            let productId = this.getAttribute("data-bs-product-id");
            console.log(userId);
            console.log(productId);

            $.ajax({
                type : "POST",
                url : "${pageContext.request.contextPath}/RemoveFromWishListServlet",
                data: {user_id : userId , product_id : productId},

                success: function (data) {
                    sessionStorage.setItem("delete"+productId , ""+productId);
                    sessionStorage.removeItem("add"+productId);
                    let deleted = sessionStorage.getItem("delete"+productId );
                    console.log(deleted);
                    if (deleted != null){
                        $("#deleteform"+productId).css("display" , "none")
                        $("#addform"+productId).css("display" , "block");
                    }

                }
            })
        })
    })
</script>
<div class="container-fluid">
    <div class="row justify-content-space">
        <%@include file="includes/sidenav.jsp" %>

        <div class="col-md-9 mt-5">
            <div class="row justify-content-space mb-4">
                <div class="col-md-9">
                    <h6 class="text-muted">Controllers</h6>
                </div>
                <div class="col-md-3">

                </div>
            </div>
            <div class="row justify-content-space">
                <c:forEach var="product" items="${productList}">
                    <div class="col-md-4">
                        <div class="card product__card__avatar">
                            <div class="card-body">
                                <img src="${product.avatar}" class="card-img-top" alt="product">
                                <div class="row justify-content-space">
                                    <div class="col-9"><h6><a style="text-decoration: none" href="${pageContext.request.contextPath}/ShowProductServlet?id=${product.id}">${product.name}</a></h6></div>
                                    <form id="addform${product.id}" action="${pageContext.request.contextPath}/WishlistServlet" method="POST">
                                        <input type="hidden" name="product_id" value="${product.id}">
                                        <input type="hidden" name="user_id" value="<%= request.getSession().getAttribute("id")%>">
                                        <div class="col-3"><button class="wishlist" id="${product.id}"  data-bs-user-id="<%= request.getSession().getAttribute("id")%>" data-bs-product-id="${product.id}"  style="border: none; outline: none; background-color: transparent" type="submit"> <i class="bi bi-heart"></i></button></div>
                                    </form>
                                    <form id="deleteform${product.id}" style="display: none" action="${pageContext.request.contextPath}/DeleteProductServlet" method="POST">
                                        <input type="hidden" name="product_id" value="${product.id}">
                                        <input type="hidden" name="user_id" value="<%= request.getSession().getAttribute("id")%>">
                                        <div class="col-3"><button class="deletewishlist" id="delete${product.id}"  data-bs-user-id="<%= request.getSession().getAttribute("id")%>" data-bs-product-id="${product.id}"  style="border: none; outline: none; background-color: transparent; color: red;" type="submit"> <i class="bi bi-heart-fill"></i></button></div>
                                    </form>
                                </div>
                                <h5 class="text-muted mb-2">${product.price}</h5>
                                <span><i class="bi bi-star-fill"></i> </span>   <span><i class="bi bi-star-fill"></i> </span>  <span><i class="bi bi-star-fill"></i> </span>   <span><i class="bi bi-star-fill"></i> </span>  <span><i class="bi bi-star-half"></i> </span>
                                <form method="GET" action="${pageContext.request.contextPath}/AddToCartServlet">
                                    <input type="hidden" name="cart" value="${product.id}">
                                    <button type="submit" class="btn btn-outline w-100 mt-2" value="Add To Cart">Add To Cart</button>
                                </form>
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


