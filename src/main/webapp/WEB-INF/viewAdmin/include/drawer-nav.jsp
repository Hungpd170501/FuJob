<!-- drawer -->
<div class="mdk-drawer js-mdk-drawer layout-compact__drawer" id="default-drawer">
    <div class="mdk-drawer__content js-sidebar-mini" data-responsive-width="992px" data-layout="compact">

        <div class="sidebar sidebar-mini sidebar-dark sidebar-left" data-perfect-scrollbar>

            <!--Navbar toggler-->
            <br>
            <ul class="nav flex-column flex-nowrap flex-shrink-0 sidebar-menu sm-item-bordered"
                id="sidebar-mini-tabs" role="tablist">
                <li class="sidebar-account mx-16pt mb-16pt">
                    <a href="#sm_account_1" class="p-4pt d-flex align-items-center justify-content-center"
                       data-toggle="tab" role="tab" aria-controls="sm_account_1" aria-selected="true">
                        <img width="32" height="32" class="rounded-circle mr-8pt"
                             src="${pageContext.request.contextPath}/asset/images/people/50/guy-3.jpg" alt="account"/>
                        <i class="material-icons text-black-20 icon-16pt">keyboard_arrow_down</i>
                    </a>
                </li>
                <li class="sidebar-menu-item" data-title="Dashboards" data-placement="right"
                    data-boundary="window">
                    <a class="sidebar-menu-button"
                       href="${pageContext.request.contextPath}/MainController?action=AdminIndex"
                       aria-controls="sm_dashboards"
                       aria-selected="true">
                        <i class="sidebar-menu-icon sidebar-menu-icon--left material-icons">dashboard</i>
                        <span class="sidebar-menu-text">Dashboard</span>
                    </a>
                </li>
                <li class="sidebar-menu-item " data-title="Account" data-placement="right" data-container="body"
                    data-boundary="window">
                    <a class="sidebar-menu-button"
                       href="${pageContext.request.contextPath}/MainController?action=UserList"
                    >
                        <i class="sidebar-menu-icon sidebar-menu-icon--left material-icons">account_box</i>
                        <span class="sidebar-menu-text">Users</span>
                    </a>
                </li>
                <li class="sidebar-menu-item " data-title="Company" data-placement="right" data-container="body"
                    data-boundary="window">
                    <a class="sidebar-menu-button"
                       href="${pageContext.request.contextPath}/MainController?action=CompanyList">
                        <i class="sidebar-menu-icon sidebar-menu-icon--left material-icons">business</i>
                        <span class="sidebar-menu-text">Companies</span>
                    </a>
                </li>
                <li class="sidebar-menu-item " data-title="Job" data-placement="right" data-container="body"
                    data-boundary="window">
                    <a class="sidebar-menu-button"
                       href="${pageContext.request.contextPath}/MainController?action=JobList">
                        <i class="sidebar-menu-icon sidebar-menu-icon--left material-icons">work</i>
                        <span class="sidebar-menu-text">Projects</span>
                    </a>
                </li>
                <li class="sidebar-menu-item " data-title="Job" data-placement="right" data-container="body"
                    data-boundary="window">
                    <a class="sidebar-menu-button"
                       href="${pageContext.request.contextPath}/MainController?action=DisputeList">
                        <i class="sidebar-menu-icon sidebar-menu-icon--left material-icons">receipt</i>
                        <span class="sidebar-menu-text">Disputes</span>
                    </a>
                </li>
                <li class="sidebar-menu-item " data-title="Category" data-placement="right"
                    data-container="body" data-boundary="window">
                    <a class="sidebar-menu-button" href="#sm_category" data-toggle="tab" role="tab"
                       aria-controls="sm_category">
                        <i class="sidebar-menu-icon sidebar-menu-icon--left material-icons">category</i>
                        <span class="sidebar-menu-text">Others</span>
                    </a>
                </li>
<!--                <li class="sidebar-menu-item " data-title="Messaging" data-placement="right"
                    data-container="body" data-boundary="window">
                    <a class="sidebar-menu-button" href="#sm_messaging" data-toggle="tab" role="tab"
                       aria-controls="#sm_messaging">
                        <i class="sidebar-menu-icon sidebar-menu-icon--left material-icons">message</i>
                        <span class="sidebar-menu-text">Messaging</span>
                    </a>
                </li>-->
            </ul>
        </div>

        <div class="sidebar sidebar-light sidebar-left flex sidebar-secondary sidebar-p-t"
             data-perfect-scrollbar>
            <div class="tab-content">

                <div class="tab-pane" id="sm_account_1">
                    <div class="sidebar-heading">Account</div>
                    <ul class="sidebar-menu">
                        <li class="sidebar-menu-item">
                            <a class="sidebar-menu-button" href="compact-edit-account.html">
                                <span class="sidebar-menu-text">Edit Account</span>
                            </a>
                        </li>
                        <li class="sidebar-menu-item">
                            <a class="sidebar-menu-button"
                               href="${pageContext.request.contextPath}/MainController?action=Logout">Logout</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-pane " id="sm_category">
                    <div class="sidebar-heading">Category</div>
                    <ul class="sidebar-menu">
                        <li class="sidebar-menu-item open">
                            <a class="sidebar-menu-button" data-toggle="collapse" href="#category_menu">
                                <span
                                        class="material-icons sidebar-menu-icon sidebar-menu-icon--left">category</span>
                                Category
                                <span class="ml-auto sidebar-menu-toggle-icon"></span>
                            </a>
                            <ul class="sidebar-submenu collapse sm-indent" id="category_menu">
                                <li class="sidebar-menu-item">
                                    <a class="sidebar-menu-button"
                                       href="${pageContext.request.contextPath}/MainController?action=JobCategory">
                                        <span class="sidebar-menu-text">Project Category</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="tab-pane " id="sm_messaging">
                    <div class="sidebar-heading">Messaging</div>
                    <ul class="sidebar-menu">
                        <li class="sidebar-menu-item open">
                            <a class="sidebar-menu-button" data-toggle="collapse" href="#messaging_menu">
                                <span
                                        class="material-icons sidebar-menu-icon sidebar-menu-icon--left">message</span>
                                Messaging
                                <span class="ml-auto sidebar-menu-toggle-icon"></span>
                            </a>
                            <ul class="sidebar-submenu collapse sm-indent" id="messaging_menu">
                                <li class="sidebar-menu-item">
                                    <a class="sidebar-menu-button" href="compact-messages.html">
                                        <span class="sidebar-menu-text">Messages</span>
                                    </a>
                                </li>
                                <li class="sidebar-menu-item">
                                    <a class="sidebar-menu-button" href="compact-email.html">
                                        <span class="sidebar-menu-text">Email</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="tab-pane " id="sm_company">
                    <div class="sidebar-heading">Company</div>
                    <ul class="sidebar-menu">
                        <li class="sidebar-menu-item open">
                            <a class="sidebar-menu-button" data-toggle="collapse" href="#company_menu">
                                <span
                                        class="material-icons sidebar-menu-icon sidebar-menu-icon--left">business</span>
                                Company
                                <span class="ml-auto sidebar-menu-toggle-icon"></span>
                            </a>
                            <ul class="sidebar-submenu collapse sm-indent" id="company_menu">
                                <li class="sidebar-menu-item">
                                    <a class="sidebar-menu-button" href="company-list.html">
                                        <span class="sidebar-menu-text">Company Management</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                </br>
            </div>
        </div>
        <!--// END drawer-->
    </div>
    <!--// END drawer-layout-->
</div>
