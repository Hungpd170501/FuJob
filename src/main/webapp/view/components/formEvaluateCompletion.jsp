
<form method="post" action="${pageContext.request.contextPath}/MainController">
    <div class="modal fade" id="confirmCancellation" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-primary" id="exampleModalLongTitle">This Project Is Not
                        Complete?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-dark">
                        <div class="row d-flex justify-content-center">
                            <div class="d-flex flex-start w-100">
                                <!-- <img class="rounded-circle shadow-1-strong me-3" src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(21).webp" alt="avatar" width="65" height="65" /> -->
                                <div class="w-100">
                                    <h5>Add a Evaluation:</h5>
                                    <div class="rating stars">
                                     <input type="radio" name="rating" value="5" id="5-star">
                                        <label for="5-star" class="rate">?<div class="face face-5"></div></label>
                                        <input type="radio" name="rating" value="4" id="4-star">
                                        <label for="4-star" class="rate">?<div class="face face-4"></div></label>
                                        <input type="radio" name="rating" value="3" id="3-star">
                                        <label for="3-star" class="rate">?<div class="face face-3"></div></label>
                                        <input type="radio" name="rating" value="2" id="2-star">
                                        <label for="2-star" class="rate">?<div class="face face-2"></div></label>
                                        <input type="radio" name="rating" value="1" id="1-star">
                                        <label for="1-star" class="rate">?<div class="face face-1"></div></label>
                                    </div>
                                    <div class="form-outline">
                                        <label class="form-label" for="textAreaExample">Could you tell us what when wrong?</label>
                                        <textarea class="form-control" id="textAreaExample"
                                                  name="message"
                                                  placeholder=""></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                    <input type="hidden" name="action" value="UncompteleJob">
                    <input type="hidden" name="jobAppID" value="">
                    <input type="hidden" name="jobID" value="">
                    <input type="hidden" name="resumeID" value="">
                    <input type="submit" value="Yes" class="btn btn-primary">
                </div>
            </div>
        </div>
    </div>
</form>