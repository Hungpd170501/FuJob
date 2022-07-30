/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import se1621.dao.SubmitJobDAO;
import se1621.dto.SubmitJob;
import se1621.dto.User;
import se1621.service.FirebaseStoreServiceImpl;

/**
 *
 * @author HNGB
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "EditSubmissionController", urlPatterns = {"/EditSubmissionController"})
public class EditSubmissionController extends HttpServlet {

    String SUCCESS = "/MainController?action=ListJobOngoingApplied&userID=";
    String ERROR = "/view/error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SUCCESS;
        try {
            int jobApplicationID = Integer.parseInt(request.getParameter("jobApplicationID"));
            String message = request.getParameter("messageEditSubmit");
            Part filePart = request.getPart("fileEditProject");
            FirebaseStoreServiceImpl firebaseStoreServiceImpl = new FirebaseStoreServiceImpl();
            String filename = firebaseStoreServiceImpl.uploadFile(filePart);
            if (filePart.getSize() <= 0) {
                filename = null;
            }
            SubmitJob submitJob = SubmitJob.builder()
                    .jobApplicationID(jobApplicationID)
                    .messageSubmit(message)
                    .jobFile(filename)
                    .build();
            SubmitJobDAO submitJobDAO = new SubmitJobDAO();
            boolean checkEditSubmit = submitJobDAO.EditSubmission(submitJob);
            if (checkEditSubmit) {
                JobApplicationDAO jaDAO = new JobApplicationDAO();
                JobDAO jobDAO = new JobDAO();
                int jobID = jobDAO.getJobIDByJobApplicationID(jobApplicationID);
                // Khi submit project jobStatus == 8
                boolean checkUpdateJobStatus = jobDAO.updateJobStatus(jobID, 8);
                boolean checkUpdateStatus = jaDAO.updateJobApplicationStatus(jobApplicationID, 8);
                if (checkUpdateStatus && checkUpdateJobStatus) {
                    HttpSession session = request.getSession();
                    User user = (User) session.getAttribute("LOGIN_USER");
                    int userID = user.getUserID();
                    request.setAttribute("MESSAGE_UPDATE", "Submit Successfull!");
                    url = SUCCESS + userID;
                }
            }
        } catch (Exception e) {
            log("Error at EditSubmissionController: " + e);
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
