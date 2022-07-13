<%@page import="java.time.ZoneId"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar" %>
<%@ page import="se1621.entity.JobEntity" %>
<%@ page import="java.time.Duration" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
    <jsp:include page="./include/header.jsp">
        <jsp:param name="title" value="FuJob | Home Page"/>
    </jsp:include>
</head>

<body>
<jsp:include page="./components/loader.jsp"></jsp:include>
<jsp:include page="./include/navbar.jsp"></jsp:include>
<!-- Start Home -->
<section class="bg-home"
         style="background: url('${pageContext.request.contextPath}/asset/images/background-home.jpg') center center;">
    <div class="bg-overlay"></div>
    <div class="home-center">
        <div class="home-desc-center">
            <div class="container">
                <%
                    String messChangePass = (String) request.getAttribute("MESSAGE_CHANGEPASS");
                    if (messChangePass != null) {
                %>
                <div class="col-5 mx-auto text-center alert alert-warning alert-dismissible fade show" role="alert">
                    <strong><%= messChangePass%>
                    </strong>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%
                    }
                %>
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <div class="title-heading text-center text-white">
                            <h6 class="small-title text-uppercase text-light mb-3">Create trackable resumes and enrich
                                your applications.</h6>
                            <h1 class="heading font-weight-bold mb-4">Find the perfect freelance services for your
                                business</h1>
                        </div>
                    </div>
                </div>
                <div class="home-form-position">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="home-registration-form p-4 mb-3">
                                <!-- SEARCH -->
                                <form class="registration-form"
                                      action="${pageContext.request.contextPath}/MainController">
                                    <!--<form class="registration-form">-->
                                    <div class="row">
                                        <div class="col-lg-3 col-md-6">
                                            <div class="registration-form-box">
                                                <i class="fa fa-briefcase"></i>
                                                <input type="text" name="searchTitle" id="exampleInputName1"
                                                       class="form-control rounded registration-input-box"
                                                       placeholder="Title...">
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-6">
                                            <div class="registration-form-box">
                                                <i class="fa fa-archive"></i>
                                                <select class="demo-default" id="select-category" name="searchSkill">
                                                    <option value="">Skill...</option>
                                                    <c:forEach items="${applicationScope.SKILL_LIST}" var="i">
                                                        <option value="${i.skillID}">${i.skillName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-6">
                                            <div class="registration-form-box">
                                                <i class="fa fa-list-alt"></i>
                                                <select id="select-category" class="demo-default" name="searchCate">
                                                    <option value="">Categories...</option>
                                                    <c:forEach items="${applicationScope.CATEGORY_LIST}" var="i">
                                                        <option value="${i.categoryID}">${i.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-6">
                                            <div class="registration-form-box">
                                                <input type="submit" id="submit"
                                                       class="submitBnt btn btn-primary btn-block" value="Find">
                                                <!-- name = action  -->
                                                <input type="hidden" name="action" value="Search_title_exper_cate">
                                            </div>
                                        </div>
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
<!-- end home -->

<!-- all jobs start -->
<section class="section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title text-center mb-4 pb-2">
                    <h4 class="title title-line pb-5">Recent Projects</h4>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="row">
                    <c:forEach items="${requestScope.JOB_LIST}" var="jobItem">
                        <div class="col-lg-3 col-md-6 mt-4 pt-0">
                            <div class="list-grid-item rounded">
                                <div class="grid-item-content p-3 bg-light">
                                    <div class="grid-list-img">
                                        <img src="${jobItem.jobCategoryID.img}" alt="" class="img-fluid mx-auto d-block"
                                             style="width:250px;height:200px">
                                    </div>
                                    <%JobEntity job = (JobEntity) pageContext.getAttribute("jobItem");%>

                                    <div class="grid-list-desc mt-3" style="width: 186px; height: 212px">
                                        <h6 class="mb-1"><a
                                                href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=${jobItem.jobID}"
                                                class="text-dark">${jobItem.jobTitle}</a></h6>
                                        <p class="text-muted f-14 mb-1">Date posted: <%= DateTimeFormatter.ofPattern("dd-MM-yyyy")
                                                                 .withZone(ZoneId.systemDefault()).format(job.getCreatedDate()) %><br></p>
                                        <p class="text-muted f-14 mb-1">Address: ${jobItem.address}<br></p>
                                        <p class="text-muted mb-1">Budget: ${jobItem.minBudget}$ - ${jobItem.maxBudget}         
                                            $<%=(job.getPaymentMethod().getPaymentMethodID() == 2) ? "/ hour" : ""%>
                                        </p>
                                        <p class="text-muted mb-1">Expiry
                                            Date: <%=  Math.abs(Duration.between(Calendar.getInstance().toInstant(), job.getExpiriedDate()).toDays())%>
                                            days left</p>
                                    </div>
                                </div>
                                <div class="apply-button p-3 border-top" style="text-align: center">
                                    <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=${jobItem.jobID}"
                                       class="btn btn-primary btn-sm">View detail</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="row justify-content-center col-12 text-center mt-4 pt-2">
            <div>
                <a href="${pageContext.request.contextPath}/MainController?action=SearchlistJob"
                   class="btn btn-primary-outline">View all projects</a>
            </div>
        </div>
    </div>
    <!-- end containar -->
</section>
<!-- all jobs end -->

<!-- popular category start -->
<section class="section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title text-center mb-4 pb-2">
                    <h4 class="title title-line pb-5">Popular Category</h4>
                    <p class="text-muted para-desc mx-auto mb-1">Tell us about your project. We'll quickly match you
                        with the right freelancers.</p>
                </div>
            </div>
        </div>

        <div class="row">
            <c:forEach items="${applicationScope.CATEGORY_LIST}" var="c">
                <div class="job-display col-lg-3 col-md-6 mt-4 pt-2" style="display: none">
                    <a href="${pageContext.request.contextPath}/MainController?action=Search_title_exper_cate&searchTitle=${""}&searchSkill=${""}&searchCate=${c.categoryID}">
                        <div class="popu-category-box bg-light rounded text-center p-4"
                             style="width: 255px; height: 234px">
                            <div class="popu-category-icon mb-3">
                                <img loading="lazy" src="${c.img}" alt=""
                                     class="img-fluid img-thumbnail d-inline-block rounded-pill h3 text-primary"
                                     style="width:100px;height:100px">
                            </div>
                            <div class="popu-category-content">
                                <h5 class="mb-2 text-dark title">${c.categoryName}</h5>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>

        </div>
        <div id="smj" class="row justify-content-center col-12 text-center mt-4 pt-2">
            <a class="smj btn btn-primary-outline">Show more</a>
        </div>
        <div id="slj" class="row justify-content-center col-12 text-center mt-4 pt-2" style="display: none">
            <a class="slj btn btn-danger-outline">Show less</a>
        </div>
    </div>
</section>
<!-- popular category end -->


<!-- counter start -->
<section class="section bg-counter position-relative"
         style="background: url('https://test.fpt.sk/wp-content/uploads/2015/10/fpt_banner31.jpg') center center;">
    <div class="bg-overlay bg-overlay-gradient"></div>
    <div class="container">
        <div class="row" id="counter">
            <div class="col-md-4 col-6">
                <div class="home-counter pt-4 pb-4" style="margin-left: 35%">
                    <div class="counter-content overflow-hidden">
                        <div class="float-left counter-icon mr-3">
                            <i class="mdi mdi-file-document-box h1 text-white"></i>
                        </div>
                        <h1 class="counter-value text-white mb-1" data-count="${requestScope.TOTAL_JOB_APPLICATION}">
                            0</h1>
                        <p class="counter-name text-white text-uppercase mb-0">Project Order</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-6">
                <div class="home-counter pt-4 pb-4" style="margin-left: 35%">
                    <div class="counter-content overflow-hidden">
                        <div class="float-left counter-icon mr-3">
                            <i class="mdi mdi-calendar-multiple-check h1 text-white"></i>
                        </div>
                        <h1 class="counter-value text-white mb-1" data-count="${requestScope.TOTAL_JOB_POST}">0</h1>
                        <p class="counter-name text-white text-uppercase mb-0">Project Posted</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-6">
                <div class="home-counter pt-4 pb-4" style="margin-left: 35%">
                    <div class="counter-content overflow-hidden">
                        <div class="float-left counter-icon mr-3">
                            <i class="mdi mdi-account-multiple-plus h1 text-white"></i>
                        </div>
                        <h1 class="counter-value text-white mb-1" data-count="${requestScope.TOTAL_USER_EXCEPT_AD}">
                            0</h1>
                        <p class="counter-name text-white text-uppercase mb-0">Members</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- counter end -->

<!-- How it Work start -->
<div style="margin: 100px 100px">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title text-center mb-4 pb-2">
                    <h4 class="title title-line pb-5">How It Work</h4>
                    <p class="text-muted para-desc mx-auto mb-1">Tell us about your project. We'll quickly match you
                        with the right freelancers.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 mt-4 pt-2">
                <div class="how-it-work-box bg-light p-4 text-center rounded shadow">
                    <div class="how-it-work-img position-relative rounded-pill mb-3">
                        <img src="${pageContext.request.contextPath}/asset/images/how-it-work/img-1.png" alt=""
                             class="mx-auto d-block" height="50">
                    </div>
                    <div>
                        <h5>Register an account</h5>
                        <p class="text-muted">You only need an email then we will send you the login link and you will
                            have an account for yourself or for your company.</p>
                        <!--<a href="#" class="text-primary">Read more <i class="mdi mdi-chevron-right"></i></a>-->
                    </div>
                </div>
            </div>
            <div class="col-md-4 mt-4 pt-2">
                <div class="how-it-work-box bg-light p-4 text-center rounded shadow">
                    <div class="how-it-work-img position-relative rounded-pill mb-3">
                        <img src="${pageContext.request.contextPath}/asset/images/how-it-work/img-2.png" alt=""
                             class="mx-auto d-block" height="50">
                    </div>
                    <div>
                        <h5>Search your project</h5>
                        <p class="text-muted">You can easily search for a project for yourself by going to the project
                            list and applying for the project you want.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mt-4 pt-2">
                <div class="how-it-work-box bg-light p-4 text-center rounded shadow">
                    <div class="how-it-work-img position-relative rounded-pill mb-3">
                        <img src="${pageContext.request.contextPath}/asset/images/how-it-work/img-3.png" alt=""
                             class="mx-auto d-block" height="50">
                    </div>
                    <div>
                        <h5>Apply for project</h5>
                        <p class="text-muted">Choosing the project you like and submitting your application, you will be
                            considered by the project posting.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


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

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(".job-display").slice(0, 8).show();
    $(".smj").on('click', function () {
        $(".job-display:hidden").slice(0, 8).slideDown();
        if ($(".job-display:hidden").length == 0) {
            $(".smj").css("display", "none");
            document.getElementById("slj").style.display = "inline-block";
        }
    });
    $(".slj").on('click', function () {
        $(".job-display").slice(8, 50).slideUp("slow");
        $("html, body").animate({scrollTop: 2100}, "slow");
        if ($(".job-display").length > 0) {
            document.getElementById("slj").style.display = "none";
            $(".smj").css("display", "inline-block");
        }
    });

</script>
</body>
</html>
