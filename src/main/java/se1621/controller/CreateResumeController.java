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
import java.sql.Date;
import se1621.dao.ResumeDAO;
import se1621.dto.Resume;
import se1621.dto.User;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "CreateResumeController", urlPatterns = {"/CreateResumeController"})
public class CreateResumeController extends HttpServlet {

    private static final String ERROR = "/view/create-resume.jsp";
    private static final String SUCCESS = "/MainController?action=SearchResumeID&searchResumeID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String avatar = request.getParameter("avatar");
            String fullName = request.getParameter("fullname");
            String gender = request.getParameter("gender");
            Date dateOfBirth = Date.valueOf(request.getParameter("dateofbirth"));
            String gmail = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String shoolName = request.getParameter("shoolName");
            String major = request.getParameter("major");
            String gpa = request.getParameter("gpa");
            String chooseExY = request.getParameter("chooseExY");
            String website = request.getParameter("website");
            String seflintro = request.getParameter("seflintro");

            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            int userID = loginUser.getUserID();
            Resume resume = new Resume(0, userID, avatar, fullName, gender, dateOfBirth,
                    gmail, phone, address, shoolName, major, gpa, chooseExY, website, seflintro);

            ResumeDAO resumedao = new ResumeDAO();
            boolean checkValidation = true;
            boolean checkDuplicate = resumedao.checkDuplicate(userID);
            if (checkDuplicate) {
                checkValidation = false;
                boolean checkUpdateResume = resumedao.updateResume(resume, userID);
                if (checkUpdateResume) {
                    request.setAttribute("MESSAGE", "Your Resume has been updated!");
                    url = SUCCESS + userID;
                }
            }
            if (checkValidation) {
                boolean checkCreateResume = resumedao.createResume(resume);
                if (checkCreateResume) {
                    request.setAttribute("MESSAGE", "Create Resume Successfully!");
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
