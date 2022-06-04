<%-- 
    Document   : job-details
    Created on : Jun 1, 2022, 7:52:12 AM
    Author     : HNGB
--%>
<%@page import="se1621.dao.JobOrderDAO"%>
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
                                <h4 class="text-uppercase title mb-4">Job Detail</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Jobs</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Job Detail</span> 
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
                    <div class="col-lg-12">
                        <h4 class="text-dark mb-3"><%= job.getCategory().getCategoryName()%></h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div class="job-detail border rounded p-4">
                            <div class="job-detail-content">
                                <img src="images/featured-job/img-4.png" alt="" class="img-fluid float-left mr-md-3 mr-2 mx-auto d-block">
                                <div class="job-detail-com-desc overflow-hidden d-block">
                                    <h4 class="mb-2"><a href="#" class="text-dark"></a>JOB: <%= job.getJobTitle()%></h4>
                                    <p class="text-muted mb-0"><i class="mdi mdi-bank text-muted"></i> <%= job.getCompany().getCompanyName()%></p>
                                    <p class="text-muted mb-0"><i class="mdi mdi-map-marker mr-2"></i><%= job.getAddress()%></p>
                                </div>
                            </div>
                            <div class="job-detail-desc mt-4">
                                <p class="text-muted mb-3">Estimated Completion Time: <%= job.getCompletionTime()%></p>

                                <p class="text-muted mb-0">Skill: <%= job.getSkill()%></p>
                            </div>    
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
                                        <p class="text-muted mb-3"><%= job.getDescription()%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="col-lg-4 col-md-5 mt-4 mt-sm-0">
                        <div class="job-detail border rounded p-4">
                            <h5 class="text-muted text-center pb-2"><i class="mdi mdi-map-marker mr-2"></i>Location</h5>

                            <div class="job-detail-location pt-4 border-top">
                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-bank text-muted"></i>
                                    </div>
                                    <p class="text-muted mb-2">:  ${requestScope.JOB.company.companyName}</p>
                                </div>

                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-email text-muted"></i>
                                    </div>
                                    <p class="text-muted mb-2">: <%= job.getEmail()%></p>
                                </div>

                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-web text-muted"></i>
                                    </div>
                                    <p class="text-muted mb-2">:  ${requestScope.JOB.company.website}</p>
                                </div>

                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-cellphone-iphone text-muted"></i>
                                    </div>
                                    <p class="text-muted mb-2">: <%= job.getPhone()%></p>
                                </div>

                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-currency-usd text-muted"></i>
                                    </div>
                                    <p class="text-muted mb-2">: <%= job.getSalary()%></p>
                                </div>

                                <div class="job-details-desc-item">
                                    <div class="float-left mr-2">
                                        <i class="mdi mdi-security text-muted"></i>
                                    </div>
                                    <p class="text-muted mb-2">: <%= job.getExperienceNeeded()%></p>
                                </div>

                            </div>
                        </div>
                        <%
                            if (loginUser != null && !StringUtils.equals(loginUser.getRole().getRoleID(), "HR")) {
                                JobOrderDAO jobOrderDAO = new JobOrderDAO();
                                boolean checkDuplicateUserOrderJob = jobOrderDAO.checkDuplicateJobOrderByOneUser(loginUser.getUserID(), job.getJobID());
                                if(checkDuplicateUserOrderJob){
                        %>
                                    <div class="job-detail border rounded mt-4">
                                        <button type="button" disabled class="btn btn-secondary btn-block">You Applied This Job</button>
                                    </div>
                        <%        
                                }else{
                        %>        
                                    <div class="job-detail border rounded mt-4">
                                        <a href="#" class="btn btn-primary btn-block" data-toggle="modal" data-target="#formApplication">Aplly For Job</a>
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
