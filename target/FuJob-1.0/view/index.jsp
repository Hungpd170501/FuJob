<%@page import="se1621.dto.User"%>
<%@page contentType="text/html" pageEncoding="windows-1258"%>
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
        <jsp:useBean id="chooseCategory" class="se1621.dao.CategoryDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="totalJobPost" class="se1621.dao.JobDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="totalJobOrder" class="se1621.dao.JobOrderDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="totalUserNonAD" class="se1621.dao.UserDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="getTop10Job" class="se1621.dao.JobDAO" scope="request"></jsp:useBean>

            <!-- Start Home -->
            <section class="bg-home" style="background: url('${pageContext.request.contextPath}/asset/images/background-index.jpg') center center;">
            <div class="bg-overlay"></div>
            <div class="home-center">
                <div class="home-desc-center">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-12">
                                <div class="title-heading text-center text-white">
                                    <h6 class="small-title text-uppercase text-light mb-3">Create trackable resumes and enrich your applications.</h6>
                                    <h1 class="heading font-weight-bold mb-4">Find the perfect freelance services for your business</h1>
                                </div>
                            </div>
                        </div>
                        <div class="home-form-position">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="home-registration-form p-4 mb-3">
                                        <!-- SEARCH -->
                                        <form class="registration-form" action="${pageContext.request.contextPath}/MainController">
                                            <!--<form class="registration-form">-->
                                            <div class="row">
                                                <div class="col-lg-3 col-md-6">
                                                    <div class="registration-form-box">
                                                        <i class="fa fa-briefcase"></i>
                                                        <input type="text" name="searchtitle" id="exampleInputName1" class="form-control rounded registration-input-box" placeholder="Title...">
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
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end home -->

        <!-- popular category start -->
        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">Popular Category</h4>
                            <p class="text-muted para-desc mx-auto mb-1">Tell us about your project. We'll quickly match you with the right freelancers.</p>
                        </div>
                    </div>
                </div>
                <div></div>
                <div class="row">
                    <c:forEach items="${chooseCategory.listCategory_nonOrderBy}" var="c">
                        <div class="job-display col-lg-3 col-md-6 mt-4 pt-2" style="display: none">
                            <a href="${pageContext.request.contextPath}/MainController?action=Search_title_exper_cate&searchtitle=${""}&searchExper=${""}&searchCate=${c.categoryID}">
                                <div class="popu-category-box bg-light rounded text-center p-4">
                                    <div class="popu-category-icon mb-3">
                                        <img loading="lazy" src="${c.img}" alt="" class="img-fluid img-thumbnail d-inline-block rounded-pill h3 text-primary" style="width:100px;height:100px">
                                    </div>
                                    <div class="popu-category-content">
                                        <h5 class="mb-2 text-dark title">${c.categoryName}</h5>
                                        <!--                                    <p class="text-success mb-0 rounded">1270 Jobs</p>-->
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
        <!-- How it Work start -->
        <div style="margin-bottom: 100px">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">How It Work</h4>
                            <p class="text-muted para-desc mx-auto mb-1">Tell us about your project. We'll quickly match you with the right freelancers.</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 mt-4 pt-2">
                        <div class="how-it-work-box bg-light p-4 text-center rounded shadow">
                            <div class="how-it-work-img position-relative rounded-pill mb-3">
                                <img src="${pageContext.request.contextPath}/asset/images/how-it-work/img-1.png" alt="" class="mx-auto d-block" height="50">
                            </div>
                            <div>
                                <h5>Register an account</h5>
                                <p class="text-muted">You only need an email then we will send you the login link and you will have an account for yourself or for your company.</p>
                                <!--<a href="#" class="text-primary">Read more <i class="mdi mdi-chevron-right"></i></a>-->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mt-4 pt-2">
                        <div class="how-it-work-box bg-light p-4 text-center rounded shadow">
                            <div class="how-it-work-img position-relative rounded-pill mb-3">
                                <img src="${pageContext.request.contextPath}/asset/images/how-it-work/img-2.png" alt="" class="mx-auto d-block" height="50">
                            </div>
                            <div>
                                <h5>Search your project</h5>
                                <p class="text-muted">You can easily search for a project for yourself by going to the project list and applying for the project you want.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mt-4 pt-2">
                        <div class="how-it-work-box bg-light p-4 text-center rounded shadow">
                            <div class="how-it-work-img position-relative rounded-pill mb-3">
                                <img src="${pageContext.request.contextPath}/asset/images/how-it-work/img-3.png" alt="" class="mx-auto d-block" height="50">
                            </div>
                            <div>
                                <h5>Apply for project</h5>
                                <p class="text-muted">Choosing the project you like and submitting your application, you will be considered by the project posting.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- How it Work end -->

        <!-- counter start -->
        <section class="section bg-counter position-relative" style="background: url('${pageContext.request.contextPath}/asset/images/background-index.jpg') center center;">
            <div class="bg-overlay bg-overlay-gradient"></div>
            <div class="container">
                <div class="row" id="counter">
                    <div class="col-md-4 col-6">
                        <div class="home-counter pt-4 pb-4" style="margin-left: 35%">
                            <div class="counter-content overflow-hidden">
                                <div class="float-left counter-icon mr-3">
                                    <i class="mdi mdi-file-document-box h1 text-white"></i>
                                </div>
                                <h1 class="counter-value text-white mb-1" data-count="${totalJobOrder.allTotalJobOrder}">0</h1>
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
                                <h1 class="counter-value text-white mb-1" data-count="${totalJobPost.allTotalJobPost}">0</h1>
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
                                <h1 class="counter-value text-white mb-1" data-count="${totalUserNonAD.allTotalUser_NonAD}">0</h1>
                                <p class="counter-name text-white text-uppercase mb-0">Member</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- counter end -->

        <!-- all jobs start -->
        <section class="section bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12" style="margin-top: 20px">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">Top 05 Recent Projects</h4>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="row">
                            <c:forEach items="${getTop10Job.top10JobPosted}" var="t10">
                                <div class="col-lg-12">
                                    <div class="job-box bg-white overflow-hidden border rounded mt-4 position-relative overflow-hidden">
                                        <div class="lable text-center pt-2 pb-2">
                                            <ul class="list-unstyled best text-white mb-0 text-uppercase">
                                                <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                            </ul>
                                        </div>
                                        <div class="p-4">
                                            <div class="row align-items-center">
                                                <div class="col-md-2">
                                                    <div class="mo-mb-2">
                                                        <img loading="lazy" src="${t10.category.img}" alt="" class="img-fluid img-thumbnail mx-auto d-block">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div>
                                                        <h5 class="f-18"><a href="#" class="text-dark">${t10.jobTitle}</a></h5>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div>
                                                        <p class="text-muted mb-0"><i class="mdi mdi-map-marker text-primary mr-2"></i>${t10.address}</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div>
                                                        <p class="text-muted mb-0 mo-mb-2"><span class="text-primary">Price </span>${t10.salary}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="p-3 bg-light">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div>
                                                        <p class="text-muted mb-0 mo-mb-2"><span class="text-dark">Experience :</span> ${t10.experienceNeeded} </p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <p class="text-muted mb-0 mo-mb-2"><span class="text-dark">Category :</span> ${t10.category.categoryName} </p>
                                                </div>
                                                <div class="col-md-2">
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=${t10.jobID}" class="text-primary">View detail <i class="mdi mdi-chevron-double-right"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center col-12 text-center mt-4 pt-2" style="margin-top: 60px">
                    <div>
                        <a href="${pageContext.request.contextPath}/MainController?action=SearchlistJob&Search_title_exper_cate" class="btn btn-primary-outline">View all projects</a>
                    </div>
                </div>
                <!-- end row -->

                <!-- end row -->
                <!--                <div class="row">
                                    <div class="col-lg-12 mt-4 pt-2">
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination job-pagination mb-0 justify-content-center">
                                                <li class="page-item disabled">
                                                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                                                        <i class="mdi mdi-chevron-double-left f-15"></i>
                                                    </a>
                                                </li>
                                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                <li class="page-item"><a class="page-link" href="#">4</a></li>
                                                <li class="page-item">
                                                    <a class="page-link" href="#">
                                                        <i class="mdi mdi-chevron-double-right f-15"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>-->
            </div>
            <!-- end containar -->
        </section>
        <!-- all jobs end -->

        <!-- testimonial start -->
        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">Our Success Stories</h4>
                            <p class="text-muted para-desc mx-auto mb-1">Post a project to tell us about your project. We'll quickly match you with the right freelancers.</p>
                        </div>
                    </div>
                </div>
                <div class="row pt-4">
                    <div class="col-lg-12">
                        <div id="owl-testi" class="owl-carousel owl-theme">
                            <div class="item testi-box rounded p-4 mr-3 ml-2 mb-4 bg-light position-relative">
                                <p class="text-muted mb-5">Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet consecteturqui adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam</p>
                                <div class="clearfix">
                                    <div class="testi-img float-left mr-3">
                                        <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" height="64" alt="" class="rounded-circle shadow">
                                    </div>
                                    <h5 class="f-18 pt-1">Kevin Stewart</h5>
                                    <p class="text-muted mb-0">Web Designer at xyz Company</p>
                                    <div class="testi-icon">
                                        <i class="mdi mdi-format-quote-open display-2"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="item testi-box rounded p-4 mr-3 ml-2 bg-light position-relative">
                                <p class="text-muted mb-5">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo</p>
                                <div class="clearfix">
                                    <div class="testi-img float-left mr-3">
                                        <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" height="64" alt="" class="rounded-circle shadow">
                                    </div>
                                    <h5 class="f-18 pt-1">Charles Garrett</h5>
                                    <p class="text-muted mb-0">Marketing manager at abc Company</p>
                                    <div class="testi-icon">
                                        <i class="mdi mdi-format-quote-open display-2"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="item testi-box rounded p-4 mr-3 ml-2 bg-light position-relative">
                                <p class="text-muted mb-5">Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet consecteturqui adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam</p>
                                <div class="clearfix">
                                    <div class="testi-img float-left mr-3">
                                        <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" height="64" alt="" class="rounded-circle shadow">
                                    </div>
                                    <h5 class="f-18 pt-1">Perry Martinez</h5>
                                    <p class="text-muted mb-0">Marketing manager at abc Company</p>
                                    <div class="testi-icon">
                                        <i class="mdi mdi-format-quote-open display-2"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <!--            <div class="container mt-100 mt-60">
                            <div class="row justify-content-center">
                                <div class="col-12">
                                    <div class="section-title text-center mb-4 pb-2">
                                        <h4 class="title title-line pb-5">Our Client's</h4>
                                        <p class="text-muted para-desc mx-auto mb-1">Post a job to tell us about your project. We'll quickly match you with the right freelancers.</p>
                                    </div>
                                </div>
                            </div>
            
                            <div class="row align-items-center">
                                <div class="col-lg-2 col-md-4 col-6 mt-4 pt-2 text-center">
                                    <img src="${pageContext.request.contextPath}/asset/images/clients/1.png" height="50" alt="">
                                </div>end col
                                <div class="col-lg-2 col-md-4 col-6 mt-4 pt-2 text-center">
                                    <img src="${pageContext.request.contextPath}/asset/images/clients/2.png" height="50" alt="">
                                </div>end col
                                <div class="col-lg-2 col-md-4 col-6 mt-4 pt-2 text-center">
                                    <img src="${pageContext.request.contextPath}/asset/images/clients/3.png" height="50" alt="">
                                </div>end col
                                <div class="col-lg-2 col-md-4 col-6 mt-4 pt-2 text-center">
                                    <img src="${pageContext.request.contextPath}/asset/images/clients/4.png" height="50" alt="">
                                </div>end col
                                <div class="col-lg-2 col-md-4 col-6 mt-4 pt-2 text-center">
                                    <img src="${pageContext.request.contextPath}/asset/images/clients/1.png" height="50" alt="">
                                </div>end col
                                <div class="col-lg-2 col-md-4 col-6 mt-4 pt-2 text-center">
                                    <img src="${pageContext.request.contextPath}/asset/images/clients/2.png" height="50" alt="">
                                </div>end col
                            </div>
                        </div>-->
        </section>
        <!-- testimonial end -->

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
                $("html, body").animate({scrollTop: 800}, "slow");
                if ($(".job-display").length > 0) {
                    document.getElementById("slj").style.display = "none";
                    $(".smj").css("display", "inline-block");
                }
            });

        </script>
    </body>
</html>
