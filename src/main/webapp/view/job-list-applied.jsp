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
            <jsp:param name="title" value="FuJob | Projects Applied"/>
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
                                <h4 class="text-uppercase title mb-4">Projects Applied</h4>

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
        <%
            String messageUpdate = (String) request.getAttribute("UPDATE_MESSAGE");
            if (messageUpdate != null) {
        %>

        <div class="col-5 mx-auto text-center alert alert-warning alert-dismissible fade show" role="alert">
            <strong><%= messageUpdate%></strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <%
            }
        %>

        <%
            String messageCancel = (String) request.getAttribute("CANCEL_MESSAGE");
            if (messageCancel != null) {
        %>

        <div class="col-5 mx-auto text-center alert alert-warning alert-dismissible fade show" role="alert">
            <strong><%= messageCancel%></strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <%
            }
        %>
        <!-- JOB LIST START -->
        <section class="section pt-0">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title title-line pb-5">All Projects You've Applied</h4>
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
                                    <div class="cell-md-4 mt-4 float-right">
                                        <select class="form-control resume" id="statusFilter" data-filter="false">
                                            <option value="" selected>All</option>
                                            <option value="Waiting">Waiting</option>
                                            <option value="Application Closed">Application Closed</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
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
                            <% List<JobApplication> listJobApplication = (List<JobApplication>) request.getAttribute("LIST_ALLJOBORDER");
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
                                                            <% if (jobOrder.getJobApplicationStatus() == 1) {
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-timelapse mt-4" style="font-size: 25px; color: #C0C000"></i> 
                                                            <i class="painting-author" style="font-style: normal;font-size: 20px ; font-weight: bold; color: #C0C000">Waiting</i>
                                                            <%
                                                            } else if (jobOrder.getJobApplicationStatus() == 5) {
                                                            %>
                                                            <br>
                                                            <i class="mdi mdi-close-box mt-4" style="font-size: 25px; color: red"></i> 
                                                            <i class="painting-author" style="font-style: normal;font-size: 20px ; font-weight: bold; color: red">Application Closed</i>
                                                            <%
                                                                }
                                                            %>
                                                        </a>
                                                    </h4>

                                                    <%
                                                        Date dateNow = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                                                        long exDate = Math.abs(jobOrder.getJob().getExpiriedDate().getTime() - dateNow.getTime());
                                                        long resultDate = exDate / (24 * 60 * 60 * 1000);
                                                    %>
                                                    <p class="mb-2 text-muted"> <%= resultDate%> days left</p>

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
                                                        <%= jobOrder.getJob().getPayMentMethod().getPaymentMethodName()%>: <%= jobOrder.getJob().getMinBudget()%>$ - <%= jobOrder.getJob().getMaxBudget()%>$<% if (jobOrder.getJob().getPayMentMethod().getPaymentMethodID() == 2) {
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
                                                    <% if (jobOrder.getJobApplicationStatus() == 1) {
                                                    %>
                                                    <div>
                                                        <p class=" "><i class="mr-2"></i><%= jobOrder.getJob().getBids()%> bid(s)</p>
                                                    </div>
                                                    <br>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" type="button" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                    </div>
<!--                                                    <div class="mt-3">
                                                        <button onclick="getJobOrderID(<%= jobOrder.getJobApplicationID()%>, <%= jobOrder.getResumeID()%>)" type="button" style="width: 50%" class="btn btn-primary-outline-red btn-sm" data-toggle="modal" data-target="#confirmCancellation">
                                                            Cancel
                                                        </button>
                                                    </div>-->
                                                    <div class="mt-3">
                                                        <a onclick="getJobOrderID(<%= jobOrder.getJobApplicationID()%>, <%= jobOrder.getResumeID()%>)" href="#" class="btn btn-primary-outline-red btn-sm" data-toggle="modal" data-target="#formUnapply" style="width: 50%">Retract</a>
                                                    </div>
                                                    <%
                                                    } else if (jobOrder.getJobApplicationStatus() == 5) {
                                                    %>
                                                    <br>
                                                    <div class="mt-3">
                                                        <button onclick="getJobOrder('<%= jobOrder.getPriceDeal()%>', '<%= jobOrder.getMessage()%>', '<%= jobOrder.getCvFile()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewformApplication" style="width: 50%">View Application Form</button>
                                                    </div>
                                                    <div class="mt-3">
                                                        <button onclick="getRejectionFrm('<%= jobOrder.getReasonRejection()%>')" class="btn btn-sm btn-primary-outline" data-toggle="modal" data-target="#ViewFormRejection" style="width: 50%">View Rejection Form</button>
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
                            <div class="modal fade" id="formUnapply" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header border-bottom-0">
                                            <h5 class="modal-title text-primary" id="exampleModalLabel">Cancellation Form</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form id="formUnapplyToSendhref" method="post" action="" enctype="multipart/form-data">
                                            <div class="modal-body">
                                                <div class="form-group text-dark">
                                                    <label>Your Reason<span class="text-danger">*</span></label>
                                                    <textarea class="form-control" name="reasonUnaplly" id="reasonUnaplly" placeholder="Reason you cancel your application"></textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer  d-flex justify-content-center">
                                                <input type="submit" class="btn btn-primary" value="Send" style="width: 165px">
                                            </div>
                                        </form>
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

                            <div class="modal fade" id="ViewFormRejection" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered " role="document">
                                    <div class="modal-content">
                                        <div class="modal-header border-bottom-0 bg-warning">
                                            <h5 class="modal-title text-white" id="exampleModalLabel">Rejection Form</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">
                                            <div class="form-group text-dark">
                                                <label style="font-size: 16px">Message: </label>
                                                <div style="height: 100px" class="form-control overflow-auto"><p  disabled="" id="msg2"></p></div>
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
        <script src="${pageContext.request.contextPath}/asset/ckeditor/ckeditor.js"></script>
        <script src="${pageContext.request.contextPath}/asset/js/metro.min.js"></script>
        <script>CKEDITOR.replace('message');</script>
        <script>
            function getJobOrderID(id, resumeID) {
                $('#formUnapplyToSendhref').attr('action', '${pageContext.request.contextPath}/MainController?action=UnApply&jobOrderID=' + id + '&resumeID=' + resumeID);
            }
        </script>
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
            function getJobOrder(priceDeal, message, cvFile) {
                $("#dealPrice").html(priceDeal);
                $("#msg").html(message);
                if(cvFile == "null"){
                    document.getElementById("CVp").style.display = "none";
                }else {
                    document.getElementById("CVp").style.display = "block";
                    document.getElementById('CV').setAttribute('href', cvFile);
                }
                
            }
        </script>
        <script>
            function getRejectionFrm(message) {
                $("#msg2").html(message);
            }
        </script>
        <script>
            $(document).ready(function() {
            $('#statusFilter').on('change', function() {
            $('#paintings').data('list').filter(this.value);
            });
                    });
        </script>
    </body>
</html>

