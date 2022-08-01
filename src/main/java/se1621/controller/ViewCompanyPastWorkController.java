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
import java.util.ArrayList;
import java.util.List;
import se1621.dao.JobApplicationDAO;
import se1621.dao.JobDAO;
import se1621.dao.JobSkillsDAO;
import se1621.dao.UserDAO;
import se1621.dto.Job;
import se1621.dto.JobApplication;
import se1621.dto.JobSkills;
import se1621.dto.User;

/**
 *
 * @author quocb
 */
@WebServlet(name = "ViewCompanyPastWorkController", urlPatterns = {"/ViewCompanyPastWorkController"})
public class ViewCompanyPastWorkController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "/view/job-list-past-project.jsp";
    private static final String SUCCESS = "/view/job-list-past-project.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            //user tao job
            int userID = Integer.parseInt(request.getParameter("userID"));
            List<JobApplication> listJobOrder = new ArrayList<>();
            JobApplicationDAO jobOrderDAO = new JobApplicationDAO();
            listJobOrder = jobOrderDAO.getListPastProjects(userID);
            JobSkillsDAO jsDAO = new JobSkillsDAO();
            List<JobSkills> listJs = jsDAO.getJobSkillForAllJob();
            for (JobApplication jobApply : listJobOrder) {

                List<JobSkills> ljk = new ArrayList<>();
                for (JobSkills js : listJs) {
                    if (jobApply.getJob().getJobID() == js.getJobID()) {
                        ljk.add(js);
                    }
                    jobApply.getJob().setListJobSkills(ljk);
                }
            }
            if (!listJobOrder.isEmpty()) {
                request.setAttribute("LIST_ALLJOBONGOING_POSTED", listJobOrder);
                url = SUCCESS;
            } else {
                request.setAttribute("LIST_ALLJOBONGOING_POSTED", listJobOrder);
                request.setAttribute("MESSAGE", "YOU HAVEN'T ACCEPTED FOR ANY PROJECT");
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
