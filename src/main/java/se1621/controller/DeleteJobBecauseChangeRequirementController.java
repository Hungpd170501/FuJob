/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobDAO;

/**
 *
 * @author quocb
 */
@WebServlet(name = "DeleteJobBecauseChangeRequirementController", urlPatterns = {"/DeleteJobBecauseChangeRequirementController"})
public class DeleteJobBecauseChangeRequirementController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "MainController?action=ListJobOngoingPosted&userID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            JobDAO jobDao = new JobDAO();

            JobApplicationDAO jobApplicationDAO = new JobApplicationDAO();
            int jobPostID = Integer.parseInt(request.getParameter("jobPostID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            int jobApplication = Integer.parseInt(request.getParameter("jobApplicationID"));
            String reasonCancel = "My requirements have changed and I no longer required this work to be done";
            boolean check = jobDao.deleteJobPost(jobPostID, reasonCancel);
            if (check) {
                jobApplicationDAO.endProject(jobApplication);
                url = SUCCESS + userID;
                request.setAttribute("MESSAGE_CANCEL", "End project successfull!");
            }
        } catch (Exception ex) {
            log("Error at DeleteJobPostController: " + ex.toString());
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
