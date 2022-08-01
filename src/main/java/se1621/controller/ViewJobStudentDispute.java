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
import java.util.ArrayList;
import java.util.List;
import se1621.dao.DisputeDAO;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobSkillsDAO;
import se1621.dao.ResumeDAO;
import se1621.dto.Disputes;
import se1621.dto.JobApplication;
import se1621.dto.JobSkills;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "ViewJobStudentDispute", urlPatterns = {"/ViewJobStudentDispute"})
public class ViewJobStudentDispute extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/view/studentDispute.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            DisputeDAO disputeDAO = new DisputeDAO();
            List<Disputes> listDispute = disputeDAO.getListDisputeByUserID(userID);//lay list dispute
            if (!listDispute.isEmpty()) {//neu co (luc huy tranh chap thi van con hang dispute)
                ResumeDAO resumeDAO = new ResumeDAO();
                int resumeID = resumeDAO.getResumeID(userID);
                List<JobApplication> listJobOrderDispute = new ArrayList<>();
                JobApplicationDAO jobOrderDAO = new JobApplicationDAO();
                listJobOrderDispute = jobOrderDAO.getListJobAppDispute(resumeID); //lay cac job dang tranh chap cua hoc sinh
                if (listJobOrderDispute.isEmpty()) { //neu k co job dang tranh chap
                    List<JobApplication> listEmpty = new ArrayList<>(); //tao list rong de gui qua
                    request.setAttribute("LIST_ST_JOB_DISPUTE", listEmpty);
                    request.setAttribute("MESSAGE", "NO DISPUTE TO DISPLAY!");
                    url = SUCCESS;
                } else {
                    JobSkillsDAO jsDAO = new JobSkillsDAO();
                    List<JobSkills> listJs = jsDAO.getJobSkillForAllJob(); //lay all list job skill
                    for (JobApplication jobApply : listJobOrderDispute) {

                        List<JobSkills> ljk = new ArrayList<>();
                        for (JobSkills js : listJs) {
                            if (jobApply.getJob().getJobID() == js.getJobID()) {//neu jobskill va jobApplied co chung jobID
                                ljk.add(js);
                            }
                            jobApply.getJob().setListJobSkills(ljk); //gan cac skill cho jobApplied
                        }
                    }
                    for (Disputes dispute : listDispute) {
                        for (JobApplication jobApply : listJobOrderDispute) {
                            if (dispute.getJobApplication().getJobApplicationID() == jobApply.getJobApplicationID()) {//neu dispute va jobApplied co chung jobAppID
                                dispute.setJobApplication(jobApply); //gan jobAppli cho dispute
                            }
                        }
                    }
                    request.setAttribute("LIST_ST_JOB_DISPUTE", listDispute);
                    url = SUCCESS;
                }

            } else {
                request.setAttribute("LIST_ST_JOB_DISPUTE", listDispute);
                request.setAttribute("MESSAGE", "NO DISPUTE TO DISPLAY!");
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at View all job Controller" + e.toString());
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
