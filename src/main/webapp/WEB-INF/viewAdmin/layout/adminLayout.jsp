<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <jsp:include page="/WEB-INF/viewAdmin/include/head.jsp">
        <jsp:param name="title" value="FuJob | Admin Page"/>
    </jsp:include>
</head>
<body class="layout-compact layout-sticky-subnav layout-compact">
<%@include file="/WEB-INF/viewAdmin/components/loader.jsp" %>
<div class="mdk-drawer-layout js-mdk-drawer-layout" data-push data-responsive-width="992px">
    <div class="mdk-drawer-layout__content page-content">
        <%@include file="/WEB-INF/viewAdmin/include/navbar.jsp" %>
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
