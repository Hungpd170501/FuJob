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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.StringUtils;
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
            UserDAO userDAO = new UserDAO();
            CompanyInfoDAO compnayDAO = new CompanyInfoDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            int search = Integer.parseInt(request.getParameter("searchJobID"));
            List<Job> listJob = jobDAO.getListHrJob(search);
            for (Job job : listJob) {
                int categoryID = job.getCategory().getCategoryID();
                Category category = categoryDAO.getCategory(categoryID);
                job.setCategory(category);
                int userID = job.getUserID();
                User user = userDAO.getUser(userID);
                CompanyInfo company = compnayDAO.getCompanyInfo(user.getCompanyID());
                job.setCompany(company);
            }
            if (!listJob.isEmpty()) {
                request.setAttribute("LIST_JOBPOST", listJob);
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
