<%@ page import="models.Product" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
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
            $(".removeCart").click(function (e) {
                e.preventDefault();
                let productId = this.getAttribute("data-bs");
                console.log(productId);

                $.ajax({
                    type : "POST",
                    url : "${pageContext.request.contextPath}/RemoveCartServlet",
                    data: {product_id : productId},

                    success: function (data) {
                        console.log($(".wishlist"));
                        window.alert("product Removed from cart")
                        location.reload();
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
                            <form action="${pageContext.request.contextPath}/CustomerLogoutServlet" method="GET">
                                <button class="btn btn-outline w-100"> Logout</button>
                            </form>

                        </div>
                    </div>


                </div>
            <li class="nav-item">
                <%
                    Map<Integer, Product> cartPI = (HashMap<Integer, Product>)request.getSession().getAttribute("cart");
                    int size = 0;
                    if(cartPI != null){
                        size = cartPI.size();
                    }
                %>
                <button class="btn btn-outline cart__button" type="submit"  data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"><i class="bi bi-basket2"></i>
                    <span class=" position-absolute  badge  rounded-pill bg-danger cart__item__count"> <%= size %> </span>
                </button>


            </li>
        </ul>
    </div>
</nav>

<%--Offcanvas for cart--%>


<div class="offcanvas offcanvas-end cart__body" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasRightLabel">Cart </h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">
        </button>
    </div>
    <div class="offcanvas-body">
        <%
            Map<Integer, Product> cartP = (HashMap<Integer, Product>)request.getSession().getAttribute("cart");
            int total = 0;
        %>
        <div class="container-fluid cart__container">
            <c:forEach var="carte" items="<%= cartP%>">
                <div class="card-body shadow-sm w-100">
                    <div class="row justify-content-space">
                        <div class="col-4">
                            <img src="${carte.value.avatar}" alt="" style="width: 100px ; height: 100px; ">
                        </div>
                        <div class="col-7">
                            <h6 class="">${carte.value.name}</h6>
                            <h6><span>Quantity: ${carte.value.productQty} |</span> Price : ${carte.value.price * carte.value.productQty}</h6>
                        </div>

                        <button data-bs="${carte.key}" class="removeCart" style="background-color: transparent; color: #060863; outline: none; border: none"><i class="bi bi-trash"></i></button>
                    </div>
                </div>
                <hr>
            </c:forEach>
        </div>
    </div>
</div>
