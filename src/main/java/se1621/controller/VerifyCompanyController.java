/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package se1621.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import se1621.dao.CompanyInfoDAO;
import se1621.dto.CompanyInfo;
import se1621.service.FirebaseStoreService;
import se1621.service.FirebaseStoreServiceImpl;

import java.io.IOException;

/**
 * @author HNGB
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "VerifyCompanyController", urlPatterns = {"/VerifyCompanyController"})
public class VerifyCompanyController extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/view/company-detail.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int companyID = Integer.parseInt(request.getParameter("companyID"));
            Part filePart = request.getPart("file");
            FirebaseStoreService firebaseStoreService = new FirebaseStoreServiceImpl();
            String filename = firebaseStoreService.uploadFile(filePart);
            CompanyInfoDAO comDAO = new CompanyInfoDAO();
            boolean checkUpdate = comDAO.updateBusinessLicense(companyID, filename);
            CompanyInfo com = comDAO.getCompanyInfo(companyID);
            if (checkUpdate) {
                request.setAttribute("COMPANYINFO", com);
                request.setAttribute("MESSAGE_UPDATE", "Sent! Waiting for approval!");
                url = SUCCESS;
            } else {
                request.setAttribute("COMPANYINFO", com);
                request.setAttribute("MESSAGE_UPDATE", "ERROR! Please try again!");
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at SearchCompanyIDController: " + e);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
