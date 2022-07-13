
<%@page import="java.util.List"%>
<%@page import="se1621.dto.JobSkills"%>
<%@page import="se1621.dto.Category"%>
<%@page import="se1621.dto.Job"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Post Job "/>
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
                                <h4 class="text-uppercase title mb-4">Create A new Project</h4>

                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->
        <%
            Job job = (Job) request.getAttribute("JOB");
        %>
        <!-- POST A JOB START -->
        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="rounded shadow bg-white p-4">
                            <div class="custom-form">
                                <div id="message3"></div>
                                <form action="/FuJob/MainController" method="POST">
                                    <%
                                        if (job.getJobID() > 0) {
                                    %>
                                    <h4 class="text-dark mb-3" style="font-weight: 700">Update Project :</h4>
                                    <%
                                    } else {
                                    %>
                                    <h4 class="text-dark mb-3" style="font-weight: 700">Post a New Project :</h4>
                                    <%
                                        }
                                    %>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group app-label mt-2">
                                                <label>Project Name<span class="text-danger">*</span></label>
                                                <input id="jobtitle" name="jobTitle" type="text" class="form-control resume" required="" value="${requestScope.JOB.jobTitle}" placeholder="Enter your project name">

                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Project Category</label><span class="text-danger">*</span>
                                                <div class="form-button p-1">
                                                    <select id="cateID" class="form-control resume" name="categoryID" required="">
                                                        <%
                                                            if (job.getCategory() != null) {
                                                        %>
                                                        <option id="" selected="selected" value="${requestScope.JOB.category.categoryID}">${requestScope.JOB.category.categoryName}</option>
                                                        <%
                                                            }
                                                        %>
                                                        <c:forEach items="${applicationScope.CATEGORY_LIST}" var="i">
                                                            <option value="${i.categoryID}">${i.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Skill Required<span class="text-danger">*</span></label> 
                                                <div class="form-button p-1">
                                                    <select class="form-control resume select2 select2-hidden-accessible" name="skillID" multiple="" data-placeholder="Select skill" style="width: 100%; border-color: #dee2e6" tabindex="-1" aria-hidden="true">
                                                        <%
                                                            List<JobSkills> listJobSkill = (List<JobSkills>) request.getAttribute("LIST_JOBSKILLS");
                                                            if (!listJobSkill.isEmpty()) {
                                                                for (JobSkills jobSkill : listJobSkill) {
                                                        %>
                                                        <option selected="selected" value="<%= jobSkill.getSkill().getSkillID()%>"><%= jobSkill.getSkill().getSkillName()%></option>
                                                        <c:forEach items="${applicationScope.SKILL_LIST}" var="i">
                                                            <option value="${i.skillID}">${i.skillName}</option>
                                                        </c:forEach>
                                                        <%
                                                            }
                                                        } else {
                                                        %>
                                                        <c:forEach items="${applicationScope.SKILL_LIST}" var="i">
                                                            <option value="${i.skillID}">${i.skillName}</option>
                                                        </c:forEach>
                                                        <%
                                                            }
                                                        %>     
                                                    </select> 
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Payment Method<span class="text-danger">*</span> 
                                                    <span class="ml-5">Min - Max ($)<span class="text-danger">*</span></span>
                                                </label>
                                                <div class="row form-button">
                                                    <div class="col-lg-6 p-1 col-md-6">
                                                        <select id="paymentID" class="form-control resume" name="paymentMethodID">
                                                            <%
                                                                if (job.getPayMentMethod() != null) {
                                                            %>
                                                            <option selected="selected" value="${requestScope.JOB.payMentMethod.paymentMethodID}">${requestScope.JOB.payMentMethod.paymentMethodName}</option>    
                                                            <%
                                                                }
                                                            %>
                                                            <option value="2">Pay by Hour</option>
                                                            <option value="1">Pay by Project</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-lg-3 p-1 col-md-5" >
                                                        <%
                                                            if (job.getMinBudget() > 0) {
                                                        %>
                                                        <input id="minBudget" name="minBudget" type="number" step="0.5" min="0.5" class="form-control resume" value="${requestScope.JOB.minBudget}" required="" placeholder="0.5">
                                                        <%
                                                        } else {
                                                        %>
                                                        <input id="minBudget" name="minBudget" type="number" step="0.5" min="0.5" class="form-control resume" value="" required="" placeholder="0.5">
                                                        <%
                                                            }
                                                        %>
                                                    </div>    
                                                    <div class="col-lg-3 p-1 col-md-5" >    
                                                        <%
                                                            if (job.getMaxBudget() > 0) {
                                                        %>
                                                        <input id="maxBudget" name="maxBudget" type="number" step="0.5" min="1" class="form-control resume" value="${requestScope.JOB.maxBudget}" required="" placeholder="10">
                                                        <%
                                                        } else {
                                                        %>
                                                        <input id="maxBudget" name="maxBudget" type="number" step="0.5" min="1" class="form-control resume" value="" required="" placeholder="10">
                                                        <%
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Email<span class="text-danger">*</span></label>
                                                <input onchange="checkValidation()" id="email" name="email" type="email" class="form-control resume" required="" value="${requestScope.JOB.email}" placeholder="abc@gmail.com">
                                                <p id="errorEmail" class="text-danger h7"><p>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Phone<span class="text-danger">*</span></label>
                                                <input onchange="checkValidation()" id="phone" name="phone" type="tel" class="form-control resume" value="${requestScope.JOB.phone}" required="" placeholder="0123456789">
                                                <p id="errorPhone" class="text-danger h7"><p>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <%
                                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyy-MM-dd");
                                                    LocalDate localDate = LocalDate.now();
                                                %>
                                                <label>Expiry date<span class="text-danger">*</span></label>
                                                <input min="<%=dtf.format(localDate)%>" id="expiriedDate" name="expiriedDate" type="date" class="form-control resume" value="${requestScope.JOB.expiriedDate}" required="" placeholder="dd/mm/yyyy">
                                                <p id="errorExDate" class="text-danger h7"><p>
                                            </div>
                                        </div>

                                        <div class="col-md-8">
                                            <div class="form-group app-label mt-2">
                                                <label>Address<span class="text-danger">*</span></label>
                                                <input id="address" name="address" type="text" class="form-control resume" required="" value="${requestScope.JOB.address}" placeholder="District 9, Ho Chi Minh City">
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group app-label">
                                                <label>Description<span class="text-danger">*</span> :</label>
                                                <textarea id="description" name="description" type="text" class="form-control resume" required="" placeholder="Things needed for the job:">${requestScope.JOB.description}</textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-12 mt-2">
                                            <input type="hidden" name="jobID" value="<%= job.getJobID()%>">
                                            <%
                                                if (job.getJobID() > 0) {
                                            %>
                                            <input type="submit" id="postJobbtn" name="" class="submitBnt btn btn-primary" value="Update Project">
                                            <%
                                            } else {
                                            %>
                                            <input type="submit" id="postJobbtn" name="" class="submitBnt btn btn-primary" value="Post a Project">
                                            <%
                                                }
                                            %>
                                            <input type="hidden" id="postJobbtn" name="action" class="submitBnt btn btn-primary" value="Post a Job">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- POST A JOB END -->

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
        <script>CKEDITOR.replace('description');</script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
        <script>
                                                    $(document).ready(function () {
                                                        $('.select2').select2({
                                                            closeOnSelect: false
                                                        });
                                                    });
        </script>
        <script>
            function checkValidation() {
                var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im;
                var phoneNumber = document.getElementById('phone').value.replace(/\s/g, '');
                var checkPhone = false;
                let email = document.getElementById('email').value;
                var checkEmail = email.includes("@");
                var checkM = false;
                //checkPhone
                if (phoneNumber !== '') {
                    if (regex.test(phoneNumber) == false) {
                        $('#errorPhone').text('Phone number is invalid!');
                        document.getElementById('postJobbtn').disabled = true;
                    } else {
                        $('#errorPhone').text('');
                        checkPhone = true;
                    }
                } else {
                    $('#errorPhone').text('');
                    checkPhone = true;
                }
                //checkMail
                if (email !== "") {
                    if (!checkEmail) {
                        $('#errorEmail').text('Email is invalid!');
                        document.getElementById('postJobbtn').disabled = true;
                    } else {
                        $('#errorEmail').text('');
                        checkM = true;
                    }
                } else {
                    $('#errorEmail').text('');
                    checkM = true;
                }
                if (checkPhone == true && checkM == true || regex.test(phoneNumber) == true && checkEmail == true) {
                    document.getElementById('postJobbtn').disabled = false;
                }

            }
        </script>
        <script>
            $("#paymentID option").each(function () {
                $(this).siblings('[value="' + this.value + '"]').remove();
            });
            $("#cateID option").each(function () {
                $(this).siblings('[value="' + this.value + '"]').remove();
            });
        </script>
        <script>
            $('#minBudget').change(function () {
                var maxValue = document.getElementById("maxBudget").value;
                $('#minBudget').attr({
                    "max": maxValue
                });
            });
            $('#maxBudget').change(function () {
                var minValue = document.getElementById("minBudget").value;
                $('#maxBudget').attr({
                    "min": minValue
                });
            });
        </script>
    </body>
</html>
