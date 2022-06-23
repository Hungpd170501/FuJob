<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="se1621.dto.User"%>
<%@ page pageEncoding="UTF-8" %>

<%
    User loginUser = (User) session.getAttribute("LOGIN_USER");
%>
<!-- Navigation Bar-->
<header id="topnav" class="defaultscroll scroll-active">
    <!-- Tagline STart -->
    <div class="tagline">
        <div class="container">
            <div class="float-left">
                <div class="phone">
                    <i class="mdi mdi-phone-classic"></i> +84 899 315 570
                </div>
                <div class="email">
                    <a href="#">
                        <i class="mdi mdi-email"></i> FuJob1621@gmail.com
                    </a>
                </div>
            </div>
            <div class="float-right">
                <ul class="topbar-list list-unstyled d-flex" style="margin: 11px 0px;">
                    <li class="list-inline-item">
                        <% if (loginUser != null) {
                        %>
                        <a href="javascript:void(0);"><i class="mdi mdi-account mr-2"></i>${sessionScope.LOGIN_USER.fullName}</a></li>
                    <li class="list-inline-item"><a href="${pageContext.request.contextPath}/MainController?action=Logout"><i class="mdi mdi-logout"></i>Logout</a></li>

                    <%
                    } else {%>
                    <a href="${pageContext.request.contextPath}/view/login.jsp"><i class="mdi mdi-account mr-2"></i>Login</a></li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <!-- Tagline End -->

    <!-- Menu Start -->
    <div class="container">
        <!-- Logo container-->
        <div>
            <a href="${pageContext.request.contextPath}" class="logo">
                <img src="${pageContext.request.contextPath}/asset/images/Logo/Logo/Untitled-1.png" alt="" class="logo-light" height="18" />
                <img src="${pageContext.request.contextPath}/asset/images/Logo/Logo/Untitled-3.png" alt="" class="logo-dark" height="30" />
            </a>
        </div>                 
        <!--        <div class="buy-button">
                    <a href="view/post-a-job.jsp" class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Your Resume</a>
                </div>-->
        <!-- End Logo container-->
        <div class="menu-extras">
            <div class="menu-item">
                <!-- Mobile menu toggle-->
                <a class="navbar-toggle">
                    <div class="lines">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </a>
                <!-- End mobile menu toggle-->
            </div>
        </div>

        <div id="navigation">
            <!-- Navigation Menu-->   
            <ul class="navigation-menu">




                <li></li>
                <li><a href="${pageContext.request.contextPath}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/MainController?action=SearchlistJob">Project List</a></li>
                    <% if (loginUser != null) {
                    %>
                <li class="has-submenu">
                    <a href="javascript:void(0)">Your Project</a><span class="menu-arrow"></span>
                    <ul class="submenu">

                        <%--<li><a href="${pageContext.request.contextPath}/MainController?action=SearchlistJob&pageJob=${1}">Job List</a></li>--%>
                        <%
                            if (loginUser != null && StringUtils.equals(loginUser.getRole().getRoleID(), "US")) {
                        %>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=SearchlistJobOrder&userID=<%= loginUser.getUserID()%>">Your Project Applied</a></li>   
                        <li><a href="${pageContext.request.contextPath}/MainController?action=ListJobByID&userID=${sessionScope.LOGIN_USER.userID}">Your Project Posted</a></li>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=ListJobByID&userID=${sessionScope.LOGIN_USER.userID}">Your Project Ongoing</a></li>
                        
                            <%
                            } else if (loginUser != null && StringUtils.equals(loginUser.getRole().getRoleID(), "HR")) {
                            %>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=ListJobByID&userID=${sessionScope.LOGIN_USER.userID}">Your Project Posted</a></li>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=ListJobByID&userID=${sessionScope.LOGIN_USER.userID}">Your Project Ongoing</a></li>
                        
                            <%
                            } else if (loginUser != null && StringUtils.equals(loginUser.getRole().getRoleID(), "HRM")) {
                            %>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=ListJobByID&userID=${sessionScope.LOGIN_USER.userID}">Your Project Posted</a></li>

                        <%
                            }
                        %>        
                    </ul>
                </li>
                <%
                    }
                %>

                <li>
                    <a href="${pageContext.request.contextPath}/view/about.jsp">contact</a>
                </li>
                <li></li>

                <li></li>


                <%
                    if (loginUser != null && StringUtils.equals(loginUser.getRole().getRoleID(), "US")) {
                %>
                <li>
                    <div class="buy-button">
                        <a href="${pageContext.request.contextPath}/view/post-a-job.jsp" class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Post a Project</a>
                    </div>
                </li>
                <li class="has-submenu">
                    <div class="buy-button">
                        <div class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Your Resume</div>
                    </div>
                    <ul class="submenu">
                        <li><a href="${pageContext.request.contextPath}/MainController?action=CheckCreateResume&studentID=${sessionScope.LOGIN_USER.userID}">Edit your resume</a></li>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=SearchResumeID&studentID=${sessionScope.LOGIN_USER.userID}">View your resume</a></li>
                    </ul>  
                </li>
                <%
                } else if (loginUser != null && StringUtils.equals(loginUser.getRole().getRoleID(), "HR")) {
                %>
                <li>
                    <div class="buy-button">
                        <a href="${pageContext.request.contextPath}/view/post-a-job.jsp" class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Post a Project</a>
                    </div>
                </li>

                <li class="has-submenu">

                    <div class="buy-button">
                        <a href="${pageContext.request.contextPath}/MainController?action=SearchCompanyID&searchCompanyID=${sessionScope.LOGIN_USER.companyID}" class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Your Company Info</a>

                    </div>


                </li>   
                <%
                } else if (loginUser != null && StringUtils.equals(loginUser.getRole().getRoleID(), "HRM")) {
                %>
                <li>
                    <div class="buy-button">
                        <a href="${pageContext.request.contextPath}/view/post-a-job.jsp" class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Post a Project</a>
                    </div>
                </li>

                <li class="has-submenu">

                    <div class="buy-button">
                        <div class="btn btn-primary"><i class="mdi mdi-cloud-upload"></i> Your company</div>
                    </div>

                    <ul class="submenu">
                        <li><a href="${pageContext.request.contextPath}/view/create-companyinfo.jsp">Edit your company info</a></li>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=SearchCompanyID&searchCompanyID=${sessionScope.LOGIN_USER.companyID}">View your company info</a></li>
                        <li><a href="${pageContext.request.contextPath}/MainController?action=ViewAllHR&companyID=${sessionScope.LOGIN_USER.companyID}">Your human resource </a></li>
                    </ul>
                </li>
                <%
                    }
                %>
            </ul><!--end navigation menu-->
        </div><!--end navigation-->
    </div><!--end container-->
    <!--end end-->
</header><!--end header-->
<!-- Navbar End -->