<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="https://unpkg.com/bootstrap-table@1.20.2/dist/bootstrap-table.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>
<script src="https://unpkg.com/bootstrap-table@1.20.2/dist/bootstrap-table.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/tableExport.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/jsPDF/jspdf.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
<script src="https://unpkg.com/bootstrap-table@1.20.2/dist/extensions/export/bootstrap-table-export.min.js"></script>
<link href="https://unpkg.com/bootstrap-table@1.20.2/dist/extensions/page-jump-to/bootstrap-table-page-jump-to.min.css"
      rel="stylesheet">
<script src="https://unpkg.com/bootstrap-table@1.20.2/dist/extensions/page-jump-to/bootstrap-table-page-jump-to.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
<style>
    .fade.in {
        opacity: 1;
    }

    .modal.in .modal-dialog {
        -webkit-transform: translate(0, 0);
        -o-transform: translate(0, 0);
        transform: translate(0, 0);
    }

    .modal-backdrop.in {
        opacity: 0.5;
    }

    /*#select {
      width: 100px;
      display: inline-block;
    }*/
</style>
<div class="border-bottom-2 py-32pt position-relative z-1">
    <div
            class="container page__container d-flex flex-column flex-md-row align-items-center text-center text-sm-left">
        <div class="flex d-flex flex-column flex-sm-row align-items-center mb-24pt mb-md-0">

            <div class="mb-24pt mb-sm-0 mr-sm-24pt">
                <h2 class="mb-0">DISPUTES MANAGEMENT</h2>

                <ol class="breadcrumb p-0 m-0">
                    <li class="breadcrumb-item"><a
                            href="${pageContext.request.contextPath}/MainController?action=AdminIndex">Home</a></li>
                    <li class="breadcrumb-item active">
                        DISPUTES MANAGEMENT
                    </li>
                </ol>

            </div>
        </div>
    </div>
</div>
<div class="container page_container">
    <div class="page-section">
        <div class="page-separator">
            <div class="page-separator__text">Overview</div>
        </div>
        <div class="row">
            <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                <div class="card">
                    <div class="card-body p-3">
                        <div class="row">
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Total Disputes</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_DISPUTE_CLOSED+requestScope.COUNT_DISPUTE_OPEN+requestScope.COUNT_DISPUTE_RESOLVED}
                                    </h5>
                                </div>
                            </div>
                            <div class="col-4 text-end">
                                <i class="material-icons text-50">more_vert</i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                <div class="card">
                    <div class="card-body p-3">
                        <div class="row">
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Open Disputes</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${empty requestScope.COUNT_DISPUTE_OPEN ?"0":requestScope.COUNT_DISPUTE_OPEN}
                                    </h5>
                                </div>
                            </div>
                            <div class="col-4 text-end">
                                <i class="material-icons text-50" style="color: blue;">more_vert</i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                <div class="card">
                    <div class="card-body p-3">
                        <div class="row">
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Closed Disputes</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${empty requestScope.COUNT_DISPUTE_CLOSED ?"0":requestScope.COUNT_DISPUTE_CLOSED}
                                    </h5>
                                </div>
                            </div>
                            <div class="col-4 text-end">
                                <i class="material-icons text-50" style="color: blue;">more_vert</i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6">
                <div class="card">
                    <div class="card-body p-3">
                        <div class="row">
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Resolved</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${empty requestScope.COUNT_DISPUTE_RESOLVED ?"0":requestScope.COUNT_DISPUTE_RESOLVED}
                                    </h5>
                                </div>
                            </div>
                            <div class="col-4 text-end">
                                <i class="material-icons text-50" style="color: blue;">more_vert</i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-separator mt-4">
            <div class="page-separator__text">OPEN DISPUTES</div>
        </div>
        <div class="row mb-32pt d-flex align-items-center">
            <div class="flex" style="max-width: 100%">

                <div class="card m-0">
                    <table id="open-projects-table" data-toggle="table" data-pagination="true"
                           data-toggle="table"
                           data-toolbar="#toolbar"
                           data-show-jump-to="true"
                           data-show-search-clear-button="true"
                           data-page-size="10"
                           data-remember-order="true"
                           data-show-columns="true"
                           data-show-columns-toggle-all="true"
                           data-show-pagination-switch="true"
                           data-show-toggle="true"
                           data-show-fullscreen="true"
                           data-buttons="buttons"
                           data-search="true"
                           data-buttons-class="light"
                           data-show-export="true" data-page-list="[10, 25, 50, 100, all]"
                           class="table mb-0 thead-border-top-0 table-nowrap pagination-sm">
                        <thead>
                        <tr>
                            <th style="width: 51px;" data-sortable="true">
                                <a>Id</a>
                            </th>
                            <th data-sortable="true">
                                <a>Project Name</a>
                            </th>
                            <th data-sortable="true">
                                <a>Claimant</a>
                            </th>
                            <th data-sortable="true">
                                <a>Student</a>
                            </th>
                            <th data-sortable="true">
                                Client
                            </th>
                            <th data-sortable="true">
                                Awarded Bid
                            </th>
                            <th style="width: 120px;" data-sortable="true">
                                <a>Company</a>
                            </th>
                            <th data-sortable="true">
                                Created Date
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Category
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Budget
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Payment Method
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Address
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Email
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Phone
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Description
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Last Modified Date
                            </th>
                            <th data-sortable="true">
                                Expiried Date
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false">
                                <a>Status</a>
                            </th>
                            <th style="width: 20px;" class="pl-0" data-sortable="true" data-searchable="false">Action
                            </th>
                        </tr>
                        </thead>
                        <tbody class="list" id="open-project-search">
                        <c:forEach items="${requestScope.OPEN_DISPUTE_LIST}" var="item">
                            <tr>
                                <td>${pageScope.item.id}</td>
                                <td>
                                    <div class="media flex-nowrap align-items-center"
                                         style="white-space: nowrap;">
                                        <!--                                            <div class="avatar avatar-32pt mr-8pt">
                                                                                        <span class="avatar-title rounded-circle"></span>
                                                                                    </div>-->
                                        <div class="media-body">
                                            <div class="d-flex flex-column">
                                                <p class="mb-0 text-info">${pageScope.item.jobApplication.job.jobTitle}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-info">@${pageScope.item.userID}</td>
                                <td class="text-info">${pageScope.item.jobApplication.resume.user.fullName}</td>
                                <td class="text-info">${pageScope.item.jobApplication.job.user.fullName}</td>
                                <td class="text-info">${pageScope.item.jobApplication.priceDeal}</td>
                                <td>
                                    <p class="mb-0"><strong
                                            class="js-lists-values-date text-50">${pageScope.item.jobApplication.job.user.companyID.companyName}</strong>
                                    </p>
                                </td>
                                <td class="text-info">${pageScope.item.createdDate}</td>
                                <td class="text-info">${pageScope.item.jobApplication.job.jobCategoryID.categoryName}</td>
                                <td>
                                    <p class="mb-0 text-success">Open</p>
                                </td>
                                <td class="text-right pl-0">
                                    <a href="" class="ml-2 text-danger">Deactivate
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        


        <div class="page-separator mt-4">
            <div class="page-separator__text">RESOLVED DISPUTES</div>
        </div>
        <div class="row mb-32pt d-flex align-items-center">
            <div class="flex" style="max-width: 100%">

                <div class="card m-0">
                    <table id="table" data-toggle="table" data-pagination="true"
                           data-toggle="table"
                           data-toolbar="#toolbar"
                           data-show-jump-to="true"
                           data-show-search-clear-button="true"
                           data-page-size="10"
                           data-remember-order="true"
                           data-show-columns="true"
                           data-show-columns-toggle-all="true"
                           data-show-pagination-switch="true"
                           data-show-toggle="true"
                           data-show-fullscreen="true"
                           data-buttons="buttons"
                           data-search="true"
                           data-buttons-class="light"
                           data-show-export="true" data-page-list="[10, 25, 50, 100, all]"
                           class="table mb-0 thead-border-top-0 table-nowrap pagination-sm">
                        <thead>
                        <tr>
                            <th style="width: 51px;" data-sortable="true">
                                <a>Id</a>
                            </th>
                            <th data-sortable="true">
                                <a>Project Name</a>
                            </th>
                            <th data-sortable="true">
                                <a>Claimant</a>
                            </th>
                            <th data-sortable="true">
                                <a>Student</a>
                            </th>
                            <th data-sortable="true">
                                Client
                            </th>
                            <th data-sortable="true">
                                Awarded Bid
                            </th>
                            <th style="width: 120px;" data-sortable="true">
                                <a>Company</a>
                            </th>
                            <th data-sortable="true">
                                Created Date
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Category
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Budget
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Payment Method
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Address
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Email
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Phone
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Description
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Last Modified Date
                            </th>
                            <th data-sortable="true">
                                Expiried Date
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false">
                                <a>Status</a>
                            </th>
                            <th style="width: 20px;" class="pl-0" data-sortable="true" data-searchable="false">Action
                            </th>
                        </tr>
                        </thead>
                        <tbody class="list" id="search-closed-job">
                        <c:forEach items="${requestScope.RESOLVED_DISPUTE_LIST}" var="itemClosed">
                            <tr>
                                <td>${pageScope.itemClosed.id}</td>
                                <td>
                                    <div class="media flex-nowrap align-items-center"
                                         style="white-space: nowrap;">
                                        <!--                                            <div class="avatar avatar-32pt mr-8pt">
                                                                                        <span class="avatar-title rounded-circle"></span>
                                                                                    </div>-->
                                        <div class="media-body">
                                            <div class="d-flex flex-column">
                                                <p class="mb-0 text-info">${pageScope.itemClosed.jobApplication.job.jobTitle}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-info">@${pageScope.itemClosed.userID}</td>
                                <td class="text-info">${pageScope.itemClosed.jobApplication.resume.user.fullName}</td>
                                <td class="text-info">${pageScope.itemClosed.jobApplication.job.user.fullName}</td>
                                <td class="text-info">${pageScope.itemClosed.jobApplication.priceDeal}</td>
                                <td>
                                    <p class="mb-0"><strong
                                            class="js-lists-values-date text-50">${pageScope.itemClosed.jobApplication.job.user.companyID.companyName}</strong>
                                    </p>
                                </td>
                                <td class="text-info">${pageScope.itemClosed.createdDate}</td>
                                <td class="text-info">${pageScope.itemClosed.jobApplication.job.jobCategoryID.categoryName}</td>
                                <td>
                                    <p class="mb-0 text-success">Open</p>
                                </td>
                                <td class="text-right pl-0">
                                    <a href="" class="ml-2 text-danger">Deactivate
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $("body").children().first().before($(".modal"));
    $(function () {
        $('#table').bootstrapTable();
    });
</script>

