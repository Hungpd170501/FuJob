<%@page import="se1621.dto.Resume"%>
<%@page import="se1621.dto.Job"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Canđiates listing"/>
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
                                <h4 class="text-uppercase title mb-4">Candidates Listing</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Pages</a></li> 
                                    <li><a href="#" class="text-uppercase font-weight-bold">Candidates</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Candidates List</span> 
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
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
                                            <input type="text" name="searchtitle" id="exampleInputName1" class="form-control rounded registration-input-box" placeholder="Candidate name...">
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
        <!-- end home -->



        <!-- CANDIDATES LISTING START -->
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

                         

                            <% List<Resume> listResume = (List<Resume>) request.getAttribute("LIST_CANDIDATEOFJOB");
                                if (listResume != null) {
                                    if (listResume.size() > 0) {
                                        for (Resume resume : listResume) {
                            %>
                            
    
                            <div class="col-lg-12 col-md-8">
                                <div class="candidates-listing-item">
                                    <div class="border mt-4 rounded p-3">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <div class="float-left mr-4">
                                                    <img src="" alt="" class="d-block rounded" height="90">
                                                </div>
                                                <div class="candidates-list-desc overflow-hidden job-single-meta  pt-2">
                                                    <h5 class="mb-2"><a href="#" class="text-dark"><%= resume.getFullName()%></a></h5>
                                                    <ul class="list-unstyled">
                                                        <li class="text-muted"><i class="mdi mdi-account mr-1"></i><%= resume.getExperienceYear()%></li>
                                                        <li class="text-muted"><i class="mdi mdi-map-marker mr-1"></i><%= resume.getGender()%></li>
                                                        <li class="text-muted"><i class="mdi mdi-currency-usd mr-1"></i> </li>
                                                    </ul>
                                                    <p class="text-muted mt-1 mb-0">Skills :</p>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="candidates-list-fav-btn text-right">
                                                    <div class="fav-icon">
                                                        <i class="mdi mdi-heart"></i>
                                                    </div>
                                                    <div class="candidates-listing-btn mt-4">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchResumeID&searchResumeID=<%= resume.getUserID() %>" class="btn btn-primary-outline btn-sm">View Profile</a>
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
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination job-pagination mb-0 justify-content-center">
                                        <c:forEach begin="${1}" end="${requestScope.numberPage}" var="i">
                                            <li class="${i==pageJob?"page-item active":""}"><a class="page-link" href="MainController?action=SearchlistJob&pageJob=${i}&searchtitle=${i}&searchExper=${i}&searchCate=${i}">${i}</a></li>                                        
                                        </c:forEach>
                                    </ul>
                                </nav>
                            </div>
                        
                    </div>
                </div>
            </div>
        </section>
        <!-- CANDIDATES LISTING END -->

        
        
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
