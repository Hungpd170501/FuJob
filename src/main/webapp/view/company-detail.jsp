<%@page import="se1621.dto.CompanyInfo"%>
<%@page import="se1621.dao.CompanyInfoDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <%--    <jsp:useBean id ="company" class="se1621.dao.CompanyInfoDAO" scope="request"></jsp:useBean> --%>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Company Detail"/>
        </jsp:include>
    </head>

    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>
            <!-- Start home -->           
            <section class="bg-half page-next-level"> 
                <div class="bg-overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="text-center text-white">
                                <h4 class="text-uppercase title mb-4">Company Detail</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Pages</a></li> 
                                    <li><a href="#" class="text-uppercase font-weight-bold">Employer</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Company Detail</span> 
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->

            <!-- EMPLOYERS DETAILS START -->


            <section class="section">
            <%
                CompanyInfo companyInfo = (CompanyInfo) request.getAttribute("COMPANYINFO");
                if (companyInfo != null) {
            %>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="text-sm-center">
                            <img src="images/featured-job/img-3.png" alt="" class="img-fluid mx-md-auto d-block">
                            <h4 class="mt-3"><a href="#" class="text-dark"> <%= companyInfo.getCompanyName()%> </a></h4>
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item mr-3">
                                    <p class="text-muted mb-0"><i class="mdi mdi-map-marker mr-2"></i><%= companyInfo.getAddress()%></p>
                                </li>

                                <li class="list-inline-item">
                                    <p class="text-success mb-0"><i class="mdi mdi-bookmark-check mdi-18px mr-2"></i>Verified</p>
                                </li>
                            </ul>

                            <ul class="list-inline mb-2">
                                <li class="list-inline-item mr-3 ">
                                    <p class="text-muted"><i class="mdi mdi-earth mr-2"></i><%= companyInfo.getWebsite()%></p>
                                </li>

                                <li class="list-inline-item mr-3">
                                    <p class="text-muted"><i class="mdi mdi-email mr-2"></i><%= companyInfo.getGmail()%></p>
                                </li>

                                <li class="list-inline-item">
                                    <p class="text-muted"><i class="mdi mdi-cellphone-iphone mr-2"></i><%= companyInfo.getPhone()%></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="border-top border-bottom pt-4 pb-4">
                            <div class="row justify-content-sm-center">
                                <div class="col-lg-3 col-md-3 col-6">
                                    <div class="text-sm-center m-14">
                                        <h5 class="text-dark mb-2">Employer</h5>
                                        <p class="text-muted mb-0"><%= companyInfo.getNumberOfEmployee()%></p>
                                    </div>
                                </div>

                                <div class="col-lg-3 col-md-3 col-6">
                                    <div class="text-sm-center m-14">
                                        <h5 class="text-dark mb-2">Type</h5>
                                        <p class="text-muted mb-0"><%= companyInfo.getTypeCompany()%></p>
                                    </div>
                                </div>

                                <div class="col-lg-3 col-md-3 col-6">
                                    <div class="text-sm-center m-14">
                                        <h5 class="text-dark mb-2">Established Year</h5>
                                        <p class="text-muted mb-0"><%= companyInfo.getEstablishedYear()%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4 pt-2">
                        <h4>Company Overview :</h4>
                        <div class="rounded border p-4 mt-3">
                            <p class="text-muted"> <%= companyInfo.getCompanyOverview()%> </p>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
        </section>

        <!-- EMPLOYERS DETAILS END -->

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