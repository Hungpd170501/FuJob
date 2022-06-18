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
import java.util.List;
import se1621.dao.ResumeDAO;
import se1621.dao.StudentSkillDAO;
import se1621.dto.Resume;
import se1621.dto.StudentSkill;

/**
 *
 * @author HNGB
 */
@WebServlet(name = "CheckCreateResumeController", urlPatterns = {"/CheckCreateResumeController"})
public class CheckCreateResumeController extends HttpServlet {

    private static final String ERROR = "/view/create-resume.jsp";
    private static final String SUCCESS = "/view/create-resume.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int studentID = Integer.parseInt(request.getParameter("studentID"));
            ResumeDAO dao = new ResumeDAO();
            List<Resume> listResume = dao.getListResume(studentID);
            StudentSkillDAO studentSkillDAO = new StudentSkillDAO();
            List<StudentSkill> listStudentSkill = studentSkillDAO.getStudentSkill(studentID);
            if (!listResume.isEmpty()) {
                request.setAttribute("LIST_RESUME", listResume);
                request.setAttribute("LIST_STUDENTSKILL", listStudentSkill);
                url = SUCCESS;
            } else {
                Resume resume = Resume.builder().address("").avartar("").dateOfBirth(null)
                        .experienceYear("").fullName("").gender("").gmail("").gpa("")
                        .major("").overview("").phone("").schoolName("").website("").build();
                listResume.add(resume);
                request.setAttribute("LIST_RESUME", listResume);
                request.setAttribute("LIST_STUDENTSKILL", listStudentSkill);
            }
        } catch (Exception e) {
            log("Error at SearchResumeIDController: " + e.toString());
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
