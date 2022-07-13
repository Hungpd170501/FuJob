<%@page import="se1621.dto.Error.CompanyInfoError"%>
<%@page import="se1621.dao.CompanyInfoDAO"%>
<%@page import="java.util.List"%>
<%@page import="se1621.dto.CompanyInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Edit Company "/>
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
                                <h4 class="text-uppercase title mb-4">Create Company Information</h4>
                                
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
                            <%
                                CompanyInfoError comError = (CompanyInfoError) request.getAttribute("COM_ERROR");
                                if (comError == null) {
                                    comError = new CompanyInfoError();
                                }
                            %>
                            <form action="/FuJob/MainController" method="POST" enctype="multipart/form-data">
                                <div class="row mt-4">
                                    
                                    <input type="hidden" name="companyID" value=" ${requestScope.COMPANYINFO.companyID}" />
                                    <label class="col-md-12">
                                        <input type="file" style="display: none" id="imageFile" name="avatar" onchange="showPreview(event);" >
                                        <img style="cursor:  pointer" id="file-ip-1-preview" onerror="this.src='${pageContext.request.contextPath}/asset/images/avatar-default.jpg';" src="${requestScope.COMPANYINFO.avatar}" class="img-fluid avatar avatar-medium d-block mx-auto rounded-pill" alt="" >
                                    </label>
                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Company Name<span class="text-danger">*</span> :</label>
                                            <input id="company-name" type="text" name="companyname" class="form-control resume" required="" placeholder="Comapny Name :" value="${requestScope.COMPANYINFO.companyName}">
                                            <p class="text-danger text-right h6 small"><%= comError.getCompanyNameError()%></p>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Established Year<span class="text-danger">*</span> :</label>
                                            <input id="EstablishedYear" name="establishedyear" type="number" min="1000" class="form-control resume" required="" placeholder="Established Year :" value="${requestScope.COMPANYINFO.establishedYear}">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Address<span class="text-danger">*</span> :</label>
                                            <input id="Address" name="address" type="text" class="form-control resume" required="" placeholder="Address: " value="${requestScope.COMPANYINFO.address}">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Type Company<span class="text-danger">*</span> :</label>
                                            <input id="TypeCompany" name="typecompany" type="text" class="form-control resume" required="" placeholder="Type Company :" value="${requestScope.COMPANYINFO.typeCompany}">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Website<span class="text-danger">*</span> :</label>
                                            <input onchange="checkValidation()" id="Website" name="website" type="text" class="form-control resume" required="" placeholder="Website :" value="${requestScope.COMPANYINFO.website}">
                                            <p id="errorWebsite" class="text-danger h7"><p>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Email<span class="text-danger">*</span> :</label>
                                            <input onchange="checkValidation()" id="Email" name="gmail" type="email" class="form-control resume" required="" placeholder="Gmail :" value="${requestScope.COMPANYINFO.gmail}">
                                            <p id="errorEmail" class="text-danger h7"><p>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Phone<span class="text-danger">*</span> :</label>
                                            <input onchange="checkValidation()" id="Phone" name="phone" type="tel" class="form-control resume" required="" placeholder="Phone: " value="${requestScope.COMPANYINFO.phone}">
                                            <p id="errorPhone" class="text-danger h7"><p>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Number of Employee<span class="text-danger">*</span> :</label>
                                            <input id="Numberofemployee" name="numberofemployee" type="number" class="form-control resume" required="" placeholder="Number of employee :" value="${requestScope.COMPANYINFO.numberOfEmployee}">
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="form-group app-label">
                                            <label class="text-muted">Company Overview<span class="text-danger">*</span> :</label>
                                            <textarea id="Companyoverview" name="companyoverview" type="text" class="form-control resume" required="" placeholder="Company Overview :">${requestScope.COMPANYINFO.companyOverview}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 mt-4">
                                    <input type="hidden" id="btnCreateCom1" name="action" class="submitBnt btn btn-primary" value="Create CompanyInfo">
                                    <input type="submit" id="btnCreateCom" class="submitBnt btn btn-primary" value="Submit Company Info">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- CREATE RESUME END -->


        <!-- subscribe end -->

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
        <script>CKEDITOR.replace('companyoverview');</script>
        <script>
            function showPreview(event) {
                if (event.target.files.length > 0) {
                    var src = URL.createObjectURL(event.target.files[0]);
                    var preview = document.getElementById("file-ip-1-preview");
                    preview.src = src;
                    preview.style.display = "block";
                }
            }
            
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
                var phoneNumber = document.getElementById('Phone').value.replace(/\s/g, '');
                var checkPhone = false;
                let email = document.getElementById('Email').value;
                var checkEmail = email.includes("@");
                var checkM = false;
                var website = document.getElementById('Website').value;
                var checkW = false;
                //checkPhone
                if (phoneNumber !== '') {
                    if (regex.test(phoneNumber) == false) {
                        $('#errorPhone').text('Phone number is invalid!');
                        document.getElementById('btnCreateCom').disabled = true;
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
                        document.getElementById('btnCreateCom').disabled = true;
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
                        document.getElementById('btnCreateCom').disabled = true;
                    } else {
                        $('#errorWebsite').text('');
                        checkW = true;
                    }
                } else {
                    $('#errorWebsite').text('');
                    checkW = true;
                }
                
                if (checkPhone == true && checkM == true && checkW == true|| regex.test(phoneNumber) == true && checkEmail == true && validURL(website) == true) {
                    document.getElementById('btnCreateCom').disabled = false;
                }

            }
        </script>

    </body>
</html>
