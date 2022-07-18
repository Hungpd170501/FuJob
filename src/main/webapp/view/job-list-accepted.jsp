
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
            <jsp:param name="title" value="FuJob | Project Applied (In Progress)"/>
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
                                <h4 class="text-uppercase title mb-4">Project Applied (In Progress)</h4>

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
                                            <input type="hidden" name ="action" value="SearchJobOrder">
                                            <input type="hidden" name ="studentID" value="${sessionScope.LOGIN_USER.userID}">
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
                            %>
                            <div class="job-display col-lg-12 mt-4 pt-2" style="display: none">
                                <div class="job-list-box border rounded">
                                    <div class="p-3">
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
                                                            <i style="font-style: normal;font-size: 20px ; font-weight: bold; color: green">In Progress</i>
                                                            <%
                                                            } else if (jobOrder.getJobApplicationStatus() == 6) {
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-bookmark-check mt-4" style="font-size: 25px; color: green"></i> 
                                                            <i style="font-style: normal;font-size: 20px ; font-weight: bold; color: green">Completed</i>
                                                            <%
                                                            } else if (jobOrder.getJobApplicationStatus() == 7) {
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-bookmark-check mt-4" style="font-size: 25px; color: red"></i> 
                                                            <i style="font-style: normal;font-size: 20px ; font-weight: bold; color: red">Not Completed</i>
                                                            <%
                                                            } else if(jobOrder.getJobApplicationStatus() == 8) { 
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-bookmark-check mt-4" style="font-size: 25px; color: orange"></i> 
                                                            <i style="font-style: normal;font-size: 20px ; font-weight: bold; color: orange">Pending Review</i>
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
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>" class="btn btn-sm btn-primary-outline" style="width: 50%">View Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobApplicatonID(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#SubmitProject" style="width: 50%">Submit Project</button>
                                                    </div>
                                                    <%
                                                    } else if (jobOrder.getJobApplicationStatus() == 6) {
                                                    %>
                                                    <br>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>" class="btn btn-sm btn-primary-outline" style="width: 50%">View Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobApplicatonID(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#SubmitProject" style="width: 50%">Submit Project</button>
                                                    </div>
                                                    <%
                                                    } else if (jobOrder.getJobApplicationStatus() == 7) {
                                                    %>
                                                    <br>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>" class="btn btn-sm btn-primary-outline" style="width: 50%">View Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobApplicatonID(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#SubmitProject" style="width: 50%">Submit Project</button>
                                                    </div>
                                                    <%
                                                    } else if (jobOrder.getJobApplicationStatus() == 8) {
                                                    %>
                                                    <br>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= jobOrder.getJob().getJobID()%>" class="btn btn-sm btn-primary-outline" style="width: 50%">View Detail</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getJobApplicatonID(<%= jobOrder.getJobApplicationID()%>)" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewSubmission" style="width: 50%">View Submission</button>
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
                                                    <input type="file" class="form-control" name="fileProject">
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
                                                    <a class=""  target="_blank" rel="noopener noreferrer" type="text" id="CV" href="" ><p style="text-decoration: underline"> <i class="mdi mdi-link-variant"></i> View Product </p></a>
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
        <script>
                                                            function getJobOrderID(id, userID) {
                                                                $('#yesOption').attr('href', '${pageContext.request.contextPath}/MainController?action=UnApply&jobOrderID=' + id + '&userID=' + userID);
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
        <script>
            function getJobOrder(priceDeal, message, cvFile) {
                $("#dealPrice").html(priceDeal);
                $("#msg").html(message);
                document.getElementById('CV').setAttribute('href', cvFile);
            }
        </script>
        <script>
            function getJobApplicatonID(jobApplicationID) {
                $('#jobApplicationID').val(jobApplicationID);
            }
        </script>
    </body>
</html>

