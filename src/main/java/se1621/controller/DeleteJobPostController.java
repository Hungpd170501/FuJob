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
import java.util.List;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobDAO;
import se1621.dto.JobApplication;


/**
 *
 * @author quocb
 */
@WebServlet(name="DeleteJobPostController", urlPatterns={"/DeleteJobPostController"})
public class DeleteJobPostController extends HttpServlet {
   
    private static final String ERROR = "job-list-byid.jsp";
    private static final String SUCCESS = "MainController?action=ListJobByID&userID=";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try{
            JobDAO jobDao = new JobDAO();

            JobApplicationDAO jobApplicationDAO = new JobApplicationDAO();
            int jobPostID = Integer.parseInt(request.getParameter("jobPostID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            String reasonCancel = request.getParameter("reasonCancel");
            List<Integer> listJobOrderID = jobApplicationDAO.getListJobOrderOfJob(jobPostID);
            boolean check = jobDao.deleteJobPost(jobPostID,reasonCancel);
            if(check){
                for (Integer jobOrderID : listJobOrderID) {
                    jobApplicationDAO.delete(jobOrderID);
                }
               url = SUCCESS + userID;
               request.setAttribute("MESSAGE_CANCEL", "Delete successfull!");
            }
        }catch(Exception ex){
            log("Error at DeleteJobPostController: " + ex);
        }finally{
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
