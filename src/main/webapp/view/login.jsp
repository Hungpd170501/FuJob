<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="windows-1258"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Login"/>
        </jsp:include>

    </head>

    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>
            <div class="back-to-home rounded d-none d-sm-block">
                <a href="${pageContext.request.contextPath}" class="text-white rounded d-inline-block text-center"><i class="mdi mdi-home"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="vh-100" style="background: url('${pageContext.request.contextPath}/asset/images/background-home.jpg') center center;">

            <div class="home-center">
                <div class="home-desc-center">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-4 col-md-6">
                                <div class="alert shadow alert-light hide-if-empty text-center" role="alert">${requestScope.LOGIN_MESSAGE}</div>
                                <div class="login-page bg-white shadow rounded p-4">
                                    <div class="text-center">
                                        <h4 class="mb-4">Login</h4>  
                                    </div> 
                                    <form class="login-form" action="${pageContext.request.contextPath}/MainController" method="post">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group position-relative">
                                                    <label>Your Email <span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control" placeholder="Your Email" value="${param.email}" name="email" required="">
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="form-group position-relative">
                                                    <label>Password <span class="text-danger">*</span></label>
                                                    <input type="password" name="password" placeholder="Password" class="form-control" value="${param.password}" required="">
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <p class="float-right forgot-pass"><a href="${pageContext.request.contextPath}/view/recovery_password.jsp" class="text-dark font-weight-bold">Forgot password ?</a></p>
                                                <div class="form-group">
                                                    <div class="custom-control m-0 custom-checkbox">
                                                        <input type="checkbox" class="custom-control-input" value="lsRememberMe" id="rememberMe"> 
                                                        <label class="custom-control-label" for="rememberMe">Remember me</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Nut LOGIN -->
                                            <div class="col-lg-12 mb-0">
                                                <input type="submit" name="action" class="btn btn-primary w-100" value="Login" onclick="lsRememberMe()">
                                            </div>
                                            <div class="col-lg-12 mt-4 text-center">
                                                <h6>Or Login With</h6>
                                                <ul class="list-unstyled social-icon mb-0 mt-3">
                                                    <li class="list-inline-item"><a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/FuJob/LoginGoogleHandler&response_type=code&client_id=674216776597-dsnqcp414vcta1d1mi4aa5umrmakucjd.apps.googleusercontent.com&approval_prompt=force" class="rounded"><i class="mdi mdi-google-plus" title="Google"></i></a></li>
                                                </ul><!--end icon-->
                                            </div>
                                            <div class="col-12 text-center">
                                                <p class="mb-0 mt-3"><small class="text-dark mr-2">Don't have an account ?</small> <a href="${pageContext.request.contextPath}/view/signup.jsp" class="text-dark font-weight-bold">Sign Up</a></p>
                                            </div>
                                        </div>
                                    </form>
                                </div><!---->
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
        <script src="${pageContext.request.contextPath}/asset/js/remember-me.js"></script>

<!--        <script src="https://www.google.com/recaptcha/api.js?render=6LeCa7IeAAAAAFhlitWRqflibLyvju1K_P5U52dj"></script>
        <script>
            grecaptcha.ready(function () {
                grecaptcha.execute('6LeCa7IeAAAAAFhlitWRqflibLyvju1K_P5U52dj', {action: ''}).then(function (token) {
                    document.getElementById('recaptToken').value = token;
                });
            });
        </script>-->
    </body>
</html>
