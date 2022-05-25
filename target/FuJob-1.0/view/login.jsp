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
                <a href="../view/index.jsp" class="text-white rounded d-inline-block text-center"><i class="mdi mdi-home"></i></a>
            </div>

            <!-- Hero Start -->
            <section class="vh-100" style="background: url('https://via.placeholder.com/2000X1333//88929f/5a6270C/O https://placeholder.com/') center center;">

                <div class="home-center">
                    <div class="home-desc-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-4 col-md-6">
                                    <div class="login-page bg-white shadow rounded p-4">
                                        <div class="text-center">
                                            <h4 class="mb-4">Login</h4>  
                                        </div>
                                        <form class="login-form" action="MainController" method ="POST" >
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="form-group position-relative">
                                                        <label>Your Email <span class="text-danger">*</span></label>
                                                        <input type="email" class="form-control" placeholder="Email" name="email" required="">
                                                    </div>
                                                </div>

                                                <div class="col-lg-12">
                                                    <div class="form-group position-relative">
                                                        <label>Password <span class="text-danger">*</span></label>
                                                        <input type="password" class="form-control" placeholder="Password" name="password" required="">
                                                    </div>
                                                </div>

                                                <div class="col-lg-12">
                                                    <p class="float-right forgot-pass"><a href="recovery_passward.html" class="text-dark font-weight-bold">Forgot password ?</a></p>
                                                    <div class="form-group">
                                                        <div class="custom-control m-0 custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input" id="customCheck1">
                                                            <label class="custom-control-label" for="customCheck1">Remember me</label>
                                                        </div>
                                                    </div>
                                                </div>
                                        <!-- Nut LOGIN -->
                                                <div class="col-lg-12 mb-0">
                                                    <input type="submit" name="action" class="btn btn-primary w-100" value="Login"/>
<!--                                                    <button class="btn btn-primary w-100">Sign in</button>-->
                                                </div>
                                                <div class="col-lg-12 mt-4 text-center">
                                                    <h6>Or Login With</h6>
                                                    <ul class="list-unstyled social-icon mb-0 mt-3">
                                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i class="mdi mdi-facebook" title="Facebook"></i></a></li>
                                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i class="mdi mdi-google-plus" title="Google"></i></a></li>
                                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i class="mdi mdi-github-circle" title="Github"></i></a></li>
                                                    </ul><!--end icon-->
                                                </div>
                                                <div class="col-12 text-center">
                                                    <p class="mb-0 mt-3"><small class="text-dark mr-2">Don't have an account ?</small> <a href="signup.html" class="text-dark font-weight-bold">Sign Up</a></p>
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
