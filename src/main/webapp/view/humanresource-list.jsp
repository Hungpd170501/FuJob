<%@page import="java.util.List"%>
<%@page import="se1621.dto.User"%>
<%@page contentType="text/html" pageEncoding="windows-1258"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Home Page"/>
        </jsp:include>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css">
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
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Your company</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Your Human Resource</span> 
                                    </li>
                                </ul>
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
            <% List<User> listUser = (List<User>) request.getAttribute("LIST_USER");
                    String message = (String) request.getAttribute("MESSAGE");
                    if(message == null){
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
                    <form action="${pageContext.request.contextPath}/MainController" method="POST">
                    <table id="example" class=" table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Creation Date</th>
                                <th>Project Posted</th>
                                <th>Status</th>
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
                                <td><%= user.getUserID()%></td>
                                <td><%= user.getFullName()%></td>
                                <td><%= user.getEmail()%></td>
                                <td><%= user.getCreatedDate()%></td>
                                <td><a href="${pageContext.request.contextPath}/MainController?action=ListJobByID&userID=<%= user.getUserID() %>"><%= user.getProjectPosted()%></a></td>
                                <td>
                                    <%
                                        if (user.getUserStatus() == 1) {
                                    %>
                                    <select style="background-color: rgba(0, 0, 0, 0);border: none">
                                        <option selected="selected" value="1">Active</option>
                                        <option value="0">Deactivates</option>
                                    </select>    
                                    <%
                                        }
                                        if (user.getUserStatus() == 0) {
                                    %>
                                    <select name="userStatus" style="background-color: rgba(0, 0, 0, 0);border: none">
                                        <option value="1">Active</option>
                                        <option selected="selected" value="0">Deactivates</option>
                                    </select>    
                                    <%
                                        }
                                    %>
                                </td>
                                    <input type="hidden" name="companyID" value="<%= user.getCompanyID() %>">
                                    <input type="hidden" name="hrID" value="<%= user.getUserID() %>">
                                    <input type="hidden" name="action" value="UpdateStatusHR">
                                <td><input type="submit" class="btn btn-primary" value="Update"></td>
                                
                            </tr>
                            <%          }
                                        }
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                    </form>
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
                            <input type="hidden" name="companyID" value="${sessionScope.LOGIN_USER.companyID}">
                            <input type="hidden" name="roleID" value="HR">
                            <input type="hidden" name="password" value="1">
                        </div>
                        <div class="modal-footer border-top-0 d-flex justify-content-center">
                            <input type="submit" name="action" class="btn btn-primary" value="Register HR">
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
    </body>
</html>
