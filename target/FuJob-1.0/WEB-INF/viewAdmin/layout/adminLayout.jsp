<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <jsp:include page="/WEB-INF/viewAdmin/include/head.jsp">
        <jsp:param name="title" value="FuJob | Admin Dashboard"/>
    </jsp:include>
</head>
<body class="layout-compact layout-sticky-subnav layout-compact">
<%@include file="/WEB-INF/viewAdmin/components/loader.jsp" %>
<div class="mdk-drawer-layout js-mdk-drawer-layout" data-push data-responsive-width="992px">
    <div class="mdk-drawer-layout__content page-content">
        <%@include file="/WEB-INF/viewAdmin/components/loader.jsp" %>
        <div class="border-bottom-2 py-32pt position-relative z-1">
            <div
                    class="container page__container d-flex flex-column flex-md-row align-items-center text-center text-sm-left">
                <div class="flex d-flex flex-column flex-sm-row align-items-center mb-24pt mb-md-0">

                    <div class="mb-24pt mb-sm-0 mr-sm-24pt">
                        <h2 class="mb-0">Dashboard</h2>
                        <ol class="breadcrumb p-0 m-0">
                            <li class="breadcrumb-item"><a href="compact-index.html">Home</a></li>
                            <li class="breadcrumb-item active">
                                Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/viewAdmin/page/${param.body}"/>
        <%@include file="/WEB-INF/viewAdmin/include/footer.jsp" %>
    </div>
    <!-- // END drawer-layout__content -->

    <!-- drawer -->
    <%@include file="/WEB-INF/viewAdmin/include/drawer-nav.jsp" %>
    <%@include file="/WEB-INF/viewAdmin/include/js.jsp" %>
</div>

</body>
</html>
