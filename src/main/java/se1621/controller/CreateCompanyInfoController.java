/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import se1621.dao.CompanyInfoDAO;
import se1621.dao.UserDAO;
import se1621.dto.CompanyInfo;
import se1621.dto.Error.CompanyInfoError;
import se1621.dto.Role;
import se1621.dto.User;
import se1621.service.FirebaseStoreServiceImpl;

/**
 *
 * @author HNGB
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "CreateCompanyInfoController", urlPatterns = {"/CreateCompanyInfoController"})
public class CreateCompanyInfoController extends HttpServlet {

    private static final String ERROR = "/view/create-companyinfo.jsp";
    private static final String SUCCESS = "/MainController?action=SearchCompanyID&searchCompanyID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int companyID = Integer.parseInt(request.getParameter("companyID").trim());
            String companyName = request.getParameter("companyname");
            int establishedYear = Integer.parseInt(request.getParameter("establishedyear"));
            String address = request.getParameter("address");
            String typecompany = request.getParameter("typecompany");
            String website = request.getParameter("website");
            String gmail = request.getParameter("gmail");
            String phone = request.getParameter("phone");
            int numberOfEmployee = Integer.parseInt(request.getParameter("numberofemployee"));
            String companyOverview = request.getParameter("companyoverview");
//            String avatar = request.getParameter("avatar");
            Part filePart = request.getPart("avatar");
            FirebaseStoreServiceImpl firebaseStoreServiceImpl = new FirebaseStoreServiceImpl();
            String filename = firebaseStoreServiceImpl.uploadFile(filePart);
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
                    .avatar(filename)
                    .companyID(companyID)
                    .build();
            CompanyInfoDAO dao = new CompanyInfoDAO();
            CompanyInfoError comError = new CompanyInfoError();
            boolean checkValidation = true;
            boolean checkDuplicate = dao.checkDuplicate(companyName);
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            int currentCompnayID = loginUser.getCompanyID();
            boolean checkUpdate = false;
            boolean checkCreate = true;
            if (checkDuplicate) {
                if (currentCompnayID == companyID) {
                    checkUpdate = dao.updateCompanyInfo(company);
                    if (checkUpdate) {
                        request.setAttribute("MESSAGE_COM", "Update Company Successfull!");
                        url = SUCCESS + companyID;
                    } else {
                        checkValidation = false;
                        comError.setCompanyNameError("Company name already exists!");
                    }
                }
            } else if (checkValidation) {
                if (currentCompnayID == companyID) {
                    checkUpdate = dao.updateCompanyInfo(company);
                    if (checkUpdate) {
                        request.setAttribute("MESSAGE_COM", "Update Company Successfull!");
                        url = SUCCESS + companyID;
                    }
                } else {
                    checkCreate = dao.createComInfo(company);
                }
                if (checkCreate) {
                    int userID = loginUser.getUserID();
                    String fullName = loginUser.getFullName();
                    String email = loginUser.getEmail();
                    String password = loginUser.getPassword();
                    String roleID = loginUser.getRole().getRoleID();
                    String roleName = loginUser.getRole().getRoleName();
                    User user = User.builder()
                            .userID(userID)
                            .fullName(fullName)
                            .password(password)
                            .email(email)
                            .role(new Role(roleID, roleName))
                            .companyID(companyID)
                            .build();
                    UserDAO udao = new UserDAO();
                    boolean check = udao.updateCompanyID(user, companyID);
                    session.setAttribute("LOGIN_USER", user);
                    if (check) {
                        request.setAttribute("MESSAGE_COM", "Create Company Successfull!");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateCompanyInfoController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateCompanyInfoController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
