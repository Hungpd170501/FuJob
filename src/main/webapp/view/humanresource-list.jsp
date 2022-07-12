<%@page import="java.util.List"%>
<%@page import="se1621.dto.User"%>
<%@page contentType="text/html" pageEncoding="windows-1258"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Manage Human Resource"/>
        </jsp:include>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap4.min.css">
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
                                <h4 class="text-uppercase title mb-4">Manage Human Resource</h4>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="section pt-0">
                <div class="container" style="margin-top: 100px">
                    <div class="row justify-content-center">
                        <div class="col-12">
                            <div class="section-title text-center mb-4 pb-2">
                                <h4 class="title title-line pb-5">Your human resource</h4>
                            </div>
                        </div>
                    </div>
                </div>
            <%
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
            <% List<User> listUser = (List<User>) request.getAttribute("LIST_USER");
                String message = (String) request.getAttribute("MESSAGE");
                if (message == null) {
                    message = "";
                }
            %>
            <div class="col-lg-12 text-warning text-center">
                <h5> <%=message%> </h5>
            </div>
            <%
            %>
            <div class="container">
                <div class="col-12 text-center">
                    <a class="btn btn-primary" data-toggle="modal" data-target="#formAddNewHR">Add New</a>
                </div>

                <table id="example" class=" table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Creation Date</th>
                            <th>Project Posted</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listUser != null) {
                                if (listUser.size() > 0) {
                                    for (User user : listUser) {
                                        if (user.getRole().getRoleID().equals("HR")) {
                        %>
                        <tr>
                    <form action="${pageContext.request.contextPath}/MainController" method="POST">
                        <td><%= user.getUserID()%></td>
                        <td><%= user.getFullName()%></td>
                        <td><%= user.getEmail()%></td>
                        <td><%= user.getCreatedDate()%></td>
                        <td><a href="${pageContext.request.contextPath}/MainController?action=ListJobByID&userID=<%= user.getUserID()%>"><%= user.getProjectPosted()%></a></td>
                        <input type="hidden" name="companyID" value="<%= user.getCompanyID()%>">
                        <input type="hidden" name="hrID" value="<%= user.getUserID()%>">
                        <td><a onclick="getEmailHR('<%= user.getEmail() %>')" class="btn btn-primary" data-toggle="modal" data-target="#formChangePassHR">Change Password</a></td>
                    </form>   
                    </tr>
                    <%          }
                                }
                            }
                        }
                    %>
                    </tbody>
                </table>

            </div>
        </section>   

        <div class="modal fade" id="formAddNewHR" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header border-bottom-0">
                        <h5 class="modal-title text-primary" id="exampleModalLabel">Human Resource Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/MainController">
                        <div class="modal-body">
                            <div class="form-group text-dark">
                                <label>Full Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="fullName" placeholder="Enter HR Name" required="">
                            </div>
                            <div class="form-group text-dark">
                                <label>Email Login<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="email" placeholder="Enter HR Email to Login" required="">
                            </div>
                            <div class="form-group text-dark">
                                <label>Password<span class="text-danger">*</span></label>
                                <input id="password" type="password" class="form-control" name="password" placeholder="Enter HR password" required="">
                            </div>
                            <div class="form-group text-dark">
                                <label>Confirm Password<span class="text-danger">*</span></label>
                                <input oninput="checkConfirmPass()" id="confirmPassword" type="password" class="form-control" name="confirmPassword" placeholder="Enter HR password" required="">
                                <p id="errorConfirmPass" class="text-danger h7"><p>
                            </div>
                            <input type="hidden" name="companyID" value="${sessionScope.LOGIN_USER.companyID}">
                            <input type="hidden" name="roleID" value="HR">
                        </div>
                        <div class="modal-footer border-top-0 d-flex justify-content-center">
                            <input id="registerHR" type="submit" name="action" class="btn btn-primary" value="Register HR">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="formChangePassHR" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header border-bottom-0">
                        <h5 class="modal-title text-primary" id="exampleModalLabel">Change Human Resource Password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/MainController">
                        <div class="modal-body">
                            <div class="form-group text-dark">
                                <label>New Password<span class="text-danger">*</span></label>
                                <input id="newPassword" type="password" class="form-control" name="password" placeholder="Enter HR password" required="">
                            </div>
                            <div class="form-group text-dark">
                                <label>Confirm Password<span class="text-danger">*</span></label>
                                <input oninput="checkConfirmPassChange()" id="confirmPasswordChange" type="password" class="form-control" name="confirmPassword" placeholder="Enter HR password" required="">
                                <p id="errorConfirmPassChange" class="text-danger h7"><p>
                            </div>
                        </div>
                        <div class="modal-footer border-top-0 d-flex justify-content-center">
                            <input type="hidden" name="action" value="changePassHR">
                            <input type="hidden" id="emailC" name="email" value="">
                            <input type="hidden" name="companyID" value="${sessionScope.LOGIN_USER.companyID}">
                            <input id="changePassBtn" type="submit" class="btn btn-primary" value="Change">
                        </div>
                    </form>
                </div>
            </div>
        </div>                     
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
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap4.min.js"></script>
        <script>
                                        $(document).ready(function () {
                                            $('#example').DataTable();
                                        });
        </script>
        <script>
            function checkConfirmPass() {
                var pass = document.getElementById('password').value
                var confirmPass = document.getElementById('confirmPassword').value
                if (confirmPass != pass) {
                    $('#errorConfirmPass').text('Confirm Password is not match Password!');
                    document.getElementById('registerHR').disabled = true;
                } else {
                    $('#errorConfirmPass').text('');
                    document.getElementById('registerHR').disabled = false;
                }
            }
            function checkConfirmPassChange() {
                var pass = document.getElementById('newPassword').value
                var confirmPass = document.getElementById('confirmPasswordChange').value
                if (confirmPass != pass) {
                    $('#errorConfirmPassChange').text('Confirm Password is not match Password!');
                    document.getElementById('changePassBtn').disabled = true;
                } else {
                    $('#errorConfirmPassChange').text('');
                    document.getElementById('changePassBtn').disabled = false;
                }
            }
            
            function getEmailHR(email) {
                $('#emailC').val(email);       
            }
        </script> 
    </body>
</html>
