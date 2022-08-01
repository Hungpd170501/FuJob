/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller.admin;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.UserDAO;
import se1621.dto.Error.UserError;
import se1621.dto.Role;
import se1621.dto.User;
import se1621.utils.Helper;

@WebServlet(name = "CreateAccountController", urlPatterns = {"/CreateAccountController"})
public class CreateAccountController extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "MainController?action=UserList";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleID = request.getParameter("roleID");
            UserDAO dao = new UserDAO();
            UserError userError = new UserError();
            boolean checkValidation = true;
            boolean checkDuplicate = dao.checkDuplicateEmail(email);

            if (checkDuplicate) {
                checkValidation = false;
                userError.setEmailError("Email duplicated!");
            }
            if (checkValidation) {
                User user = User.builder()
                        .password(Helper.hashPassword(password))
                        .fullName(fullName)
                        .role(new Role(roleID, ""))
                        .email(email)
                        .build();
                dao.createUser(user);
//                    EmailService emailServiceIml = new EmailServiceImpl();
//                    new Thread(() -> emailServiceIml.sendEmail(getServletContext(), user, "verify")).start();
                url = SUCCESS;
            } else {
                request.setAttribute("USER_ERROR", userError);
            }
        } catch (Exception e) {
            log("Error at SignUpController:"+e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
