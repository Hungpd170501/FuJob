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
                <h2 class="mb-0">USER MANAGEMENT</h2>

                <ol class="breadcrumb p-0 m-0">
                    <li class="breadcrumb-item"><a
                            href="${pageContext.request.contextPath}/MainController?action=AdminIndex">Home</a></li>
                    <li class="breadcrumb-item active">
                        USER MANAGEMENT
                    </li>
                </ol>

            </div>
        </div>
        <div class="row"
             role="tablist">
            <div class="col-auto d-flex flex-column">
                <h6 class="m-0">${requestScope.HR_2 + requestScope.HRM_2 + requestScope.AD_2 + requestScope.US_2}</h6>
                <p class="text-50 mb-0 d-flex align-items-center">
                    Pending
                </p>
            </div>
            <div class="col-auto border-left">
                <h6 class="m-0">3</h6>
                <p class="text-50 mb-0 d-flex align-items-center">
                    Online users
                </p>
            </div>
            <div class="col-auto border-left">
                <a href=""
                   class="btn btn-accent" data-toggle="modal" data-target="#myModal">New Account</a>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Create New Account</h4>
            </div>
            <div class="modal-body">
                <form method="POST" action="${pageContext.request.contextPath}/MainController">
                    <div class="modal-body">
                        <div class="form-group text-dark">
                            <label>Full Name<span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="fullName" placeholder="Enter Name"
                                   required="">
                        </div>
                        <div class="form-group text-dark">
                            <label>Email Login<span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="email" placeholder="Enter Email to Login"
                                   required="">
                        </div>
                        <div class="form-group text-dark">
                            <label>Role:</label>
                            <select class="form-select form-control" aria-label="Default select example" name="roleID">
                                <option value="US" selected>Student</option>
                                <option value="HRM">Human Resources Manager</option>
                                <option value="AD">Administrator</option>
                            </select>
                        </div>
                        <div class="form-group text-dark">
                            <label>Password<span class="text-danger">*</span></label>
                            <input id="password" type="password" class="form-control" name="password"
                                   placeholder="Enter password" required="">
                        </div>
                        <div class="form-group text-dark">
                            <label>Confirm Password<span class="text-danger">*</span></label>
                            <input oninput="checkConfirmPass()" id="confirmPassword" type="password"
                                   class="form-control" name="confirmPassword" placeholder="Enter password" required="">
                            <p id="errorConfirmPass" class="text-danger h7">
                            <p>
                        </div>
                    </div>
                        <div class="modal-footer border-top-0 d-flex justify-content-center">
                            <input type="submit" name="action" class="btn btn-primary" value="Create Account">
                        </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <!--<button type="button" class="btn btn-primary">Save changes</button>-->
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
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-6">

                        <div class="card mb-md-0 ml-n2">
                            <div class="card-header pb-0 border-0 d-flex mt-1">
                                <div class="flex">
                                    <div class="h2 mb-0">${requestScope.COUNT_USER_LIST}</div>
                                    <p class="mb-0"><strong>Total users</strong></p>
                                </div>
                                <i class="material-icons text-50">more_vert</i>
                            </div>
                            <div class="card-body">
                                <div class="text-50 mb-16pt">

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Students</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_US}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${requestScope.COUNT_TOTAL_US / requestScope.COUNT_USER_LIST * 100}%;"
                                                 aria-valuenow="${requestScope.COUNT_TOTAL_US}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_USER_LIST}"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">HR/HRM</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_HR + requestScope.COUNT_TOTAL_HRM}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${((requestScope.COUNT_TOTAL_HR + requestScope.COUNT_TOTAL_HRM)/requestScope.COUNT_USER_LIST)*100}%;"
                                                 aria-valuenow="${requestScope.COUNT_TOTAL_HR + requestScope.COUNT_TOTAL_HRM}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_USER_LIST}"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Administrators</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_AD}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${requestScope.COUNT_TOTAL_AD / requestScope.COUNT_USER_LIST * 100}%;"
                                                 aria-valuenow="${requestScope.COUNT_TOTAL_AD}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_USER_LIST}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-6">

                        <div class="card mb-md-0">
                            <div class="card-header pb-0 border-0 d-flex mt-1">
                                <div class="flex">
                                    <div class="h2 mb-0">${requestScope.COUNT_TOTAL_US}</div>
                                    <p class="mb-0"><strong>Students</strong></p>
                                </div>
                                <i class="material-icons text-50">more_vert</i>
                            </div>
                            <div class="card-body">
                                <div class="text-50 mb-16pt">

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Active</small>
                                            <small class="lh-24pt">${requestScope.US_1}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${requestScope.US_1 / requestScope.COUNT_TOTAL_US * 100}%;"
                                                 aria-valuenow="${requestScope.US_1}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_TOTAL_US}"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Inactive</small>
                                            <small class="lh-24pt">${requestScope.US_0}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${requestScope.US_0 / requestScope.COUNT_TOTAL_US * 100}%;"
                                                 aria-valuenow="${requestScope.US_0}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_TOTAL_US}"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Pending requests</small>
                                            <small class="lh-24pt">${requestScope.US_2}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${requestScope.US_2 / requestScope.COUNT_TOTAL_US * 100}%;"
                                                 aria-valuenow="${requestScope.US_2}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_TOTAL_US}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-md-4">
                <div class="row">
                    <div class="col-md-12">

                        <div class="card mb-md-0">
                            <div class="card-header pb-0 border-0 d-flex mt-1">
                                <div class="flex row">
                                    <div class="col-auto d-flex flex-column">
                                        <div class="h2 mb-0">${requestScope.COUNT_TOTAL_HR}</div>
                                        <p class="mb-0"><strong>HR</strong></p>
                                    </div>
                                    <div class="col-auto border-left d-flex flex-column">
                                        <div class="h2 mb-0">${requestScope.COUNT_TOTAL_HRM}</div>
                                        <p class="mb-0"><strong>HRM</strong></p>
                                    </div>
                                </div>
                                <i class="material-icons text-50">more_vert</i>
                            </div>
                            <div class="card-body">
                                <div class="text-50 mb-16pt">

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Active</small>
                                            <small class="lh-24pt">${requestScope.HR_1 + requestScope.HRM_1}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${(requestScope.HR_1 + requestScope.HRM_1) / (requestScope.COUNT_TOTAL_HR+requestScope.COUNT_TOTAL_HRM) * 100}%;"
                                                 aria-valuenow="${requestScope.HR_1 + requestScope.HRM_1}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${(requestScope.COUNT_TOTAL_HR+requestScope.COUNT_TOTAL_HRM)}"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Inactive</small>
                                            <small class="lh-24pt">8</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${requestScope.HR_0 + requestScope.HRM_0}%;"
                                                 aria-valuenow="${requestScope.HR_0 + requestScope.HRM_0}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${(requestScope.COUNT_TOTAL_HR+requestScope.COUNT_TOTAL_HRM)}"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Pending requests</small>
                                            <small class="lh-24pt">${requestScope.HR_2 + requestScope.HRM_2}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${(requestScope.HR_2 + requestScope.HRM_2) / (requestScope.COUNT_TOTAL_HR+requestScope.COUNT_TOTAL_HRM) * 100}%;"
                                                 aria-valuenow="${requestScope.HR_2 + requestScope.HRM_2}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_TOTAL_HR+requestScope.COUNT_TOTAL_HRM}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>

        <div class="page-separator mt-4">
            <div class="page-separator__text">USERS</div>
        </div>
        <div class="toolbar mb-2">
            <div class="form-inline">
                <span class="mr10">STATUS:</span>
                <select class="form-control mr10">
                    <option selected>All</option>
                    <option value="2">Pending</option>
                    <option value="1">Active</option>
                    <option value="0">Inactive</option>
                </select>
                <span class="mr10 ml-3">ROLE: </span>
                <select class="form-control mr10">
                    <option selected>All</option>
                    <option value="1">Human Resources</option>
                    <option value="2">Human Resources Manager</option>
                    <option value="3">Student</option>
                    <option value="3">Administration</option>
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
                           data-page-size="25"
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
                                <a>#</a>
                            </th>
                            <th data-sortable="true">
                                <a>Name</a>
                            </th>
                            <th data-sortable="true">
                                <a>Email</a>
                            </th>
                            <th data-sortable="true" data-filter-control="select">
                                <a>Role</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false">
                                <a>Created</a>
                            </th>
                            <th style="width: 120px;" data-sortable="true" data-searchable="false">
                                <a>Status</a>
                            </th>
                            <th style="width: 20px;" class="pl-0" data-sortable="true" data-searchable="false">Action
                            </th>
                        </tr>
                        </thead>
                        <tbody class="list" id="search">
                        <c:forEach items="${requestScope.USER_LIST}" var="item">
                            <tr>
                                <td class="js-lists-values-id small">${pageScope.item.userID}</td>
                                <td>
                                    <div class="media flex-nowrap align-items-center"
                                         style="white-space: nowrap;">
                                        <!--                                            <div class="avatar avatar-32pt mr-8pt">
                                                                                        <span class="avatar-title rounded-circle"></span>
                                                                                    </div>-->
                                        <div class="media-body">
                                            <div class="d-flex flex-column">
                                                <p class="mb-0"><strong
                                                        class="js-lists-values-username">${pageScope.item.fullName}</strong>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="js-lists-values-email">${pageScope.item.email}</td>
                                <td class="js-lists-values-role-name">${pageScope.item.role.roleID}</td>
                                <td>
                                    <p class="mb-0"><strong
                                            class="js-lists-values-date text-50">${pageScope.item.createdDate}</strong>
                                    </p>
                                </td>
                                <td>
                                    <c:if test="${pageScope.item.userStatus == 0}">
                                        <p class="mb-0 text-danger"><strong
                                                class="js-lists-values-activity">Inactive</strong></p>
                                    </c:if>
                                    <c:if test="${pageScope.item.userStatus == 1}">
                                        <p class="mb-0 text-success"><strong
                                                class="js-lists-values-activity">Active</strong></p>
                                    </c:if>
                                    <c:if test="${pageScope.item.userStatus == 2}">
                                        <p class="mb-0 text-warning"><strong
                                                class="js-lists-values-activity">Pending</strong></p>
                                    </c:if>
                                </td>
                                <td class="text-right pl-0">
                                    <c:if test="${pageScope.item.userStatus == 1 && pageScope.item.fullName != sessionScope.LOGIN_USER.fullName}">
                                        <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                            <input type="hidden" name="action" value="UpdateUserStatus">
                                            <input type="hidden" name="userID" value="${pageScope.item.userID}">
                                            <input type="hidden" name="status" value="0">
                                            <input type="submit" class="text-danger" style="border: 0; background: 0;" value="Deactivate">   
                                        </form>
                                    </c:if>
                                    <c:if test="${pageScope.item.userStatus != 1}">
                                        <form method="POST" action="${pageContext.request.contextPath}/MainController">
                                            <input type="hidden" name="action" value="UpdateUserStatus">
                                            <input type="hidden" name="userID" value="${pageScope.item.userID}">
                                            <input type="hidden" name="status" value="1">
                                            <input type="submit" class="text-success" style="border: 0; background: 0;" value="Activate">   
                                        </form>
                                    </c:if>

                                    <div class="btn-group">
                                        <button type="button" class="btn  dropdown-toggle"
                                                data-toggle="dropdown" aria-haspopup="true"
                                                data-boundary="viewport"
                                                aria-expanded="false"></button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" data-toggle="modal" data-target="#profile">View
                                                Profile</a>
                                        </div>
                                    </div>
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

