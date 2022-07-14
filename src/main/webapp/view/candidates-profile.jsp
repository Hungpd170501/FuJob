<%@page import="java.text.SimpleDateFormat"%>
<%@page import="se1621.dto.JobSkills"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page import="se1621.dto.JobApplication"%>
<%@page import="se1621.dto.ResumeSkill"%>
<%@page import="se1621.dto.Resume"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Student Resume"/>
        </jsp:include>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .checked {
                color: orange;
            }
        </style>
    </head>

    <body>
        <jsp:include     page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>

        <%
            Resume resume = (Resume) request.getAttribute("RESUME");
            if (resume.getResumeID() == 0) {
                String message = (String) request.getAttribute("MESSAGE");
        %>
        <section class="bg-half page-next-level"> 
            <div class="bg-overlay"></div>
        </section>
        <section class="section text-center" name="action">
            <h3 class="text-warning "><%=message%></h3>
            <a href="${pageContext.request.contextPath}/MainController?action=CheckCreateResume&studentID=${sessionScope.LOGIN_USER.userID}"><p class="h5" style="text-decoration: underline">Create Your Resume Now</p></a>
        </section>
        <%
        } else {
        %>
        <!-- Start home -->
        <section class="bg-half page-next-level"> 
            <div class="bg-overlay"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="candidates-profile-details text-center">
                            <img id="image" src="${requestScope.RESUME.avatar}" height="150" alt="" class="d-block mx-auto shadow rounded-pill mb-4">
                            <h4 class="text-white mb-2"> <%=resume.getFullName()%> </h4>
                            <p class="text-white mb-2"><%=resume.getMajor()%></p>
                            <ul class="list-unstyled social-icon  mb-0">
                                <li class="list-inline-item"><a href="${requestScope.RESUME.website}" class="rounded"><i class="mdi mdi-web"></i></a></li>
                                <li class="list-inline-item"><a href="${requestScope.RESUME.linkedIn}" class="rounded"><i class="mdi mdi-linkedin"></i></a></li>
                                <li class="list-inline-item"><a href="${requestScope.RESUME.gitHub}" class="rounded"><i class="mdi mdi-github-box"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <%
                String messResume = (String) request.getAttribute("MESSAGE_RESUME");
                if (messResume != null) {
            %>
            <div class="col-5 mx-auto text-center alert alert-warning alert-dismissible fade show" role="alert">
                <strong><%= messResume%></strong>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%
                }
            %>
        </section>
        <!-- end home -->

        <!-- CANDIDATES PROFILE START -->

        <section class="section" name="action" value="SearchResumeID">



            <div class="container ">
                <div class="row">
                    <div class="col-lg-12">
                        <h4 class="text-dark">Overview</h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-3">
                        <div class="border rounded p-4">
                            <p class="list-inline pt-3 mb-0 "> ${requestScope.RESUME.overview} </p>

                            <ul class="list-inline pt-3 border-top mb-0 row mt-4">
                                <li class="list-inline-item mr-3 col-md-6">
                                    <p href="" class="f-15 mb-0 "><i class="mdi mdi-map-marker mr-2"></i><strong>Address:</strong>  ${requestScope.RESUME.address}</p>
                                </li>
                                <li class="list-inline-item mr-3 col-md-5">
                                    <p href="" class="f-15 mb-0"><i class="mdi mdi-email mr-2"></i><strong>Email:</strong> ${requestScope.RESUME.gmail}</p>
                                </li>

                                <li class="list-inline-item mr-3 col-md-6">
                                    <p href="" class="f-15 mb-0"><i class="mdi mdi-cellphone-iphone mr-2"></i><strong>Phone:</strong> ${requestScope.RESUME.phone}</p>
                                </li>
                                <%
                                    SimpleDateFormat simpleformat = new SimpleDateFormat("dd MMM yyyy");
                                    String date = simpleformat.format(resume.getCreatedDate());
                                %>
                                <li class="list-inline-item mr-3 col-md-5">
                                    <p href="" class="f-15 mb-0 "><i class="mdi mdi-timetable mr-2"></i><strong>Joined:</strong> <%= date%></p>
                                </li>
                            </ul>
                            <ul class="list-inline pt-3 border-top mb-0 row">
                                <li class="list-inline-item mr-3 col-md-3">
                                    <p href="" class="f-15 mb-0 "><i class=" mr-2"></i> Project Completed: 94%</p>                                  
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
                            <div class="col-lg-12 mt-4 pt-5">
                                <div class="border rounded candidates-profile-education text-center">
                                    <div class="profile-education-icon border rounded-pill bg-white text-primary">
                                        <i class="mdi mdi-36px mdi-school"></i>
                                    </div>
                                    <h6 class="text-uppercase f-17 font-weight-bold " style="letter-spacing: 5px"> FPT UNIVERSITY</h6>
                                    <p class="border-top"></p>
                                    <p class="f-14 mb-1"> ${requestScope.RESUME.major} </p>
                                    <p class="pb-3 mb-0"> GPA: ${requestScope.RESUME.gpa} </p>                               
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class ="col-lg-6">
                        <div class="row">
                            <div class="col-lg-12 mt-4 pt-2">
                                <h4 class="text-dark text-center">Experience</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 mt-4 pt-5">
                                <div class="border rounded candidates-profile-education text-center">
                                    <div class="profile-education-icon border rounded-pill bg-white text-primary">
                                        <i class="mdi mdi-36px mdi-briefcase-check"></i>
                                    </div>
                                    <h6 class="text-uppercase f-17 font-weight-bold " style="letter-spacing: 5px"></h6>
                                    <p class=""></p>
                                    <p class="pb-4 mb-0">Skills:
                                        <%
                                            List<ResumeSkill> listStudentSkill = (List<ResumeSkill>) request.getAttribute("LIST_STUDENTSKILL");
                                            for (int i = 0; i < listStudentSkill.size() - 1; i++) {
                                        %>
                                        <%= listStudentSkill.get(i).getSkill().getSkillName()%>,
                                        <%
                                            }
                                        %>
                                        <%= listStudentSkill.get(listStudentSkill.size() - 1).getSkill().getSkillName()%>
                                    </p>
                                    <p class="pb-4 mb-0">Website: ${requestScope.RESUME.website}</p>                               
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>         

        </section> 

        <section class="section pt-0">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center  pb-2">
                            <h4 class="title title-line pb-5">All Projects Completed</h4>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <% List<JobApplication> listJobApplication = (List<JobApplication>) request.getAttribute("LIST_ALLJOBONGOING_APPLIED");
                        if (listJobApplication.isEmpty()) {

                            String message = (String) request.getAttribute("MESSAGE0");
                    %>
                    <div class="col-lg-12 text-warning text-center">
                        <h3> <%=message%> </h3>
                    </div>
                    <%
                        }
                        if (listJobApplication != null) {
                            if (listJobApplication.size() > 0) {
                                for (JobApplication jobOrder : listJobApplication) {
                    %>
                    <div class="job-display col-lg-12  pt-2" >
                        <div class="job-list-box border rounded">
                            <div class="p-3">
                                <div class="row align-items-center">
                                    <div class="col-lg-3">
                                        <div class="company-logo-img">
                                            <% if (jobOrder.getResume().getAvatar() == null) {
                                            %>
                                            <img src="<%= jobOrder.getJob().getCompany().getAvatar()%>" alt="" class="img-fluid img-thumbnail mx-auto d-block" style="width:200px;height:200px">
                                            <%
                                            } else {
                                            %>
                                            <img src="<%= jobOrder.getResume().getAvatar()%>" alt="" class="img-fluid img-thumbnail mx-auto d-block" style="width:200px;height:200px">
                                            <%
                                                }
                                            %>

                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-9">
                                        <div class="job-list-desc">
                                            <% if (jobOrder.getResume().getAvatar() == null) {
                                            %>
                                            <h4 class="mb-2"><a href="" class="text-dark"><%= jobOrder.getJob().getCompany().getCompanyName()%>
                                                </a>
                                            </h4>
                                            <%
                                            } else {
                                            %>
                                            <h4 class="mb-2"><a href="" class="text-dark"><%= jobOrder.getResume().getFullName()%>
                                                </a>
                                            </h4>
                                            <%
                                                }
                                            %>
                                            <% for (int i = 0; i < jobOrder.getEvaluateCompletion().getRatingValue(); i++) {
                                            %>
                                            <span class="fa fa-star checked"></span>
                                            <%
                                                }
                                                for (int j = jobOrder.getEvaluateCompletion().getRatingValue(); j < 5; j++) {
                                            %>
                                            <span class="fa fa-star"></span>
                                            <%
                                                }
                                            %>
                                            

                                            <h6 class="mt-4"><%= jobOrder.getEvaluateCompletion().getContent()%></h6>

                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-3">
                                        <div class="job-list-button-sm text-right">
                                            <div class="mt-3">
                                                <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>" class="btn btn-sm btn-primary">View Detail Job</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal -->

                    <%

                                }

                            }
                        }

                    %>
                    <%                                if (listJobApplication.size() > 10) {
                    %>
                    <div class="smj col-12 text-center mt-4 pt-2">
                        <a class="btn btn-primary-outline">Show more</a>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>           
        <%
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
        <script>
            var img = $('#image').attr('src');
            if (img == "") {
                document.getElementById("image").src = "https://imgfan.com/images/imgupload.jpg";
            }
        </script>
    </body>
</html>