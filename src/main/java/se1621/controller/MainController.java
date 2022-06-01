/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {

    private static final String SIGNUP_CONTROLLER = "SignUpController";
    private static final String SIGNUP = "SignUp";
    private static final String ERROR = "error.jsp";
    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String LOGIN = "Login";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String LOGOUT = "Logout";
    private static final String RECOVERY_PASSWORD_CONTROLLER = "RecoveryPasswordController";
    private static final String RECOVERY_PASSWORD = "RecoveryPassword";
    private static final String CHANGE_PASSWORD_CONTROLLER = "ChangePasswordController";
    private static final String CHANGE_PASSWORD = "ChangePassword";
    private static final String SEARCH_COMPANYID_CONTROLLER = "SearchCompanyIDController";
    private static final String SEARCH = "Search";
    private static final String CREATECOM_CONTROLLER = "CreateCompanyInfoController";
    private static final String CREATECOM = "Create CompanyInfo";
    private static final String CHOOSECOMPANY_CONTROLLER = "ChooseCompanyController";
    private static final String CHOOSECOMPANY = "Choose Company";
    private static final String CREATERESUME_CONTROLLER = "CreateResumeController";
    private static final String CREATERESUME = "Submit Resume";
    private static final String POSTJOB_CONTROLLER = "PostJobController";
    private static final String POSTJOB = "Post a Job";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        try {
            String action = request.getParameter("action");
            if (LOGIN.equals(action)) {
                url = LOGIN_CONTROLLER;
            } else if (SIGNUP.equals(action)) {
                url = SIGNUP_CONTROLLER;
            } else if (RECOVERY_PASSWORD.equals(action)) {
                url = RECOVERY_PASSWORD_CONTROLLER;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_CONTROLLER;
            } else if (CHANGE_PASSWORD.equals(action)) {
                url = CHANGE_PASSWORD_CONTROLLER;
            } else if (SEARCH.equals(action)) {
                url = SEARCH_COMPANYID_CONTROLLER;
            } else if (CREATECOM.equals(action)) {
                url = CREATECOM_CONTROLLER;
            } else if (CHOOSECOMPANY.equals(action)) {
                url = CHOOSECOMPANY_CONTROLLER;
            } else if (CREATERESUME.equals(action)) {
                url = CREATERESUME_CONTROLLER;
            } else if (POSTJOB.equals(action)) {
                url = POSTJOB_CONTROLLER;
            } else {
                url = ERROR;
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
