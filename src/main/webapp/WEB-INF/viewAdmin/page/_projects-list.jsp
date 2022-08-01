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
                <h2 class="mb-0">PROJECTS MANAGEMENT</h2>

                <ol class="breadcrumb p-0 m-0">
                    <li class="breadcrumb-item"><a
                            href="${pageContext.request.contextPath}/MainController?action=AdminIndex">Home</a></li>
                    <li class="breadcrumb-item active">
                        PROJECTS MANAGEMENT
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Total Projects</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_JOB_LIST}
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Today's Project</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_TODAY_JOB}
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Open Projects</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_OPEN_JOB_LIST}
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Completed</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${empty requestScope.COUNT_JOB_COMPLETED ?"0":requestScope.COUNT_JOB_COMPLETED}
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
            <div class="page-separator__text">OPEN PROJECTS</div>
        </div>
        <div class="row mb-32pt d-flex align-items-center mb-4">
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
                                <a>Client</a>
                            </th>
                            <th data-sortable="true">
                                <a>Bids</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true">
                                <a>Company</a>
                            </th>
                            <th data-sortable="true">
                                Category
                            </th>
                            <th data-sortable="true">
                                Budget
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Payment Method
                            </th>
                            <th data-sortable="true">
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
                            <th data-sortable="true">
                                Created Date
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
                        <c:forEach items="${requestScope.OPEN_JOB_LIST}" var="item">
                            <tr>
                                <td>${pageScope.item.jobID}</td>
                                <td>
                                    <div class="media flex-nowrap align-items-center"
                                         style="white-space: nowrap;">
                                        <!--                                            <div class="avatar avatar-32pt mr-8pt">
                                                                                        <span class="avatar-title rounded-circle"></span>
                                                                                    </div>-->
                                        <div class="media-body">
                                            <div class="d-flex flex-column">
                                                <p class="mb-0 text-info">${pageScope.item.jobTitle}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-info">@${pageScope.item.user.fullName}</td>
                                <td class="text-info">${fn:length(pageScope.item.jobApplications)}</td>
                                <td>
                                    <p class="mb-0"><strong
                                            class="js-lists-values-date text-50">${pageScope.item.user.companyID.companyName}</strong>
                                    </p>
                                </td>
                                <td>${pageScope.item.jobCategoryID.categoryName}</td>
                                <td>${pageScope.item.minBudget}$ - ${pageScope.item.maxBudget}$</td>
                                <td>${pageScope.item.paymentMethod.paymentMethodName}</td>
                                <td>${pageScope.item.address}</td>
                                <td>${pageScope.item.email}</td>
                                <td>${pageScope.item.phone}</td>
                                <td>${pageScope.item.description}</td>
                                <td>${pageScope.item.createdDate}</td>
                                <td>${pageScope.item.lastModifiedDate}</td>
                                <td>${pageScope.item.expiriedDate}</td>

                                <td>
                                    <p class="mb-0 text-success">Open</p>
                                </td>
                                <td class="text-right pl-0">
                                    <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                                    <input type="hidden" name="action" value="UpdateJobStatus">
                                                    <input type="hidden" name="jobID" value="${pageScope.item.jobID}">
                                                    <input type="hidden" name="status" value="0">
                                                    <input type="submit" class="text-danger" style="border: 0; background: 0;" value="Deactivate">   
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <div class="page-separator mt-4">
            <div class="page-separator__text">WORK IN PROGRESS</div>
        </div>
        <div class="row mb-32pt d-flex align-items-center mb-4">
            <div class="flex" style="max-width: 100%">

                <div class="card m-0">
                    <table id="ongoing-projects-table" data-toggle="table" data-pagination="true"
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
                                <a>Client</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true">
                                <a>Company</a>
                            </th>
                            <th data-sortable="true">
                                Category
                            </th>
                            <th data-sortable="true">
                                <a>Student</a>
                            </th>
                            <th data-sortable="true">
                                Awarded Bid
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Payment Method
                            </th>
                            <th data-sortable="true">
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
                            <th data-sortable="true">
                                Created Date
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Last Modified Date
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false" data-visible="false">
                                <a>Status</a>
                            </th>
                            <th style="width: 20px;" class="pl-0" data-sortable="true" data-searchable="false">Action
                            </th>
                        </tr>
                        </thead>
                        <tbody class="list" id="ongoing-project-search">
                        <c:forEach items="${requestScope.ONGOING_JOB_LIST}" var="item">
                            <tr>
                                <td>${pageScope.item.jobID}</td>
                                <td>
                                    <div class="media flex-nowrap align-items-center"
                                         style="white-space: nowrap;">
                                        <!--                                            <div class="avatar avatar-32pt mr-8pt">
                                                                                        <span class="avatar-title rounded-circle"></span>
                                                                                    </div>-->
                                        <div class="media-body">
                                            <div class="d-flex flex-column">
                                                <p class="mb-0 text-info">${pageScope.item.jobTitle}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-info">@${pageScope.item.user.fullName}</td>
                                <td>
                                    <p class="mb-0"><strong
                                            class="js-lists-values-date text-50">${pageScope.item.user.companyID.companyName}</strong>
                                    </p>
                                </td>
                                <td>${pageScope.item.jobCategoryID.categoryName}</td>
                                <c:forEach items="${pageScope.item.jobApplications}" var="jobApplicationItem">
                                    <c:if test="${pageScope.jobApplicationItem.jobApplicationStatus != 0}">
                                        <td class="text-info">
                                            <a href=""
                                               class="ml-2 text-info">@${pageScope.jobApplicationItem.resume.user.fullName}
                                            </a>
                                        </td>
                                        <td>${pageScope.jobApplicationItem.priceDeal}$</td>
                                    </c:if>
                                </c:forEach>
                                <td>${pageScope.item.paymentMethod.paymentMethodName}</td>
                                <td>${pageScope.item.address}</td>
                                <td>${pageScope.item.email}</td>
                                <td>${pageScope.item.phone}</td>
                                <td>${pageScope.item.description}</td>
                                <td>${pageScope.item.createdDate}</td>
                                <td>${pageScope.item.lastModifiedDate}</td>

                                <td>
                                    <p class="mb-0 text-success">In Progress</p>
                                </td>
                                                                <td class="text-right pl-0">
                                    <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                                    <input type="hidden" name="action" value="UpdateJobStatus">
                                                    <input type="hidden" name="jobID" value="${pageScope.item.jobID}">
                                                    <input type="hidden" name="status" value="0">
                                                    <input type="submit" class="text-danger" style="border: 0; background: 0;" value="Deactivate">   
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <div class="page-separator mt-4">
            <div class="page-separator__text">CLOSED PROJECTS</div>
        </div>
        <div class="toolbar mb-2">
            <div class="form-inline">
                <span class="mr10">STATUS:</span>
                <select class="form-control mr10">
                    <option selected>All</option>
                    <option value="6">Uncompleted</option>
                    <option value="5">Completed</option>
                    <option value="4">Expired</option>
                    <option value="Deleted">Inactive</option>
                </select>
                <button id="build" class="btn btn-light ml-3">Rebuild Table</button>
            </div>
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
                                <a>Client</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true">
                                <a>Company</a>
                            </th>
                            <th data-sortable="true">
                                Category
                            </th>
                            <th data-sortable="true" data-visible="false">
                                <a>Student</a>
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Awarded Bid
                            </th>
                            <th data-sortable="true">
                                Budget
                            </th>
                            <th data-sortable="true" data-visible="false">
                                <a>Bids</a>
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Payment Method
                            </th>
                            <th data-sortable="true">
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
                            <th data-sortable="true">
                                Created Date
                            </th>
                            <th data-sortable="true" data-visible="false">
                                Last Modified Date
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false">
                                <a>Status</a>
                            </th>
                            <th data-searchable="false" data-visible="false">
                                <a>Action</a>
                            </th>
                        </tr>
                        </thead>
                        <tbody class="list" id="search-closed-job">
                        <c:forEach items="${requestScope.CLOSED_JOB_LIST}" var="itemClosed">
                            <tr>
                                <td>${pageScope.itemClosed.jobID}</td>
                                <td>
                                    <div class="media flex-nowrap align-items-center"
                                         style="white-space: nowrap;">
                                        <!--                                            <div class="avatar avatar-32pt mr-8pt">
                                                                                        <span class="avatar-title rounded-circle"></span>
                                                                                    </div>-->
                                        <div class="media-body">
                                            <div class="d-flex flex-column">
                                                <p class="mb-0 text-info">${pageScope.itemClosed.jobTitle}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-info">@${pageScope.itemClosed.user.fullName}</td>
                                <td>
                                    <c:if test="${pageScope.itemClosed.user.companyID != null}">
                                        ${pageScope.itemClosed.user.companyID.companyName}
                                    </c:if>
                                    <c:if test="${pageScope.itemClosed.user.companyID == null}">
                                        N/A
                                    </c:if>
                                </td>
                                <td>${pageScope.itemClosed.jobCategoryID.categoryName}</td>
                                <c:if test="${pageScope.itemClosed.jobStatus == 5 || pageScope.itemClosed.jobStatus == 6}">
                                    <c:forEach items="${pageScope.itemClosed.jobApplications}" var="jobApplicationItem">
                                        <c:if test="${pageScope.jobApplicationItem.jobApplicationStatus != 0}">
                                            <td class="text-info">
                                                <a href=""
                                                   class="ml-2 text-info">@${pageScope.jobApplicationItem.resume.user.fullName}
                                                </a>
                                            </td>
                                            <td>${pageScope.jobApplicationItem.priceDeal}$</td>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${pageScope.itemClosed.jobStatus != 5 && pageScope.itemClosed.jobStatus != 6}">
                                    <td>N/A</td>
                                    <td>N/A</td>
                                </c:if>
                                <td>${pageScope.itemClosed.minBudget}$ - ${pageScope.itemClosed.maxBudget}$</td>
                                <td class="text-info">${fn:length(pageScope.item.jobApplications)}</td>
                                <td>${pageScope.itemClosed.paymentMethod.paymentMethodName}</td>
                                <td>${pageScope.itemClosed.address}</td>
                                <td>${pageScope.itemClosed.email}</td>
                                <td>${pageScope.itemClosed.phone}</td>
                                <td>${pageScope.itemClosed.description}</td>
                                <td>${pageScope.itemClosed.createdDate}</td>
                                <td>${pageScope.itemClosed.lastModifiedDate}</td>

                                <td>
                                    <c:if test="${pageScope.itemClosed.jobStatus == 5}">
                                        <p class="mb-0 text-success">Completed</p>
                                    </c:if>
                                    <c:if test="${pageScope.itemClosed.jobStatus == 6}">
                                        <p class="mb-0 text-danger">Uncompleted</p>
                                    </c:if>
                                    <c:if test="${pageScope.itemClosed.jobStatus == 4}">
                                        <p class="mb-0 text-warning">Expired</p>
                                    </c:if>
                                    <c:if test="${pageScope.itemClosed.jobStatus != 4 && pageScope.itemClosed.jobStatus != 5 && pageScope.itemClosed.jobStatus != 6}">
                                        <p class="mb-0 text-secondary">Deleted</p>
                                    </c:if>
                                </td>

                                <td class="text-right pl-0">


                                    <a href="" class="ml-2 text-secondary">View Detail
                                    </a>

                                    <c:if test="${pageScope.itemClosed.jobStatus == 5 && pageScope.itemClosed.jobStatus == 6}">
                                        <div class="btn-group">
                                            <button type="button" class="btn  dropdown-toggle"
                                                    data-toggle="dropdown" aria-haspopup="true"
                                                    data-boundary="viewport"
                                                    aria-expanded="false"></button>
                                            <div class="dropdown-menu">
                                                <a class="dropdown-item" data-toggle="modal" data-target="">View
                                                    Evaluation</a>
                                                <a class="dropdown-item" data-toggle="modal" data-target="">View
                                                    Product</a>
                                            </div>
                                        </div>
                                    </c:if>
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

