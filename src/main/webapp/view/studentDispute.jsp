
<%@page import="se1621.dto.User"%>
<%@page import="se1621.dto.Disputes"%>
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
            <jsp:param name="title" value="FuJob | Dispute"/>
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
                                <h4 class="text-uppercase title mb-4">Dispute</h4>

                            </div>
                        </div>
                    </div>
                </div>
            </section>
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
            <!-- end home -->
            <!-- JOB LIST START -->
            <section class="section pt-0">
                <div class="container">
                    <div class="row justify-content-center">
                    <%
                        User us = (User) session.getAttribute("LOGIN_USER");
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
                            <h4 class="title title-line pb-5">All Disputes</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4 pt-2">
                        <div class="row align-items-center">
                            <div class="col-lg-12">
                            </div>
                        </div>
                        <!-- Môt sô tool co the xai duoc cho phan trang va sort -->
                        <div id="chuaNameJob" class="row">
                            <% List<Disputes> listDispute = (List<Disputes>) request.getAttribute("LIST_ST_JOB_DISPUTE");
                                if (listDispute.isEmpty()) {

                                    String message = (String) request.getAttribute("MESSAGE");
                            %>
                            <div class="col-lg-12 text-warning text-center">
                                <h3> <%=message%> </h3>
                            </div>
                            <%
                                }
                                if (listDispute != null) {
                                    if (listDispute.size() > 0) {
                                        for (Disputes dispute : listDispute) {
                                            if (dispute.getDisStatus() == 1) {
                            %>
                            <li style="list-style: none">
                                <div class="job-display col-lg-12 mt-4 pt-2">
                                    <div class="job-list-box border rounded">
                                        <div class="p-3" style="width: 1100px">
                                            <div class="row align-items-center">
                                                <div class="col-lg-3">
                                                    <div class="company-logo-img">
                                                        <img src="<%= dispute.getJobApplication().getJob().getCategory().getImg()%>" alt="" class="img-fluid img-thumbnail mx-auto d-block" style="width:250px;height:250px">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 col-md-9">
                                                    <div class="job-list-desc">
                                                        <h4 class="mb-2"><a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= dispute.getJobApplication().getJob().getJobID()%>" class="text-dark"><%= dispute.getJobApplication().getJob().getJobTitle()%>
                                                                <br>
                                                                <i class="mdi mdi-bookmark-check mt-4" style="font-size: 25px; color: orange"></i> 
                                                                <i class="painting-author" style="font-style: normal;font-size: 20px ; font-weight: bold; color: orange">In Dispute</i>
                                                            </a>
                                                        </h4>

                                                        <%
                                                            String description = dispute.getJobApplication().getJob().getDescription();
                                                            if (description.length() > 200 || description.isBlank()) {
                                                                description = description.substring(0, 197) + ". . .";
                                                            }
                                                        %>
                                                        <p class="mb-4"><%= description%></p>
                                                        <h6>Skills Require:
                                                            <%
                                                                List<JobSkills> listJobSkills = dispute.getJobApplication().getJob().getListJobSkills();
                                                                for (int i = 0; i < listJobSkills.size() - 1; i++) {
                                                            %>
                                                            <%= listJobSkills.get(i).getSkill().getSkillName()%>,
                                                            <%
                                                                }
                                                            %>
                                                            <%= listJobSkills.get(listJobSkills.size() - 1).getSkill().getSkillName()%>
                                                        </h6>
                                                        <h6>
                                                            <%= dispute.getJobApplication().getJob().getPayMentMethod().getPaymentMethodName()%>: <%= dispute.getJobApplication().getJob().getMinBudget()%>$ - <%= dispute.getJobApplication().getJob().getMaxBudget()%>$ <% if (dispute.getJobApplication().getJob().getPayMentMethod().getPaymentMethodID() == 2) {
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
                                                        <%
                                                            Date dateNow = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                                                            long dayBetween = dateNow.getTime() - dispute.getCreatedDate().getTime();
                                                            long dayResult = dayBetween / (24 * 60 * 60 * 1000);
                                                            if (dispute.getUser().getUserID() == us.getUserID()) {
                                                                if (dayResult > 3) {
                                                        %>
                                                        <br>
                                                        <%
                                                            if (dispute.getEvidence().getEvidenceID() > 0) {
                                                        %>
                                                        <div class="mt-3">
                                                            <button onclick="viewEvidence('<%= dispute.getEvidence().getMessage()%>', '<%= dispute.getEvidence().getEvidenceFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#viewEvidence" style="width: 50%">View Evidence</button>
                                                        </div>
                                                        <%
                                                        } else {
                                                        %>
                                                        <div class="mt-3">
                                                            <button onclick="getDisputeI(<%= dispute.getDisputeID()%>)" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#sendEvidence" style="width: 50%">Send Evidence</button>
                                                        </div>
                                                        <%
                                                            }
                                                        } else {
                                                        %>
                                                        <br>
                                                        <div class="mt-3">
                                                            <button onclick="getDisputeID(<%= dispute.getDisputeID()%>)" class="btn btn-sm btn-danger-outline" data-toggle="modal" data-target="#CancelDispute" style="width: 50%">Cancel</button>
                                                        </div>
                                                        <%
                                                            }
                                                        } else {
                                                            if (dayResult > 3) {
                                                        %>
                                                        <br>
                                                        <%
                                                            if (dispute.getEvidence().getEvidenceID() > 0) {
                                                        %>
                                                        <div class="mt-3">
                                                            <button onclick="viewEvidence('<%= dispute.getEvidence().getMessage()%>', '<%= dispute.getEvidence().getEvidenceFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#viewEvidence" style="width: 50%">View Evidence</button>
                                                        </div>
                                                        <%
                                                        } else {
                                                        %>
                                                        <div class="mt-3">
                                                            <button onclick="getDisputeI(<%= dispute.getDisputeID()%>)" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#sendEvidence" style="width: 50%">Send Evidence</button>
                                                        </div>
                                                        <%
                                                            }
                                                        %>
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal -->
                                <div class="modal fade" id="CancelDispute" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header border-bottom-0">
                                                <h5 class="modal-title text-primary" id="exampleModalLabel">Cancel Dispute</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <form method="post" action="${pageContext.request.contextPath}/MainController">
                                                <div class="modal-body">
                                                    <div class="form-group text-dark ckarea">
                                                        <label>Message<span class="text-danger">*</span></label>
                                                        <textarea id="messageCancelDispute" class="form-control" name="messageCancelDispute" placeholder="Message for employer" required ></textarea>
                                                    </div>
                                                    <div class="form-group text-dark ckarea">
                                                        <label class="text-warning font-italic">This message will be sent to the owner of this project!</label>
                                                    </div>
                                                </div>
                                                <div class="modal-footer border-top-0 d-flex justify-content-center">
                                                    <input type="submit" class="btn btn-primary" value="Send">
                                                    <input type="hidden" name="action" value="StudentCancelDispute">
                                                </div>
                                                <input type="hidden" id="disputeID" name="disputeID" value="">
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="sendEvidence" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header border-bottom-0">
                                                <h5 class="modal-title text-primary" id="exampleModalLabel">Send Evidence</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <form method="post" action="${pageContext.request.contextPath}/MainController" enctype="multipart/form-data">
                                                <div class="modal-body">
                                                    <div class="form-group text-dark ckarea">
                                                        <label>Tell Your Story<span class="text-danger">*</span></label>
                                                        <textarea id="userStory" class="form-control" name="userStory" placeholder="Tell us your story..." required ></textarea>
                                                    </div>
                                                    <div class="form-group text-dark">
                                                        <label>Evidence File</label>
                                                        <input type="file" class="form-control" name="fileEvidence" required="">
                                                    </div>
                                                </div>
                                                <div class="modal-footer border-top-0 d-flex justify-content-center">
                                                    <input type="submit" class="btn btn-primary" value="Send">
                                                    <input type="hidden" name="action" value="SendEvidence">
                                                </div>
                                                <input type="hidden" id="disputeI" name="disputeID" value="">
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="viewEvidence" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered " role="document">
                                        <div class="modal-content">
                                            <div class="modal-header border-bottom-0 bg-warning">
                                                <h5 class="modal-title text-white" id="exampleModalLabel">Your Sent Evidence</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>

                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-6 form-group text-dark">
                                                        <a class=""  target="_blank" rel="noopener noreferrer" type="text" id="evidenceFile" href="" ><p style="text-decoration: underline"> <i class="mdi mdi-link-variant"></i> View Evidence You Sent</p></a>
                                                    </div>
                                                </div>
                                                <div class="form-group text-dark">
                                                    <label style="font-size: 16px">Your Story: </label>
                                                    <div style="height: 100px" class="form-control overflow-auto"><p  disabled="" id="yourStory"></p></div>
                                                </div>
                                            </div>
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
        <script>CKEDITOR.replace('messageCancelDispute');</script>
        <script>CKEDITOR.replace('userStory');</script>
        <script>
            function getDisputeID(disputeID) {
                $('#disputeID').val(disputeID);
            }
        </script>
        <script>
            function getDisputeI(disputeID) {
                $('#disputeI').val(disputeID);
            }
        </script>
        <script>
            function viewEvidence(yourStory, evidenceFile) {
                document.getElementById('evidenceFile').setAttribute('href', evidenceFile);
                $("#yourStory").html(yourStory);
            }
        </script>
    </body>
</html>

