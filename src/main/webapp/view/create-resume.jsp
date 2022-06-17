<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Create Resume"/>
        </jsp:include>
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
                                <h4 class="text-uppercase title mb-4">Create Resume</h4>
                                <ul class="page-next d-inline-block mb-0">
                                    <li><a href="index.html" class="text-uppercase font-weight-bold">Home</a></li>
                                    <li><a href="#" class="text-uppercase font-weight-bold">Pages</a></li> 
                                    <li><a href="#" class="text-uppercase font-weight-bold">Candidates</a></li> 
                                    <li>
                                        <span class="text-uppercase text-white font-weight-bold">Create Resume</span> 
                                    </li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->

            <!-- CREATE RESUME START -->
            <section class="section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <h5 class="text-dark">General Information :</h5>
                        </div>

                        <div class="col-12 mt-3">
                            <div class="custom-form p-4 border rounded">

                                <form action="/FuJob/MainController" method="POST">
                                    <label class="col-md-12">
                                        <input type="file" style="display: none" id="imageFile" name="avatar" >
                                        <img style="cursor:  pointer" id="image"   src="https://via.placeholder.com/400X400//88929f/5a6270C/O https://placeholder.com/" class="img-fluid avatar avatar-medium d-block mx-auto rounded-pill" alt="" >
                                    </label>
                                    <div class="row mt-4">
                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Full Name<span class="text-danger">*</span> :</label>
                                                <input id="full-name" type="text" name="fullname" class="form-control resume" placeholder="Full Name :" required="">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Gender<span class="text-danger">*</span> :</label>
                                                <div class="form-button">
                                                    <select class="form-control resume" name="gender" required="">
                                                        <option value="Male">Male</option>
                                                        <option value="Female">Female</option>
                                                        <option value="Other">Other</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Date Of Birth<span class="text-danger">*</span> :</label>
                                                <input id="date-of-birth" type="date" name="dateofbirth" class="form-control resume" placeholder="Date Of Birth" required="">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Email<span class="text-danger">*</span> :</label>
                                                <input id="email" type="email" name="email" class="form-control resume" placeholder="Email :" required="">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Phone<span class="text-danger">*</span> :</label>
                                                <input id="Phone" name="phone" type="tel" class="form-control resume" required="" placeholder="0123456789 ">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Address<span class="text-danger">*</span> :</label>
                                                <input id="address" name="address" type="text" class="form-control resume" required="" placeholder="District 9, Ho Chi Minh City ">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">School Name<span class="text-danger">*</span> :</label>
                                                <input id="schoolName" name="shoolName" type="text" class="form-control resume" required="" placeholder="Job University ">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Major<span class="text-danger">*</span> :</label>
                                                <input id="major" name="major" type="text" class="form-control resume" required="" placeholder="Major: ">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">GPA:</label>
                                                <input id="gpa" name="gpa" type="text" class="form-control resume" placeholder="8/10 ">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group app-label">
                                                <label class="text-muted">Experience in your major<span class="text-danger">*</span> :</label>
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
                                            <div class="form-group app-label">
                                                <!--                                                <label class="text-muted">Skill Required<span class="text-danger">*</span></label>
                                                                                                <input id="skillrequired" name="skill" type="text" class="form-control resume" required="" placeholder="JAVA, HTML, ....">-->
                                                <label class="text-muted">Skill Required<span class="text-danger">*</span></label> 
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
                                        <div class="form-group app-label">
                                            <label class="text-muted">Your Website:</label>
                                            <input id="website" name="website" type="text" class="form-control resume" placeholder="website, github, facebook,... ">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Self-Introduction<span class="text-danger">*</span> :</label>
                                            <textarea id="seflintro" name="seflintro" type="text" class="form-control resume" required="" placeholder="Self-Introduction :"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 mt-4">
                                    <input type="submit" id="submit" name="action" class="submitBnt btn btn-primary" value="Submit Resume">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </section>
        <!-- CREATE RESUME END -->



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
