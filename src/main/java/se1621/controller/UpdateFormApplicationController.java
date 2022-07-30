/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package se1621.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobDAO;
import se1621.dao.ResumeDAO;
import se1621.dto.Job;
import se1621.dto.JobApplication;
import se1621.dto.User;
import se1621.service.FirebaseStoreServiceImpl;

/**
 *
 * @author lehad
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name="UpdateFormApplicationController", urlPatterns={"/UpdateFormApplicationController"})
public class UpdateFormApplicationController extends HttpServlet {
   
    private static final String ERROR = "/view/job-list-applied";
//    private static final String SUCCESS = "/view/job-list-applied";
    private static final String SUCCESS = "MainController?action=SearchlistJobOrder&userID=";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            int userID = loginUser.getUserID();
            int resumeID = Integer.parseInt(request.getParameter("resumeID"));
            int jobID = Integer.parseInt(request.getParameter("jobID"));
            String priceDeal = request.getParameter("priceDeal");
            String message = request.getParameter("message");
            Part filePart = request.getPart("file");
            FirebaseStoreServiceImpl firebaseStoreServiceImpl = new FirebaseStoreServiceImpl();
            String filename=firebaseStoreServiceImpl.uploadFile(filePart);
            JobApplication jobApply = JobApplication.builder()
                    .priceDeal(priceDeal)
                    .message(message)
                    .cvFile(filename)
                    .build();
            JobApplicationDAO jobApplicationDAO = new JobApplicationDAO();
            boolean checkUpDate = jobApplicationDAO.updateFormApplicationOfResume(jobApply, resumeID, jobID);
            if(checkUpDate){
                request.setAttribute("UPDATE_MESSAGE", "Your form application has been updated!");
                url = SUCCESS + userID;
            }
        } catch (Exception e) {
            log("error at UpdateFormApplicationController" + e);
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
