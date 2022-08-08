<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    <%--    custom css--%>
    <link href="assets/app.css" rel="stylesheet">
    <%--    Icons Css--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<%--    Google Fonts--%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&family=Cookie&family=Oleo+Script+Swash+Caps:wght@400;700&family=Philosopher:ital,wght@0,400;0,700;1,400;1,700&family=Raleway:ital,wght@0,200;0,300;0,700;0,800;1,100;1,300;1,500;1,700&display=swap" rel="stylesheet">
    <title>Home| Fiesta</title>
    <style>
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand brand__name"> FIESTA <span class="brand__icon"><i class="bi bi-controller"></i></span></a>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="login.jsp">Login</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="index.jsp">Register</a>
            </li>
        </ul>
    </div>
</nav>
<div class="container-fluid  ">
    <div class="row justify-content-center mt-5 ">
        <div class="col-sm-9 align-items-center">
            <div class="card register__card">
                <div class="card-body">
                    <div class="row justify-content-center ">
                        <div class="col-md-4 align-items-center me-5">
                            <img class="register__card__image" src="assets/img/image_processing20211110-31697-onp92b.png" alt="console">
                        </div>
                        <div class="col-md-6 align-items-center mt-5">
                            <form>
                                <h3 class="text-center register__form__logo"><i class="bi bi-controller"></i></h3>
                                <h5 class="text-center text-muted">Welcome Back to The Console!!</h5>
                                <label for="email">Email</label>
                                <input type="email" id="email" class="form-control mb-2"  placeholder="Enter Your Email..." name="email" required>
                                <label for="password">Password</label>
                                <input type="password" id="password" class="form-control mb-2"  placeholder="Enter Your password..." name="password"  required>
                                <h6 class="text-danger">I am not yet a Fiestan! <span><a href="index.jsp">Register</a></span></h6>
                                <input type="submit" class="w-100 submit__button py-2 border-0 mt-3" value="Login to Console" >
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>
