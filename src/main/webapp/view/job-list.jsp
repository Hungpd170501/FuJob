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

                        <div class="row"> 
                            <% List<Job> listJob = (List<Job>) request.getAttribute("LIST_ALLJOB");
                                if (listJob != null) {
                                    if (listJob.size() > 0) {
                                        for (Job job : listJob) {
                            %>
                            <div class="col-lg-12 mt-4 pt-2">
                                <div class="job-list-box border rounded">
                                    <div class="p-3">
                                        <div class="row align-items-center">
                                            <div class="col-lg-2">
                                                <div class="company-logo-img">
                                                    <img src="images/featured-job/img-1.png" alt="" class="img-fluid mx-auto d-block">
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
                                                            <p class="text-muted mb-0"><i class="mdi mdi-clock-outline mr-2"><%= job.getDeadline() %></i></p>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3">
                                                <div class="job-list-button-sm text-right">
                                                    <span class="badge badge-success">Part-Time</span>

                                                    <div class="mt-3">
                                                        <a href="#" class="btn btn-sm btn-primary">Apply</a>
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


                            <div class="col-lg-12 mt-4 pt-2 ">
                                <c:set var = "searchtitle" value="${requestScope.searchtitle}"/>
                                <c:set var = "searchExper" value="${requestScope.searchExper}"/>
                                <c:set var = "searchCate" value="${requestScope.searchCate}"/>
                                <%--<c:set var="pageJob" value="${requestScope.pageJob}"/>--%>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination job-pagination mb-0 justify-content-center">
                                        <c:forEach begin="${1}" end="${requestScope.numberPage}" var="i">
                                            <%--<li class="${i==pageJob?"page-item active":""}"><a class="page-link" href="MainController?action=SearchlistJob&pageJob=${i}&searchtitle=${i}&searchExper=${i}&searchCate=${i}">${i}</a></li> --%>                                        
                                            <li class="${i==pageJob?"page-item active":""}"><a class="page-link" href="MainController?action=SearchlistJob&Search_title_exper_catesearchtitle=${i}&searchExper=${i}&searchCate=${i}">${i}</a></li>                                        
                                         </c:forEach>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- JOB LIST START -->

        <!-- footer start -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-12 mb-0 mb-md-4 pb-0 pb-md-2">
                        <a href="javascript:void(0)"><img src="images/logo-light.png" height="20" alt=""></a>
                        <p class="mt-4">At vero eos et accusamus et iusto odio dignissim os ducimus qui blanditiis praesentium</p>
                        <ul class="social-icon social list-inline mb-0">
                            <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-facebook"></i></a></li>
                            <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-twitter"></i></a></li>
                            <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-instagram"></i></a></li>
                            <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-google"></i></a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <p class="text-white mb-4 footer-list-title">Company</p>
                        <ul class="list-unstyled footer-list">
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> About Us</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Media & Press</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Career</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Blog</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Pricing</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Marketing</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> CEOs </a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Agencies</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Our Apps</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <p class="text-white mb-4 footer-list-title">Resources</p>
                        <ul class="list-unstyled footer-list">
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Support</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Privacy Policy</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Terms</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Accounting </a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> Billing</a></li>
                            <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right"></i> F.A.Q.</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-3 col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <p class="text-white mb-4 footer-list-title f-17">Business Hours</p>
                        <ul class="list-unstyled text-foot mt-4 mb-0">
                            <li>Monday - Friday : 9:00 to 17:00</li>
                            <li class="mt-2">Saturday : 10:00 to 15:00</li>
                            <li class="mt-2">Sunday : Day Off (Holiday)</li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
        <!-- footer end -->
        <hr>
        <footer class="footer footer-bar">
            <div class="container text-center">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="">
                            <p class="mb-0">© 2019 -2020 Jobya. Design with <i class="mdi mdi-heart text-danger"></i> by Themesdesign.</p>
                        </div>
                    </div>
                </div>
            </div><!--end container-->
        </footer><!--end footer-->
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
    </body>
</html>