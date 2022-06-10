<%@page import="se1621.dto.User"%>
<%@page import="se1621.dto.Job"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Job List"/>
        </jsp:include>
    </head>
    <body>

        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>
        <jsp:useBean id="chooseCategory" class="se1621.dao.CategoryDAO" scope="request"></jsp:useBean>

            <!-- Start home -->
            <section class="bg-half page-next-level"> 
                <div class="bg-overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="text-center text-white">
                                <h4 class="text-uppercase title mb-4">Job List view</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Jobs</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Job Listing</span> 
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->

            <div class="container">
                <div class="home-form-position">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="home-registration-form job-list-reg-form bg-light shadow p-4 mb-3">

                                <!-- START SEARCH -->
                                <form class="registration-form" action="${pageContext.request.contextPath}/MainController">
                                <!--                                <form class="registration-form">-->
                                <div class="row">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-briefcase"></i>
                                            <input type="text" name="searchtitle" id="exampleInputName1" class="form-control rounded registration-input-box" placeholder="Job title...">
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-archive"></i>
                                            <select class="demo-default" id="select-category" name="searchExper">
                                                <!--                                                <select class="demo-default" id="select-category" required="">-->
                                                <option value="">Experience</option>
                                                <option value="Less than 1 year">Less than 1 year</option>
                                                <option value="1-3 years">1-3 years</option>
                                                <option value="3-5 years">3-5 years</option>
                                                <option value="5-10 years">5-10 years</option>
                                                <option value="More than 10 years">More than 10 years</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-list-alt"></i>
                                            <select id="select-category" class="demo-default" name="searchCate">
                                                <!--<select id="select-category" class="demo-default">-->
                                                <option value="">Categories...</option>
                                                <c:forEach items="${chooseCategory.listCategory}" var="i">
                                                    <option value="${i.categoryID}">${i.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <input type="submit" id="submit" class="submitBnt btn btn-primary btn-block" value="Submit">
                                            <!-- name = action  -->
                                            <input type="hidden" name ="action" value="Search_title_exper_cate">
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <!-- END SEARCH -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JOB LIST START -->
        <section class="section pt-0">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">Available job for you</h4>
                            <p class="text-muted para-desc mx-auto mb-1">Post a job to tell us about your project. We'll quickly match you with the right freelancers.</p>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4 pt-2">
                        <div class="row align-items-center">
                            <div class="col-lg-12">
                                <div class="show-results">
                                    <div class="float-left">
                                        <h5 class="text-dark mb-0 pt-2 f-18">Showing result</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- them display -->
                        <div class="row" > 
                            <% List<Job> listJob = (List<Job>) request.getAttribute("LIST_ALLJOB");
                                if (listJob != null) {
                                    if (listJob.size() > 0) {
                                        for (Job job : listJob) {
                            %>
                            <div class="job-display col-lg-12 mt-4 pt-2"style="display: none">
                                <div class="job-list-box border rounded" >
                                    <div class="p-3">
                                        <div class="row align-items-center">
                                            <div class="col-lg-2">
                                                <div class="company-logo-img">
                                                    <img src="<%= job.getCategory().getImg() %>" alt="" class="img-fluid mx-auto d-block">
                                                </div>
                                            </div>
                                            <div class="col-lg-7 col-md-9">
                                                <div class="job-list-desc">

                                                    <h6 class="mb-2"><a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= job.getJobID()%>" class="text-dark"><%= job.getJobTitle()%></a></h6>

                                                    <p class="text-muted mb-0"><i class="mdi mdi-bank mr-2"></i><%= job.getCompany().getCompanyName()%></p>
                                                    <p class="text-muted mb-0"><i class="fa fa-list-alt mr-2"></i><%= job.getCategory().getCategoryName()%></p>
                                                    <ul class="list-inline mb-0">
                                                        <li class="list-inline-item mr-3">
                                                            <p class="text-muted mb-0"><i class="mdi mdi-map-marker mr-2"></i><%= job.getAddress()%></p>
                                                        </li>

                                                        <li class="list-inline-item mr-3">
                                                            <p class="text-muted mb-0"><i class="mdi mdi-clock-outline mr-2"><%= job.getDeadline()%></i></p>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3">
                                                <div class="job-list-button-sm text-right">

                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= job.getJobID()%>" class="btn btn-sm btn-primary">View Detail</a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%

                                        }

                                    }
                                }

                            %>
                            
                            <%
                                    if (listJob.size() > 10) {
                            %>
                            <div class="smj col-12 text-center mt-4 pt-2">
                                <a class="btn btn-primary-outline">Show more</a>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
        </section>
        <!-- JOB LIST START -->

        <!-- footer start -->
        <jsp:include page="./include/footer.jsp"></jsp:include>

            <!--end footer-->
            <!-- Footer End -->
            <!-- Back to top -->
            <a href="#" class="back-to-top rounded text-center" id="back-to-top"> 
                <i class="mdi mdi-chevron-up d-block"> </i> 
            </a>
            <!-- Back to top -->

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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(".job-display").slice(0, 10).show();
            $(".smj").on("click", function () {
                $(".job-display:hidden").slice(0, 5).slideDown();
                if ($(".job-display:hidden").length == 0) {
                    $(".smj").fadeOut('slow');
                }
            });
        </script>
    </body>
</html>