<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Job Detail"/>
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
                        <h4 class="text-uppercase title mb-4">Job Detail</h4>
                        <ul class="page-next d-inline-block mb-0">
                            <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                            <li><a href="#" class="text-uppercase font-weight-bold">Jobs</a></li> 
                            <li>
                                <span class="text-uppercase text-white font-weight-bold">Job Detail two</span> 
                            </li> 
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end home -->

    <!-- JOB SINGLE START -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-7">
                    <div class="job-detail text-center job-single border rounded p-4">
                        <div class="job-single-img mb-2">
                            <img src="images/featured-job/img-1.png" alt="" class="img-fluid mx-auto d-block">
                        </div>
                        <h4 class=""><a href="#" class="text-dark">Web Designer</a></h4>
                        <ul class="list-inline mb-0">
                            <li class="list-inline-item mr-3">
                                <p class="text-muted mb-2"><i class="mdi mdi-bank mr-1"></i>Web Themes.pvt.Ltd</p>
                            </li>

                            <li class="list-inline-item">
                                <p class="text-muted mb-2"><i class="mdi mdi-map-marker mr-1"></i>Jim Rosa Lane San Francisco</p>
                            </li>

                            <li class="list-inline-item">
                                <p class="text-muted mb-2"><i class="mdi mdi-currency-usd mr-1"></i>$850 - $1000/month</p>
                            </li>
                        </ul>
                        <p class="text-muted mb-0">Suspendisse pulvinar augue ac venenatis condimentum at sem libero volutpat nibh that nec pellentesque velit pede quis nunc Fusce a quam etiam ut purus mattis mauris sodales aliquam curabitur site Quisque placerat namipsum risus rutrum vitaeeumolestie vel lacus sed augue</p>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <h5 class="text-dark mt-4">Job Description :</h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="job-detail border rounded mt-2 p-4">
                                <div class="job-detail-desc">
                                    <p class="text-muted mb-3">Aenean vulputate eleifend tellus aenean leo ligula porttitor consequat vitae eleifend ac enim liquam lorem ante, dapibus in, viverra quis feugiat a tellu hasellus viverra nulla ut metus varius laoreet uisque rutrum enean imperdiet tiam ultricies nisi vel augue urabitur ullamcorper ultricies nisi am eget dui tiam rhoncus aecenas tempus tellus eget condimentum rhoncus sem quam semper libero amet adipiscing sem neque sed ipsum am quam nunc blandit luctus pulvinar hendrerit idlorem Maecenas nec odio et ante tincidunt tempus. Nullam quis ante. </p>

                                    <p class="text-muted mb-0">Nam quam nunc blandit vel luctus pulvinar hendrerit id lorem Maecenas nec odio et ante tincidunt tempus donec vitae sapien ut libero venenatis faucibus ullam quis ante tiam sit amet orci eget eros faucibus tincidunt ed fringilla mauris sit amet nibh Donec sodales sagittis magna ed consequat leo eget bibendum sodales augue velit cursus nunc quis gravida magna mi libero usce vulputate eleifend sapien estibulum purus qua scelerisque ut mollis sed nonummy id metus ullam accumsan lorem Vivamus elementum semper enean vulputate eleifend tellus enean leo ligula porttitor eu consequat vitae eleifend ac enim liquam lorem ante dapibus viverra quis feugiat tellus hasellus viverra nulla ut metus varius laoreet uisque rutrum Aenean imperdiet in dui</p>
                                </div>

                                <ul class="list-inline mt-3 mb-0">
                                    <li class="list-inline-item mr-3">
                                        <a href="" class="text-muted mb-0"><i class="mdi mdi-earth mr-1"></i>www.example.com</a>
                                    </li>

                                    <li class="list-inline-item mr-3">
                                        <a href="" class="text-muted mb-0"><i class="mdi mdi-download mr-1"></i>Download Info</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <h4 class="text-dark mt-4">Education & Experience :</h4>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="job-detail border rounded mt-2 p-4">
                                <div class="job-detail-desc">
                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Morbi mattis ullamcorper velit hasellus gravida semper nisi nullam vel sem.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Phasellus viverra nulla ut metus varius laoreet uisque rutrum enean imperdiet.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Etiam ultricies nisi vel augue Curabitur ullamcorper ultricies nisi am eget dui tiam rhoncus.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Donec mollis hendrerit risus hasellus nec sem in justo pellentesque facilisis.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Praesent congue erat at massa Sed cursus turpis vitae tortor onec posuere vulputate arcu.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Donec elit libero, sodales nec volutpat a suscipit non turpis ullam sagittis.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Pellentesque auctor neque nec urna Proin sapien ipsum porta a auctor quis euismod ut mi.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-0">Ptristique senectus et netus et malesuada fames porta a auctor quis euismod ut mi.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <h5 class="text-dark mt-4">Responsibilities :</h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="job-detail border rounded mt-2 p-4">
                                <div class="job-detail-desc">
                                    <p class="text-muted mb-3">Aenean vulputate eleifend tellus aenean leo ligula porttitor consequat at vitae eleifend ac enim liquam lorem ante, dapibus in, viverra quis feugiat a tellu hasellus viverra nulla ut metus varius laoreet uisque rutrum enean imperdiet tiam ultricies nisi vel augue urabitur ullamcorper ultricies nisi am eget dui tiam rhoncus aecenas tempus tellus eget condimentum rhoncus sem quam semper libero amet Nullam quis ante. </p>
                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Morbi mattis ullamcorper velit hasellus gravida semper nisi nullam vel sem.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Phasellus viverra nulla ut metus varius laoreet uisque rutrum enean imperdiet.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Etiam ultricies nisi vel augue Curabitur ullamcorper ultricies nisi am eget dui tiam rhoncus.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Donec mollis hendrerit risus hasellus nec sem in justo pellentesque facilisis.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-2">Praesent congue erat at massa Sed cursus turpis vitae tortor onec posuere vulputate arcu.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <i class="mdi mdi-minus text-muted"></i>
                                        </div>
                                        <p class="text-muted mb-0">Donec elit libero, sodales nec volutpat a suscipit non turpis ullam sagittis.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <h5 class="text-dark mt-4">How To Apply :</h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="job-detail border rounded mt-2 p-4">
                                <div class="job-detail-desc">
                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <p class="text-muted mb-0">1 )</p>
                                        </div>
                                        <p class="text-muted mb-3 overflow-hidden d-block">Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae In ac dui quis mi consectetuer lacinia ed aliquam ultrices mauris nteger ante arcu accumsan consectetuer thet a eget posuere ut mauris raesent adipiscing Sed lectus Donec mollis hendrerit risus hasellue.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <p class="text-muted mb-0">2 )</p>
                                        </div>
                                        <p class="text-muted mb-3 overflow-hidden d-block">In enim justo rhoncus ut imperdiet a venenatis vitae justo ullam dictum felis eu pede mollis pretium nteger tincidunt enean imperdiet tiam ultricies nisi vel augue urabitur ullamcorper ultricies nisi am eget Etiam rhoncus ras dapibus ivamus elementum semper nisi.</p>
                                    </div>

                                    <div class="job-details-desc-item">
                                        <div class="float-left mr-3">
                                            <p class="text-muted mb-0">3 )</p>
                                        </div>
                                        <p class="text-muted mb-0 overflow-hidden d-block">Maecenas nec odio et ante tincidunt tempus onec vitae sapien ut libero venenatis faucibus ullam quis ante tiam sit Vestibulum purus quam scelerisque ut mollis sed nonummy id metus ullam accumsan lorem in dui ras ultricies mi eu turpis hendrerit fringilla amet orci eget eros.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-5 mt-4 mt-sm-0 pt-2 pt-sm-0">
                    <div class="company-brand-logo text-center">
                        <img src="images/featured-job/img-2.png" alt="" class="img-fluid mx-auto d-block mb-3">
                        <h5 class="text-muted mb-0"><a href="#" class="text-muted"><i class="mdi mdi-bank mr-1"></i>Themes Code.Pvt.Ltd</a></h5>
                    </div>

                    <div class="job-detail rounded border job-overview mt-4 mb-4">
                        <div class="single-post-item mb-4">
                            <div class="float-left mr-3">
                                <i class="mdi mdi-security text-muted mdi-24px"></i>
                            </div>
                            <div class="overview-details">
                                <h6 class="text-muted mb-0">Experience</h6>
                                <h6 class="text-black-50 pt-2 mb-0">1 To 3 Years Exp.</h6>
                            </div>
                        </div>

                        <div class="single-post-item mb-4">
                            <div class="float-left mr-3">
                                <i class="mdi mdi-currency-usd text-muted mdi-24px"></i>
                            </div>
                            <div class="overview-details">
                                <h6 class="text-muted mb-0">Salary</h6>
                                <h6 class="text-black-50 pt-2 mb-0">$700 - $1200/month</h6>
                            </div>
                        </div>

                        <div class="single-post-item mb-4">
                            <div class="float-left mr-3">
                                <i class="mdi mdi-apps text-muted mdi-24px"></i>
                            </div>
                            <div class="overview-details">
                                <h6 class="text-muted mb-0">Category</h6>
                                <h6 class="text-black-50 pt-2 mb-0">Developer</h6>
                            </div>
                        </div>

                        <div class="single-post-item mb-4">
                            <div class="float-left mr-3">
                                <i class="mdi mdi-human-male-female text-muted mdi-24px"></i>
                            </div>
                            <div class="overview-details">
                                <h6 class="text-muted mb-0">Gender</h6>
                                <h6 class="text-black-50 pt-2 mb-0">Male & Female</h6>
                            </div>
                        </div>

                        <div class="single-post-item mb-4">
                            <div class="float-left mr-3">
                                <i class="mdi mdi-calendar-today text-muted mdi-24px"></i>
                            </div>
                            <div class="overview-details">
                                <h6 class="text-muted mb-0">Date Posted</h6>
                                <h6 class="text-black-50 pt-2 mb-0">30/08/2018</h6>
                            </div>
                        </div>

                        <div class="single-post-item mb-4">
                            <div class="float-left mr-3">
                                <i class="mdi mdi-email text-muted mdi-24px"></i>
                            </div>
                            <div class="overview-details">
                                <h6 class="text-muted mb-0">Email</h6>
                                <h6 class="text-black-50 pt-2 mb-0">Themescode@gmail.com</h6>
                            </div>
                        </div>

                        <div class="single-post-item">
                            <div class="float-left mr-3">
                                <i class="mdi mdi-phone-classic text-muted mdi-24px"></i>
                            </div>
                            <div class="overview-details">
                                <h6 class="text-muted mb-0">Contact No</h6>
                                <h6 class="text-black-50 pt-2 mb-0">+91 1987 6543 21</h6>
                            </div>
                        </div>
                    </div>

                    <h5 class="text-dark">Job Location</h5>
                    <div class="map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d6030.418742494061!2d-111.34563870463673!3d26.01036670629853!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses-419!2smx!4v1471908546569" class="rounded" style="border: 0" allowfullscreen=""></iframe>
                    </div>

                    <div class="job-details-desc-item mt-2">
                        <div class="float-left mr-2">
                            <i class="mdi mdi-map-marker text-muted"></i>
                        </div>
                        <p class="text-muted mb-2">2254 Horizon CircleTacoma, WA 98499</p>
                    </div>

                    <ul class="social-icon list-inline mb-0 mt-4">
                        <li class="list-inline-item">Share :</li>
                        <li class="list-inline-item"><a href="#" class=" rounded"><i class="mdi mdi-facebook"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=" rounded"><i class="mdi mdi-twitter"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=" rounded"><i class="mdi mdi-google-plus"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=" rounded"><i class="mdi mdi-whatsapp"></i></a></li>
                        <li class="list-inline-item"><a href="#" class=" rounded"><i class="mdi mdi-linkedin"></i></a></li>
                    </ul>

                    <div class="mt-4">
                        <a href="#" class="btn btn-primary btn-block btn-sm"><i class="mdi mdi-send mr-2"></i>Apply This Job</a>
                    </div>

                    <div class="mt-4">
                        <div class="job-single-or position-relative">
                            <h6 class="mb-0 text-dark text-center">OR</h6>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="job-single-social-icon text-center mt-4">
                                <a href="" class="text-white"><i class="mdi mdi-facebook facebook"></i></a>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="job-single-social-icon text-center mt-4">
                                <a href="" class="text-white"><i class="mdi mdi-google-plus google"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- JOB SINGLE END -->

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