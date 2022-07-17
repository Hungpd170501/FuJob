<%@page import="se1621.dto.JobSkills" %>
<%@page import="se1621.dto.JobApplication" %>
<%@page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Projects Posted (In Progress)"/>
        </jsp:include>
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
                                <h4 class="text-uppercase title mb-4">Projects Posted (In Progress)</h4>

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
                            <div class="home-registration-form job-list-reg-form bg-light shadow p-4 mb-3">
                                <!-- START SEARCH -->
                                <form class="registration-form" action="${pageContext.request.contextPath}/MainController">
                                <!--<form class="registration-form">-->
                                <div class="row">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-briefcase"></i>
                                            <input type="text" name="searchTitle" id="exampleInputName1"
                                                   class="form-control rounded registration-input-box" placeholder="Title...">
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="registration-form-box">
                                            <i class="fa fa-archive"></i>
                                            <select class="demo-default" id="select-category" name="searchSkill">
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
                                            <input type="submit" id="submit" class="submitBnt btn btn-primary btn-block"
                                                   value="Find">
                                            <!-- name = action  -->
                                            <input type="hidden" name="action" value="SearchJobOrder">
                                            <input type="hidden" name="studentID" value="${sessionScope.LOGIN_USER.userID}">
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
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">All Projects You've Accepted</h4>
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
                        <div class="row">

                            <% List<JobApplication> listJobApplication = (List<JobApplication>) request.getAttribute("LIST_ALLJOBONGOING_POSTED");
                                if (listJobApplication.isEmpty()) {
                                    String message = (String) request.getAttribute("MESSAGE");
                            %>
                            <div class="col-lg-12 text-warning text-center">
                                <h3><%=message%>
                                </h3>
                            </div>
                            <%
                                }
                                if (listJobApplication != null) {
                                    if (listJobApplication.size() > 0) {
                                        for (JobApplication jobOrder : listJobApplication) {
                            %>
                            <div class="job-display col-lg-12 mt-4 pt-2" style="display: none">
                                <div class="job-list-box border rounded">
                                    <div class="p-3">
                                        <div class="row align-items-center">
                                            <div class="col-lg-3">
                                                <div class="company-logo-img">
                                                    <img src="<%= jobOrder.getJob().getCategory().getImg()%>" alt=""
                                                         class="img-fluid img-thumbnail mx-auto d-block"
                                                         style="width:250px;height:250px">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-9">
                                                <div class="job-list-desc">
                                                    <h4 class="mb-2"><a
                                                            href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>"
                                                            class="text-dark"><%= jobOrder.getJob().getJobTitle()%>
                                                            <% if (jobOrder.getJob().getJobStatus() == 3) {
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-bookmark-check mt-4"
                                                               style="font-size: 25px; color: green"></i>
                                                            <i style="font-style: normal;font-size: 20px ; font-weight: bold; color: green">In
                                                                progress</i>
                                                                <%
                                                                } else if (jobOrder.getJob().getJobStatus() == 5) {
                                                                %>
                                                            <br>
                                                            <i class="mdi mdi-bookmark-check mt-4"
                                                               style="font-size: 25px; color: green"></i>
                                                            <i style="font-style: normal;font-size: 20px ; font-weight: bold; color: green">Completed</i>
                                                            <%
                                                            } else if (jobOrder.getJob().getJobStatus() == 6) {
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-bookmark-check mt-4"
                                                               style="font-size: 25px; color: red"></i>
                                                            <i style="font-style: normal;font-size: 20px ; font-weight: bold; color: red">Not
                                                                completed</i>
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
                                                    <p class="mb-4"><%= description%>
                                                    </p>
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
                                                        <%= jobOrder.getJob().getPayMentMethod().getPaymentMethodName()%>
                                                        : <%= jobOrder.getJob().getMinBudget()%>$
                                                        - <%= jobOrder.getJob().getMaxBudget()%>
                                                        $ <% if (jobOrder.getJob().getPayMentMethod().getPaymentMethodID() == 2) {
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
                                                    <% if (jobOrder.getJob().getJobStatus() == 3) {
                                                    %>
                                                    <br>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>"
                                                           class="btn btn-sm btn-primary-outline" style="width: 50%">View
                                                            Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')"
                                                                type="button" class="btn btn-sm btn-primary-outline"
                                                                data-toggle="modal" data-target="#ViewformApplication"
                                                                style="width: 50%">View Application Form
                                                        </button>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="unCompleteJob(<%= jobOrder.getJobApplicationID()%>, <%= jobOrder.getJob().getJobID()%>, <%= jobOrder.getResumeID()%>)" type="button" class="btn btn-primary-outline-red btn-sm" data-toggle="modal" data-target="#confirmCancellation" style="width: 50%">
                                                            Not Complete
                                                        </button>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="completeJob(<%=jobOrder.getJobApplicationID()%>, <%= jobOrder.getJob().getJobID()%>, <%= jobOrder.getResumeID()%>)"
                                                                type="button" class="btn btn-primary-outline btn-sm"
                                                                data-toggle="modal" data-target="#confirmAcceptaction"
                                                                style="width: 50%">
                                                            Complete
                                                        </button>
                                                    </div>
                                                    <%
                                                    } else if (jobOrder.getJob().getJobStatus() == 5) {
                                                    %>
                                                    <br>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>"
                                                           class="btn btn-sm btn-primary-outline" style="width: 50%">View
                                                            Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')"
                                                                type="button" class="btn btn-sm btn-primary-outline"
                                                                data-toggle="modal" data-target="#ViewformApplication"
                                                                style="width: 50%">View Application Form
                                                        </button>
                                                    </div>
                                                    <%
                                                    } else if (jobOrder.getJob().getJobStatus() == 6) {
                                                    %>
                                                    <br>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>"
                                                           class="btn btn-sm btn-primary-outline" style="width: 50%">View
                                                            Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')"
                                                                type="button" class="btn btn-sm btn-primary-outline"
                                                                data-toggle="modal" data-target="#ViewformApplication"
                                                                style="width: 50%">View Application Form
                                                        </button>
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
                                                    <p style="display: inline-block" id="dealPrice"></p>
                                                </div>
                                                <div class="col-6 form-group text-dark">
                                                    <a class=""  target="_blank" rel="noopener noreferrer" type="text" id="CV" href="" ><p style="text-decoration: underline"> <i class="mdi mdi-link-variant"></i> View CV </p></a>
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
                            <%
                                        }

                                    }
                                }

                            %>
                            <form method="post" action="${pageContext.request.contextPath}/MainController">
                                <div class="modal fade" id="confirmCancellation" tabindex="-1" role="dialog"
                                     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title text-primary" id="exampleModalLongTitle">This Project Is Not
                                                    Complete?</h5>
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
                                                                <h5>Add a Evaluation:</h5>
                                                                <div class="rating stars">
                                                                    <input type="radio" name="rating" value="5" id="5-star">
                                                                    <label for="5-star" class="rate">☆<div class="face face-5"></div></label>
                                                                    <input type="radio" name="rating" value="4" id="4-star">
                                                                    <label for="4-star" class="rate">☆<div class="face face-4"></div></label>
                                                                    <input type="radio" name="rating" value="3" id="3-star">
                                                                    <label for="3-star" class="rate">☆<div class="face face-3"></div></label>
                                                                    <input type="radio" name="rating" value="2" id="2-star">
                                                                    <label for="2-star" class="rate">☆<div class="face face-2"></div></label>
                                                                    <input type="radio" name="rating" value="1" id="1-star">
                                                                    <label for="1-star" class="rate">☆<div class="face face-1"></div></label>
                                                                </div>
                                                                <div class="form-outline">
                                                                    <label class="form-label" for="textAreaExample">Could you tell us what when wrong?</label>
                                                                    <textarea class="form-control" id="textAreaExample"
                                                                              name="message"
                                                                              placeholder=""></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                                <input type="hidden" id="unCompleteJob_jobID" name="jobID" value="">
                                                <input type="hidden" id="unCompleteJob_jobApplicationID" name="jobApplicationID" value="">
                                                <input type="hidden" id="unCompleteJob_resumeID" name="resumeID" value="">
                                                <input type="hidden" name="action" value="UncompteleJob">
                                                <input type="submit" value="Yes" class="btn btn-primary">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/MainController">
                                <div class="modal fade" id="confirmAcceptaction" tabindex="-1" role="dialog"
                                     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title text-primary" id="exampleModalLongTitle2">This Project Is
                                                    Completed?</h5>
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
                                                                <h5>Add a Evaluation:</h5>
                                                                <div class="rating">
                                                                    <input type="radio" name="rating" value="5" id="5">
                                                                    <label for="5" class="rate">☆<div class="face face-5"></div></label>
                                                                    <input type="radio" name="rating" value="4" id="4">
                                                                    <label for="4" class="rate">☆<div class="face face-4"></div></label>
                                                                    <input type="radio" name="rating" value="3" id="3">
                                                                    <label for="3" class="rate">☆<div class="face face-3"></div></label>
                                                                    <input type="radio" name="rating" value="2" id="2">
                                                                    <label for="2" class="rate">☆<div class="face face-2"></div></label>
                                                                    <input type="radio" name="rating" value="1" id="1">
                                                                    <label for="1" class="rate">☆<div class="face face-1"></div></label>
                                                                </div>
                                                                <div class="form-outline">
                                                                    <label class="form-label" for="textAreaExample2">What's your view?</label>
                                                                    <textarea class="form-control" id="textAreaExample2"
                                                                              name="message"
                                                                              placeholder=""></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                                <input type="hidden" name="action" value="CompleteJob">
                                                <input type="hidden" id="completeJob_jobID" name="jobID">
                                                <input type="hidden" id="completeJob_jobApplicationID" name="jobApplicationID">
                                                <input type="hidden" id="completeJob_resumeID" name="resumeID">
                                                <input type="submit" value="Yes" class="btn btn-primary">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <% if (listJobApplication.size() > 10) {
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
        <script src="${pageContext.request.contextPath}/asset/ckeditor/ckeditor.js"></script>
        <script>CKEDITOR.replace('message');</script>
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
        <script>
            function getJobOrder(priceDeal, message, cvFile) {
                $("#dealPrice").html(priceDeal);
                $("#msg").html(message);
                document.getElementById('CV').setAttribute('href', cvFile);
            }
            function unCompleteJob(jobApplication, jobID, resumeID) {
                $("#unCompleteJob_jobApplicationID").val(jobApplication);
                $("#unCompleteJob_jobID").val(jobID);
                $("#unCompleteJob_resumeID").val(resumeID);
            }
            function completeJob(jobApplication, jobID, resumeID) {
                $("#completeJob_jobApplicationID").val(jobApplication);
                $("#completeJob_jobID").val(jobID);
                $("#completeJob_resumeID").val(resumeID);
            }
        </script>
        <script src="${pageContext.request.contextPath}/asset/ckeditor/ckeditor.js"></script>
        <script>CKEDITOR.replace('message');</script>
    </body>
</html>
