<div class="border-bottom-2 py-32pt position-relative z-1">
    <div
            class="container page__container d-flex flex-column flex-md-row align-items-center text-center text-sm-left">
        <div class="flex d-flex flex-column flex-sm-row align-items-center mb-24pt mb-md-0">

            <div class="mb-24pt mb-sm-0 mr-sm-24pt">
                <h2 class="mb-0">Dashboard</h2>
                <ol class="breadcrumb p-0 m-0">
                    <li class="breadcrumb-item"><a
                            href="${pageContext.request.contextPath}/MainController?action=AdminIndex">Home</a></li>
                    <li class="breadcrumb-item active">
                        Dashboard
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>
<div class="container page__container">
    <div class="page-section">
        <div class="row mb-lg-8pt">
            <div class="col-lg-8">

                <div class="page-separator">
                    <div class="page-separator__text">Overview</div>
                </div>

                <div class="row">
                    <div class="col-md-6">

                        <div class="card ">
                            <div class="card-header pb-0 border-0 d-flex">
                                <div class="flex">
                                    <div class="h2 mb-0">130</div>
                                    <p class="mb-0"><strong>Users</strong></p>
                                </div>
                                <i class="material-icons text-50">more_horiz</i>
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
                                            <small class="flex lh-24pt">HRM</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_HRM}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${((requestScope.COUNT_TOTAL_HRM)/requestScope.COUNT_USER_LIST)*100}%;"
                                                 aria-valuenow="${requestScope.COUNT_TOTAL_HRM}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${requestScope.COUNT_USER_LIST}"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">HR</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_HR}</small>
                                        </p>
                                        <div class="progress"
                                             style="height: 4px;">
                                            <div class="progress-bar bg-primary"
                                                 role="progressbar"
                                                 style="width: ${((requestScope.COUNT_TOTAL_HR)/requestScope.COUNT_USER_LIST)*100}%;"
                                                 aria-valuenow="${requestScope.COUNT_TOTAL_HR}"
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
                                <div class="text-center">
                                    <a href="${pageContext.request.contextPath}/MainController?action=UserList" class="btn btn-outline-secondary">View users</a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-6">

                        <div class="card ">
                            <div class="card-header pb-0 border-0 d-flex">
                                <div class="flex">
                                    <div class="h2 mb-0">${requestScope.COUNT_COMPANY_LIST}</div>
                                    <p class="mb-0"><strong>Companies</strong></p>
                                </div>
                                <i class="material-icons text-50">more_horiz</i>
                            </div>
                            <div class="card-body">
                                <div class="text-50 mb-16pt">

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Verified</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_COMPANY_3}</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: ${requestScope.COUNT_TOTAL_COMPANY_3 / requestScope.COUNT_COMPANY_LIST * 100}%;" aria-valuenow="37" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Pending</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_COMPANY_2}</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: ${requestScope.COUNT_TOTAL_COMPANY_2 / requestScope.COUNT_COMPANY_LIST * 100}%;" aria-valuenow="22" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Not verified</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_COMPANY_1}</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: ${requestScope.COUNT_TOTAL_COMPANY_1 / requestScope.COUNT_COMPANY_LIST * 100}%;" aria-valuenow="13" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div>
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Inactive</small>
                                            <small class="lh-24pt">${requestScope.COUNT_TOTAL_COMPANY_0}</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: ${requestScope.COUNT_TOTAL_COMPANY_0 / requestScope.COUNT_COMPANY_LIST * 100}%;" aria-valuenow="26" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="text-center">
                                    <a href="${pageContext.request.contextPath}/MainController?action=CompanyList" class="btn btn-outline-secondary">View companies</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">

                        <div class="card ">
                            <div class="card-header pb-0 border-0 d-flex">
                                <div class="flex">
                                    <div class="h2 mb-0">50</div>
                                    <p class="mb-0"><strong>Projects</strong></p>
                                </div>
                                <i class="material-icons text-50">more_horiz</i>
                            </div>
                            <div class="card-body">
                                <div class="text-50 mb-16pt">

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Open</small>
                                            <small class="lh-24pt">21</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 42%;" aria-valuenow="37" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Work In Progress</small>
                                            <small class="lh-24pt">2</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 4%;" aria-valuenow="22" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Completed</small>
                                            <small class="lh-24pt">0</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 0%;" aria-valuenow="13" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div>
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Uncompleted</small>
                                            <small class="lh-24pt">0</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 0%;" aria-valuenow="26" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="text-center">
                                    <a href="${pageContext.request.contextPath}/MainController?action=ProjectList" class="btn btn-outline-secondary">View Projects</a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-6">

                        <div class="card ">
                            <div class="card-header pb-0 border-0 d-flex">
                                <div class="flex">
                                    <div class="h2 mb-0">7</div>
                                    <p class="mb-0"><strong>Disputes</strong></p>
                                </div>
                                <i class="material-icons text-50">more_horiz</i>
                            </div>
                            <div class="card-body">
                                <div class="text-50 mb-16pt">

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Open</small>
                                            <small class="lh-24pt">0</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 0%;" aria-valuenow="37" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Need To Response</small>
                                            <small class="lh-24pt">0</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 0%;" aria-valuenow="22" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="mb-4pt">
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Closed</small>
                                            <small class="lh-24pt">7</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 100%;" aria-valuenow="13" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div>
                                        <p class="d-flex align-items-center mb-0">
                                            <small class="flex lh-24pt">Resolved</small>
                                            <small class="lh-24pt">0</small>
                                        </p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style="width: 0%;" aria-valuenow="26" aria-valuemin="0"
                                                 aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="text-center">
                                    <a href="${pageContext.request.contextPath}/MainController?action=DisputeList" class="btn btn-outline-secondary">View Disputes</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="page-separator">
                    <div class="page-separator__text">Schedule</div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <div class="flex">
                                <strong>Today</strong>
                            </div>
                            <i class="material-icons text-50">more_horiz</i>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-soft-warning mb-0 p-8pt">
                            <div class="d-flex align-items-start">
                                <div class="mr-8pt">
                                    <i class="material-icons">error_outline</i>
                                </div>
                                <div class="flex">
                                    <small class="text-100">Nothing scheduled for today.</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
