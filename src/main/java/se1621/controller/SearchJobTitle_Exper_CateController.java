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
import java.util.List;
import se1621.dao.CompanyInfoDAO;
import se1621.dao.JobDAO;
import se1621.dao.UserDAO;
import se1621.dto.CompanyInfo;
import se1621.dto.Job;
import se1621.dto.User;

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
            String searchExper = request.getParameter("searchExper");
            int searchCate = 0;
            try {
                searchCate = Integer.parseInt(request.getParameter("searchCate"));
            } catch (Exception e) {
            }
            JobDAO jobDAO = new JobDAO();
            UserDAO userDAO = new UserDAO();
            CompanyInfoDAO compnayDAO = new CompanyInfoDAO();
            List<Job> listJob = jobDAO.searchAllJobTile_Experience_Category(searchTitle, searchExper, searchCate);
            for (Job job : listJob) {
                int userID = job.getUserID();
                User user = userDAO.getUser(userID);
                CompanyInfo company = compnayDAO.getCompanyInfo(user.getCompanyID());
                job.setCompany(company);
            }

            int pageJob;
            int numberPostJob = 5; // so post job trong 1 trang
            int sizeJob = listJob.size();
            int numberPage = (sizeJob % 5 == 0 ? (sizeJob / 5) : ((sizeJob / 5)) + 1); // so trang dc tao sau khi dem so jobPost
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
                request.setAttribute("searchTitle", searchTitle);
                request.setAttribute("searchExper", searchExper);
                request.setAttribute("searchCate", searchCate);
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
