
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page import="se1621.dto.JobSkills"%>
<%@page import="se1621.dto.JobApplication"%>
<%@page import="se1621.dto.Job"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Current Work"/>
        </jsp:include>
        <style>
            .checked {
                color: orange;
            }
        </style>
    </head>
    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>

            <!-- Start home -->
            <section class="bg-half page-next-level">
                <div class="bg-overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="text-center text-white">
                                <h4 class="text-uppercase title mb-4">Current Work</h4>

                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->
            <!--SEARCH-->
            <div class="container">
                <div class="home-form-position">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="p-4 mb-3">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- JOB LIST START -->
            <section class="section pt-0">
                <div class="container">
                    <div class="row justify-content-center">
                    <%
                        String messResume = (String) request.getAttribute("MESSAGE_UPDATE");
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
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">All Current Works</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4 pt-2">
                        <div class="row align-items-center">
                            <div class="col-lg-12">
                                <div class="show-results">
                                    <!--                                    <div class="float-left registration-form-box">
                                                                            <input style="width: 150%" type="text" id="searchjs" onkeyup="myFunction()" placeholder="Search project name..">
                                                                        </div>-->
                                    <div class="float-left">
                                        <h5 class="text-dark mb-0 pt-2 f-18">Showing result</h5>
                                    </div>
                                    <!-- Select tình trang JOB -->
                                    <div class="cell-md-4 mt-4 float-right">
                                        <select class="form-control resume" id="statusFilter" data-filter="false">
                                            <option value="" selected>All</option>
                                            <option value="In Progress">In Progress</option>
                                            <option value="Pending Review">Pending Review</option>
                                            <option value="Submission Rejected<">Submission Rejected</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Môt sô tool co the xai duoc cho phan trang va sort -->
                        <div id="chuaNameJob" class="row">
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
                                <% List<JobApplication> listJobApplication = (List<JobApplication>) request.getAttribute("LIST_ALLJOBONGOING_APPLIED");
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
                                            for (JobApplication jobOrder : listJobApplication) {
                                                if (jobOrder.getJob().getDisputeStatus() != 1) {
                                %>
                                <li style="list-style: none">
                                    <div class="job-display col-lg-12 mt-4 pt-2">
                                        <div class="job-list-box border rounded">
                                            <div class="p-3" style="width: 1100px">
                                                <div class="row align-items-center">
                                                    <div class="col-lg-3">
                                                        <div class="company-logo-img">
                                                            <img src="<%= jobOrder.getJob().getCategory().getImg()%>" alt="" class="img-fluid img-thumbnail mx-auto d-block" style="width:250px;height:250px">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-9">
                                                        <div class="job-list-desc">
                                                            <h4 class="mb-2"><a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>" class="text-dark"><%= jobOrder.getJob().getJobTitle()%>
                                                                    <% if (jobOrder.getJobApplicationStatus() == 3) {
                                                                    %>
                                                                    <br>
                                                                    <i class="mdi mdi-bookmark-check mt-4" style="font-size: 25px; color: green"></i> 
                                                                    <i class="painting-author" style="font-style: normal;font-size: 20px ; font-weight: bold; color: green">In Progress</i>
                                                                    <%
                                                                    } else if (jobOrder.getJobApplicationStatus() == 8) {
                                                                    %>
                                                                    <br>
                                                                    <i class="mdi mdi-bookmark-check mt-4" style="font-size: 25px; color: orange"></i> 
                                                                    <i class="painting-author" style="font-style: normal;font-size: 20px ; font-weight: bold; color: orange">Pending Review</i>
                                                                    <%
                                                                    } else if (jobOrder.getJobApplicationStatus() == 9) {
                                                                    %>
                                                                    <br>
                                                                    <i class="mdi mdi-close-box mt-4" style="font-size: 25px; color: red"></i> 
                                                                    <i class="painting-author" style="font-style: normal;font-size: 20px ; font-weight: bold; color: red">Submission Rejected</i>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </a>
                                                            </h4>

                                                            <%
                                                                String description = jobOrder.getJob().getDescription();
                                                                if (description.length() > 200 || description.isBlank()) {
                                                                    description = description.substring(0, 197) + ". . .";
                                                                }
                                                            %>
                                                            <p class="mb-4"><%= description%></p>
                                                            <h6>Skills Require:
                                                                <%
                                                                    List<JobSkills> listJobSkills = jobOrder.getJob().getListJobSkills();
                                                                    for (int i = 0; i < listJobSkills.size() - 1; i++) {
                                                                %>
                                                                <%= listJobSkills.get(i).getSkill().getSkillName()%>,
                                                                <%
                                                                    }
                                                                %>
                                                                <%= listJobSkills.get(listJobSkills.size() - 1).getSkill().getSkillName()%>
                                                            </h6>
                                                            <h6>
                                                                <%= jobOrder.getJob().getPayMentMethod().getPaymentMethodName()%>: <%= jobOrder.getJob().getMinBudget()%>$ - <%= jobOrder.getJob().getMaxBudget()%>$ <% if (jobOrder.getJob().getPayMentMethod().getPaymentMethodID() == 2) {
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
                                                            <% if (jobOrder.getJobApplicationStatus() == 3) {
                                                            %>
                                                            <br>
                                                            <div class="mt-3">
                                                                <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                            </div>
                                                            <div class="mt-3">
                                                                <button onclick="getJobApplicatonID(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#SubmitProject" style="width: 50%">Submit Project</button>
                                                            </div>
                                                            <div class="mt-3">
                                                                <button onclick="getJobApplicatonIDtoDispute(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-danger-outline" data-toggle="modal" data-target="#Dispute" style="width: 50%">Dispute</button>
                                                            </div>
                                                            <%
                                                            } else if (jobOrder.getJobApplicationStatus() == 9) {
                                                            %>
                                                            <br>
                                                            <div class="mt-3">
                                                                <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                            </div>
                                                            <div class="mt-3">
                                                                <button onclick="editJob('<%= jobOrder.getSubmitJob().getJobFile()%>', '<%= jobOrder.getSubmitJob().getMessageSubmit()%>', '<%= jobOrder.getJobApplicationID()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#EditSubmission" style="width: 50%">Edit Submission</button>
                                                            </div>
                                                            <div class="mt-3">
                                                                <button onclick="getFeedBack('<%= jobOrder.getReasonRejectionSubmmit()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#viewFeedBack" style="width: 50%">View Feedback</button>
                                                            </div>
                                                            <div class="mt-3">
                                                                <button onclick="getJobApplicatonIDtoDispute(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-danger-outline" data-toggle="modal" data-target="#Dispute" style="width: 50%">Dispute</button>
                                                            </div>
                                                            <%
                                                            } else if (jobOrder.getJobApplicationStatus() == 8) {
                                                            %>
                                                            <br>
                                                            <div class="mt-3">
                                                                <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                            </div>
                                                            <div class="mt-3">
                                                                <button onclick="getSubmitJob('<%= jobOrder.getSubmitJob().getJobFile()%>', '<%= jobOrder.getSubmitJob().getMessageSubmit()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewSubmission" style="width: 50%">View Submission</button>
                                                            </div>
                                                            <div class="mt-3">
                                                                <button onclick="getJobApplicatonIDtoDispute(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-danger-outline" data-toggle="modal" data-target="#Dispute" style="width: 50%">Dispute</button>
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

                                    <!-- Modal -->
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

                                    <div class="modal fade" id="ViewformApplication" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered " role="document">
                                            <div class="modal-content">
                                                <div class="modal-header border-bottom-0 bg-warning">
                                                    <h5 class="modal-title text-white" id="exampleModalLabel">Application Form</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>

                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class=" col-6 form-group text-dark mb-0">
                                                            <label style="font-size: 16px">Deal Price: </label>
                                                            <p style="display: inline-block" id="dealPrice"></p> $
                                                        </div>
                                                        <div class="col-6 form-group text-dark">
                                                            <a class=""  target="_blank" rel="noopener noreferrer" type="text" id="CV" href="" ><p id="CVp" style="text-decoration: underline"> <i class="mdi mdi-link-variant"></i> View CV </p></a>
                                                        </div>
                                                    </div>
                                                    <div class="form-group text-dark">
                                                        <label style="font-size: 16px">Message: </label>
                                                        <div style="height: 100px" class="form-control overflow-auto"><p  disabled="" id="msg"></p></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="SubmitProject" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header border-bottom-0">
                                                    <h5 class="modal-title text-primary" id="exampleModalLabel">Submit Project</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <form method="post" action="${pageContext.request.contextPath}/MainController" enctype="multipart/form-data">
                                                    <div class="modal-body">
                                                        <div class="form-group text-dark">
                                                            <label>Message<span class="text-danger">*</span></label>
                                                            <textarea class="form-control" required="" name="messageSubmit" placeholder="Message for employer"></textarea>
                                                        </div>
                                                        <div class="form-group text-dark">
                                                            <label>Project File</label>
                                                            <input type="file" class="form-control" name="fileProject" required="">
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer border-top-0 d-flex justify-content-center">
                                                        <input type="submit" class="btn btn-primary" value="Send">
                                                        <input type="hidden" class="btn btn-primary" name="action" value="SendProject">
                                                    </div>
                                                    <input type="hidden" id="jobApplicationID" name="jobApplicationID" value="">
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="ViewSubmission" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered " role="document">
                                            <div class="modal-content">
                                                <div class="modal-header border-bottom-0 bg-warning">
                                                    <h5 class="modal-title text-white" id="exampleModalLabel">View Product</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>

                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-6 form-group text-dark">
                                                            <a class=""  target="_blank" rel="noopener noreferrer" type="text" id="jobFile" href="" ><p style="text-decoration: underline"> <i class="mdi mdi-link-variant"></i> View Product </p></a>
                                                        </div>
                                                    </div>
                                                    <div class="form-group text-dark">
                                                        <label style="font-size: 16px">Message: </label>
                                                        <div style="height: 100px" class="form-control overflow-auto"><p  disabled="" id="messageJob"></p></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="viewFeedBack" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-warning">
                                                    <h5 class="modal-title text-white" id="exampleModalLongTitle">Feed back</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container text-dark">
                                                        <div class="row d-flex justify-content-center">
                                                            <div class="d-flex flex-start w-100">
                                                                <!-- <img class="rounded-circle shadow-1-strong me-3" src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(21).webp" alt="avatar" width="65" height="65" /> -->
                                                                <div class="w-100">
                                                                    <div class="form-group text-dark">
                                                                        <label style="font-size: 16px">Message: </label>
                                                                        <div style="height: 100px" class="form-control overflow-auto"><p  disabled="" id="contentFeedback"></p></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="EditSubmission" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header border-bottom-0">
                                                    <h5 class="modal-title text-primary" id="exampleModalLabel">Edit Project</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <form method="post" action="${pageContext.request.contextPath}/MainController" enctype="multipart/form-data">
                                                    <div class="modal-body">
                                                        <div class="form-group text-dark">
                                                            <label>Message<span class="text-danger">*</span></label>
                                                            <textarea class="form-control" id="messageEditSubmit" required="" name="messageEditSubmit" placeholder="Message for employer"></textarea>
                                                        </div>
                                                        <div class="col-6 form-group text-dark">
                                                            <a class=""  target="_blank" rel="noopener noreferrer" type="text" id="fileEditProject" href="" ><p style="text-decoration: underline"> <i class="mdi mdi-link-variant"></i> Submitted file </p></a>
                                                        </div>
                                                        <div class="form-group text-dark">
                                                            <label>Upload new File</label>
                                                            <input type="file" class="form-control" name="fileEditProject" required="">
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer border-top-0 d-flex justify-content-center">
                                                        <input type="submit" class="btn btn-primary" value="Send">
                                                        <input type="hidden" class="btn btn-primary" name="action" value="EditSubmission">
                                                    </div>
                                                    <input type="hidden" id="jobApplicationIDEdit" name="jobApplicationID" value="">
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="Dispute" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header border-bottom-0">
                                                    <h5 class="modal-title text-primary" id="exampleModalLabel">Dispute Form</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <form method="post" action="${pageContext.request.contextPath}/MainController">
                                                    <div class="modal-body">
                                                        <div class="form-group text-dark">
                                                            <label>Title<span class="text-danger">*</span></label>
                                                            <input id="titleDispute" type="text" required="" class="form-control" name="titleDispute" placeholder="Enter the title...">
                                                        </div>
                                                        <div class="form-group text-dark ckarea">
                                                            <label>Message<span class="text-danger">*</span></label>
                                                            <textarea id="messageDispute" class="form-control" name="messageDispute" placeholder="Message for employer" required ></textarea>
                                                        </div>
                                                        <div class="form-group text-dark ckarea">
                                                            <label class="text-warning font-italic">This message will be sent to the owner of this project!</label>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer border-top-0 d-flex justify-content-center">
                                                        <input type="submit" class="btn btn-primary" value="Send">
                                                        <input type="hidden" name="action" value="StudentSendDispute">
                                                    </div>
                                                    <input type="hidden" id="jobApplicationIDDispute" name="jobApplicationID" value="">
                                                    <input type="hidden" name="studentID" value="${sessionScope.LOGIN_USER.userID}">
                                                </form>
                                            </div>
                                        </div>
                                    </div>                
                                </li> 
                                <%
                                                }

                                            }
                                        }
                                    }

                                %>
                                <%                                if (listJobApplication.size() > 10) {
                                %>
                                <!--                                <div class="smj col-12 text-center mt-4 pt-2">
                                                                    <a class="btn btn-primary-outline">Show more</a>
                                                                </div>-->
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- JOB LIST START -->



        <!-- footer start -->
        <jsp:include page="./include/footer.jsp"></jsp:include>

            <!-- Back to top -->
            <a href="#" class="back-to-top rounded text-center" id="back-to-top">
                <i class="mdi mdi-chevron-up d-block"> </i>

            </a>
            <!-- Back to top -->

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
        <script src="${pageContext.request.contextPath}/asset/ckeditor/ckeditor.js"></script>
        <script>
                                                                    function getJobOrderID(id, userID) {
                                                                        $('#yesOption').attr('href', '${pageContext.request.contextPath}/MainController?action=UnApply&jobOrderID=' + id + '&userID=' + userID);
                                                                    }
        </script>
        <script>CKEDITOR.replace('messageDispute');</script>
        <script>
            function getJobOrder(priceDeal, message, cvFile) {
                $("#dealPrice").html(priceDeal);
                $("#msg").html(message);
                if (cvFile == "null") {
                    document.getElementById("CVp").style.display = "none";
                } else {
                    document.getElementById("CVp").style.display = "block";
                    document.getElementById('CV').setAttribute('href', cvFile);
                }

            }
        </script>
        <script>
            function getJobApplicatonID(jobApplicationID) {
                $('#jobApplicationID').val(jobApplicationID);
            }
        </script>
        <script>
            function getSubmitJob(jobFile, messageSubmit) {
                document.getElementById('jobFile').setAttribute('href', jobFile);
                $("#messageJob").html(messageSubmit);
            }
        </script>
        <script>
            function getFeedBack(reason) {
                $("#contentFeedback").html(reason);
            }
        </script>
        <script>
            $(document).ready(function () {
                $('#statusFilter').on('change', function () {
                    $('#paintings').data('list').filter(this.value);
                });
            });
        </script>
        <script>
            function myFunction() {
                // Declare variables
                var input, filter, chuaName, nameJob, a, i, txtValue, div;
                input = document.getElementById('searchjs');
                filter = input.value.toUpperCase();
                chuaName = document.getElementById("chuaNameJob");
                nameJob = chuaName.getElementsByTagName('h4');
                div = document.getElementsByClassName("job-display");
                // Loop through all list items, and hide those who don't match the search query
                for (i = 0; i < nameJob.length; i++) {
                    a = nameJob[i].getElementsByTagName("a")[0];
                    txtValue = a.textContent || a.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        div[i].style.display = "";
                    } else {
                        div[i].style.display = "none";
                    }
                }
            }
        </script>
        <script>
            function editJob(jobFile, messageSubmit, jobApplicationID) {
                document.getElementById('jobApplicationIDEdit').value = jobApplicationID;
                document.getElementById('fileEditProject').setAttribute('href', jobFile);
                document.getElementById('messageEditSubmit').textContent = messageSubmit;
            }
        </script>
        <script>
            function getJobApplicatonIDtoDispute(jobApplicationID) {
                $('#jobApplicationIDDispute').val(jobApplicationID);
            }
        </script>
    </body>
</html>

