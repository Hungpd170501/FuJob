<%@page import="se1621.dto.Error.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <jsp:include page="./include/header.jsp">
            <jsp:param name="title" value="FuJob | Test"/>
        </jsp:include>
    </head>
    <body>
    <center>
        <h1>Img Upload Demo</h1>
        <form method="post" action="${pageContext.request.contextPath}/uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <div class="preview">
                       <img id="file-ip-1-preview" class="img-fluid avatar avatar-medium d-block mx-auto rounded-pill">
                    </div>
                    <div class="col-2">
                        <input type="file" id="imageFile" name="file" onchange="showPreview(event);"/>
                    </div>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </table>
        </form>
        </br>
        </br>
        </br>
        </br>
        </br>
        <h1>File Upload Demo</h1>
        <form method="post" action="${pageContext.request.contextPath}/uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td> 
                        <input type="file" name="file"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </table>
        </form>
    </center>
    <script>
        function showPreview(event){
            if(event.target.files.length > 0){
              var src = URL.createObjectURL(event.target.files[0]);
              var preview = document.getElementById("file-ip-1-preview");
              preview.src = src;
              preview.style.display = "block";
            }
        }
    </script>
    </body>
</html>
