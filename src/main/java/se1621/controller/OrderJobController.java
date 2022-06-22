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
import se1621.dao.JobApplicationDAO;
import se1621.dto.Job;
import se1621.dto.JobApplication;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "OrderJobController", urlPatterns = {"/OrderJobController"})
public class OrderJobController extends HttpServlet {

    private static final String ERROR = "/view/post-a-job.jsp";
    private static final String SUCCESS = "/MainController?action=SearchlistJobOrder&userID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            int jobID = Integer.parseInt(request.getParameter("jobID"));
            String cvFile = request.getParameter("cvFile");
            String salaryDeal = request.getParameter("salaryDeal");
            String message = request.getParameter("message");
            JobApplication jobOrder = JobApplication.builder()
                    .resumeID(userID)
                    .job(Job.builder().jobID(jobID).build())
                    .cvFile(cvFile)
                    .priceDeal(salaryDeal)
                    .message(message)
                    .build();
            JobApplicationDAO jobOrderDAO = new JobApplicationDAO();
            int jobOrderID = jobOrderDAO.getJobOrderID(userID, jobID); // neu user da apply ma huy chua
            if (jobOrderID > 0) { // tien hanh re apply (update)
                boolean reApply = jobOrderDAO.reApply(jobOrder, jobOrderID);
                if (reApply) {
                    request.setAttribute("MESSAGE", "Send application successfully!");
                    url = SUCCESS + userID;
                }
            } else { // neu chua apply
                boolean apply = jobOrderDAO.orderJob(jobOrder);
                if (apply) {// cho apply cai moi
                    request.setAttribute("MESSAGE", "Send application successfully!");
                    url = SUCCESS + userID;
                }
            }

        } catch (Exception e) {
            log(e.getMessage());
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
