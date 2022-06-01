<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Post Job "/>
        </jsp:include>
        <jsp:useBean id="chooseCategory" class="se1621.dao.CategoryDAO" scope="request"></jsp:useBean>
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
                                <h4 class="text-uppercase title mb-4">Create A new Job</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Post A Job</span> 
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
                                        <h4 class="text-dark mb-3">Post a New Job :</h4>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Job Title<span class="text-danger">*</span></label>
                                                    <input id="jobtitle" name="jobtitle" type="text" class="form-control resume" required="" placeholder="">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group app-label">
                                                    <label class="text-muted">Experience Needed<span class="text-danger">*</span> :</label>
                                                    <div class="form-button">
                                                        <select class="form-control resume" name="chooseExY" required="">
                                                            <option value="Less than 1 year">Less than 1 year</option>
                                                            <option value="1-3 years">1-3 years</option>
                                                            <option value="3-5 years">3-5 years</option>
                                                            <option value="5-10 years">5-10 years</option>
                                                            <option value="More than 10 years">More than 10 years</option>
                                                        </select>

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Job Category</label>
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
                                                    <label class="text-muted">Skill Required<span class="text-danger">*</span></label>
                                                    <input id="skillrequired" name="skill" type="text" class="form-control resume" required="" placeholder="JAVA, HTML, ....">
                                                </div>
                                            </div> 
                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Deadline<span class="text-danger">*</span></label>
                                                    <input id="deadline" name="deadline" type="date" class="form-control resume" required="" placeholder="">
                                                </div>
                                            </div>


                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Estimated Completion Time <span class="text-danger">*</span></label>
                                                    <input id="completiontime" name="completiontime" type="text" class="form-control resume" required="" placeholder="1day, 2day, ...">
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Salary<span class="text-danger">*</span></label>
                                                    <input id="salary" name="salary" type="text" class="form-control resume" required="" placeholder="100$">
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Address<span class="text-danger">*</span></label>
                                                    <input id="address" name="address" type="text" class="form-control resume" required="" placeholder="District 9, Ho Chi Minh City">
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Email<span class="text-danger">*</span></label>
                                                    <input id="email" name="email" type="tel" class="form-control resume" required="" placeholder="abc@gmail.com">
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group app-label mt-2">
                                                    <label class="text-muted">Phone<span class="text-danger">*</span></label>
                                                    <input id="phone" name="phone" type="tel" class="form-control resume" required="" placeholder="0123456789">
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="form-group app-label">
                                                    <label class="text-muted">Description<span class="text-danger">*</span> :</label>
                                                    <textarea id="description" name="description" type="text" class="form-control resume" required="" placeholder="Things needed for the job:
 ....
What the job will do:
 ...."></textarea>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <ul class="list-inline mb-0">
                                                    <li class="list-inline-item">
                                                        <div class="input-group mt-2 mb-2">
                                                            <div class="custom-file">
                                                                <input type="file" name="cv" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                                                                <label class="custom-file-label rounded"><i class="mdi mdi-cloud-upload mr-1"></i> Upload Files</label>
                                                            </div>
                                                        </div>
                                                    </li>

                                                    <li class="list-inline-item">
                                                        <h6 class="text-muted mb-0">Upload Your CV</h6>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-12 mt-2">
                                                <input type="submit" id="submit" name="action" class="submitBnt btn btn-primary" value="Post a Job">
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

    </body>
</html>