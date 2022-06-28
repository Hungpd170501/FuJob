<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                <a href="${pageContext.request.contextPath}/view/index.jsp" class="text-white rounded d-inline-block text-center"><i class="mdi mdi-home"></i></a>
            </div>

            <!-- Hero Start -->
            <section class="vh-100" style="background: url('https://via.placeholder.com/2000X1333//88929f/5a6270C/O https://placeholder.com/') center center;">

                <div class="home-center">
                    <div class="home-desc-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-4 col-md-6">
                                    <div class="login_page bg-white shadow rounded p-4">
                                        <div class="text-center">
                                            <h4 class="mb-4">Reset your password</h4>  
                                        </div>
                                        <form class="login-form" id="recovery-pasword-form" method="post" action="/FuJob/MainController">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <p class="text-muted">Check your email for a link to reset your password. If it does not appear within a few minutes, check your spam folder.</p>
                                                </div>
                                                <div class="col-lg-12">
                                                    <a href="/FuJob/view/login.jsp" class="btn btn-primary w-100">Return to sign in</a>
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
