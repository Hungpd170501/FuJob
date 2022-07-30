<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | About Us"/>
        </jsp:include>
    </head>

    <body>
        <jsp:include page="./components/loader.jsp"></jsp:include>
        <jsp:include page="./include/navbar.jsp"></jsp:include>
        <jsp:useBean id="totalJobPost" class="se1621.dao.JobDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="totalJobOrder" class="se1621.dao.JobApplicationDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="totalUserNonAD" class="se1621.dao.UserDAO" scope="request"></jsp:useBean>
            <!-- Start home -->
            <section class="bg-half page-next-level"> 
                <div class="bg-overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="text-center text-white">
                                <h4 class="text-uppercase title mb-4">Dispute Resolution</h4>

                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end home -->
            <!-- ABOUT US START -->
            <section class="section" style="margin-top: -20px">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-12 col-md-8" style="text-align: center;font-weight: 900">
                            <div class="about-desc ml-lg-4 float-left">
                                <h2>Dispute Resolution Process</h2>
                            </div>
                        </div>
                        <div class="" style="margin-left: 60px">
                            <h5 style="font-weight: 900">STAGE 1 - Identifying the issue</h5>
                            <div style="margin-left: 10px">
                                <h6>- User refuses to pay partner</h6>
                                <h6>- Stealing ownership</h6>
                                <h6>- Other...</h6>
                            </div>
                            <h5 style="font-weight: 900">STAGE 2 - Negotiations</h5>
                            <div style="margin-left: 10px">
                                <h6>- At this stage, either party can negotiate for partial compensation . Both parties will have the opportunity to tell their side of the story and also negotiate terms to resolve the issue between themselves (about 3 day).</h6>
                                <h6>- Only the party who originally filed for the dispute can cancel the dispute. If after 3 days the problem is not resolved through negotiation. Admin pages will be the arbitrator and resolve the dispute.</h6>
                            </div>
                            <h5 style="font-weight: 900">STAGE 3 - Show Evidence</h5>
                            <div style="margin-left: 10px">
                                <h6>- Both parties will have 2 days to present proof that they are serious about completing the project.</h6>
                                <div style="margin-left: 10px">
                                    <h6><li>Student: Stages of student implementation of projects (images, files, etc.) or exchanges between students and companies about the project….</li></h6>
                                    <h6><li>Company: Project requirements or changes during the student's project (images, files, etc.)...</li></h6>
                                </div>
                            </div>
                            <h5 style="font-weight: 900">STAGE 4 - Arbitration</h5>
                            <div style="margin-left: 10px">
                                <h6>- Admin will review all evidence and other information provided to reach a decision. Dispute verdicts are final, binding, and irreversible.</h6>
                                <div style="margin-left: 10px">
                                <h6><li>Student wins: The company has to pay that student based on the percentage of students who complete the project.</li></h6>
                                <h6><li>Company wins: Students will compensate percentage of the project that is damaged.</li></h6>
                                </div>
                                <h6>- If within 1 month the student or the company does not pay the above compensation amount. The admin will pay for it and the student or company will owe the admin. If the student and the company still have not paid the admin, the admin will take the case to court and let the law handle it.</h6>
                            </div>
                            <h6>We respect and seriously implement the provisions of the law on protecting the interests of members. Therefore, it is requested that the parties including students and companies provide complete, accurate, honest and detailed information related to the service provision transaction. All acts of deception and fraud are condemned and must be fully responsible before the law.</h6>
                        </div>
                    </div>
                </div>
            </section>


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
