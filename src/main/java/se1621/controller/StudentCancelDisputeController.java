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
import jakarta.servlet.http.HttpSession;
import se1621.dao.DisputeDAO;
import se1621.dao.JobDAO;
import se1621.dao.UserDAO;
import se1621.dto.Disputes;
import se1621.dto.Job;
import se1621.dto.User;
import se1621.service.EmailServiceImpl;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "StudentCancelDisputeController", urlPatterns = {"/StudentCancelDisputeController"})
public class StudentCancelDisputeController extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/MainController?action=ViewJobStDispute&userID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            User student = (User) session.getAttribute("LOGIN_USER");
            int disputeID = Integer.parseInt(request.getParameter("disputeID"));
            String messageCancel = request.getParameter("messageCancelDispute");
            DisputeDAO disputeDAO = new DisputeDAO();
            boolean checkInsertReasonCancel = disputeDAO.InsertReasonCancel(messageCancel, disputeID);
            if (checkInsertReasonCancel) {
                JobDAO jobDAO = new JobDAO();
                Disputes dispute = disputeDAO.getDisputeByDisputeID(disputeID);
                int jobID = jobDAO.getJobIDByJobApplicationID(dispute.getJobApplication().getJobApplicationID());
                Job job = jobDAO.getJob(jobID);
                UserDAO usDAO = new UserDAO();
                User hr = usDAO.getUser(job.getUserID());
                boolean checkUpdateStatus = jobDAO.updateDisputeStatus(0, jobID);
                if (checkUpdateStatus) {
                    EmailServiceImpl emailServiceIml = new EmailServiceImpl();
                    new Thread(() -> emailServiceIml.sendEmailCancelDispute(getServletContext(), hr, student.getFullName(), "CANCEL DISPUTE", messageCancel, job.getJobTitle())).start();
                    request.setAttribute("MESSAGE_UPDATE", "Dispute Canceled!");
                    url = SUCCESS + student.getUserID();
                }
            }
        } catch (Exception e) {
            log("Error at StudentSendDisputeController:" + e);
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
