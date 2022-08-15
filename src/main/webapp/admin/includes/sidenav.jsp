<%--
  Created by IntelliJ IDEA.
  User: HP-PC
  Date: 8/12/2022
  Time: 3:01 PM
  To change this template use File | Settings | File Templates.
--%>

<div class="col-md-3">
    <aside>
        <ul class="navbar-nav mt-5 sidenav">
            <li class="nav-item mb-3">
                <a href="../admin/dashboard.jsp" class="nav-link d-flex">
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
                <a href="../admin/gameControllerCategory.jsp" class="nav-link d-flex">
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
                <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="nav-link d-flex">
                    <i class="bi bi-indent me-3"></i>
                    <h6>Logout</h6>
                </a>
            </li>
        </ul>
    </aside>
</div>
