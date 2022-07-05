<%@page import="se1621.dto.JobApplication"%>
<%@page import="se1621.dto.ResumeSkill"%>
<%@page import="se1621.dto.Resume"%>
<%@page import="se1621.dto.Job"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Canđiates listing"/>
        </jsp:include>
    </head>

    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>
        <jsp:useBean id="chooseCategory" class="se1621.dao.CategoryDAO" scope="request"></jsp:useBean>

            <!-- Start home -->
            <section class="bg-half page-next-level"> 
                <div class="bg-overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="text-center text-white">
                                <h4 class="text-uppercase title mb-4">Candidates Listing</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Pages</a></li> 
                                    <li><a href="#" class="text-uppercase font-weight-bold">Candidates</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Candidates List</span> 
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->
            <!-- CANDIDATES LISTING START -->
            <section class="section pt-0">
                <div class="container">
                    <div class="row justify-content-center" style="margin-top: 70px">
                        <div class="col-12">
                            <div class="section-title text-center mb-4 pb-2">

                                <h4 class="title title-line pb-5">All Candidates Apply This Projects</h4>
                                <!--                                <p class="text-muted para-desc mx-auto mb-1">Post a job to tell us about your project. We'll quickly match you with the right freelancers.</p>-->

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12 mt-4 pt-2">
                            <div class="row align-items-center">
                                <div class="col-lg-12">
                                    <div class="show-results">
                                        <div class="float-left">
                                            <h5 class="text-dark mb-0 pt-2 f-18">Showing result</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>



                        <% List<JobApplication> listJobApplication = (List<JobApplication>) request.getAttribute("LIST_CANDIDATEOFJOB");
                            if (listJobApplication.isEmpty()) {
                                String message = (String) request.getAttribute("MESSAGE");
                        %>
                        <div class="col-lg-12 text-warning text-center">
                            <h3> <%=message%> </h3>
                        </div>
                        <%
                            }
                            if (listJobApplication != null) {
                                if (listJobApplication.size() > 0) {
                                    for (JobApplication jobAplication : listJobApplication) {
                        %>
                        <div class="job-display col-lg-12 mt-4 pt-2"style="display: none">
                            <div class="candidates-listing-item">
                                <div class="border mt-4 rounded p-3">
                                    <div class="row">
                                        <div class="col-md-9 ">
                                            <div class="float-left mr-4">
                                                <img src="<%= jobAplication.getResume().getAvatar()%>" alt="" class="img-fluid d-block rounded" height="50" style="width:220px;height:240px">
                                            </div>
                                            <div class="candidates-list-desc overflow-hidden job-single-meta  pt-2 p-3">
                                                <h4 class="mb-3"><a class="text-dark"><%= jobAplication.getResume().getFullName()%></a></h4>
                                                <p class=" mb-3"><h7  style="font-weight: 700"> Gender: </h7><%= jobAplication.getResume().getGender()%></p>
                                                <p class=" mb-3"><h7  style="font-weight: 700"> Gmail: </h7><%= jobAplication.getResume().getGmail()%></p>
                                                <p class=" mb-3"><h7  style="font-weight: 700"> Phone: </h7><%= jobAplication.getResume().getPhone()%></p>
                                                <p class=" mb-3"><h7 style="font-weight: 700">Skill: </h7> 
                                                    <%
                                                        List<ResumeSkill> listResumeSkills = jobAplication.getResume().getListResumeSkills();
                                                        for (int i = 0; i < listResumeSkills.size() - 1; i++) {
                                                    %>
                                                    <%= listResumeSkills.get(i).getSkill().getSkillName()%>,
                                                <%
                                                    }
                                                %>
                                                <%= listResumeSkills.get(listResumeSkills.size() - 1).getSkill().getSkillName()%>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="candidates-list-fav-btn text-right">        
                                                <div class="candidates-listing-btn mt-4">
                                                    <a href="${pageContext.request.contextPath}/MainController?action=SearchResumeID&studentID=<%= jobAplication.getResume().getUserID()%>" class="btn btn-primary-outline btn-sm " style="width: 50%">View Profile</a>
                                                </div>
                                                <div class="mt-3">
                                                    <%
                                                        int jobID = (Integer) request.getAttribute("JOBIDCANDIDATE");
                                                    %>
                                                    <button onclick="denyJobApp(<%= jobAplication.getResumeID()%>,<%= jobID%>)" type="button" class="btn btn-primary-outline-red btn-sm" data-toggle="modal" data-target="#confirmCancellation" style="width: 50%">
                                                        Deny
                                                    </button>
                                                </div>
                                                <div class="mt-3">
                                                    <button onclick="acceptJobApp(<%= jobAplication.getResumeID()%>,<%= jobID%>)" type="button" class="btn btn-primary-outline btn-sm" data-toggle="modal" data-target="#confirmAcceptaction" style="width: 50%">
                                                        Accept
                                                    </button>
                                                </div>
                                                <div class="mt-3">
                                                    <button onclick="getJobOrder('<%= jobAplication.getPriceDeal()%>', '<%= jobAplication.getMessage()%>', '<%= jobAplication.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View form application</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="ViewformApplication" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered " role="document">
                                <div class="modal-content">
                                    <div class="modal-header border-bottom-0">
                                        <h5 class="modal-title text-primary" id="exampleModalLabel">Application Form</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form method="post" action="${pageContext.request.contextPath}/MainController" enctype="multipart/form-data">
                                        <div class="modal-body">
                                            <div class="form-group text-dark">
                                                <label>Deal Price</label>
                                                <input type="text" id="dealPrice" class="form-control" name="priceDeal" placeholder="Enter price you want to deal" disabled>
                                            </div>
                                            <div class="form-group text-dark">
                                                <label>Message</label>
                                                <textarea class="my-textarea form-control" id="msg" name="message" placeholder="Message for employer" disabled></textarea>
                                            </div>
                                            <div class="form-group text-dark">
                                                <a class=""  target="_blank" rel="noopener noreferrer" type="text" id="CV" href="" ><p style="text-decoration: underline"> <i class="mdi mdi-link-variant"></i> View CV </p></a>
                                            </div>
                                        </div>

                                        <input type="hidden" name="jobID" value="${requestScope.JOB.jobID}">
                                        <input type="hidden" name="userID" value="${sessionScope.LOGIN_USER.userID}">
                                    </form>
                                </div>
                            </div>
                        </div>                    

                        <div class="modal fade" id="confirmCancellation" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-primary" id="exampleModalLongTitle">Do you want to deny this application?</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                        <a id="yesOption" href=""><button type="button" class="btn btn-primary">Yes</button></a>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="modal fade" id="confirmAcceptaction" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-primary" id="exampleModalLongTitle">Do you want to accept this application?</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                        <a id="yesOption2" href=""><button type="button" class="btn btn-primary">Yes</button></a>
                                    </div>
                                </div>
                            </div>
                        </div>
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
            </div>
        </section>
        <!-- CANDIDATES LISTING END -->



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
        <script src="${pageContext.request.contextPath}/asset/ckeditor/ckeditor.js"></script>
        <script>CKEDITOR.replace('message');</script>
        <script>
            function denyJobApp(resumeID, jobID) {
                $('#yesOption').attr('href', '${pageContext.request.contextPath}/MainController?action=DenyJob&jobID=' + jobID + '&resumeID=' + resumeID);
            }
        </script>

        <script>
            function acceptJobApp(resumeID, jobID) {
                $('#yesOption2').attr('href', '${pageContext.request.contextPath}/MainController?action=AcceptJob&jobID=' + jobID + '&resumeID=' + resumeID);
            }
        </script>
        <script>
            function getJobOrder(priceDeal, message, cvFile) {
                $("#dealPrice").val(priceDeal);
                CKEDITOR.instances["msg"].setData(message);
                document.getElementById('CV').setAttribute('href', cvFile);
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(".job-display").slice(0, 10).show();
            $(".smj").on("click", function () {
                $(".job-display:hidden").slice(0, 5).slideDown();
                if ($(".job-display:hidden").length == 0) {
                    $(".smj").fadeOut('slow');
                }
            });
        </script>
    </body>
</html>
