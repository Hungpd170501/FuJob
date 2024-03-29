/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package se1621.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.UserDAO;
import se1621.utils.Helper;

import java.io.IOException;

/**
 * @author HNGB
 */
@WebServlet(name = "ChangePassHRController", urlPatterns = {"/ChangePassHRController"})
public class ChangePassHRController extends HttpServlet {

    private final String SUCCESS = "/MainController?action=ViewAllHR&companyID=";
    private final String ERROR = "/view/error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            int companyID = Integer.parseInt(request.getParameter("companyID"));
            UserDAO userDAO = new UserDAO();
            boolean checkChange = userDAO.updateUserPassword(email, Helper.hashPassword(password));
            if (checkChange) {
                request.setAttribute("MESSAGE_UPDATE", email + " has changed password!");
                url = SUCCESS + companyID;
            } else {
                request.setAttribute("MESSAGE_UPDATE", "Password change failed!");
                url = SUCCESS + companyID;
            }
        } catch (Exception e) {
            log("Error at View all job Controller" + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
