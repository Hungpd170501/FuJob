<div class="navbar navbar-expand navbar-shadow px-0  pl-lg-16pt navbar-light bg-body" id="default-navbar" data-primary>
    <!-- Navbar toggler -->
    <button class="navbar-toggler d-block d-lg-none rounded-0" type="button" data-toggle="sidebar">
        <span class="material-icons">menu</span>
    </button>
    <!-- Navbar Brand -->
    <a href="${pageContext.request.contextPath}/MainController?action=AdminIndex" class="navbar-brand mr-16pt">
        <img class="navbar-brand-icon mr-0 mr-lg-8pt"
             src="${pageContext.request.contextPath}/asset/images/Logo/Logo/Untitled-3.png" width="70" alt="FuJob">
        <span class="d-none d-lg-block"></span>
    </a>
    <div class="flex"></div>
    <div class="nav navbar-nav flex-nowrap d-flex ml-0 mr-16pt">
        <div class="nav-item dropdown d-none d-sm-flex">
            <a href="#" class="nav-link d-flex align-items-center dropdown-toggle" data-toggle="dropdown">
                <img width="32" height="32" class="rounded-circle mr-8pt"
                     src="${pageContext.request.contextPath}/asset/images/people/50/guy-3.jpg" alt="account"/>
                <span class="flex d-flex flex-column mr-8pt">
                    <span class="navbar-text-100">${sessionScope.LOGIN_USER.fullName}</span>
                    <small class="navbar-text-50">Administrator</small>
                </span>
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <div class="dropdown-header"><strong>Account</strong></div>
                <a class="dropdown-item" href="compact-edit-account.html">Edit Account</a>
                <a class="dropdown-item"
                   href="${pageContext.request.contextPath}/MainController?action=Logout">Logout</a>
            </div>
        </div>
        <!-- Notifications dropdown -->
        <div class="nav-item ml-16pt dropdown dropdown-notifications">
            <button class="nav-link btn-flush dropdown-toggle" type="button" data-toggle="dropdown"
                    data-dropdown-disable-document-scroll data-caret="false">
                <i class="material-icons">notifications</i>
                <span class="badge badge-notifications badge-accent">2</span>
            </button>
            <div class="dropdown-menu dropdown-menu-right">
                <div data-perfect-scrollbar class="position-relative">
                    <div class="dropdown-header"><strong>System notifications</strong></div>
                    <div class="list-group list-group-flush mb-0">
                        <a href="javascript:void(0);" class="list-group-item list-group-item-action unread">
                            <span class="d-flex align-items-center mb-1">
                                <small class="text-black-50">3 minutes ago</small>
                                <span class="ml-auto unread-indicator bg-accent"></span>
                            </span>
                            <span class="d-flex">
                                <span class="avatar avatar-xs mr-2">
                                    <span class="avatar-title rounded-circle bg-light">
                                        <i class="material-icons font-size-16pt text-accent">account_circle</i>
                                    </span>
                                </span>
                                <span class="flex d-flex flex-column">

                                    <span class="text-black-70">Your profile information has not been synced
                                        correctly.</span>
                                </span>
                            </span>
                        </a>
                        <a href="javascript:void(0);" class="list-group-item list-group-item-action">
                            <span class="d-flex align-items-center mb-1">
                                <small class="text-black-50">5 hours ago</small>

                            </span>
                            <span class="d-flex">
                                <span class="avatar avatar-xs mr-2">
                                    <span class="avatar-title rounded-circle bg-light">
                                        <i class="material-icons font-size-16pt text-primary">group_add</i>
                                    </span>
                                </span>
                                <span class="flex d-flex flex-column">
                                    <strong class="text-black-100">Adrian. D</strong>
                                    <span class="text-black-70">Wants to join your private group.</span>
                                </span>
                            </span>
                        </a>
                        <a href="javascript:void(0);" class="list-group-item list-group-item-action">
                            <span class="d-flex align-items-center mb-1">
                                <small class="text-black-50">1 day ago</small>
                            </span>
                            <span class="d-flex">
                                <span class="avatar avatar-xs mr-2">
                                    <span class="avatar-title rounded-circle bg-light">
                                        <i class="material-icons font-size-16pt text-warning">storage</i>
                                    </span>
                                </span>
                                <span class="flex d-flex flex-column">

                                    <span class="text-black-70">Your deploy was successful.</span>
                                </span>
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- // END Notifications dropdown -->

        <!-- Notifications dropdown -->
        <div class="nav-item ml-16pt dropdown dropdown-notifications">
            <button class="nav-link btn-flush dropdown-toggle" type="button" data-toggle="dropdown"
                    data-dropdown-disable-document-scroll data-caret="false">
                <i class="material-icons icon-24pt">mail_outline</i>
            </button>
            <div class="dropdown-menu dropdown-menu-right">
                <div data-perfect-scrollbar class="position-relative">
                    <div class="dropdown-header"><strong>Messages</strong></div>
                    <div class="list-group list-group-flush mb-0">

                        <a href="javascript:void(0);" class="list-group-item list-group-item-action unread">
                            <span class="d-flex align-items-center mb-1">
                                <small class="text-black-50">5 minutes ago</small>

                                <span class="ml-auto unread-indicator bg-accent"></span>

                            </span>
                            <span class="d-flex">
                                <span class="avatar avatar-xs mr-2">
                                    <img src="${pageContext.request.contextPath}/asset/images/people/110/woman-5.jpg"
                                         alt="people"
                                         class="avatar-img rounded-circle">
                                </span>
                                <span class="flex d-flex flex-column">
                                    <strong class="text-black-100">Michelle</strong>
                                    <span class="text-black-70">Clients loved the new design.</span>
                                </span>
                            </span>
                        </a>
                        <a href="javascript:void(0);" class="list-group-item list-group-item-action">
                            <span class="d-flex align-items-center mb-1">
                                <small class="text-black-50">5 minutes ago</small>

                            </span>
                            <span class="d-flex">
                                <span class="avatar avatar-xs mr-2">
                                    <img src="${pageContext.request.contextPath}/asset/images/people/110/woman-5.jpg"
                                         alt="people"
                                         class="avatar-img rounded-circle">
                                </span>
                                <span class="flex d-flex flex-column">
                                    <strong class="text-black-100">Michelle</strong>
                                    <span class="text-black-70">? Superb job..</span>
                                </span>
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- // END Notifications dropdown -->
    </div>
</div>
