
<%@ page import="models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.AdminDAO" %>
<%@ page import="Config.Db_Config" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@taglib prefix="" tagdir="" uri="" %>--%>


<%@taglib  uri ="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%

    // User user = (User) request.getSession().getAttribute("user");
    AdminDAO adminDAO = new AdminDAO(Db_Config.connection());
    List<Product> productList = adminDAO.getAllProducts("Console System");
    request.setAttribute("productList" , productList);

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
                <h6 class="welcome__text pt-3 me-1">Welcome Admin</h6>
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
                    <span class=" position-absolute  badge  rounded-pill bg-danger cart__item__count"> 1</span>
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
        ...
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
            <div class="row justify-content-space mb-4">
                <div class="col-md-9">
                    <h6 class="text-muted">Admin Dashboard</h6>
                </div>
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="btn btn-primary">Add New Product</a>
                </div>
            </div>
            <div class="row justify-content-space">
                <c:forEach var="product" items="${productList}">
                    <div class="col-md-4">
                        <div class="card product__card__avatar">
                            <div class="card-body">
                                <img src="${product.avatar}" class="card-img-top" alt="product">
                                <div class="row justify-content-space">
                                    <div class="col-9"><h6>${product.name}</h6></div>
                                </div>
                                <h5 class="text-muted mb-2">${product.price}</h5>
                                <div class="d-flex admin__action_container">
                                    <a href="${pageContext.request.contextPath}/AdminShowProductServlet?id=${product.id}" class="ms-5 me-2 admin__action text-muted" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="View Product"><i class="bi bi-eye-fill"> </i></a>
                                    <a href="${pageContext.request.contextPath}/EditProductServlet?id=${product.id}" class="me-2 admin__action text-muted" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Edit Product"><i class="bi bi-pencil-square"> </i> </a>
                                    <a  href="${pageContext.request.contextPath}/DeleteProductServlet?id=${product.id}" onclick="confirm('Are You Sure You Want To Delete This?!')" class=" admin__action text-muted" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Delete product"><i class="bi bi-trash"></i> </a>
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
