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
import se1621.dao.DisputeDAO;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobDAO;
import se1621.dao.UserDAO;
import se1621.dto.Disputes;
import se1621.dto.Job;
import se1621.dto.JobApplication;
import se1621.dto.User;
import se1621.service.EmailServiceImpl;

/**
 *
 * @author quocb
 */
@WebServlet(name = "HRSendDisputeController", urlPatterns = {"/HRSendDisputeController"})
public class HRSendDisputeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/MainController?action=ViewJobHrDispute&userID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String titleDispute = request.getParameter("titleDispute");
            String messageDispute = request.getParameter("messageDispute");
            int jobApplicationID = Integer.parseInt(request.getParameter("jobApplicationID"));
            int hrID = Integer.parseInt(request.getParameter("studentID"));
            Disputes dispute = Disputes.builder()
                    .jobApplication(JobApplication.builder().jobApplicationID(jobApplicationID).build())
                    .user(User.builder().userID(hrID).build())
                    .message(messageDispute)
                    .title(titleDispute)
                    .build();
            DisputeDAO disputeDAO = new DisputeDAO();
            boolean checkDup = disputeDAO.checkDuplicateDispute(hrID, jobApplicationID);//ktra da gui dispute truoc do chua
            if (checkDup) { //neu co thi xoa tao lai
                boolean checkDelete = disputeDAO.deleteDispute(hrID, jobApplicationID);
                if (checkDelete) {
                    boolean checkCreateDispute = disputeDAO.createDispute(dispute);
                    if (checkCreateDispute) {
                        JobDAO jobDAO = new JobDAO();
                        int jobID = jobDAO.getJobIDByJobApplicationID(jobApplicationID);
                        Job job = jobDAO.getJob(jobID);
                        UserDAO usDAO = new UserDAO();
                        JobApplicationDAO jaDAO = new JobApplicationDAO();
                        JobApplication ja = jaDAO.getJobOrderByJobApplicationID(jobApplicationID);
                        User student = usDAO.getUser(ja.getResume().getUserID());
                        User hr = usDAO.getUser(hrID);
                        boolean checkUpdateStatus = jobDAO.updateDisputeStatus(1, jobID);
                        if (checkUpdateStatus) {
                            EmailServiceImpl emailServiceIml = new EmailServiceImpl();
                            new Thread(() -> emailServiceIml.sendEmail(getServletContext(), student, hr.getFullName(), titleDispute, messageDispute, job.getJobTitle())).start();
                            request.setAttribute("MESSAGE_UPDATE", "Send Dispute Sucessfull!");
                            url = SUCCESS + hrID;
                        }
                    }
                }
            } else { //chua tao truoc do thi tao
                boolean checkCreateDispute = disputeDAO.createDispute(dispute);
                if (checkCreateDispute) {
                    JobDAO jobDAO = new JobDAO();
                    int jobID = jobDAO.getJobIDByJobApplicationID(jobApplicationID);
                    Job job = jobDAO.getJob(jobID);
                    UserDAO usDAO = new UserDAO();
                    JobApplicationDAO jaDAO = new JobApplicationDAO();
                    JobApplication ja = jaDAO.getJobOrderByJobApplicationID(jobApplicationID);
                    User student = usDAO.getUser(ja.getResume().getUserID());
                    User hr = usDAO.getUser(hrID);
                    boolean checkUpdateStatus = jobDAO.updateDisputeStatus(1, jobID);
                    if (checkUpdateStatus) {
                        EmailServiceImpl emailServiceIml = new EmailServiceImpl();
                        new Thread(() -> emailServiceIml.sendEmail(getServletContext(), student, hr.getFullName(), titleDispute, messageDispute, job.getJobTitle())).start();
                        request.setAttribute("MESSAGE_UPDATE", "Send Dispute Sucessfull!");
                        url = SUCCESS + hrID;
                    }
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
