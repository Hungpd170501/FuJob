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
import se1621.dao.JobDAO;
import se1621.dao.JobSkillsDAO;
import se1621.dao.UserDAO;
import se1621.dto.Job;
import se1621.dto.JobSkills;
import se1621.dto.User;

/**
 *
 * @author quocb
 */
@WebServlet(name = "ListJobByIDController", urlPatterns = {"/ListJobByIDController"})
public class ListJobByIDController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "/view/job-list-byid.jsp";
    private static final String SUCCESS = "/view/job-list-byid.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String url = ERROR;
        try {
            JobDAO jobDAO = new JobDAO();
            int userID = Integer.parseInt(request.getParameter("userID"));
            UserDAO usDAO = new UserDAO();
            User us = usDAO.getUser(userID);
            List<Job> listJob = jobDAO.getListHrJob(userID);
            JobSkillsDAO jsDAO = new JobSkillsDAO();
            List<JobSkills> listJs = jsDAO.getJobSkillForAllJob();
            for (Job job : listJob) {
                List<JobSkills> ljk = new ArrayList<>();
                for (JobSkills js : listJs) {
                    if(job.getJobID() == js.getJobID()){
                                ljk.add(js);
                    }
                    job.setListJobSkills(ljk);
                }
            }
            String messCancel = (String) request.getAttribute("MESSAGE_CANCEL");
            if (!listJob.isEmpty()) {
                request.setAttribute("MESSAGE_CANCEL", messCancel);
                request.setAttribute("HR", us);
                request.setAttribute("LIST_JOBPOST", listJob);
                url = SUCCESS;
            }else{
                request.setAttribute("HR", us);
                request.setAttribute("LIST_JOBPOST", listJob);
                request.setAttribute("MESSAGE", "NO PROJECT TO DISPLAY");
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
