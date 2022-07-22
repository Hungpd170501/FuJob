<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="se1621.dao.JobSkillsDAO"%>
<%@page import="se1621.dto.JobSkills"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Date"%>
<%@page import="se1621.dto.User"%>
<%@page import="se1621.dto.Job"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Projects Posted "/>
        </jsp:include>
    </head>
    <body>

        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>

        <%
            User hr = (User) request.getAttribute("HR");
        %>
        <!-- Start home -->
        <section class="bg-half page-next-level">

            <div class="bg-overlay"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="text-center text-white">
                            <h4 class="text-uppercase title mb-4">List Posted Projects</h4>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end home -->

        <div class="container">
            <div class="home-form-position">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="home-registration-form job-list-reg-form bg-light shadow p-4 mb-3">

                            <!-- START SEARCH -->
                            <form class="registration-form" action="${pageContext.request.contextPath}/MainController">
                                <!--<form class="registration-form">-->
                                <div class="row">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-briefcase"></i>

                                            <input type="text" name="searchTitle" id="exampleInputName1" class="form-control rounded registration-input-box" placeholder="Title...">
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-archive"></i>

                                            <select class="demo-default" id="select-category" name="searchSkill" >
                                                <option value="">Skill...</option>
                                                <c:forEach items="${applicationScope.SKILL_LIST}" var="i">
                                                    <option value="${i.skillID}">${i.skillName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-list-alt"></i>

                                            <select id="select-category" class="demo-default" name="searchCate">
                                                <option value="">Categories...</option>
                                                <c:forEach items="${applicationScope.CATEGORY_LIST}" var="i">
                                                    <option value="${i.categoryID}">${i.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">

                                            <input type="submit" id="submit" class="submitBnt btn btn-primary btn-block" value="Find">
                                            <!-- name = action  -->
                                            <input type="hidden" name ="action" value="searchJobPost">
                                            <input type="hidden" name ="hrID" value="<%= hr.getUserID()%>">
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <!-- END SEARCH -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JOB LIST START -->
        <section class="section pt-0">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <%
                            String messCancel = (String) request.getAttribute("MESSAGE_CANCEL");
                            if (messCancel != null) {
                        %>
                        <div class="col-5 mx-auto text-center alert alert-warning alert-dismissible fade show" role="alert">
                            <strong><%= messCancel%></strong>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <%
                            }
                        %> 
                        <div class="section-title text-center mb-4 pb-2">
                            <%
                                User loginUser = (User) session.getAttribute("LOGIN_USER");
                                if (loginUser != null && StringUtils.equals(loginUser.getRole().getRoleID(), "HRM")) {
                            %>
                            <h4 class="title title-line pb-5">Projects were posted by <%= hr.getFullName()%> </h4>
                            <%
                            } else {
                            %>
                            <h4 class="title title-line pb-5">List of projects posted</h4>
                            <%
                                }
                            %>
                            <p class="text-muted para-desc mx-auto mb-1">Tell us about your project. We'll quickly match you with the right freelancers.</p>
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
<!--                                    <div class="cell-md-4 mt-4 float-right">
                                        <select class="form-control resume" id="statusFilter" data-filter="false">
                                            <option value="" selected>All</option>
                                            <option value="Published">Published</option>
                                            <option value="Handed Over">Handed Over</option>
                                            <option value="Posting Expired">Posting Expired</option>
                                        </select>
                                    </div>-->
                                </div>
                            </div>
                        </div>
                        <!-- them display -->

                        <div class="row" > 
                            <ul id="paintings"
                                data-role="list"
                                data-sort-class="painting"
                                data-sort-dir="desc"
                                data-cls-list="unstyled-list row flex-justify-center mt-4"
                                data-cls-list-item="cell-sm-6 cell-md-4"
                                data-filter-class="painting-author"
                                data-show-pagination="true"
                                data-items="10"
                                data-items-steps="all, 3, 10"
                                data-show-list-info="true"
                                >
                            <% List<Job> listJob = (List<Job>) request.getAttribute("LIST_JOBPOST");
                                if (listJob == null || listJob.isEmpty()) {
                                    String message = (String) request.getAttribute("MESSAGE");
                            %>
                            <div class="col-lg-12 text-warning text-center">
                                <h3> <%=message%> </h3>
                            </div>
                            <%
                                }
                                if (listJob != null) {
                                    if (listJob.size() > 0) {
                                        for (Job job : listJob) {
                            %>
                            <li style="list-style: none">
                            <div class="job-display col-lg-12 mt-4 pt-1">

                                <div class="job-list-box border rounded" >
                                    <div class="p-3" style="width: 1100px">
                                        <div class="row align-items-center">
                                            <div class="col-lg-3">
                                                <div class="company-logo-img">

                                                    <img loading="lazy" src="<%= job.getCategory().getImg()%>" alt="" class="img-fluid img-thumbnail mx-auto d-block" style="width:250px;height:250px">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-9">
                                                <div class="job-list-desc">
                                                    <h4 class="mb-1" style="font-weight: 700"><a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= job.getJobID()%>" class="text-dark"><%= job.getJobTitle()%>
                                                            <% if (job.getJobStatus() == 1) {
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-bookmark-check mt-4" style="font-size: 25px; color: green"></i> 
                                                            <i class="painting-author" style="font-style: normal;font-size: 20px ; font-weight: bold; color: green">Open</i>
                                                            <%
                                                                }
                                                            %>
                                                        </a>
                                                    </h4>
                                                    <%
                                                        Date dateNow = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                                                        long exDate = Math.abs(job.getExpiriedDate().getTime() - dateNow.getTime());
                                                        long resultDate = exDate / (24 * 60 * 60 * 1000);
                                                    %>
                                                    <p class="mb-2 text-muted"> <%= resultDate%> days left</p>
                                                    <%
                                                        String description = job.getDescription();
                                                        if (description.length() > 200) {
                                                            description = description.substring(0, 197) + ". . .";
                                                        }
                                                    %>
                                                    <p class="mb-4"><%= description%></p>
                                                    <h6>Skills Require: 
                                                        <%
                                                            List<JobSkills> listJobSkills = job.getListJobSkills();
                                                            for (int i = 0; i < listJobSkills.size() - 1; i++) {
                                                        %>
                                                        <%= listJobSkills.get(i).getSkill().getSkillName()%>,
                                                        <%
                                                            }
                                                        %>
                                                        <%= listJobSkills.get(listJobSkills.size() - 1).getSkill().getSkillName()%>
                                                    </h6>
                                                    <h6>
                                                        <%= job.getPayMentMethod().getPaymentMethodName()%>: <%= job.getMinBudget()%>$ - <%= job.getMaxBudget()%>$ <% if (job.getPayMentMethod().getPaymentMethodID() == 2) {
                                                        %>
                                                        / hour
                                                        <%
                                                            }
                                                        %>
                                                    </h6>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3">
                                                <div class="job-list-button-sm text-right">

                                                    <% if (job.getJobStatus() == 1) {
                                                    %>
                                                    <div>
                                                        <p class=" "><i class="mr-2"></i><%= job.getBids()%>  bid(s)</p>
                                                    </div>
                                                    <br>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=EditJob&jobID=<%= job.getJobID()%>" class="btn btn-sm btn-primary-outline" style="width: 50%">Edit Project</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= job.getJobID()%>" class="btn btn-sm btn-primary-outline" style="width: 50%">View Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <a onclick="getJobPostID(<%=job.getJobID()%>, <%= job.getUserID()%>)" href="#" class="btn btn-primary-outline-red btn-sm" data-toggle="modal" data-target="#formCancel" style="width: 50%">Delete</a>
                                                    </div>
                                                    
                                                    <div class="mt-3">

                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchCandidateOfJob&JobIDCandidate=<%= job.getJobID()%>" class="btn btn-sm btn-primary-outline"style="width: 50%">List candidate</a>
                                                    </div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </li>
                            <div class="modal fade" id="confirmCancellation" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title text-primary" id="exampleModalLongTitle">Do you want to cancel your application?</h5>
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

                            <div class="modal fade" id="formCancel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header border-bottom-0">
                                            <h5 class="modal-title text-primary" id="exampleModalLabel">Cancellation Form</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form id="FormCancellation" method="post" action="" enctype="multipart/form-data">
                                            <div class="modal-body">
                                                <div class="form-group text-dark">
                                                    <label>Your Reason<span class="text-danger">*</span></label>
                                                    <textarea class="form-control" name="reasonCancel" id="reasonCancel" placeholder="Reason you cancel this project"></textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer  d-flex justify-content-center">
                                                <input type="submit" class="btn btn-primary" value="Send" style="width: 165px">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <%
                                        }

                                    }
                                }

                            %>
                            <%                                if (listJob.size() > 10) {
                            %>
                            <div class="smj col-12 text-center mt-4 pt-2">
                                <a class="btn btn-primary-outline">Show more</a>
                            </div>
                            <%
                                }
                            %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Back to top -->

        <a href="#" class="back-to-top rounded text-center" id="back-to-top" style="display: inline"> 
            <i class="mdi mdi-chevron-up d-block"></i> 
        </a>
        <!-- Back to top -->
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
        <script src="${pageContext.request.contextPath}/asset/js/metro.min.js"></script>
<!--        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                                            $(".job-display").slice(0, 10).show();
                                                            $(".smj").on("click", function () {
                                                                $(".job-display:hidden").slice(0, 5).slideDown();
                                                                if ($(".job-display:hidden").length == 0) {
                                                                    $(".smj").fadeOut('slow');
                                                                }
                                                            });
        </script>-->

        <script>
            function getJobPostID(id, userID) {
                $('#FormCancellation').attr('action', '${pageContext.request.contextPath}/MainController?action=DeleteJobPost&jobPostID=' + id + '&userID=' + userID);
            }
        </script>
        <script>
            $(document).ready(function() {
            $('#statusFilter').on('change', function() {
            $('#paintings').data('list').filter(this.value);
            });
                    });
        </script>

        <script>CKEDITOR.replace('message');</script>


    </body>

</html>
