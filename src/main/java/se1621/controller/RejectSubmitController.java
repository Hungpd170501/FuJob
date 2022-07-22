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
import jakarta.servlet.http.HttpSession;
import se1621.dao.EvaluateCompletionDAO;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobDAO;
import se1621.dto.EvaluateCompletion;
import se1621.dto.Job;
import se1621.dto.Resume;
import se1621.dto.User;

/**
 *
 * @author quocb
 */
@WebServlet(name = "RejectSubmitController", urlPatterns = {"/RejectSubmitController"})
public class RejectSubmitController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "MainController?action=ListJobOngoingPosted&userID=";
    private static final int UNCOMPLETED = 4;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            JobDAO jobDao = new JobDAO();
            JobApplicationDAO jobApplicationDAO = new JobApplicationDAO();
            int jobApp = Integer.parseInt(request.getParameter("jobApplicationID"));
            int jobID = Integer.parseInt(request.getParameter("jobID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            String reasonRejectSubmmit = request.getParameter("message");
            boolean check = jobApplicationDAO.rejectJobApp(jobApp, reasonRejectSubmmit);
            if (check) {
                jobDao.rejectJobPost(jobID);
                url = SUCCESS + userID;
            }
        } catch (Exception ex) {
            log("Error at DenyJobAppController: " + ex.toString());
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
