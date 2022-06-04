<%-- 
    Document   : formApplication
    Created on : Jun 4, 2022, 9:35:45 PM
    Author     : HNGB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
    <div class="modal fade" id="formApplication" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header border-bottom-0">
                    <h5 class="modal-title text-primary" id="exampleModalLabel">Application Form</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="POST" action="/FuJob/MainController">
                    <div class="modal-body">
                        <div class="form-group text-dark">
                            <label>Deal Salary</label>
                            <input type="text" class="form-control" name="salaryDeal" placeholder="Enter salary you want to deal">
                        </div>
                        <div class="form-group text-dark">
                            <label>Message</label>
                            <textarea class="form-control" name="message" placeholder="Message for employer"></textarea>
                        </div>
                        <div class="form-group text-dark">
                            <label>Upload CV</label>
                            <input type="file" class="form-control" name="cvFile" placeholder="Password">
                        </div>    
                    </div>
                    <div class="modal-footer border-top-0 d-flex justify-content-center">
                        <input type="submit" name="action" class="btn btn-primary" value="Send application">
                    </div>
                    <input type="hidden" name="jobID" value="${requestScope.JOB.jobID}">
                    <input type="hidden" name="userID" value="${sessionScope.LOGIN_USER.userID}">
                </form>
            </div>
        </div>
    </div>
</body>
