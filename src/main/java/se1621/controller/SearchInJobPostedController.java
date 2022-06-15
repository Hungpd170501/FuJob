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
import se1621.dao.CategoryDAO;
import se1621.dao.CompanyInfoDAO;
import se1621.dao.JobDAO;
import se1621.dao.UserDAO;
import se1621.dto.Category;
import se1621.dto.CompanyInfo;
import se1621.dto.Job;
import se1621.dto.User;

/**
 *
 * @author lehad
 */
@WebServlet(name = "SearchInJobPostedController", urlPatterns = {"/SearchInJobPostedController"})
public class SearchInJobPostedController extends HttpServlet {

    private static final String ERROR = "/view/job-list-byid.jsp";
    private static final String SUCCESS = "/view/job-list-byid.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String searchTitle = request.getParameter("searchtitle");
            String searchExper = request.getParameter("searchExper");
            int searchCate = 0;
            int hrID = Integer.parseInt(request.getParameter("hrID"));
            try {
                searchCate = Integer.parseInt(request.getParameter("searchCate"));
            } catch (Exception e) {
            }
            JobDAO jobDAO = new JobDAO();
            UserDAO userDAO = new UserDAO();
            CompanyInfoDAO compnayDAO = new CompanyInfoDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Job> listJob = jobDAO.getJobPosted(searchTitle, searchExper, searchCate, hrID);
            for (Job job : listJob) {
                int userID = job.getUserID();
                User user = userDAO.getUser(userID);
                CompanyInfo company = compnayDAO.getCompanyInfo(user.getCompanyID());
                job.setCompany(company);
                int categoryID = job.getCategory().getCategoryID();
                Category category = categoryDAO.getCategory(categoryID);
                job.setCategory(category);
            }
            if (!listJob.isEmpty()) {
                request.setAttribute("LIST_JOBPOST", listJob);
                url = SUCCESS;
            } else {
                request.setAttribute("LIST_JOBPOST", listJob);
                request.setAttribute("MESSAGE", "NO JOB TO DISPLAY");
            }
        } catch (Exception e) {
            log("Error at Search JobPostedController" + toString());
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
