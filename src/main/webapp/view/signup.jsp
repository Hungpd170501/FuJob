<%@page import="Error.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Signup"/>
        </jsp:include>

    </head>

    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>

            <div class="back-to-home rounded d-none d-sm-block">
                <a href="../view/index.jsp" class="text-white rounded d-inline-block text-center"><i class="mdi mdi-home"></i></a>
            </div>

            <!-- Hero Start -->
            <section class="vh-85" style="background: url('https://via.placeholder.com/2000X1333//88929f/5a6270C/O https://placeholder.com/') center center;">
                <div class="home-center">
                    <div class="home-desc-center">
                        <div class="container">
                            <div class="row justify-content-center" style="margin: 80px auto">
                                <div class="col-md-6">
                                    <div class="login_page bg-white shadow rounded p-4">
                                        <div class="text-center">
                                            <h4 class="mb-4">Sign up</h4>  
                                        </div>
                                    <%
                                        UserError userError = (UserError) request.getAttribute("USER_ERROR");
                                        if (userError == null) {
                                            userError = new UserError();
                                        }
                                    %>
                                    <form action="MainController" method="POST" class="login-form" oninput='confirmpassword.setCustomValidity(confirmpassword.value != password.value ? "Password do not match!" : "")'>
                                        <div class="row">
                                            <!--                                                <div class="col-md-12">
                                                                                                <ul class="nav nav-pills nav nav-pills bg-white rounded nav-justified flex-column flex-sm-row" id="pills-tab" role="tablist">
                                                                                                    <li class="active nav-item">
                                                                                                        <a class="nav-link rounded active" id="job-seeker-tab" role="tab" aria-controls="job-seeker" aria-selected="true" data-toggle="tab" href="#jobseeker">Job Seeker</a>
                                                                                                    </li>
                                                                                                    <li class="nav-item">
                                                                                                        <a class="nav-link rounded" id="recruiter-tab" role="tab" aria-controls="job-seeker" aria-selected="true" data-toggle="tab" href="#recruiter">Recruiter</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </div>-->
                                            <!--                                                <div class="col-md-12 btn-group">
                                                                                                <label class=" btn btn-primary active">
                                                                                                    <input type="radio" name="options" id="option1" autocompelte="off">Job Seeker
                                                                                                </label>
                                                                                                <label class=" btn btn-primary">
                                                                                                    <input type="radio" name="options" id="option2" autocompelte="off">Recruiter
                                                                                                </label>
                                            
                                                                                            </div>-->

                                            <div class="col-md-12">
                                                <div class="form-group position-relative">                                               
                                                    <label>Full Name <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="First Name" name="fullName" required="">
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="form-group position-relative">
                                                    <label>Your Email <span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control" placeholder="Email" name="email" required=""> <%= userError.getEmailError()%>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="form-group position-relative">
                                                    <label>Password <span class="text-danger">*</span></label>
                                                    <input type="password" class="form-control" placeholder="Password" name="password" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group position-relative">
                                                    <label>Confirm Password <span class="text-danger">*</span></label>
                                                    <input type="password" class="form-control" placeholder="Confirm Password" name="confirmpassword" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group position-relative">                                               
                                                    <label>Job Seeker </label>
                                                    <input type="radio" name="roleID" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group position-relative">                                               
                                                    <label>Recruiter </label>
                                                    <input type="radio" name="roleID" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <div class="custom-control m-0 custom-checkbox">
                                                        <input type="checkbox" class="custom-control-input" id="customCheck1" required="">
                                                        <label class="custom-control-label" for="customCheck1" >I Accept <a href="#" class="text-primary">Terms And Condition</a></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <!--                                                    <button class="btn btn-primary w-100">Register</button>-->
                                                <input class="btn btn-primary w-100" type="submit" name="action" value="Singup">
                                            </div>
                                            <div class="col-lg-12 mt-4 text-center">
                                                <h6>Or Signup With</h6>
                                                <ul class="list-unstyled social-icon mb-0 mt-3">
                                                    <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i class="mdi mdi-facebook" title="Facebook"></i></a></li>
                                                    <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i class="mdi mdi-google-plus" title="Google"></i></a></li>
                                                    <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i class="mdi mdi-github-circle" title="Github"></i></a></li>
                                                </ul><!--end icon-->
                                            </div>
                                            <div class="mx-auto">
                                                <p class="mb-0 mt-3"><small class="text-dark mr-2">Already have an account ?</small> <a href="login.html" class="text-dark font-weight-bold">Sign in</a></p>
                                            </div>
                                        </div>
                                    </form>

                                    <%
                                        String message = (String) request.getAttribute("MESSAGE");
                                        if (message == null) {
                                            message = "";
                                        }
                                    %>
                                    <h1><%= message%></h1>
                                </div>   

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

    <script src="${pageContext.request.contextPath}/asset/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/asset/js/home.js"></script>
</body>
</html>