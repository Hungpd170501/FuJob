/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import Error.UserError;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dao.UserDAO;
import se1621.dto.User;

/**
 *
 * @author HNGB
 */

@WebServlet(name = "SignUpController", urlPatterns = {"/SignUpController"})
public class SignUpController extends HttpServlet {
    private static final String ERROR = "signup.jsp";
    private static final String SUCCESS = "signup.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleID = request.getParameter("roleID");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            UserDAO dao = new UserDAO();
            UserError userError = new UserError();
            boolean checkValidation= true;
            boolean checkDuplicate= dao.checkDuplicate(email);
            
            if(checkDuplicate){
                checkValidation= false;
                userError.setEmailError("Email duplicate");
            }
            if(checkValidation){
                User user = new User("", password, fullName, email, roleID, status);
                boolean checkSignup = dao.signup(user);
                if(checkSignup){
                    request.setAttribute("MESSAGE","Insert Successfully!!");
                    url= SUCCESS;
                }
            }else{
                request.setAttribute("USER_ERROR", userError);
            }
        } catch (Exception e) {
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
