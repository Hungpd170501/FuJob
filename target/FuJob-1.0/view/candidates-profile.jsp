<%@page import="se1621.dto.Resume"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Candidate Profile"/>
        </jsp:include>

    </head>

    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>


        <%
            String search = request.getParameter("searchResumeID");
            if (search == null) {
                search = " ";
            }
        %>

        <%
            List<Resume> listResume = (List<Resume>) request.getAttribute("LIST_RESUME");
            if (listResume.isEmpty()) {
                String message = (String) request.getAttribute("MESSAGE");
        %>
         <section class="bg-half page-next-level"> 
             <div class="bg-overlay"></div>
         </section>
        <section class="section text-center" name="action">
            <h3 class="text-warning "><%=message%></h3>
            <a href="${pageContext.request.contextPath}/view/create-resume.jsp"><p class="h5" style="text-decoration: underline">Create Your Resume Now</p></a>
        </section>
        <%
            }
            if (listResume != null) {
                if (listResume.size() > 0) {
        %>

        <%
            for (Resume resume : listResume) {
        %>
        <!-- Start home -->
        <section class="bg-half page-next-level"> 
            <div class="bg-overlay"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="candidates-profile-details text-center">
                            <img src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" height="150" alt="" class="d-block mx-auto shadow rounded-pill mb-4">
                            <h5 class="text-white mb-2"> <%=resume.getFullName()%> </h5>
                            <p class="text-white-50 h6 mb-2"><i class="mdi mdi-bank mr-2"></i><%= resume.getWebsite()%></p>
                            <p class="text-white-50 h6 mb-2"><%=resume.getMajor()%></p>
                            <ul class="candidates-profile-icons list-inline mb-3">
                                <li class="list-inline-item"><a href="#" class="text-warning"><i class="mdi mdi-star"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="text-warning"><i class="mdi mdi-star"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="text-warning"><i class="mdi mdi-star"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="text-warning"><i class="mdi mdi-star"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="text-warning"><i class="mdi mdi-star"></i></a></li>
                            </ul>

                            <ul class="list-unstyled social-icon social mb-0">
                                <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-facebook"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-twitter"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-instagram"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded"><i class="mdi mdi-google-plus"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end home -->

        <!-- CANDIDATES PROFILE START -->

        <section class="section" name="action" value="SearchResumeID">



            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h4 class="text-dark">Overview</h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-3">
                        <div class="border rounded p-4">
                            <p class="text-muted"> <%= resume.getOverview()%> </p>

                            <ul class="list-inline pt-3 border-top mb-0 row">
                                <li class="list-inline-item mr-3 col-md-3">
                                    <p href="" class="text-muted f-15 mb-0 "><i class="mdi mdi-map-marker mr-2"></i><%= resume.getAddress()%></p>
                                </li>

                                <li class="list-inline-item mr-3 col-md-3">
                                    <p href="" class="text-muted f-15 mb-0 "><i class="mdi mdi-web mr-2"></i><%= resume.getWebsite()%></p>
                                </li>

                                <li class="list-inline-item mr-3 col-md-3">
                                    <p href="" class="text-muted f-15 mb-0"><i class="mdi mdi-email mr-2"></i><%= resume.getGmail()%></p>
                                </li>

                                <li class="list-inline-item mr-3">
                                    <p href="" class="text-muted f-15 mb-0"><i class="mdi mdi-cellphone-iphone mr-2"></i><%= resume.getPhone()%></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>



                <div class = "row">
                    <div class ="col-lg-6">
                        <div class="row">
                            <div class="col-lg-12 mt-4 pt-2">
                                <h4 class="text-dark text-center">Education</h4>
                            </div>
                        </div>
                        <div class="row">
                            <!--                    <div class="col-lg-3"></div>-->
                            <div class="col-lg-12 mt-4 pt-5">
                                <div class="border rounded candidates-profile-education text-center text-muted">
                                    <div class="profile-education-icon border rounded-pill bg-white text-primary">
                                        <i class="mdi mdi-36px mdi-school"></i>
                                    </div>
                                    <h6 class="text-uppercase f-17 text-muted font-weight-bold " style="letter-spacing: 5px"> <%= resume.getSchoolName()%> </p></h6>
                                    <p class="border-top"></p>
                                    <p class="f-14 mb-1"> <%= resume.getMajor()%> </p>
                                    <p class="pb-3 mb-0"> GPA: <%= resume.getGpa()%> </p>                               
                                </div>
                            </div>
                            <!--                    <div class="col-lg-3"></div>-->
                        </div>
                    </div>
                    <div class ="col-lg-6">
                        <div class="row">
                            <div class="col-lg-12 mt-4 pt-2">
                                <h4 class="text-dark text-center">Experience</h4>
                            </div>
                        </div>
                        <div class="row">
                            <!--                    <div class="col-lg-3"></div>-->
                            <div class="col-lg-12 mt-4 pt-5">
                                <div class="border rounded candidates-profile-education text-center text-muted">
                                    <div class="profile-education-icon border rounded-pill bg-white text-primary">
                                        <i class="mdi mdi-36px mdi-briefcase-check"></i>
                                    </div>
                                    <h6 class="pb-3 mb-0">Experience: <%= resume.getExperienceYear()%> </p></h6>
                                    <p class="pb-3 mb-0">Skills: </p>
                                    <p class="pb-3 mb-0">Website: <%= resume.getWebsite()%> </p>                               
                                </div>
                            </div>
                            <!--                    <div class="col-lg-3"></div>-->
                        </div>
                    </div>
                </div>
            </div>         

        </section>  
        <%
            }
        %>

        <%
                }
            }
        %>
        <!-- CANDIDATES PROFILE END -->

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