
<%@ page import="models.User" %>
<%@ page import="models.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%

    Product product = (Product) request.getSession().getAttribute("editProduct");

%>

<!DOCTYPE html>
<%@include file="includes/header.jsp" %>


<div class="container-fluid">
    <div class="row justify-content-space">
        <%@include file="includes/sidenav.jsp" %>
        <div class="col-md-9 mt-5">
            <div class="row justify-content-space">
                <div class="col-sm-9 align-items-center">
                    <div class="card register__card">
                        <div class="card-body">
                            <div class="row justify-content-center ">
                                <div class="col-md-6 align-items-center mt-3">
                                    <form method="POST" action="${pageContext.request.contextPath}/UpdateProductServlet" enctype="multipart/form-data">
                                        <input type="hidden"  class="form-control mb-2" value="<%= product.getId()%>"  placeholder="Enter Product name..." name="id" required>
                                        <label for="name">Product Name</label>
                                        <input type="text" id="name" class="form-control mb-2" value="<%= product.getName()%>"  placeholder="Enter Product name..." name="name" required>
                                        <label for="desc">Product Description</label>
                                        <textarea  rows="4" cols="50" maxlength="200" id="desc" class="form-control mb-2"  placeholder="Enter Your password..." name="desc"  required><%= product.getDesc()%></textarea>
                                        <label for="price">Product Price</label>
                                        <input type="number" id="price" class="form-control mb-2"  value="<%= product.getPrice()%>"  placeholder="Enter Your price..." name="price" required>
                                        <label for="category">Product Category</label>
                                        <select class="form-select mb-2" id="category" name="category" value=""  aria-label="Default select example">
                                            <option selected ><%= product.getCategory()%></option>
                                            <option value="Console System">Console System</option>
                                            <option value="Console CD">Console CD</option>
                                            <option value="Console Controllers">Console Controllers</option>
                                            <option value="Screens">Screens</option>
                                        </select>
                                        <label for="file">Product Image</label>
                                        <input type="text" id="file" value="<%= product.getAvatar()%>" class="form-control form-control-lg mb-2"  placeholder="Insert Image Url" name="file" required>
                                        <input type="submit" class="w-100 submit__button py-2 border-0 mt-3" value="Add A New Console" >
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>

