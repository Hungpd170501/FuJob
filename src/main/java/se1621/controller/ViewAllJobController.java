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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "ViewAllJobController", urlPatterns = {"/ViewAllJobController"})
public class ViewAllJobController extends HttpServlet {

    private static final String ERROR = "/view/job-list.jsp";
    private static final String SUCCESS = "/view/job-list.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            JobDAO jobDAO = new JobDAO();
            UserDAO userDAO = new UserDAO();
            CompanyInfoDAO compnayDAO = new CompanyInfoDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Job> listJob = jobDAO.getListJob();
            for (Job job : listJob) {
                int categoryID = job.getCategory().getCategoryID();
                Category category = categoryDAO.getCategory(categoryID);
                job.setCategory(category);
                int userID = job.getUserID();
                User user = userDAO.getUser(userID);
                CompanyInfo company = compnayDAO.getCompanyInfo(user.getCompanyID());
                job.setCompany(company);
            }
            int pageJob;
            int numberPostJob = 10; // so post job trong 1 trang
            int sizeJob = listJob.size();
            int numberPage = (sizeJob % numberPostJob == 0 ? (sizeJob / numberPostJob) : ((sizeJob /numberPostJob)) + 1); // so trang dc tao sau khi dem so jobPost
            String xPage = request.getParameter("pageJob");
            if (xPage == null) {
                pageJob = 1;
            } else {
                pageJob = Integer.parseInt(xPage);
            }
            int starPage, endPage; // page 1 va page cuoi
            starPage = (pageJob - 1) * numberPostJob; // lay 5 page dau
            endPage = Math.min(pageJob * numberPostJob, sizeJob); // page cuoi se con lai bao nhieu post
            List<Job> listPageAllJob = jobDAO.getPaginateJobList(listJob, starPage, endPage);

            if (!listPageAllJob.isEmpty()) {
                request.setAttribute("LIST_ALLJOB", listPageAllJob);
                request.setAttribute("pageJob", pageJob);
                request.setAttribute("numberPage", numberPage);
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