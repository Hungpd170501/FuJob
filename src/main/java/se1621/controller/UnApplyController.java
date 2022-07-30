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
import se1621.dao.JobApplicationDAO;
import se1621.dao.ResumeDAO;
import se1621.dto.Resume;

/**
 *
 * @author HNGB
 */
@WebServlet(name="UnApplyController", urlPatterns={"/UnApplyController"})
public class UnApplyController extends HttpServlet {
   
    private static final String ERROR = "job-list-applied.jsp";
    private static final String SUCCESS = "MainController?action=SearchlistJobOrder&userID=";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int jobOrderID = Integer.parseInt(request.getParameter("jobOrderID"));
            int resumeID = Integer.parseInt(request.getParameter("resumeID"));
            String reasonUnaplly = request.getParameter("reasonUnaplly");
            JobApplicationDAO jobOrderDAO = new JobApplicationDAO();
            ResumeDAO resumeDAO = new ResumeDAO();
            Resume resume = resumeDAO.getResumeByResumeID(resumeID);
            boolean check = jobOrderDAO.unApply(jobOrderID,reasonUnaplly);
            if(check){
               request.setAttribute("CANCEL_MESSAGE", "UnApply successfull");
               url = SUCCESS + resume.getUserID();

            }
        } catch (Exception e) {
            log("Error at DeleteController: " + e);
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
