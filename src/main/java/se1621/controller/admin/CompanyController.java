/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.v2.CompanyDAO;
import se1621.dao.v2.CompanyDAOImpl;
import se1621.entity.CompanyEntity;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import static java.util.stream.Collectors.counting;
import static java.util.stream.Collectors.groupingBy;

/**
 * @author ACER
 */
@WebServlet(name = "CompanyController", urlPatterns = {"/CompanyController"})
public class CompanyController extends HttpServlet {

    private static final String ERROR = "/view/error.jsp";
    private static final String SUCCESS = "/WEB-INF/viewAdmin/company-list.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            CompanyDAO companyDAO = new CompanyDAOImpl();
            List<CompanyEntity> listAllCompany = companyDAO.getAll("CompanyEntity");
            Map<Integer, Long> countCompanyByStatus =
                    listAllCompany.stream()
                            .filter(e -> e.getCompanyStatus() != null)
                            .collect(groupingBy(CompanyEntity::getCompanyStatus, counting()));
            if (countCompanyByStatus.size() != 4) {
                for (int i = 0; i <= 3; i++) {
                    countCompanyByStatus.putIfAbsent(i, 0L);
                }
            }
            countCompanyByStatus.forEach((key, value) -> {
                        request.setAttribute("COUNT_TOTAL_COMPANY_" + key, value);
                    }
            );
            request.setAttribute("COUNT_COMPANY_LIST", listAllCompany.size());
            request.setAttribute("COMPANY_LIST", listAllCompany);
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at CompanyController: " + e);
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
