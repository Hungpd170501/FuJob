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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import se1621.dao.CompanyInfoDAO;
import se1621.dao.UserDAO;
import se1621.dto.CompanyInfo;
import se1621.dto.Error.CompanyInfoError;
import se1621.dto.Role;
import se1621.dto.User;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "CreateCompanyInfoController", urlPatterns = {"/CreateCompanyInfoController"})
public class CreateCompanyInfoController extends HttpServlet {

    private static final String ERROR = "/view/create-companyinfo.jsp";
    private static final String SUCCESS = "/MainController?action=Search&search=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String companyName = request.getParameter("companyname");
            String establishedYear = request.getParameter("establishedyear");
            String address = request.getParameter("address");
            String typecompany = request.getParameter("typecompany");
            String website = request.getParameter("website");
            String gmail = request.getParameter("gmail");
            String phone = request.getParameter("phone");
            int numberOfEmployee = Integer.parseInt(request.getParameter("numberofemployee"));
            String companyOverview = request.getParameter("companyoverview");
            String avatar = request.getParameter("avatar");

            CompanyInfoDAO dao = new CompanyInfoDAO();
            CompanyInfoError comError = new CompanyInfoError();
            boolean checkValidation = true;
            boolean checkDuplicate = dao.checkDuplicate(companyName);

            if (checkDuplicate) {
                checkValidation = false;
                comError.setCompanyNameError("Company Name already exists!");
            }
            if (checkValidation) {
                CompanyInfo company = CompanyInfo.builder()
                                        .companyName(companyName)
                                        .address(address)
                                        .website(website)
                                       .gmail(gmail)
                                       .phone(phone)
                                       .typeCompany(typecompany)
                                       .establishedYear(establishedYear)
                                       .numberOfEmployee(numberOfEmployee)
                                       .companyOverview(companyOverview)
                                       .avatar(avatar)
                                       .build();
                boolean checkCreate = dao.createComInfo(company);
                if (checkCreate) {
                    int companyID = dao.getCompanyID(companyName);
                    HttpSession session = request.getSession();
                    User loginUser = (User) session.getAttribute("LOGIN_USER");
                    int userID = loginUser.getUserID();
                    String fullName = loginUser.getFullName();
                    String email = loginUser.getEmail();
                    String password = loginUser.getPassword();
                    String roleID = loginUser.getRole().getRoleID();
                    User user = User.builder()
                            .userID(userID)
                            .fullName(fullName)
                            .password(password)
                            .username(fullName)
                            .email(email)
                            .role(new Role(roleID, ""))
                            .companyID(companyID)
                            .build();
                    UserDAO udao = new UserDAO();
                    boolean check = udao.updateCompanyID(user, companyID);
                    if (check) {
                        request.setAttribute("MESSAGE", "Create Company Successfully!!");
                        url = SUCCESS + companyID;
                    }
                }
            } else {
                request.setAttribute("COM_ERROR", comError);
            }
        } catch (ClassNotFoundException | NumberFormatException | SQLException e) {
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
