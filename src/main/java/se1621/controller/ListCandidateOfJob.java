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
import java.util.ArrayList;
import java.util.List;
import se1621.dao.CategoryDAO;
import se1621.dao.CompanyInfoDAO;
import se1621.dao.JobDAO;
import se1621.dao.JobOrderDAO;
import se1621.dao.ResumeDAO;
import se1621.dao.UserDAO;
import se1621.dto.Category;
import se1621.dto.CompanyInfo;
import se1621.dto.Job;
import se1621.dto.Resume;
import se1621.dto.User;

/**
 *
 * @author quocb
 */
@WebServlet(name="ListCandidateOfJob", urlPatterns={"/ListCandidateOfJob"})
public class ListCandidateOfJob extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "/view/candidates-listing.jsp";
    private static final String SUCCESS = "/view/candidates-listing.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            ResumeDAO resumeDAO = new ResumeDAO();
            JobOrderDAO jobOrderDAO = new JobOrderDAO();
            int search = Integer.parseInt(request.getParameter("JobIDCandidate"));
            List<Integer> listUserID = jobOrderDAO.getListUserIDOfJob(search);
            List<Resume> listResume = new ArrayList<Resume>();
            for (Integer integer : listUserID) {
                listResume.add(resumeDAO.getResumeByID(integer));
            }
            if (!listResume.isEmpty()) {
                request.setAttribute("LIST_CANDIDATEOFJOB", listResume);
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}