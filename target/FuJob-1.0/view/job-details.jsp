<%-- 
    Document   : job-details
    Created on : Jun 1, 2022, 7:52:12 AM
    Author     : HNGB
--%>
<%@page import="se1621.dao.JobApplicationDAO"%>
<%@page import="se1621.dto.JobApplication"%>
<%@page import="se1621.dao.ResumeDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="se1621.dto.JobSkills"%>
<%@page import="java.util.List"%>
<%@page import="se1621.dto.SkillRequire"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="se1621.dto.User"%>
<%@page import="se1621.dto.Job"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Job Detail"/>
        </jsp:include>
    </head>
    <body>
        <%
            User loginUser = (User) session.getAttribute("LOGIN_USER");
        %>
        <jsp:include page="./components/loader.jsp"></jsp:include>

        <jsp:include page="./include/navbar.jsp"></jsp:include>

            <!-- Start home -->
            <section class="bg-half page-next-level"> 
                <div class="bg-overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="text-center text-white">
                                <h4 class="text-uppercase title mb-4">Projects Detail</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Projects</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Projects Detail</span> 
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->

            <!-- JOB DETAILS START -->
            <section class="section">
            <%
                Job job = (Job) request.getAttribute("JOB");
                if (job != null) {
            %>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center" style="margin-bottom: 50px">
                        <h1 class="mb-2" style="font-weight: 700"><a href="#" class="text-dark"></a><%= job.getJobTitle()%></h1>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div class="row job-detail border rounded p-4 row">
                            <div class="col-lg-5">
                                <img src="<%= job.getCategory().getImg()%>" alt="" class="img-fluid img-thumbnail float-left mr-md-3 mr-2 mx-auto d-block" style="width:800px;height:250px">
                            </div>
                            <div class="col-lg-7" style="margin-top: 30px">
                                <div class="job-detail-com-desc overflow-hidden d-block">
                                    <p class=" mb-3"><h7  style="font-weight: 700"> Category: </h7><%= job.getCategory().getCategoryName()%></p>
                                    <p class=" mb-3"><h7 style="font-weight: 700">Skill require: </h7> 
                                        <%
                                            List<JobSkills> listJobSkills = (List<JobSkills>) request.getAttribute("LIST_SKILLREQUIRE");
                                            for (int i = 0; i < listJobSkills.size() - 1; i++) {
                                        %>
                                        <%= listJobSkills.get(i).getSkill().getSkillName()%>,
                                    <%
                                        }
                                    %>
                                    <%= listJobSkills.get(listJobSkills.size() - 1).getSkill().getSkillName()%>
                                    </p>
                                    <p class=" mb-3"><h7 style="font-weight: 700"> Budget: </h7><%= job.getBudget()%> $ <% if(job.getPaymentMethodID() == 2)
                                    { %> 
                                        / hour
                                    <% } %></p>
                                <%  
                                    Date dateNow = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                                    long exDate = Math.abs(job.getExpiriedDate().getTime() - dateNow.getTime());
                                    long resultDate = exDate/(24*60*60*1000);
                                %>
                                    <p class=" mb-3"><h7 style="font-weight: 700"> Expiry Date: </h7><%= resultDate %> days left</p>
                                </div>
                            </div> 
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-12">
                                <div class="job-detail border rounded mt-2 p-4"> 
                                    <div>
                                        <h5 class="text-dark"  style="font-weight: 700">Projects Description </h5>
                                    </div>
                                    <div class="job-detail-location pt-4 border-top">
                                        <div class="job-detail-desc">
                                            <p class="mb-3"><%= job.getDescription()%></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-5 mt-4 mt-sm-0">
                        <div class="job-detail border rounded p-4">
                            <h5 class="text-center pb-2" style="font-weight: 700">Contact me</h5>
                            <div class="job-detail-location pt-4 border-top">
                                <%
                                    if(job.getCompany().getCompanyName()!= null){
                                %>
                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-office-building" style="color: gray" ></i>
                                    </div>
                                    <p class=" mb-2"><a href="${pageContext.request.contextPath}/MainController?action=SearchCompanyID&searchCompanyID=<%= job.getCompany().getCompanyID() %>"> <%= job.getCompany().getCompanyName() %></a></p>
                                </div>
                                <%
                                    }
                                %>
                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-map-marker" style="color: red" ></i>
                                    </div>
                                    <p class="mb-2"><%= job.getAddress()%></p>
                                </div>
                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-email" style="color: #008fd8"></i>
                                    </div>
                                    <p class="mb-2"><%= job.getEmail()%></p>
                                </div>
                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-cellphone-iphone" style="color: #079992"></i>
                                    </div>
                                    <p class="mb-2"><%= job.getPhone()%></p>
                                </div>
                            </div>
                        </div>

                        <%
                            if (loginUser == null) {
                        %>
                        <div class="job-detail border rounded mt-4">
                            <a href="${pageContext.request.contextPath}/view/login.jsp" class="btn btn-primary btn-block">Apply For Projects</a>
                        </div>
                        <%
                        } else if (loginUser != null && !StringUtils.equals(loginUser.getRole().getRoleID(), "HR")) {
                            JobApplicationDAO jobOrderDAO = new JobApplicationDAO();
                            ResumeDAO resumeDAO = new ResumeDAO();
                            boolean checkDuplicateUserOrderJob = jobOrderDAO.checkDuplicateJobOrderByOneUser(resumeDAO.getResumeID(loginUser.getUserID()), job.getJobID());
                            if (checkDuplicateUserOrderJob) {
                        %>
                        <div class="job-detail border rounded mt-4">
                            <button type="button" disabled class="btn btn-secondary btn-block">You Applied This Project</button>
                        </div>
                        <%
                        } else {
                        %>        
                        <div class="job-detail border rounded mt-4">
                            <a href="#" class="btn btn-primary btn-block" data-toggle="modal" data-target="#formApplication">Apply For Projects</a>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
                <!--Application Form-->        
            </div>
        </section>
        <!-- JOB DETAILS END -->

        <!-- footer start -->

        <jsp:include page="./include/footer.jsp"></jsp:include>

            <!--Application Form--> 
        <jsp:include page="./components/formApplication.jsp"></jsp:include>
        <%
            }
        %>


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
