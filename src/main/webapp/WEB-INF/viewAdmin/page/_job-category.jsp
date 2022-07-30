<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="border-bottom-2 py-32pt position-relative z-1">
    <div
            class="container page__container d-flex flex-column flex-md-row align-items-center text-center text-sm-left">
        <div class="flex d-flex flex-column flex-sm-row align-items-center mb-24pt mb-md-0">

            <div class="mb-24pt mb-sm-0 mr-sm-24pt">
                <h2 class="mb-0">Project Categories Management</h2>
                <ol class="breadcrumb p-0 m-0">
                    <li class="breadcrumb-item"><a
                            href="${pageContext.request.contextPath}/MainController?action=AdminIndex">Home</a></li>
                    <li class="breadcrumb-item active">
                        Project Category
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>
<div class="container page__container">
    <div class="page-section">

        <div class="row mb-lg-8pt">

        </div>
        <div class="row mb-32pt">
            <div class="col-lg-4">
                <div class="page-separator">
                    <div class="page-separator__text">Add a new Project Category</div>
                </div>
                <div class="flex" style="max-width: 100%">
                    <form method="POST" id="create-job-category-form">
                        <div class="form-group">
                            <input class="form-control" type="text" name="categoryName" id="categoryName"
                                   placeholder="Enter new job category..">
                        </div>
                        <button class="btn btn-primary" id="create">Create</button>

                    </form>
                </div>
            </div>
            <div class="col-lg-8 d-flex align-items-center">
                <div class="flex" style="max-width: 100%">

                    <div class="card m-0">

                        <div class="table-responsive" data-toggle="lists"
                             data-lists-sort-by="js-lists-values-id"
                             data-lists-values='["js-lists-values-job-category-name", "js-lists-values-id"]'>

                            <div class="card-header">
                                <div class="search-form">
                                    <input type="text" class="form-control search" placeholder="Search ...">
                                    <button class="btn" type="button" role="button"><i
                                            class="material-icons">search</i></button>
                                </div>
                            </div>
                            <table class="table mb-0 thead-border-top-0 table-nowrap" id="authorTable">
                                <thead>
                                <tr>
                                    <th style="width: 51px;">
                                        <a href="javascript:void(0)" class="sort"
                                           data-sort="js-lists-values-id">ID</a>
                                    </th>
                                    <th>
                                        <a href="javascript:void(0)" class="sort"
                                           data-sort="js-lists-values-job-category-name">Name</a>
                                    </th>
                                    <th style="width: 120px;">
                                        <a href="javascript:void(0)" class="sort"
                                           data-sort="js-lists-values-activity">Status</a>
                                    </th>
                                    <th style="width: 24px;" class="pl-0"></th>
                                </tr>
                                </thead>
                                <tbody class="list" id="search">
                                <c:forEach items="${requestScope.JOB_CATEGORY_LIST}" var="jobCategoryItem">
                                    <tr>
                                        <td class="js-lists-values-id small">${pageScope.jobCategoryItem.categoryID}</td>
                                        <td>
                                            <div class="d-flex flex-column">
                                                <input class="form-control" type="text"
                                                       value="${pageScope.jobCategoryItem.categoryName}"/>
                                                <p class="mb-0"><strong
                                                        class="d-none js-lists-values-job-category-name">${pageScope.jobCategoryItem.categoryName}</strong>
                                                </p>
                                            </div>
                                        </td>
                                        <td class="text-50 js-lists-values-activity small">
                                            <select id="select01" data-toggle="select" class="form-control">
                                                <option selected="">Active</option>
                                                <option>Inactive</option>
                                            </select>
                                        </td>
                                        <td class="text-right pl-0">
                                            <a href="" class="text-50"><i
                                                    class="material-icons">edit</i></a>
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

    </div>
</div>
<!--<script src="https://code.jquery.com/jquery-3.6.0.min.js"
integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity=""
crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity=""
crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-growl/1.0.6/bootstrap-growl.min.js" integrity=""></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.5.2/bootbox.min.js" integrity=""></script>
<script>
$(document).ready(function () {
$('#create').on('click', function () {
var name = $('#categoryName').val();
console.log("success");

$.ajax({
url: '/AddJobCategoryController?name=' + name,
type: "POST",
success: function (data, status, xhr) {
console.log(data + ", status" + status);
// $('#authorTable').append('<tr id=' + data.id + '><td data-target=name>' + data.categoryName + '</td><td>' + '</td><td>' + '</td><td>' + '</td><td>' + '</td><td> <button type="button" data-id=' + ' class="edit btn btn-primary btn-sm">Edit</button><button id="deleteBtn" type="button" data-id=' + ' class="delete btn btn-danger btn-sm">Delete</button></td></tr>');
$.bootstrapGrowl("another message, yay!", {
ele: 'body', // which element to append to
type: 'info', // (null, 'info', 'error', 'success')
offset: {from: 'top', amount: 20}, // 'top', or 'bottom'
align: 'right', // ('left', 'right', or 'center')
width: 250, // (integer, or 'auto')
delay: 4000,
allow_dismiss: true,
stackup_spacing: 10 // spacing between consecutively stacked growls.
});
},
error: function (jqXhr, textStatus, errorMessage) { // error callback
console.log(errorMessage);
}
});
});
});
</script>-->
