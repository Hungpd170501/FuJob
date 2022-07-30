/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.UserDAO;
import se1621.dto.User;
import se1621.service.EmailServiceImpl;

/**
 *
 * @author ACER
 */
@WebServlet(name = "RecoveryPasswordController", urlPatterns = {"/RecoveryPasswordController"})
public class RecoveryPasswordController extends HttpServlet {

    private static final String ERROR = "/view/recovery_password.jsp";
    private static final String SUCCESS = "/view/recovery-password-detail.jsp";

    protected void processRequest(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String email = request.getParameter("email");
            UserDAO userDAO = new UserDAO();
            User user = userDAO.checkUserByEmail(email);
            if (user == null || user.getUserStatus() != 1) {
                request.setAttribute("RECOVERY_PASSWORD_MESSAGE", "Opp somthing wrong! Maybe the email you enter is incorrect or not verified!");
            } else {
                EmailServiceImpl emailServiceIml = new EmailServiceImpl();
                new Thread(() -> emailServiceIml.sendEmail(getServletContext(), user, "forgot")).start();
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at RecoveryPasswordController: " + e);
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
