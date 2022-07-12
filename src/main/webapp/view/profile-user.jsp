<%-- 
    Document   : profile-user
    Created on : Jul 2, 2022, 10:47:20 AM
    Author     : HNGB
--%>

<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="se1621.dto.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Profile "/>
        </jsp:include>
    </head>
    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>
            <section class="bg-half page-next-level"> 
                <div class="bg-overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="text-center text-white">
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="${pageContext.request.contextPath}/view/index.jsp" class="text-uppercase font-weight-bold">Home</a></li>
                                <li>
                                    <span class="text-uppercase text-white font-weight-bold">Profile</span> 
                                </li> 
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%
            User us = (User) session.getAttribute("LOGIN_USER");
            String messUpdate = (String) request.getAttribute("MESSAGE_UPDATE");
            if (messUpdate != null) {
        %>
        <div class="col-5 mx-auto text-center alert alert-warning alert-dismissible fade show" role="alert">
            <strong><%= messUpdate%></strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            }
        %>
        <div class="container rounded mt-5 mb-5 ">
            <form action="/FuJob/MainController" method="POST">
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="text-center">Profile</h2>
                        <div class="col-md-6 mx-auto form-group position-relative">
                            <label>Full Name</label>
                            <div class="row">
                                <span class="col-md-2 form-control text-center"><i class="mdi mdi-24px mdi-account-card-details"></i></span>
                                <input type="text" name="fullName" class="form-control col-md-10" value="${sessionScope.LOGIN_USER.fullName}">
                            </div>
                        </div>
                        <div class="col-md-6 mx-auto form-group position-relative">
                            <label>Email</label>
                            <div class="row">
                                <span class="col-md-2 form-control text-center"><i class="mdi mdi-24px mdi-email"></i></span>
                                <input type="text" class="form-control col-md-10" value="${sessionScope.LOGIN_USER.email}" readonly="">
                            </div>
                        </div>
                            <%
                            if (us != null && StringUtils.equals(us.getRole().getRoleID(), "HR")==false){
                            %>
                        <div class="col-md-6 mx-auto"><a href="#" data-toggle="modal" data-target="#formPassword"><i class="mdi mdi-key mr-1"></i><u>Change Password</u></a></div>  
                            <%
                                }
                            %>
                        <input type="hidden" name="userID" value="${sessionScope.LOGIN_USER.userID}">   
                        <div class="mt-5 text-center"><input class="btn btn-primary profile-button" name="action" type="submit" value="Update Profile"></div>
                    </div>
                </div>
            </form>
        </div>

        <div class="modal fade" id="formPassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header border-bottom-0">
                        <h5 class="modal-title text-primary" id="exampleModalLabel">Change Password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/MainController">
                        <div class="modal-body">
                            <div class="form-group text-dark">
                                <label>Enter your current password</label>
                                <input id="passwordEnter" type="password" class="form-control" name="passwordEnter" placeholder="Enter your current password:">
                            </div>
                        </div>
                        <div class="modal-footer border-top-0 d-flex justify-content-center">
                            <input type="submit" class="btn btn-primary" value="Cofirm">
                            <input type="hidden" name="action" value="CheckPasswordToChange">
                        </div>
                    </form>
                </div>
            </div>
        </div> 
        <jsp:include page="./include/footer.jsp"></jsp:include>
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
