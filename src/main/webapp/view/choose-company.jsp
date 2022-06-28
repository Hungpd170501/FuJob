<%-- 
    Document   : choose-company
    Created on : May 27, 2022, 8:33:12 PM
    Author     : HNGB
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="se1621.dao.CompanyInfoDAO"%>
<%@page import="se1621.dto.CompanyInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="./include/header.jsp">
        <jsp:param name="title" value="FuJob | Choose Company "/>
    </jsp:include>
    <jsp:useBean id="chooseCompany" class="se1621.dao.CompanyInfoDAO" scope="request"></jsp:useBean>
</head>
<body>
<jsp:include page="./components/loader.jsp"></jsp:include>

<jsp:include page="./include/navbar.jsp"></jsp:include>


<section class="bg-home" style="background: url('https://via.placeholder.com/2000X1333//88929f/5a6270C/O https://placeholder.com/') center center;">
    <div class="bg-overlay"></div>
    <div class="home-center">
        <div class="home-desc-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <div class="title-heading text-center text-white">
                            <h6 class="small-title text-uppercase text-light mb-3">Let We Know</h6>
                            <h1 class="heading font-weight-bold mb-4">Your Company: </h1>
                        </div>
                    </div>
                </div>
                <div class="home-form-position">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="home-registration-form p-4 mb-3">

                                <form action="/FuJob/MainController" method="post" class="registration-form">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6">
                                            <div class="registration-form-box">
                                                <i class="fa fa-list-alt"></i>

                                                <select id="select-category" name ="choose-companyName" class="demo-default">

                                                    <option value="">Company...</option>
                                                    <c:forEach items="${chooseCompany.listCompany}" var="i">
                                                        <option value="${i.companyID}">${i.companyName}</option>
                                                    </c:forEach>

                                                </select>

                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6">
                                            <div class="registration-form-box">
                                                <input type="submit" id="submit" name="action" class="submitBnt btn btn-primary btn-block" value="Choose Company">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 text-center">
                                        <p class="mb-0 mt-3"><small class="text-light mr-2">Another Company ?</small> <a href="/FuJob/view/create-companyinfo.jsp" class="text-light font-weight-bold">Create your Company Information</a></p>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>







<jsp:include page="./include/footer.jsp"></jsp:include>
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