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
import se1621.dao.EvaluateCompletionDAO;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobSkillsDAO;
import se1621.dao.ResumeDAO;
import se1621.dto.EvaluateCompletion;
import se1621.dto.JobApplication;
import se1621.dto.JobSkills;

/**
 *
 * @author HNGB
 */
@WebServlet(name="ViewStudentPastWorkController", urlPatterns={"/ViewStudentPastWorkController"})
public class ViewStudentPastWorkController extends HttpServlet {
   
    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/view/student-past-work.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            ResumeDAO resumeDAO = new ResumeDAO();
            int resumeID = resumeDAO.getResumeID(userID);
            List<JobApplication> listPastWork = new ArrayList<>();
            JobApplicationDAO jobOrderDAO = new JobApplicationDAO();
            listPastWork = jobOrderDAO.getListStudentPastWork(resumeID);
            JobSkillsDAO jsDAO = new JobSkillsDAO();
            List<JobSkills> listJs = jsDAO.getJobSkillForAllJob();
            for (JobApplication jobApply : listPastWork) {

                List<JobSkills> ljk = new ArrayList<>();
                for (JobSkills js : listJs) {
                    if (jobApply.getJob().getJobID() == js.getJobID()) {
                        ljk.add(js);
                    }
                    jobApply.getJob().setListJobSkills(ljk);
                }
            }
            EvaluateCompletionDAO ecDAO = new EvaluateCompletionDAO();
            List<EvaluateCompletion> listEc = new ArrayList<>();
            listEc = ecDAO.getAllEvaluate();
            for (JobApplication jobApply : listPastWork) {
                for (EvaluateCompletion ec : listEc) {
                    if(jobApply.getJob().getJobID() == ec.getJob().getJobID() && jobApply.getResumeID() == ec.getResume().getResumeID()){
                        jobApply.setEvaluateCompletion(ec);
                    }
                }
            }
            if (!listPastWork.isEmpty()) {
                request.setAttribute("LIST_ST_PAST_WORK", listPastWork);
                url = SUCCESS;
            } else {
                url = SUCCESS;
                request.setAttribute("LIST_ST_PAST_WORK", listPastWork);
                request.setAttribute("MESSAGE", "NO WORK PAST TO DISPLAY!");
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at View all job Controller" + e);
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
