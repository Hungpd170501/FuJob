<%@page import="se1621.dto.ResumeSkill"%>
<%@page import="se1621.dto.Resume"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Edit Resume"/>
        </jsp:include>
        <jsp:useBean id="chooseSkill" class="se1621.dao.SkillDAO" scope="request"></jsp:useBean>
            <link rel="stylesheet" href="https://unpkg.com/filepond@^4/dist/filepond.css" type="text/css"/>
            <link rel="stylesheet" href="https://unpkg.com/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css" type="text/css"/>
            <link rel="stylesheet" href="https://unpkg.com/filepond/dist/filepond.min.css" type="text/css"/>
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

                            </div>
                        </div>
                    </div>
                <%
                    String messResume = (String) request.getAttribute("MESSAGE_RESUME");
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
            </div>
        </section>
        <!-- end home -->
        <%
            Resume resume = (Resume) request.getAttribute("RESUME");
        %>
        <!-- CREATE RESUME START -->
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h5 class="text-dark">General Information :</h5>
                    </div>
                    <div class="col-12 mt-3">
                        <div class="custom-form p-4 border rounded">
                            <form action="/FuJob/MainController" method="POST" enctype="multipart/form-data">
                                <label class="col-md-12">
                                    <input type="file" style="display: none" id="imageFile" name="avatar" onchange="showPreview(event);" > <p class="text-muted text-center">Upload Your Avatar</p>
                                    <img style="cursor:  pointer" id="file-ip-1-preview" onerror="this.src='${pageContext.request.contextPath}/asset/images/avatar-default.jpg';"  src="${requestScope.RESUME.avatar}" class="img-fluid avatar avatar-medium d-block mx-auto rounded-pill" alt="avatar">
                                </label>
                                <div class="row mt-4">
                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Full Name<span class="text-danger">*</span> :</label>
                                            <input id="full-name" type="text" name="fullname" class="form-control resume" placeholder="Full Name :" required="" value="${requestScope.RESUME.fullName}">

                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Gender<span class="text-danger">*</span> :</label>
                                            <div class="form-button">
                                                <select class="form-control resume" name="gender" required="">
                                                    <%
                                                        if (resume.getGender() != "") {
                                                            if (resume.getGender() == "Male") {
                                                    %>    
                                                    <option selected="selected" value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                    <option value="Other">Other</option>
                                                    <%                                                        }
                                                        if (resume.getGender() == "Female") {
                                                    %>
                                                    <option value="Male">Male</option>
                                                    <option selected="selected" value="Female">Female</option>
                                                    <option value="Other">Other</option>
                                                    <%
                                                        }
                                                        if (resume.getGender() == "Other") {
                                                    %>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                    <option selected="selected" value="Other">Other</option>    
                                                    <%
                                                            }
                                                        }
                                                    %>
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
                                            <input id="date-of-birth" type="date" name="dateofbirth" class="form-control resume" placeholder="Date Of Birth" required="" value="${requestScope.RESUME.dateOfBirth}">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Email<span class="text-danger">*</span> :</label>
                                            <input onchange="checkValidation()" id="email" type="email" name="email" class="form-control resume" placeholder="Email :" required="" value="${requestScope.RESUME.gmail}">
                                            <p id="errorEmail" class="text-danger h7"><p>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Phone<span class="text-danger">*</span> :</label>
                                            <input onchange="checkValidation()" id="phone" name="phone" type="tel" class="form-control resume" required="" placeholder="0123456789 " value="${requestScope.RESUME.phone}">
                                            <p id="errorPhone" class="text-danger h7"><p>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Address<span class="text-danger">*</span> :</label>
                                            <input id="address" name="address" type="text" class="form-control resume" required="" placeholder="District 9, Ho Chi Minh City " value="${requestScope.RESUME.address}">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Major<span class="text-danger">*</span> :</label>
                                            <input id="major" name="major" type="text" class="form-control resume" required="" placeholder="Major: " value="${requestScope.RESUME.major}">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">GPA:</label>
                                            <input id="gpa" name="gpa" type="text" class="form-control resume" placeholder="8/10 " value="${requestScope.RESUME.gpa}">
                                        </div>
                                    </div>


                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Skills<span class="text-danger">*</span></label> 
                                            <div class="form-button">
                                                <select class="form-control resume select2 select2-hidden-accessible" name="skillID" multiple="" data-placeholder="Select skill" style="width: 100%; border-color: #dee2e6" tabindex="-1" aria-hidden="true" required="">
                                                    <%
                                                        List<ResumeSkill> listResumeSkill = (List<ResumeSkill>) request.getAttribute("LIST_STUDENTSKILL");
                                                        if (!listResumeSkill.isEmpty()) {
                                                            for (ResumeSkill studentSkill : listResumeSkill) {
                                                    %>
                                                    <option selected="selected" value="<%= studentSkill.getSkill().getSkillID()%>" ><%= studentSkill.getSkill().getSkillName()%></option>
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
                                        <div class="form-group app-label">
                                            <label class="text-muted">Your Website:</label>
                                            <input onchange="checkValidation()" id="website" name="website" type="text" class="form-control resume" placeholder="If u have a website of yourself, fill in here" value="${requestScope.RESUME.website}">
                                            <p id="errorWebsite" class="text-danger h7"><p>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Your GitHub</label>
                                            <input onchange="checkValidation()" id="gitHub" name="github" type="text" class="form-control resume" placeholder="If u have a github, fill in here " value="${requestScope.RESUME.gitHub}">
                                            <p id="errorGitHub" class="text-danger h7"><p>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Your LinkedIn</label>
                                            <input onchange="checkValidation()" id="linkedIn" name="linkedIn" type="text" class="form-control resume" placeholder="If u have a linkedin, fill in here " value="${requestScope.RESUME.linkedIn}">
                                            <p id="errorLinkedIn" class="text-danger h7"><p>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Self-Introduction<span class="text-danger">*</span> :</label>
                                            <textarea id="seflintro" name="seflintro" type="text" class="form-control resume" required="" placeholder="Self-Introduction :">${requestScope.RESUME.overview}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 mt-4">
                                    <input type="submit" id="submitResume" name="action" class="submitBnt btn btn-primary" value="Submit Resume">
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
        <script src="${pageContext.request.contextPath}/asset/ckeditor/ckeditor.js"></script>
        <script>CKEDITOR.replace('seflintro');</script>
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
            function showPreview(event) {
                if (event.target.files.length > 0) {
                    var src = URL.createObjectURL(event.target.files[0]);
                    var preview = document.getElementById("file-ip-1-preview");
                    preview.src = src;
                    preview.style.display = "block";
                }
            }
        </script>
        <script>
            function validURL(str) {
                var pattern = new RegExp('^(https?:\\/\\/)?' + // protocol
                        '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|' + // domain name
                        '((\\d{1,3}\\.){3}\\d{1,3}))' + // OR ip (v4) address
                        '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
                        '(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
                        '(\\#[-a-z\\d_]*)?$', 'i'); // fragment locator
                return !!pattern.test(str);
            }
            function checkValidation() {
                var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im;
                var phoneNumber = document.getElementById('phone').value.replace(/\s/g, '');
                var checkPhone = false;
                let email = document.getElementById('email').value;
                var checkEmail = email.includes("@");
                var checkM = false;
                var website = document.getElementById('website').value;
                var checkW = false;
                var gitHub = document.getElementById('gitHub').value;
                var checkG = false;
                var linkedIn = document.getElementById('linkedIn').value;
                var checkL = false;
                //checkPhone
                if (phoneNumber !== '') {
                    if (regex.test(phoneNumber) == false) {
                        $('#errorPhone').text('Phone number is invalid!');
                        document.getElementById('submitResume').disabled = true;
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
                        document.getElementById('submitResume').disabled = true;
                    } else {
                        $('#errorEmail').text('');
                        checkM = true;
                    }
                } else {
                    $('#errorEmail').text('');
                    checkM = true;
                }

                //checkWeb
                if (website !== '') {
                    if (validURL(website) == false) {
                        $('#errorWebsite').text('Url is invalid!');
                        document.getElementById('submitResume').disabled = true;
                    } else {
                        $('#errorWebsite').text('');
                        checkW = true;
                    }
                } else {
                    $('#errorWebsite').text('');
                    checkW = true;
                }

                //checkGit
                if (gitHub !== '') {
                    if (validURL(gitHub) == false) {
                        $('#errorGitHub').text('Url is invalid!');
                        document.getElementById('submitResume').disabled = true;
                    } else {
                        $('#errorGitHub').text('');
                        checkG = true;
                    }
                } else {
                    $('#errorGitHub').text('');
                    checkG = true;
                }

                //checkLinkedIn
                if (linkedIn !== '') {
                    if (validURL(linkedIn) == false) {
                        $('#errorLinkedIn').text('Url is invalid!');
                        document.getElementById('submitResume').disabled = true;
                    } else {
                        $('#errorLinkedIn').text('');
                        checkL = true;
                    }
                } else {
                    $('#errorLinkedIn').text('');
                    checkL = true;
                }
                if (checkPhone == true && checkM == true && checkW == true && checkG == true && checkL == true || regex.test(phoneNumber) == true && checkEmail == true && validURL(website) == true && validURL(gitHub) == true && validURL(linkedIn) == true) {
                    document.getElementById('submitResume').disabled = false;
                }

            }
        </script>
    </body>
</html>
