<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="https://unpkg.com/bootstrap-table@1.20.2/dist/extensions/custom-view/bootstrap-table-custom-view.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/asset/css/materialdesignicons.min.css"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/asset/css/fontawesome.css"/>

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
                <h2 class="mb-0">COMPANY MANAGEMENT</h2>

                <ol class="breadcrumb p-0 m-0">
                    <li class="breadcrumb-item"><a
                            href="${pageContext.request.contextPath}/MainController?action=AdminIndex">Home</a></li>
                    <li class="breadcrumb-item active">
                        COMPANY MANAGEMENT
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Total Companies</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_COMPANY_LIST}
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Pending</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_TOTAL_COMPANY_2}
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Verified</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_TOTAL_COMPANY_3}
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
                                    <p class="text-sm mb-0 text-capitalize font-weight-bold">Inactive</p>
                                    <h5 class="font-weight-bolder mb-0">
                                        ${requestScope.COUNT_TOTAL_COMPANY_0}
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
            <div class="page-separator__text">COMPANIES</div>
        </div>
        <div class="toolbar mb-2">
            <div class="form-inline">
                <span class="mr10">STATUS:</span>
                <select class="form-control mr10">
                    <option selected>All</option>
                    <option value="3">Verified</option>
                    <option value="2">Pending</option>
                    <option value="1">Not Verified</option>
                    <option value="0">Inactive</option>
                </select>
                <button id="build" class="btn btn-light ml-3">Rebuild Table</button>
            </div>
        </div>
        <div class="row mb-32pt d-flex align-items-center">
            <div class="flex" style="max-width: 100%">
                <div class="card m-0">
                    <table id="table" data-toggle="table" data-pagination="true"
                           data-show-jump-to="true"
                           data-show-search-clear-button="true"
                           data-page-size="6"
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
                           data-show-custom-view="true"
                           data-custom-view="customViewFormatter"
                           data-show-custom-view-button="true"
                           class="table mb-0 thead-border-top-0 table-nowrap pagination-sm">
                        <thead>
                        <tr>
                            <th style="width: 51px;" data-sortable="true" data-field="id">
                                <a>#</a>
                            </th>
                            <th data-sortable="true" data-field="name">
                                <a>Name</a>
                            </th>
                            <th data-sortable="true" data-field="address">
                                <a>Address</a>
                            </th>
                            <th data-sortable="true" data-field="website">
                                <a>Website</a>
                            </th>
                            <th data-sortable="true" data-searchable="false" data-visible="false" data-field="avatar">
                                <a>Avatar</a>
                            </th>
                            <th data-sortable="true" data-field="gmail">
                                <a>Gmail</a>
                            </th>
                            <th data-sortable="true" data-field="phone">
                                <a>Phone</a>
                            </th>
                            <th data-sortable="true">
                                <a>Type Company</a>
                            </th>
                            <th data-sortable="true" data-visible="false">
                                <a>Established Year</a>
                            </th>
                            <th data-sortable="true" data-visible="false">
                                <a>NO Employee</a>
                            </th>
                            <th data-sortable="true" data-visible="false" data-field="overview">
                                <a>Overview</a>
                            </th>
                            <th data-sortable="true" data-visible="false">
                                <a>Business License</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false">
                                <a>Created</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false" data-visible="false">
                                <a>Last Modified</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false" data-field="status">
                                <a>Status</a>
                            </th>
                            <th style="width: 20px;" class="pl-0" data-sortable="true" data-searchable="false">Action
                            </th>
                        </tr>
                        </thead>
                        <tbody class="list" id="search">
                        <c:forEach items="${requestScope.COMPANY_LIST}" var="item">
                            <tr>
                                <td class="js-lists-values-id small">${pageScope.item.companyID}</td>
                                <td>
                                    <div class="media flex-nowrap align-items-center"
                                         style="white-space: nowrap;">
                                        <div class="media-body">
                                            <div class="d-flex flex-column">
                                                <p class="mb-0"><strong
                                                        class="js-lists-values-username">${pageScope.item.companyName}</strong>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>${pageScope.item.address}</td>
                                <td>
                                    <a class="text-primary" href="${pageScope.item.website}" target="_blank"
                                       rel="noopener noreferrer"> ${pageScope.item.website}</a>
                                </td>
                                <td>
                                        ${pageScope.item.avatar}
                                </td>
                                <td>${pageScope.item.gmail}</td>
                                <td>${pageScope.item.phone}</td>
                                <td>${pageScope.item.typeCompany}</td>
                                <td>${pageScope.item.establishedYear}</td>
                                <td>${pageScope.item.numberOfEmployee}</td>
                                <td>${pageScope.item.companyOverview}</td>
                                <td>${pageScope.item.businessLicense}</td>
                                <td>
                                    <p class="mb-0"><strong
                                            class="text-50">${pageScope.item.createdDate}</strong></p>
                                </td>
                                <td>
                                    <p class="mb-0"><strong
                                            class="text-50">${pageScope.item.lastModifiedDate}</strong></p>
                                </td>
                                <td>
                                    <c:if test="${pageScope.item.companyStatus == 0}">
                                        <p class="mb-0 text-danger"><strong
                                                class="">Inactive</strong></p>
                                    </c:if>
                                    <c:if test="${pageScope.item.companyStatus == 1}">
                                        <p class="mb-0 text-secondary"><strong
                                                class="">Not Verified</strong></p>
                                    </c:if>
                                    <c:if test="${pageScope.item.companyStatus == 2}">
                                        <p class="mb-0 text-warning"><strong
                                                class="js-lists-values-activity">Pending</strong></p>
                                    </c:if>
                                    <c:if test="${pageScope.item.companyStatus == 3}">
                                        <p class="mb-0 text-success"><strong
                                                class="">Verified</strong></p>
                                    </c:if>
                                </td>
                                <td class="text-right pl-0">
                                    <c:if test="${pageScope.item.companyStatus == 1 || pageScope.item.companyStatus == 3}">
                                        <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                            <input type="hidden" name="action" value="UpdateCompanyStatus">
                                            <input type="hidden" name="companyID" value="${pageScope.item.companyID}">
                                            <input type="hidden" name="status" value="0">
                                            <input type="submit" class="text-danger" style="border: 0; background: 0;" value="Deactivate">   
                                        </form>
                                        <div class="btn-group">
                                            <button type="button" class="btn  dropdown-toggle"
                                                    data-toggle="dropdown" aria-haspopup="true"
                                                    data-boundary="viewport"
                                                    aria-expanded="false"></button>
                                            <div class="dropdown-menu">
                                                <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                                    <input type="hidden" name="action" value="UpdateCompanyStatus">
                                                    <input type="hidden" name="companyID" value="${pageScope.item.companyID}">
                                                    <input type="hidden" name="status" value="3">
                                                    <input type="submit" class="" style="border: 0; background: 0;" value="Verify">   
                                                </form>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${pageScope.item.companyStatus == 2}">
                                        <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                                    <input type="hidden" name="action" value="UpdateCompanyStatus">
                                                    <input type="hidden" name="companyID" value="${pageScope.item.companyID}">
                                                    <input type="hidden" name="status" value="3">
                                                    <input type="submit" class="text-success" style="border: 0; background: 0;" value="Verify">   
                                         </form>
                                        <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                                    <input type="hidden" name="action" value="UpdateCompanyStatus">
                                                    <input type="hidden" name="companyID" value="${pageScope.item.companyID}">
                                                    <input type="hidden" name="status" value="1">
                                                    <input type="submit" class="text-danger" style="border: 0; background: 0;" value="Deny">   
                                         </form>
                                    </c:if>
                                    <c:if test="${pageScope.item.companyStatus == 0}">
                                        <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                                    <input type="hidden" name="action" value="UpdateCompanyStatus">
                                                    <input type="hidden" name="companyID" value="${pageScope.item.companyID}">
                                                    <input type="hidden" name="status" value="3">
                                                    <input type="submit" class="text-success" style="border: 0; background: 0;" value="Activate">   
                                         </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <template id="profileTemplate">
                        <div class="col-4 mt-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="text-sm-center">
                                                <img src="%IMAGE%" alt="" height="150px" width="150px"
                                                     class="d-block mx-auto rounded-pill">
                                                <h4 class="mt-3"><a href="#" class="text-dark"> %NAME% </a></h4>
                                                <span class="list-inline text-muted mb-0">%STATUS%</span>

                                                <ul class="list-inline mb-0">
                                                    <li class="list-inline-item">
                                                        <p class="text-muted mb-0"><i
                                                                class="mdi mdi-cellphone-iphone"></i>%PHONE%</p>
                                                    </li>
                                                </ul>
                                                <ul class="list-inline mb-0">
                                                    <li class="list-inline-item mr-3">
                                                        <p class="text-muted mb-0"><i class="mdi mdi-email"></i>%MAIL%
                                                        </p>
                                                    </li>
                                                </ul>
                                                <ul class="list-inline mb-0">
                                                    <li class="list-inline-item mr-3">
                                                        <p class="text-muted mb-0"><i
                                                                class="mdi mdi-map-marker mr-2"></i>%ADDRESS%</p>
                                                    </li>
                                                </ul>
                                                <ul class="list-inline mb-0">
                                                    <li class="list-inline-item mr-3 ">
                                                        <p class="text-muted mb-0"><i class="mdi mdi-earth"></i>%WEBSITE%
                                                        </p>
                                                    </li>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </template>
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


    function customViewFormatter(data) {
        var template = $('#profileTemplate').html();
        var view = '';
        $.each(data, function (i, row) {
            view += template.replace('%NAME%', row.name)
                .replace('%WEBSITE%', row.website)
                .replace('%IMAGE%', row.avatar)
                .replace('%ADDRESS%', row.address)
                .replace('%MAIL%', row.gmail)
                .replace('%PHONE%', row.phone)
                .replace('%STATUS%', row.status)
            ;
        });
        return '<div class="row mx-0">' + view + '</div>';
    }

</script>
