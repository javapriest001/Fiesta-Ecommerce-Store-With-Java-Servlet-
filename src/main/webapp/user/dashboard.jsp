<%@ page import="models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Product" %>
<%@ page import="DAO.CustomerDAO" %>
<%@ page import="Config.Db_Config" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib  uri ="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%

   // User user = (User) request.getSession().getAttribute("user");
    CustomerDAO customerDAO = new CustomerDAO(Db_Config.connection());
    List<Product> productList = customerDAO.getAllProducts("Console System");
    request.setAttribute("productList" , productList);
    if (request.getSession().getAttribute("id") == null){
        response.sendRedirect("login.jsp");

    }
   %>
<!DOCTYPE html>
<html>
<head>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    <%--    custom css--%>
    <link href="../assets/app.css" rel="stylesheet">
    <%--    Icons Css--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <%--Google Fonts--%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&family=Cookie&family=Oleo+Script+Swash+Caps:wght@400;700&family=Philosopher:ital,wght@0,400;0,700;1,400;1,700&family=Raleway:ital,wght@0,200;0,300;0,700;0,800;1,100;1,300;1,500;1,700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
                        console.log(data);

                    }
                })
            })
        })
    </script>
    <title>Home| Fiesta</title>
    <style>
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg shadow-sm">

    <div class="container-fluid aligns-items-center">
        <a class="navbar-brand brand__name"> FIESTA <span class="brand__icon"><i class="bi bi-controller"></i></span></a>
        <ul class="navbar-nav">
            <li class="nav-item">
                <h6 class="welcome__text pt-3 me-1">Welcome <%= request.getSession().getAttribute("email") %></h6>
            </li>
            <li class="nav-item me-2">
                <div class="dropdown-center ">
                    <button class="btn btn-outline cart__button rounded-pill  dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person"></i>
                    </button>

                    <div class="dropdown-menu shadow-sm  profile__dropdown  dropdown-menu-end ">
                        <div class="row justify-content-space ">
                            <div class="col-md-4">
                                <img src="../assets/img/avatar.png" alt="profile image " class="profile__image__avatar__dropdown mx-3">
                            </div>
                            <div class="col-md-6">
                                <ul class="profile__dropdown_list">
                                    <li><a class="dropdown-item mb-2" href="#">Wishlist</a></li>
                                    <li><a class="dropdown-item mb-3" href="#">Balance:  $1,000</a></li>
                                </ul>
                            </div>
                            <button class="btn btn-outline w-100"> Logout</button>
                        </div>
                    </div>


                </div>
            <li class="nav-item">
                <button class="btn btn-outline cart__button" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"><i class="bi bi-basket2"></i>
                    <span class=" position-absolute  badge  rounded-pill bg-danger cart__item__count"> </span>
                </button>
            </li>
        </ul>
    </div>
</nav>

<%--Offcanvas for cart--%>


<div class="offcanvas offcanvas-end cart__body" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">
        </button>
    </div>
    <div class="offcanvas-body">
        ....
    </div>
</div>


<div class="container-fluid">
    <div class="row justify-content-space">
        <div class="col-md-3">
            <aside>
                <ul class="navbar-nav mt-5 sidenav">
                    <li class="nav-item mb-3">
                        <a href="" class="nav-link d-flex">
                            <i class="bi bi-playstation me-3"></i>
                            <h6>Console System</h6>
                        </a>
                    </li>
                    <li class="nav-item mb-3">
                        <a href="" class="nav-link d-flex">
                            <i class="bi bi-disc me-3"></i>
                            <h6>Console CD</h6>
                        </a>
                    </li>
                    <li class="nav-item mb-3">
                        <a href="" class="nav-link d-flex">
                            <span><i class="bi bi-controller me-3"></i></span> <h6>Console Controllers</h6>
                        </a>
                    </li>
                    <li class="nav-item mb-3">
                        <a href="" class="nav-link d-flex">
                            <i class="bi bi-badge-4k me-3"></i>
                            <h6>Screens</h6>
                        </a>
                    </li>

                    <li class="nav-item mt-5 logout__sidenav">
                        <a href="" class="nav-link d-flex">
                            <i class="bi bi-indent me-3"></i>
                            <h6>Logout</h6>
                        </a>
                    </li>
                </ul>
            </aside>
        </div>
        <div class="col-md-9 mt-5">
            <div class="row justify-content-space">
                <c:forEach var="product" items="${productList}">
                    <div class="col-md-4">
                        <div class="card product__card__avatar">
                            <div class="card-body">
                                <img src="${product.avatar}" class="card-img-top" alt="product">
                                <div class="row justify-content-space">
                                    <div class="col-9"><h6><a style="text-decoration: none" href="${pageContext.request.contextPath}/ShowProductServlet?id=${product.id}">${product.name}</a></h6></div>
                                   <form action="${pageContext.request.contextPath}/WishlistServlet" method="POST">
                                       <input type="hidden" name="product_id" value="${product.id}">
                                       <input type="hidden" name="user_id" value="<%= request.getSession().getAttribute("id")%>">
                                       <div class="col-3"><button class="wishlist" data-bs-user-id="<%= request.getSession().getAttribute("id")%>" data-bs-product-id="${product.id}"  style="border: none; outline: none; background-color: transparent" type="submit"> <i class="bi bi-heart"></i></button></div>
                                   </form>
                                </div>
                                <h5 class="text-muted mb-2">${product.price}</h5>
                                <span><i class="bi bi-star-fill"></i> </span>   <span><i class="bi bi-star-fill"></i> </span>  <span><i class="bi bi-star-fill"></i> </span>   <span><i class="bi bi-star-fill"></i> </span>  <span><i class="bi bi-star-half"></i> </span>
                                <button type="submit" class="btn btn-outline w-100 mt-2" value="Add To Cart">Add To Cart</button>
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
