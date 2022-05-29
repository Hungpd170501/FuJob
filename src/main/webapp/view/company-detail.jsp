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


            <section class="section" name="action" value="Search">
            <%
                String search = request.getParameter("search");
                if (search == null) {
                    search = "";
                }
            %>

            <%
                List<CompanyInfo> listCompany = (List<CompanyInfo>) request.getAttribute("LIST_COMPANY");
                if (listCompany != null) {
                    if (listCompany.size() > 0) {
            %>

            <%
                for (CompanyInfo company : listCompany) {
            %>
            <form action="/FuJob/MainController">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="text-sm-center">
                                <img src="images/featured-job/img-3.png" alt="" class="img-fluid mx-md-auto d-block">
                                <h4 class="mt-3"><a href="#" class="text-dark"> <%= company.getCompanyName() %> </a></h4>
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item mr-3">
                                        <p class="text-muted mb-0"><i class="mdi mdi-map-marker mr-2"></i><%= company.getAddress() %></p>
                                    </li>

                                    <li class="list-inline-item">
                                        <p class="text-success mb-0"><i class="mdi mdi-bookmark-check mdi-18px mr-2"></i>Verified</p>
                                    </li>
                                </ul>

                                <ul class="list-inline mb-2">
                                    <li class="list-inline-item mr-3 ">
                                        <p class="text-muted"><i class="mdi mdi-earth mr-2"></i><%= company.getWebsite() %></p>
                                    </li>

                                    <li class="list-inline-item mr-3">
                                        <p class="text-muted"><i class="mdi mdi-email mr-2"></i><%= company.getGmail() %></p>
                                    </li>

                                    <li class="list-inline-item">
                                        <p class="text-muted"><i class="mdi mdi-cellphone-iphone mr-2"></i><%= company.getPhone() %></p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="border-top border-bottom pt-4 pb-4">
                                <div class="row justify-content-sm-center">
                                    <div class="col-lg-2 col-md-3 col-6">
                                        <div class="text-sm-center m-14">
                                            <h5 class="text-dark mb-2">Employer</h5>
                                            <p class="text-muted mb-0"><%= company.getNumberOfEmployee() %></p>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 col-md-3 col-6">
                                        <div class="text-sm-center m-14">
                                            <h5 class="text-dark mb-2">Type</h5>
                                            <p class="text-muted mb-0"><%= company.getTypeCompany() %></p>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 col-md-3 col-6">
                                        <div class="text-sm-center m-14">
                                            <h5 class="text-dark mb-2">Established Year</h5>
                                            <p class="text-muted mb-0"><%= company.getEstablishedYear() %> years </p>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 col-md-3 col-6">
                                        <div class="text-sm-center m-14">
                                            <h5 class="text-dark mb-2">Salary</h5>
                                            <p class="text-muted mb-0">$700 - $2000/month</p>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 col-md-3 col-6">
                                        <div class="text-sm-center m-14">
                                            <h5 class="text-dark mb-2">Followers</h5>
                                            <p class="text-muted mb-0">584230 +</p>
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
<!--                            <p class="text-muted">At vero eos accusamus iusto odio dignissimos ducimus blanditiis praesentium voluptatum deleniti that is atque corrupti dolores et quas molestias excepturi sint occaecati cupiditate non at provident similique sunt in culpa qui officia deserunt mollitia animi id est laboru at dolorum fuga Nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus at enim ipsam voluptatem quia voluptas aut odit aut fugit Cum sociis natoque penatibus magnis dis parturient montes nascetur ridiculus mus donec quam felis ultricies nec pellentesque eu pretium quis sem that phasellus viverra nulla ut metus varius laoreet.</p>
                                <p class="text-muted">Nobis est eligendi optio cumque nihil impedit quo minus quod maxime at placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus at enim ipsam eligendi optio cumque nihil impedit quo minus quod maxime placeat voluptatem quia that voluptas aut odit aut fugit Cum sociis natoque penatibus magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec this pellentesque eu pretium quis sem hasellus viverra nulla ut metus varius laoreet uisque rutrum enean imperdie tiam ultricies nisi vel augue.</p>
                                <p class="text-muted mb-0">Optio cumque nihil impedit quo minus quod maxime at placeate facere possimuse omnis voluptas assumenda est omnis dolor repellendus at enim ipsam voluptatem quia voluptas aut odit aut fugit um sociis natoque penatibus magnis dis parturient montes nascetur at ridiculus mus onec quam felis ultricies nec nihil impedit quo minus quod maxime at placeat facere possimuse omnis voluptas assumenda est omnis dolor repellendus at enime pellentesque eu pretium quis sem Phasellus viverra nulla ut metus varius laoreet uisque rutrum enean imperdiet tiam ultricies nisi vel augue Donec elit libero sodales nec volutpat a suscipit non turpis ullam sagittis Suspendisse pulvinar at augue ac venenatis condimentum sem libero volutpat nibh nec pellentesque velit pede quis nunc estibulum ante ipsum primis in faucibus orci luctus et ultrices as cubilia Curae usce id purus varius tincidunt libero Phasellus dolor.</p>-->
                                <p class="text-muted"> <%= company.getCompanyOverview() %> </p>
                            </div>
                        </div>
                    </div>

<!--                    <div class="row">
                        <div class="col-lg-12 mt-4 pt-2">
                            <h4>Services :</h4>
                            <div class="rounded border p-4 mt-3">
                                <p class="text-muted">Aenean tellus metus bibendum sed posuere ac mattis non nunc estibulum fringilla pede sit amet augue n turpis Pellentesque posuere raesent turpis enean posuere tortor sed cursus feugiat nunc augue blandit nunc sollicitudin at dolor sagittis lacus estibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae Sed aliquam nisi quis porttitor congue elit erat euismod orci ac placerat dolor lectus quis orci repellendus at enime pellentesque eu pretium quis sem Phasellus viverra nulla hasellus consectetuer vestibulum elit.</p>
                                <h6 class="text-dark">Details :</h6>
                                <p class="text-muted"><i class="mdi mdi-check text-success"></i> Morbi mattis ullamcorper velit hasellus gravida semper nisi nullam vel sem.</p>
                                <p class="text-muted"><i class="mdi mdi-check text-success"></i> Phasellus viverra nulla ut metus varius laoreet uisque rutrum enean imperdiet.</p>
                                <p class="text-muted"><i class="mdi mdi-check text-success"></i> Etiam ultricies nisi vel augue Curabitur ullamcorper ultricies nisi am eget dui tiam rhoncus.</p>
                                <p class="text-muted"><i class="mdi mdi-check text-success"></i> Donec mollis hendrerit risus hasellus nec sem in justo pellentesque facilisis.</p>
                                <p class="text-muted"><i class="mdi mdi-check text-success"></i> Praesent congue erat at massa Sed cursus turpis vitae tortor onec posuere vulputate arcu.</p>
                                <p class="text-muted"><i class="mdi mdi-check text-success"></i> Donec elit libero, sodales nec volutpat a suscipit non turpis ullam sagittis.</p>
                                <p class="text-muted mb-0"><i class="mdi mdi-check text-success"></i> Aenean tellus metus bibendum sed posuere ac mattis non nunc estibulum fringilla.</p>
                            </div>
                        </div>
                    </div>-->

<!--                    <div class="row">
                        <div class="col-lg-12 mt-4 pt-2">
                            <h4>Company Review :</h4>
                        </div>

                        <div class="col-lg-8 col-md-7">
                            <div class="shadow rounded p-4 mt-4">
                                <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" alt="" height="90" class="float-left shadow rounded-pill mr-3">
                                <div class="d-block overflow-hidden">
                                    <h6 class="text-muted font-weight-light float-right mb-0"><i class="mdi mdi-clock-outline mr-1"></i>32 minutes ago</h6>
                                    <h5 class="mb-1"><a href="#" class="text-dark">Mario Thomas</a></h5>
                                    <small class="text-muted font-weight-bold">Web Developer</small>
                                    <ul class="employers-icons list-inline mb-1">
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">Phasellus viverra nulla ut metus varius laoreet quisque rutrum aenean imperdiet etiam ultricies nisi avel augue curabitur ullamcorper ultricies nisi nam eget dui.</p>
                                </div>
                            </div>

                            <div class="shadow rounded p-4 mt-4">
                                <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" alt="" height="90" class="float-left shadow rounded-pill mr-3">
                                <div class="d-block overflow-hidden">
                                    <h6 class="text-muted font-weight-light float-right mb-0"><i class="mdi mdi-clock-outline mr-1"></i>49 minutes ago</h6>
                                    <h5 class="mb-1"><a href="#" class="text-dark">Mario Thomas</a></h5>
                                    <small class="text-muted font-weight-bold">Web Developer</small>
                                    <ul class="employers-icons list-inline mb-1">
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">Phasellus viverra nulla ut metus varius laoreet quisque rutrum aenean imperdiet etiam ultricies nisi avel augue curabitur ullamcorper ultricies nisi nam eget dui.</p>
                                </div>
                            </div>

                            <div class="shadow rounded p-4 mt-4">
                                <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" alt="" height="90" class="float-left shadow rounded-pill mr-3">
                                <div class="d-block overflow-hidden">
                                    <h6 class="text-muted font-weight-light float-right mb-0"><i class="mdi mdi-clock-outline mr-1"></i>1 Days Ago</h6>
                                    <h5 class="mb-1"><a href="#" class="text-dark">Mario Thomas</a></h5>
                                    <small class="text-muted font-weight-bold">Web Developer</small>
                                    <ul class="employers-icons list-inline mb-1">
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">Phasellus viverra nulla ut metus varius laoreet quisque rutrum aenean imperdiet etiam ultricies nisi avel augue curabitur ullamcorper ultricies nisi nam eget dui.</p>
                                </div>
                            </div>

                            <div class="shadow rounded p-4 mt-4">
                                <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" alt="" height="90" class="float-left shadow rounded-pill mr-3">
                                <div class="d-block overflow-hidden">
                                    <h6 class="text-muted font-weight-light float-right mb-0"><i class="mdi mdi-clock-outline mr-1"></i>3 Day Ago</h6>
                                    <h5 class="mb-1"><a href="#" class="text-dark">Mario Thomas</a></h5>
                                    <small class="text-muted font-weight-bold">Web Developer</small>
                                    <ul class="employers-icons list-inline mb-1">
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item mr-0 text-success"><i class="mdi mdi-star"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">Phasellus viverra nulla ut metus varius laoreet quisque rutrum aenean imperdiet etiam ultricies nisi avel augue curabitur ullamcorper ultricies nisi nam eget dui.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-5 mt-4">
                            <div class="p-4 rounded text-center shadow">
                                <h5 class="text-dark">Share This Job</h5>
                                <ul class="social-icon social list-unstyled mb-0">
                                    <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-facebook"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-twitter"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-google-plus"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-linkedin"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-pinterest"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-instagram"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-share-variant"></i></a></li>
                                </ul>

                                <div class="map mt-3">
                                    <iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d6030.418742494061!2d-111.34563870463673!3d26.01036670629853!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses-419!2smx!4v1471908546569" class="rounded" style="border: 0" allowfullscreen=""></iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>-->
            </form>
            <%
                }
            %>

            <%
                    }
                }
            %>
        </section>

        <!-- EMPLOYERS DETAILS END -->

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