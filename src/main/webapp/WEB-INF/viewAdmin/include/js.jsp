<!--jQuery-->
<script src="${pageContext.request.contextPath}/asset/vendor/jquery.min.js"></script>

<!--Bootstrap-->
<script src="${pageContext.request.contextPath}/asset/vendor/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/vendor/bootstrap.min.js"></script>

<!--Perfect Scrollbar-->
<script src="${pageContext.request.contextPath}/asset/vendor/perfect-scrollbar.min.js"></script>

<!--DOM Factory-->
<script src="${pageContext.request.contextPath}/asset/vendor/dom-factory.js"></script>

<!--MDK-->
<script src="${pageContext.request.contextPath}/asset/vendor/material-design-kit.js"></script>

<!--App JS-->
<script src="${pageContext.request.contextPath}/asset/js/app2.js"></script>

<!--Highlight.js-->
<script src="${pageContext.request.contextPath}/asset/js/hljs.js"></script>

<!--Global Settings-->
<script src="${pageContext.request.contextPath}/asset/js/settings.js"></script>

<!--Flatpickr-->
<script src="${pageContext.request.contextPath}/asset/vendor/flatpickr/flatpickr.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/flatpickr.js"></script>

<!--Moment.js-->
<script src="${pageContext.request.contextPath}/asset/vendor/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/vendor/moment-range.js"></script>

<!--Chart.js-->
<script src="${pageContext.request.contextPath}/asset/vendor/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/chartjs.js"></script>

<!--Chart.js Samples-->
<script src="${pageContext.request.contextPath}/asset/js/page.analytics-dashboard.js"></script>

<!--Vector Maps-->
<script src="${pageContext.request.contextPath}/asset/vendor/jqvmap/jquery.vmap.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/vendor/jqvmap/maps/jquery.vmap.world.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/vector-maps.js"></script>

<!--List.js-->
<script src="${pageContext.request.contextPath}/asset/vendor/list.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/list.js"></script>

<!--Tables-->
<script src="${pageContext.request.contextPath}/asset/js/toggle-check-all.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/check-selected-row.js"></script>

<!--Sidebar Mini JS-->
<script src="${pageContext.request.contextPath}/asset/js/sidebar-mini.js"></script>
<script>
    (function () {
        'use strict';
        // ENABLE sidebar menu tabs
        $('#sidebar-mini-tabs [data-toggle="tab"]').on('click', function (e) {
            e.preventDefault()
            $(this).tab('show')
        })
    })()
</script>

<!--App Settings (safe to remove)-->
<script src="${pageContext.request.contextPath}/asset/js/app-settings.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/app.js"></script>