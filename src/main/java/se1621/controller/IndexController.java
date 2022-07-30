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

import java.sql.SQLException;
import java.time.Instant;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import se1621.dao.JobApplicationDAO;
import se1621.dao.JobDAO;
import se1621.dao.UserDAO;
import se1621.dao.v2.CategoryDAOImpl;
import se1621.dao.v2.JobDAOImpl;
import se1621.dao.v2.SkillDAOImpl;
import se1621.entity.CategoryEntity;
import se1621.entity.JobEntity;
import se1621.entity.SkillEntity;

/**
 *
 * @author ACER
 */
@WebServlet(name = "IndexController", urlPatterns = {"/IndexController"})
public class IndexController extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String USER_PAGE = "/view/index.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            CompletableFuture<Void> future1 = CompletableFuture.runAsync(() -> {
                try {
                    JobDAOImpl jopbDAOImpl = new JobDAOImpl();
                    List<JobEntity> listJob = jopbDAOImpl.get8RecentJobPosted("FROM JobEntity j WHERE j.jobStatus=1 ORDER BY j.lastModifiedDate DESC");
                    request.setAttribute("JOB_LIST", listJob);
                } catch (Throwable t) {
                    log(t.getMessage());
                }
            });
            CompletableFuture<Void> future2 = CompletableFuture.runAsync(() -> {
                JobApplicationDAO jobApplicationDAO=new JobApplicationDAO();
                try {
                    request.setAttribute("TOTAL_JOB_APPLICATION",jobApplicationDAO.getAllTotalJobOrder());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            });
            CompletableFuture<Void> future3 = CompletableFuture.runAsync(() -> {
                try {
                    JobDAO jobDAO = new JobDAO();
                    request.setAttribute("TOTAL_JOB_POST", jobDAO.getAllTotalJobPost());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            });
            CompletableFuture<Void> future4 = CompletableFuture.runAsync(() -> {
                try {
                    UserDAO userDAO = new UserDAO();
                    request.setAttribute("TOTAL_USER_EXCEPT_AD", userDAO.getAllTotalUser_NonAD());
                } catch (Throwable t) {
                    log(t.getMessage());
                }
            });
            CompletableFuture.allOf(future1, future2, future3, future4).get();
            url=USER_PAGE;
        } catch (Exception e) {
            log("Error at IndexController: " + e);
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
