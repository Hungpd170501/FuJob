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
    </head>

    <body>
        <jsp:include     page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>

        <%
            Resume resume = (Resume) request.getAttribute("RESUME");
            if (resume == null) {
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
            }
            if (resume != null) {
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
                            <!--                    <div class="col-lg-3"></div>-->
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
