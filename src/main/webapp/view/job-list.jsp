<%@page import="java.text.SimpleDateFormat"%>
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
            <jsp:param name="title" value="FuJob | Projects Listing"/>
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
                                <h4 class="text-uppercase title mb-4">Project List view</h4>
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
                                            <select class="demo-default" id="select-category" name="searchSkill">
                                                <option value="">Skill</option>
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
                                            <input type="hidden" name ="action" value="Search_title_exper_cate">
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
                            <h4 class="title title-line pb-5">Available projects for you</h4>
                            <p class="text-muted para-desc mx-auto mb-1">Tell us about your project. We'll quickly match you with the right freelancers.</p>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center">
                    <div class="float-left">
                        <h5 class="text-dark mb-0 pt-2 f-18">Showing projects</h5>
                    </div>
                    <div class="col-lg-12">
                        <div class="show-results">
                            <div class="registration-form-box float-right">
                                <button class="btn btn-sm btn-primary-outline" onclick="sortList('painting-bid', 'desc')"> Highest bid first </button>
                                <button class="btn btn-sm btn-primary-outline" onclick="sortList('painting-name', 'asc')"> Sort projects name </button>
                                <button class="btn btn-sm btn-primary-outline" onclick="sortList('painting-price', 'asc')"> Lowest budget first </button>
                                <button class="btn btn-sm btn-primary-outline" onclick="sortList('painting-price', 'desc')"> Highest budget first </button>
                                <button class="btn btn-sm btn-primary-outline" onclick="sortList('painting-id', 'desc')"> Newest project first </button>
                                <button class="btn btn-sm btn-primary-outline" onclick="sortList('painting-id', 'asc')"> Oldest project first </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- them display -->
                <div class="row">
                    <ul  id="paintings"
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

                        <% List<Job> listJob = (List<Job>) request.getAttribute("LIST_ALLJOB");
                            if (listJob.isEmpty()) {
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
                                    <div class="p-3" style="width: 1098px; height: 338px">
                                        <div class="row align-items-center">
                                            <div class="col-lg-3">
                                                <div class="company-logo-img">
                                                    <img loading="lazy" src="<%= job.getCategory().getImg()%>" alt="" class="img-fluid img-thumbnail mx-auto d-block" style="width:250px;height:250px">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-9">
                                                <div class="job-list-desc">
                                                    <h4 class="painting-name mb-1" style="font-weight: 700"><a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= job.getJobID()%>" class="text-dark mb-5"><%= job.getJobTitle()%></a></h4>
                                                        <%
                                                            Date dateNow = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                                                            long exDate = Math.abs(job.getExpiriedDate().getTime() - dateNow.getTime());
                                                            long resultDate = exDate / (24 * 60 * 60 * 1000);
                                                        %>
                                                    <h6 class="mb-4 mt-3" >Date Posted: <%
                                                        String pattern = "dd-MM-yyyy";
                                                        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
                                                        String date = simpleDateFormat.format(job.getCreatedDate());%>
                                                        <%= date%></h6>

                                                    <%
                                                        String description = job.getDescription();
                                                        if (description.length() > 200 || description.isBlank()) {
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
                                                    <h6>Payment Method: 
                                                        <%= job.getPayMentMethod().getPaymentMethodName()%>
                                                    </h6>
                                                    <ul class="list-inline mb-0">
                                                        <li class="list-inline-item mr-3">
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3">
                                                <div class="job-list-button-sm text-right">
                                                    <div>
                                                        <h6 class="painting-bid mb-1"><i class="mr-2"></i><%= job.getBids()%> bid(s)</h6>
                                                    </div>
                                                    <h6 class="mb-4 text-green"> <%= resultDate%> days left</h6>
                                                    <div>
                                                        <h5 class="painting-id" data-format="money" style="display: none"> <%= job.getJobID()%> </h5>
                                                        <h5 class="painting-price mb-5" data-format="money">  <i class="mr-2"></i> <%= job.getMinBudget()%>$ -<%= job.getMaxBudget()%>$ <% if (job.getPayMentMethod().getPaymentMethodID() == 2) {
                                                            %>
                                                            / hour
                                                            <%
                                                                }
                                                            %> 
                                                        </h5>
                                                    </div>

                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/MainController?action=SearchJobID&searchJobID=<%= job.getJobID()%>" class="btn btn-sm btn-primary">View Detail</a>
                                                    </div>
                                                </div>
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

                        %>

                        <%                                if (listJob.size() > 10) {
                        %>
                        <!--    <div class="smj col-12 text-center mt-4 pt-2">
                            <a class="btn btn-primary-outline">Show more</a>
                        </div> --> 
                        <%
                            }
                        %>
                    </ul>
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

        <%--        <script>
                                                $(".job-display").slice(0, 30).show();
                                                $(".smj").on("click", function () {
                                                    $(".job-display:hidden").slice(0, 5).slideDown();
                                                    if ($(".job-display:hidden").length == 0) {
                                                        $(".smj").fadeOut('slow');
                                                    }
                                                });
                </script> --%>
        <script>
                                    function sortList(col, dir) {
                                        $('#paintings').data('list').sorting(col, dir, true);
                                    }
        </script>
    </body>
</html>
