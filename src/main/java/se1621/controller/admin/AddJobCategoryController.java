/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller.admin;

import java.io.IOException;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import se1621.dto.Category;

/**
 * @author ACER
 */
@WebServlet(name = "AddJobCategoryController", urlPatterns = {"/AddJobCategoryController"})
public class AddJobCategoryController extends HttpServlet {

    public AddJobCategoryController() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Action : " + action);
        Gson gson = new Gson();
        String jsonlist = "";
        String name = null;
        name = request.getParameter("name");
        log(name);

        Category category = new Category();
        category.setCategoryName(name);
        category.setCategoryID(1);

        jsonlist = gson.toJson(category);
        response.setContentType("application/json");
        response.getWriter().print(jsonlist);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
