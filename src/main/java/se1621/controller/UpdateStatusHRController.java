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

/**
 *
 * @author HNGB
 */
@WebServlet(name="UpdateStatusHRController", urlPatterns={"/UpdateStatusHRController"})
public class UpdateStatusHRController extends HttpServlet {
   private static final String ERROR = "/MainController?action=ViewAllHR&companyID=";
    private static final String SUCCESS = "/MainController?action=ViewAllHR&companyID=";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int companyID = Integer.parseInt(request.getParameter("companyID"));
            int hrID = Integer.parseInt(request.getParameter("hrID"));
            int userStatus = Integer.parseInt(request.getParameter("userStatus"));
            UserDAO userDAO = new UserDAO();
            boolean checkUpdateStatus = userDAO.updateUserStatus(hrID, userStatus);
            if(checkUpdateStatus) {
                request.setAttribute("MESSAGE_UPDATE", "ID = "+hrID+" updated successfully!");
                url = SUCCESS + companyID;
            }
            else {
                request.setAttribute("MESSAGE_UPDATE","ID = "+hrID+" Updated failed!");
                url = ERROR + companyID;
            }
        } catch (Exception e) {
            log(e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
