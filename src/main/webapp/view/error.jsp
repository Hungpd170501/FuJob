<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="./include/header.jsp">
        <jsp:param name="title" value="FuJob | Error Page"/>
    </jsp:include>
    <style>
        body {
            background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAaCAYAAACpSkzOAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABZ0RVh0Q3JlYXRpb24gVGltZQAxMC8yOS8xMiKqq3kAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzVxteM2AAABHklEQVRIib2Vyw6EIAxFW5idr///Qx9sfG3pLEyJ3tAwi5EmBqRo7vHawiEEERHS6x7MTMxMVv6+z3tPMUYSkfTM/R0fEaG2bbMv+Gc4nZzn+dN4HAcREa3r+hi3bcuu68jLskhVIlW073tWaYlQ9+F9IpqmSfq+fwskhdO/AwmUTJXrOuaRQNeRkOd5lq7rXmS5InmERKoER/QMvUAPlZDHcZRhGN4CSeGY+aHMqgcks5RrHv/eeh455x5KrMq2yHQdibDO6ncG/KZWL7M8xDyS1/MIO0NJqdULLS81X6/X6aR0nqBSJcPeZnlZrzN477NKURn2Nus8sjzmEII0TfMiyxUuxphVWjpJkbx0btUnshRihVv70Bv8ItXq6Asoi/ZiCbU6YgAAAABJRU5ErkJggg==);
        }

        .error-template {
            padding: 40px 15px;
            text-align: center;
        }

        .error-actions {
            margin-top: 15px;
            margin-bottom: 15px;
        }

        .error-actions .btn {
            margin-right: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="./components/loader.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="error-template">
                <h1>
                    Oops!</h1>
                <h2>
                    404 Not Found</h2>
                <div class="error-details">
                    Sorry, an error has occured, Requested page not found!
                </div>
                <div class="error-actions">
                    <a href="${pageContext.request.contextPath}" class="btn btn-primary btn-lg"><span
                            class="glyphicon glyphicon-home"></span>
                        Take Me Home </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- javascript -->
<script src="${pageContext.request.contextPath}/asset/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/plugins.js"></script>

<!-- selectize js -->
<script src="${pageContext.request.contextPath}/asset/js/selectize.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.nice-select.min.js"></script>

<script src="${pageContext.request.contextPath}/asset/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/counter.int.js"></script>

<script src="${pageContext.request.contextPath}/asset/js/app.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/home.js"></script>
</body>
</html>