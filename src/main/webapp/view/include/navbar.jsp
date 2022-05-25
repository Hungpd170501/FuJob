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
            <a href="#" class="logo">
                <img src="${pageContext.request.contextPath}/asset/images/logo-light.png" alt="" class="logo-light" height="18" />
                <img src="${pageContext.request.contextPath}/asset/images/logo-dark.png" alt="" class="logo-dark" height="18" />
            </a>
        </div>                 
        <div class="buy-button">
            <a href="view/post-a-job.jsp" class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Post a Job</a>
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
                        <li><a href="/FuJob/view/job-list.jsp">Job List</a></li>
                        <li><a href="/FuJob//view/job-grid.html">Job Grid</a></li>
                        <li><a href="/FuJob//view/job-details.html">Job Details</a></li>
                        <li><a href="/FuJob//view/job-details-2.jsp">Job Details-2</a></li>
                    </ul>
                </li>

                <li class="has-submenu">
                    <a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                    <ul class="submenu">
                        <li><a href="/FuJob/view/about.jsp">About us</a></li>
                        <li><a href="/FuJob/view/services.html">Services</a></li>
                        <li><a href="/FuJob/view/team.html">Team</a></li>
                        <li><a href="/FuJob/view/faq.html">Faqs</a></li>
                        <li><a href="/FuJob/view/pricing.html">Pricing plans</a></li>
                        <li class="has-submenu"><a href="javascript:void(0)"> Candidates</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="/FuJob/view/candidates-listing.jsp">Candidates Listing</a></li>
                                <li><a href="/FuJob/view/candidates-profile.jsp">Candidates Profile</a></li>
                                <li><a href="/FuJob/view/create-resume.jsp">Create Resume</a></li>
                            </ul>  
                        </li>
                        <li class="has-submenu"><a href="javascript:void(0)"> Blog</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="/FuJob/view/blog-grid.html">Blogs</a></li>
                                <li><a href="/FuJob/view/blog-sidebar.html">Blog Sidebar</a></li>
                                <li><a href="/FuJob/view/blog-details.html">Blog Details</a></li>
                            </ul>  
                        </li>
                        <li class="has-submenu"><a href="javascript:void(0)"> Employers</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="/FuJob/view/employers-list.jsp">Employers List</a></li>
                                <li><a href="/FuJob/view/company-detail.jsp">Company Detail</a></li>
                            </ul>  
                        </li>
                        <li class="has-submenu"><a href="javascript:void(0)"> User Pages</a><span class="submenu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="/FuJob/view/login.jsp">Login</a></li>
                                <li><a href="/FuJob/view/signup.jsp">Signup</a></li>
                                <li><a href="/FuJob/view/recovery_password.jsp">Forgot Password</a></li>
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
