/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.v2.JobDAO;
import se1621.dao.v2.JobDAOImpl;
import se1621.entity.JobEntity;

import java.io.IOException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.*;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.toList;

/**
 * @author ACER
 */
@WebServlet(name = "JobController", urlPatterns = {"/JobController"})
public class JobController extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/WEB-INF/viewAdmin/projects-list.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            JobDAO jobDAO = new JobDAOImpl();
            Instant currentDayMinusOne
                    = Calendar.getInstance().toInstant()
                    .minus(1, ChronoUnit.DAYS);
            List<JobEntity> listAllJob = jobDAO.getAllUsingHQL("select distinct j from JobEntity j left join fetch j.jobApplications");
            request.setAttribute("COUNT_TODAY_JOB", listAllJob.stream().filter(e -> e.getCreatedDate().isAfter(currentDayMinusOne)).count());
            List<JobEntity> closedJobList = new ArrayList<>();
            Map<Integer, List<JobEntity>> countJobByStatus
                    = listAllJob.stream()
                    .filter(e -> e.getJobStatus() != null)
                    .collect(groupingBy(JobEntity::getJobStatus, toList()));
            countJobByStatus.forEach((key, value) -> {
                if (key == 1) {
                    request.setAttribute("COUNT_OPEN_JOB_LIST", value.size());
                    request.setAttribute("OPEN_JOB_LIST", value);
                } else if (key == 3) {
                    request.setAttribute("COUNT_ONGOING_JOB_LIST", value.size());
                    request.setAttribute("ONGOING_JOB_LIST", value);
                } else {
                    if (key == 5) {
                        request.setAttribute("COUNT_JOB_COMPLETED", value.size());
                    }
                    closedJobList.addAll(value);
                }
            });
            request.setAttribute("COUNT_JOB_LIST", listAllJob.size());
            request.setAttribute("COUNT_CLOSED_JOB_LIST", closedJobList.size());
            request.setAttribute("CLOSED_JOB_LIST", closedJobList);
            request.setAttribute("JOB_LIST", listAllJob);
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at JobController: " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
