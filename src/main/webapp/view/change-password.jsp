<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="./include/header.jsp">
        <jsp:param name="title" value="FuJob | Recovery Password"/>
    </jsp:include>

</head>

<body>
<jsp:include page="./components/loader.jsp"></jsp:include>


<div class="back-to-home rounded d-none d-sm-block">
    <a href="../view/index.jsp" class="text-white rounded d-inline-block text-center"><i class="mdi mdi-home"></i></a>
</div>

<!-- Hero Start -->
<section class="vh-100"
         style="background: url('https://via.placeholder.com/2000X1333//88929f/5a6270C/O https://placeholder.com/') center center;">

    <div class="home-center">
        <div class="home-desc-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-4 col-md-6">
                        <div class="alert shadow alert-light hide-if-empty text-center"
                             role="alert">${requestScope.CHANGE_PASSWORD_MESSAGE}</div>
                        <div class="login_page bg-white shadow rounded p-4">
                            <div class="text-center">
                                <h4 class="mb-4">Change password for ${sessionScope.LOGIN_USER.email}</h4>
                            </div>
                            <form class="login-form" id="recovery-pasword-form" method="post"
                                  action="/FuJob/MainController"
                                  oninput='confirmpassword.setCustomValidity(confirmpassword.value != password.value ? "Password do not match!" : "")'>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group position-relative">
                                            <label>Password <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control" placeholder="Password"
                                                   name="password" required="">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group position-relative">
                                            <label>Confirm Password <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control" placeholder="Confirm Password"
                                                   name="confirmpassword" required="">
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <input type="hidden" name="action" value="ChangePassword">
                                        <button class="btn btn-primary w-100" type="submit"
                                                form="recovery-pasword-form">Change Password
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </div>
    </div>
</section><!--end section-->
<!-- Hero End -->

<script>
    let empty = document.querySelectorAll('.row > div');

    empty.forEach(function (element) {

        if (element.textContent === '') {
            element.previousElementSibling.style.display = 'none';
            element.style.display = 'none';
        }
    });
</script>


<!-- javascript -->
<script src="${pageContext.request.contextPath}/asset/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/plugins.js"></script>

<!-- selectize js -->
<script src="${pageContext.request.contextPath}/asset/js/selectize.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.nice-select.min.js"></script>

<script src="${pageContext.request.contextPath}/asset/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/counter.int.js"></script>

<script src="${pageContext.request.contextPath}/asset/js/app.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/home.js"></script>
</body>
</html>
