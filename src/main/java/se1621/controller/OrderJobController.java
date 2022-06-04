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
import se1621.dao.JobOrderDAO;
import se1621.dto.Job;
import se1621.dto.JobOrder;


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

            JobOrder jobOrder = JobOrder.builder()
                    .userID(userID)
                    .job(Job.builder().jobID(jobID).build())
                    .cvFile(cvFile)
                    .message(message)
                    .build();
            JobOrderDAO jobOrderDAO = new JobOrderDAO();
            boolean check = jobOrderDAO.orderJob(jobOrder);
            if (check) {
                request.setAttribute("MESSAGE", "Send application successfully!");
                url = SUCCESS + userID;
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
