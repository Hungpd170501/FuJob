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
import se1621.dao.JobDAO;
import se1621.dao.JobSkillsDAO;
import se1621.dto.Job;
import se1621.dto.JobSkills;


/**
 *
 * @author lehad
 */
@WebServlet(name = "SearchJobTitle_Exper_CateController", urlPatterns = {"/SearchJobTitle_Exper_CateController"})
public class SearchJobTitle_Exper_CateController extends HttpServlet {

    private static final String ERROR = "/view/job-list.jsp";
    private static final String SUCCESS = "/view/job-list.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String searchTitle = request.getParameter("searchtitle");
            int searchSkill = 0;
            int searchCate = 0;
            int hrID = 0;
            try {
                searchSkill = Integer.parseInt(request.getParameter("searchSkill"));
            } catch (Exception e) {
            }
            try {
                
                searchCate = Integer.parseInt(request.getParameter("searchCate"));
                hrID = Integer.parseInt(request.getParameter("hrID"));
            } catch (Exception e) {
            }
            JobDAO jobDAO = new JobDAO();   
            JobSkillsDAO jsDAO = new JobSkillsDAO();
            List<Job> listJob = jobDAO.searchAllJobTile_Skill_Category(searchTitle, searchSkill, searchCate);
            for (Job job : listJob) {
                List<JobSkills> listJs = jsDAO.getSkillRequire(job.getJobID());
                job.setListJobSkills(listJs);
            }
            if (!listJob.isEmpty()) {
                request.setAttribute("LIST_ALLJOB", listJob);
                url = SUCCESS;
            } else {
                request.setAttribute("LIST_ALLJOB", listJob);
                request.setAttribute("MESSAGE", "NO PROJECT TO DISPLAY");
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
