<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
    <jsp:include page="./include/header.jsp">
        <jsp:param name="title" value="FuJob | About Us"/>
    </jsp:include>
</head>

<body>
<jsp:include page="./components/loader.jsp"></jsp:include>
<jsp:include page="./include/navbar.jsp"></jsp:include>
<jsp:useBean id="totalJobPost" class="se1621.dao.JobDAO" scope="request"></jsp:useBean>
<jsp:useBean id="totalJobOrder" class="se1621.dao.JobApplicationDAO" scope="request"></jsp:useBean>
<jsp:useBean id="totalUserNonAD" class="se1621.dao.UserDAO" scope="request"></jsp:useBean>
<!-- Start home -->
<section class="bg-half page-next-level">
    <div class="bg-overlay"></div>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="text-center text-white">
                    <h4 class="text-uppercase title mb-4">About Us</h4>

                </div>
            </div>
        </div>
    </div>
</section>
<!-- end home -->
<!-- ABOUT US START -->
<section class="section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-4 col-md-3">
                <img src="https://cpad.ask.fm/233/987/771/-59996973-1tm75bm-61lhsk0efc6o1fp/original/file.jpg"
                     class="img-fluid rounded shadow" alt="">
            </div>
            <div class="col-lg-7 col-md-8">
                <div class="about-desc ml-lg-4">
                    <h4 class="text-dark">About us</h4>

                    <p class="text-muted">Matching the right people to the right projects is a very difficult problem in
                        Vietnam, a challenge for any recruitment platform. With the goal of applying technology to
                        change the recruitment market and make human resources more efficient, in early 2022, the idea
                        of FUJob was born.</p>

                    <p class="text-muted">Using technology, we create a platform that allows workers to find projects,
                        learn about companies and interact with employers.</p>

                    <p class="text-muted">Every day, we connect thousands of people with new project opportunities from
                        reputable businesses.</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ABOUT US END -->

<!-- COUNTER START -->
<section class="section bg-light">
    <div class="container">
        <div class="blog-post-counter">
            <div class="row" id="counter">
                <div class="col-md-4 col-6 border-right">
                    <div class="p-4">
                        <div class="blog-post counter-content text-center">
                            <h1 class="counter-value font-weight-light text-dark mb-2"
                                data-count="${totalJobOrder.allTotalJobOrder}">0</h1>
                            <p class="counter-name text-muted f-15 text-uppercase mb-2">Project order</p>
                            <i class="mdi mdi-account-multiple h3 text-muted"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-6 border-right">
                    <div class="p-4">
                        <div class="blog-post counter-content text-center">
                            <h1 class="counter-value font-weight-light text-dark mb-2"
                                data-count="${totalJobPost.allTotalJobPost}">0</h1>
                            <p class="counter-name text-muted f-15 text-uppercase mb-2">Project post</p>
                            <i class="mdi mdi-file h3 text-muted"></i>
                        </div>
                    </div>
                </div>

                <!--                            <div class="col-md-4 col-6 border-right">
                                                <div class="p-4">
                                                    <div class="blog-post counter-content text-center">
                                                        <h1 class="counter-value font-weight-light text-dark mb-2" data-count="101">0</h1>
                                                        <p class="counter-name text-muted f-15 text-uppercase mb-2">Member</p>
                                                        <i class="mdi mdi-bank h3 text-muted"></i>
                                                    </div>
                                                </div>
                                            </div>-->
                <div class="col-md-4 col-6">
                    <div class="p-4">
                        <div class="blog-post counter-content text-center">
                            <h1 class="counter-value font-weight-light text-dark mb-2"
                                data-count="${totalUserNonAD.allTotalUser_NonAD}">0</h1>
                            <p class="counter-name text-muted f-15 text-uppercase mb-2">Members</p>
                            <i class="mdi mdi-account-group h3 text-muted"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- COUNTER END -->

<!-- COMPANY TESTIMONIAL START -->
<section class="section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-5">
                <h4 class="text-dark font-weight-">Founders</h4>
                <div class="blog-post-border mt-3 mb-3"></div>
                <h5 class="text-muted mb-1">FuJob</h5>
                <!--                    <p class="mb-4 f-16"><a href="" class="text-muted"><i class="mdi mdi-earth mr-2"></i>FuJobltd.co.in</a></p>-->
                <p class="text-muted f-14">Members of group include:</p>
                <div class="job-details-desc-item">
                    <div class="float-left mr-3">
                        <i class="mdi mdi-minus text-muted f-16"></i>
                    </div>
                    <p class="text-muted f-14 mb-1">Le Ha Duy</p>
                </div>
                <div class="job-details-desc-item">
                    <div class="float-left mr-3">
                        <i class="mdi mdi-minus text-muted f-16"></i>
                    </div>
                    <p class="text-muted f-14 mb-1">Huynh Ngo Gia Bao</p>
                </div>
                <div class="job-details-desc-item">
                    <div class="float-left mr-3">
                        <i class="mdi mdi-minus text-muted f-16"></i>
                    </div>
                    <p class="text-muted f-14 mb-1">Nguyen Quoc Binh</p>
                </div>
                <div class="job-details-desc-item mb-4">
                    <div class="float-left mr-3">
                        <i class="mdi mdi-minus text-muted f-16"></i>
                    </div>
                    <p class="text-muted f-14 mb-1">Pham Duc Hung</p>
                </div>
                <p class="text-muted f-14">We are always trying to be better</p>
                <p class="border-top"></p>

                <!--                            <ul class="list-inline pt-4 border-top mb-4">
                                                <li class="list-inline-item float-right mt-2">
                                                    <ul class="list-inline bolg-post-icon mb-0">
                                                        <li class="list-inline-item f-20"><a href="" class=""><i class="mdi mdi-facebook"></i></a></li>
                                                        <li class="list-inline-item f-20"><a href="" class=""><i class="mdi mdi-twitter"></i></a></li>
                                                        <li class="list-inline-item f-20"><a href="" class=""><i class="mdi mdi-whatsapp"></i></a></li>
                                                        <li class="list-inline-item f-20"><a href="" class=""><i class="mdi mdi-instagram"></i></a></li>
                                                    </ul>
                                                </li>
                                            </ul>-->
            </div>

            <div class="col-lg-7">
                <div class="blog-post-testi">
                    <div class="row align-items-center">
                        <div class="col-md-3 col-4">
                            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist"
                                 aria-orientation="vertical">
                                <a class="nav-link about-us active" id="v-pills-home-tab" data-toggle="pill"
                                   href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
                                    <div class="blog-post-testi-img">
                                        <img src="https://wefresher.com/wp-content/uploads/2019/08/vai-tro-cua-lam-viec-nhom.jpg"
                                             alt="" class="img-fluid mx-auto d-block rounded">
                                        <div class="blog-post-overlay">
                                            <div class="blog-post-testi-icon text-center">
                                                <i class="mdi mdi-plus-circle-outline text-white h4"></i>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                                <a class="nav-link about-us" id="v-pills-profile-tab" data-toggle="pill"
                                   href="#v-pills-profile" role="tab" aria-controls="v-pills-profile"
                                   aria-selected="false">
                                    <div class="blog-post-testi-img">
                                        <img src="https://wiindi.net/DContent/Image/2021/01/Teamwork-la-gi-2.jpg" alt=""
                                             class="img-fluid mx-auto d-block rounded">
                                        <div class="blog-post-overlay">
                                            <div class="blog-post-testi-icon text-center">
                                                <i class="mdi mdi-plus-circle-outline text-white h4"></i>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                                <a class="nav-link about-us" id="v-pills-messages-tab" data-toggle="pill"
                                   href="#v-pills-messages" role="tab" aria-controls="v-pills-messages"
                                   aria-selected="false">
                                    <div class="blog-post-testi-img">
                                        <img src="https://www.waltonswords.com.au/wp-content/uploads/2020/06/Teamwork.jpg"
                                             alt="" class="img-fluid mx-auto d-block rounded">
                                        <div class="blog-post-overlay">
                                            <div class="blog-post-testi-icon text-center">
                                                <i class="mdi mdi-plus-circle-outline text-white h4"></i>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                                <a class="nav-link about-us" id="v-pills-settings-tab" data-toggle="pill"
                                   href="#v-pills-settings" role="tab" aria-controls="v-pills-settings"
                                   aria-selected="false">
                                    <div class="blog-post-testi-img">
                                        <img src="https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/CSFCMSEN/0is3e-sptkgyxm1kkblkgq.jpg"
                                             alt="" class="img-fluid mx-auto d-block rounded">
                                        <div class="blog-post-overlay">
                                            <div class="blog-post-testi-icon text-center">
                                                <i class="mdi mdi-plus-circle-outline text-white h4"></i>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                            </div>
                        </div>
                        <div class="col-md-9 col-8">
                            <div class="tab-content" id="v-pills-tabContent">
                                <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                                     aria-labelledby="v-pills-home-tab">
                                    <div>
                                        <img src="https://wefresher.com/wp-content/uploads/2019/08/vai-tro-cua-lam-viec-nhom.jpg"
                                             alt="" class="img-fluid mx-auto d-block rounded">
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
                                     aria-labelledby="v-pills-profile-tab">
                                    <div>
                                        <img src="https://wiindi.net/DContent/Image/2021/01/Teamwork-la-gi-2.jpg" alt=""
                                             class="img-fluid mx-auto d-block rounded">
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="v-pills-messages" role="tabpanel"
                                     aria-labelledby="v-pills-messages-tab">
                                    <div>
                                        <img src="https://www.waltonswords.com.au/wp-content/uploads/2020/06/Teamwork.jpg"
                                             alt="" class="img-fluid mx-auto d-block rounded">
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="v-pills-settings" role="tabpanel"
                                     aria-labelledby="v-pills-settings-tab">
                                    <div>
                                        <img src="https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/CSFCMSEN/0is3e-sptkgyxm1kkblkgq.jpg"
                                             alt="" class="img-fluid mx-auto d-block rounded">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- COMPANY TESTIMONIAL START -->

<!-- DOWNLOAD APP START -->
<!--    <section class="section pb-0" style="background: url('https://via.placeholder.com/2000X1333//88929f/5a6270C/O https://placeholder.com/') center center;">
        <div class="bg-overlay"></div>
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 order-md-1 order-2">
                    <div class="job-about-app-img mt-40">
                        <img src="images/app-download-img.png" alt="" class="img-fluid mx-auto d-block">
                    </div>
                </div>

                <div class="col-md-6 order-md-2 order-1">
                    <div class="app-about-content">
                        <div class="app-about-desc text-white">
                            <h4 class="text-white mb-3">Get Job App For Your Mobile</h4>
                            <p class="font-weight-light text-white-50">Etiam ultricies nisi vel that augue Curabitur ullamcorper ultricies adipiscing Nam at Etiam rhoncus Maecenas tempus tellus rhoncus ultricies eget condimentum rhoncus massa Sed cursus semquam.</p>
                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item"><a href="javascript:void(0)"><img src="images/apple.png" class="mt-2" height="60" alt=""></a></li>
                                <li class="list-inline-item"><a href="javascript:void(0)"><img src="images/google.png" class="mt-2" height="60" alt=""></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>-->
<!-- DOWNLOAD APP END -->

<!--             ABOUT CLIENTS START 
            <section class="section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-12">
                            <div class="section-title text-center mb-4 pb-2">
                                <h4 class="title title-line pb-5">Our Client's</h4>
                                <p class="text-muted para-desc mx-auto mb-1">Post a projects to tell us about your project. We'll quickly match you with the right freelancers.</p>
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
            </div>
        </section>-->
<!-- ABOUT CLIENTS END -->

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
