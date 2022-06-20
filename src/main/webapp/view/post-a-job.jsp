<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Post Job "/>
        </jsp:include>
        <jsp:useBean id="chooseCategory" class="se1621.dao.CategoryDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="chooseSkill" class="se1621.dao.SkillDAO" scope="request"></jsp:useBean>
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
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Post A Project</span> 
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->

            <!-- POST A JOB START -->
            <section class="section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="rounded shadow bg-white p-4">
                                <div class="custom-form">
                                    <div id="message3"></div>
                                    <form action="/FuJob/MainController" method="POST">
                                        <h4 class="text-dark mb-3" style="font-weight: 700">Post a New Project :</h4>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group app-label mt-2">
                                                    <label>Project Name<span class="text-danger">*</span></label>
                                                    <input id="jobtitle" name="jobtitle" type="text" class="form-control resume" required="" placeholder="">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label>Project Category</label>
                                                    <div class="form-button">
                                                        <select class="form-control resume" name="categoryID" required="">
                                                        <c:forEach items="${chooseCategory.listCategory}" var="i">
                                                            <option value="${i.categoryID}">${i.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Skill Required<span class="text-danger">*</span></label> 
                                                <div class="form-button">
                                                    <select class="form-control resume select2 select2-hidden-accessible" name="skillID" multiple="" data-placeholder="Select skill" style="width: 100%; border-color: #dee2e6" tabindex="-1" aria-hidden="true">
                                                        <c:forEach items="${chooseSkill.listSkill}" var="i">
                                                            <option value="${i.skillID}">${i.skillName}</option>
                                                        </c:forEach>
                                                    </select> 
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>How do you want to pay?<span class="text-danger">*</span></label>
                                                <div class="row">
                                                    <div class="col-lg-7 p-1">
                                                        <select class="form-control resume">
                                                            <option value="Pay by the hour">Pay by the hour</option>
                                                            <option value="Pay fixed price">Pay fixed price</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-lg-5 p-1" >
                                                        <input id="salary" name="salary" type="text" class="form-control resume" required="" placeholder="100$">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Address<span class="text-danger">*</span></label>
                                                <input id="address" name="address" type="text" class="form-control resume" required="" placeholder="District 9, Ho Chi Minh City">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Email<span class="text-danger">*</span></label>
                                                <input id="email" name="email" type="tel" class="form-control resume" required="" placeholder="abc@gmail.com">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label mt-2">
                                                <label>Phone<span class="text-danger">*</span></label>
                                                <input id="phone" name="phone" type="tel" class="form-control resume" required="" placeholder="0123456789">
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group app-label">
                                                <label>Description<span class="text-danger">*</span> :</label>
                                                <textarea id="description" name="description" type="text" class="form-control resume" required="" placeholder="Things needed for the job:
                                                          ....
                                                          What the job will do:
                                                          ...."></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-12 mt-2">
                                            <input type="submit" id="submit" name="" class="submitBnt btn btn-primary" value="Post a Project">
                                            <input type="hidden" id="submit" name="action" class="submitBnt btn btn-primary" value="Post a Job">
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
        <script>
            $(document).ready(function () {
                $('.select2').select2({
                    closeOnSelect: false
                });
            });
        </script>

    </body>
</html>