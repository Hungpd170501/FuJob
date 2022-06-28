<%-- 
    Document   : contact
    Created on : May 24, 2022, 9:40:28 AM
    Author     : HNGB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="./include/header.jsp">
        <jsp:param name="title" value="FuJob | Contact Page"/>
    </jsp:include>
</head>
<body>
<!-- Loader -->
<div id="preloader">
    <div id="status">
        <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
        </div>
    </div>
</div>
<!-- Loader -->

<!-- Navigation Bar-->
<header id="topnav" class="defaultscroll scroll-active">
    <!-- Tagline STart -->
    <div class="tagline">
        <div class="container">
            <div class="float-left">
                <div class="phone">
                    <i class="mdi mdi-phone-classic"></i> +1 800 123 45 67
                </div>
                <div class="email">
                    <a href="#">
                        <i class="mdi mdi-email"></i> Support@mail.com
                    </a>
                </div>
            </div>
            <div class="float-right">
                <ul class="topbar-list list-unstyled d-flex" style="margin: 11px 0px;">
                    <li class="list-inline-item"><a href="javascript:void(0);"><i class="mdi mdi-account mr-2"></i>Benny Simpson</a></li>
                    <li class="list-inline-item">
                        <select id="select-lang" class="demo-default">
                            <option value="">Language</option>
                            <option value="4">English</option>
                            <option value="1">Spanish</option>
                            <option value="3">French</option>
                            <option value="5">Hindi</option>
                        </select>
                    </li>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <!-- Tagline End -->

    <!-- Menu Start -->
    <div class="container">
        <!-- Logo container-->
        <div>
            <a href="index.html" class="logo">
                <img src="images/logo-light.png" alt="" class="logo-light" height="18" />
                <img src="images/logo-dark.png" alt="" class="logo-dark" height="18" />
            </a>
        </div>
        <div class="buy-button">
            <a href="post-a-job.html" class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Post a Job</a>
        </div><!--end login button-->
        <!-- End Logo container-->
        <div class="menu-extras">
            <div class="menu-item">
                <!-- Mobile menu toggle-->
                <a class="navbar-toggle">
                    <div class="lines">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </a>
                <!-- End mobile menu toggle-->
            </div>
        </div>

        <div id="navigation">
            <!-- Navigation Menu-->
            <ul class="navigation-menu">
                <li><a href="index.html">Home</a></li>
                <li class="has-submenu">
                    <a href="javascript:void(0)">Jobs</a><span class="menu-arrow"></span>
                    <ul class="submenu">
                        <li><a href="job-list.html">Job List</a></li>
                        <li><a href="job-grid.html">Job Grid</a></li>
                        <li><a href="job-details.html">Job Details</a></li>
                        <li><a href="job-details-2.html">Job Details-2</a></li>
                    </ul>
                </li>

                <li class="has-submenu">
                    <a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                    <ul class="submenu">
                        <li><a href="about.html">About us</a></li>
                        <li><a href="services.html">Services</a></li>
                        <li><a href="team.html">Team</a></li>
                        <li><a href="faq.html">Faqs</a></li>
                        <li><a href="pricing.html">Pricing plans</a></li>
                        <li class="has-submenu"><a href="javascript:void(0)"> Candidates</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="candidates-listing.html">Candidates Listing</a></li>
                                <li><a href="candidates-profile.html">Candidates Profile</a></li>
                                <li><a href="create-resume.html">Create Resume</a></li>
                            </ul>
                        </li>
                        <li class="has-submenu"><a href="javascript:void(0)"> Blog</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="blog-grid.html">Blogs</a></li>
                                <li><a href="blog-sidebar.html">Blog Sidebar</a></li>
                                <li><a href="blog-details.html">Blog Details</a></li>
                            </ul>
                        </li>
                        <li class="has-submenu"><a href="javascript:void(0)"> Employers</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="employers-list.html">Employers List</a></li>
                                <li><a href="company-detail.html">Company Detail</a></li>
                            </ul>
                        </li>
                        <li class="has-submenu"><a href="javascript:void(0)"> User Pages</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="login.html">Login</a></li>
                                <li><a href="signup.html">Signup</a></li>
                                <li><a href="recovery_passward.html">Forgot Password</a></li>
                            </ul>
                        </li>
                        <li><a href="components.html"> Components</a></li>
                    </ul>
                </li>
                <li>
                    <a href="contact.html">contact</a>
                </li>
            </ul><!--end navigation menu-->
        </div><!--end navigation-->
    </div><!--end container-->
    <!--end end-->
</header><!--end header-->
<!-- Navbar End -->

<!-- Start home -->
<section class="bg-half page-next-level">
    <div class="bg-overlay"></div>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="text-center text-white">
                    <h4 class="text-uppercase title mb-4">Contact Us</h4>
                    <ul class="page-next d-inline-block mb-0">
                        <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                        <li>
                            <span class="text-uppercase text-white font-weight-bold">Contact Us</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end home -->

<!-- MAP START -->
<section class="section pt-0 bg-light">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 p-0">
                <div class="map">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d6030.418742494061!2d-111.34563870463673!3d26.01036670629853!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses-419!2smx!4v1471908546569" style="border: 0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-100 mt-60">
        <div class="row align-items-center">
            <div class="col-lg-4">
                <div class="contact-item mt-40">
                    <div class="float-left">
                        <div class="contact-icon d-inline-block border rounded-pill shadow text-primary mt-1 mr-4">
                            <i class="mdi mdi-earth"></i>
                        </div>
                    </div>
                    <div class="contact-details">
                        <h4 class="text-dark mb-1">Website</h4>
                        <p class="mb-0 text-muted">Brandcode Pvt.Ltd.co.in</p>
                        <p class="mb-0 text-muted">Themescode Pvt.Ltd.co.in</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="contact-item mt-40">
                    <div class="float-left">
                        <div class="contact-icon d-inline-block border rounded-pill shadow text-primary mt-1 mr-4">
                            <i class="mdi mdi-cellphone-iphone"></i>
                        </div>
                    </div>
                    <div class="contact-details">
                        <h4 class="text-dark mb-1">Call us</h4>
                        <p class="mb-0 text-muted">123 456 7890</p>
                        <p class="mb-0 text-muted">123 456 7890</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="contact-item mt-40">
                    <div class="float-left">
                        <div class="contact-icon d-inline-block border rounded-pill shadow text-primary mt-1 mr-4">
                            <i class="mdi mdi-email"></i>
                        </div>
                    </div>
                    <div class="contact-details">
                        <h4 class="text-dark mb-1">Email</h4>
                        <p class="mb-0 text-muted">Themescodeltd@gmail.com</p>
                        <p class="mb-0 text-muted">Brandcodeltd@gmail.com</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- CONTACT END -->

<!-- CONTACT FORM START -->
<section class="section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h4 class="text-dark mb-0">Get In Touch :</h4>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8 col-md-7 mt-4 pt-2">
                <div class="custom-form rounded border p-4">
                    <div id="message"></div>
                    <form method="post" action="php/contact.php" name="contact-form" id="contact-form">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group app-label">
                                    <label class="text-muted">Name</label>
                                    <input name="name" id="name2" type="text" class="form-control resume" placeholder="Enter Name..">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group app-label">
                                    <label class="text-muted">Email address</label>
                                    <input name="email" id="email1" type="email" class="form-control resume" placeholder="Enter Email..">
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group app-label">
                                    <label class="text-muted">Subject</label>
                                    <input type="text" class="form-control resume" id="subject" placeholder="Subject..">
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group app-label">
                                    <label class="text-muted">Message</label>
                                    <textarea name="comments" id="comments" rows="5" class="form-control resume" placeholder="Message.."></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <input type="submit" id="submit" name="send" class="submitBnt btn btn-primary" value="Send Message">
                                <div id="simple-msg"></div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-lg-4 col-md-5 mt-4 pt-2">
                <div class="border rounded text-center p-4">
                    <h5 class="text-dark pb-3">Contact Info</h5>
                    <div class="contact-location rounded mt-5 p-4">
                        <div class="contact-location-icon bg-white text-primary rounded-pill">
                            <i class="mdi mdi-map-marker"></i>
                        </div>
                        <p class="text-muted pt-4 f-20 mb-0">2453 Clinton StreetLittle Rock, AR 72211</p>
                    </div>
                    <h6 class="text-muted mt-4 mb-0">Share</h6>
                    <ul class="list-unstyled social-icon mt-3 mb-0">
                        <li class="list-inline-item"><a href="#" class=""><i class="mdi mdi-facebook"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=""><i class="mdi mdi-twitter"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=""><i class="mdi mdi-whatsapp"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=""><i class="mdi mdi-instagram"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=""><i class="mdi mdi-linkedin"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- CONTACT FORM END -->

<!-- subscribe start -->
<section class="section bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-5">
                <div class="float-left position-relative notification-icon mr-2">
                    <i class="mdi mdi-bell-outline text-primary"></i>
                    <span class="badge badge-pill badge-danger">1</span>
                </div>
                <h5 class="mt-2 mb-0">Your Job Notification</h5>
            </div>
            <div class="col-lg-8 col-md-7 mt-4 mt-sm-0">
                <form>
                    <div class="form-group mb-0">
                        <div class="input-group mb-0">
                            <input name="email" id="email" type="email" class="form-control" placeholder="Your email :" required="" aria-describedby="newssubscribebtn">
                            <div class="input-group-append">
                                <button class="btn btn-primary submitBnt" type="submit" id="newssubscribebtn">Subscribe</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!-- subscribe end -->

<!--footer-->
<jsp:include page="./include/footer.jsp"></jsp:include>
<!-- Back to top -->
<a href="#" class="back-to-top rounded text-center" id="back-to-top">
    <i class="mdi mdi-chevron-up d-block"> </i>
</a>
<!-- Back to top -->

<!-- javascript -->

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