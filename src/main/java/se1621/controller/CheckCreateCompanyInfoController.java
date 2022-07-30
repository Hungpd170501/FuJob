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
import se1621.dao.CompanyInfoDAO;
import se1621.dto.CompanyInfo;

/**
 *
 * @author lehad
 */
@WebServlet(name = "CheckCreateCompanyInfoController", urlPatterns = {"/CheckCreateCompanyInfoController"})
public class CheckCreateCompanyInfoController extends HttpServlet {

    private static final String ERROR = "/view/create-companyinfo.jsp";
    private static final String SUCCESS = "/view/create-companyinfo.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        try {
            int companyID = Integer.parseInt(request.getParameter("CompanyID"));
            CompanyInfoDAO dao = new CompanyInfoDAO();
            CompanyInfo companyInfo = dao.getCompanyInfo(companyID);
            if (companyInfo != null && companyID > 0) {
                request.setAttribute("COMPANYINFO", companyInfo);
                url = SUCCESS;
            }else{
                CompanyInfo company = CompanyInfo.builder()
                        .companyID(0)
                        .avatar("")
                        .companyName("")
                        .establishedYear(0)
                        .address("")
                        .typeCompany("")
                        .website("")
                        .gmail("")
                        .phone("")
                        .numberOfEmployee(0)
                        .companyOverview("")
                        .build();
                request.setAttribute("COMPANYINFO", company);
            }
        } catch (Exception e) {
            log("Error at CheckCompanyController" + e);
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
