/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package se1621.controller;

import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.net.ssl.HttpsURLConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.http.client.fluent.Request;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import se1621.dao.UserDAO;
import se1621.dto.User;
import se1621.dto.UserGoogle;

@WebServlet(name = "LoginGoogleHandler", urlPatterns = {"/LoginGoogleHandler"})
public class LoginGoogleHandler extends HttpServlet {

    private final static String ADMIN_PAGE = "MainController?action=AdminIndex";
    private final static String USER_PAGE = "MainController?action=IndexController";
    private final static String SIGNUP_PAGE = "MainController?action=SignUp&email=";
    private final static String ERROR = "/view/login.jsp";
    public static String GOOGLE_CLIENT_ID = "674216776597-dsnqcp414vcta1d1mi4aa5umrmakucjd.apps.googleusercontent.com";
    public static String GOOGLE_CLIENT_SECRET = "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";
    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/FuJob/LoginGoogleHandler";
    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String code = request.getParameter("code");
            if (code != null) {
                URL obj = new URL(GOOGLE_LINK_GET_TOKEN);
                HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
                con.setRequestMethod("POST");
                con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
                String postParams = "code=" + code
                        + "&client_id=" + GOOGLE_CLIENT_ID
                        + "&client_secret=" + GOOGLE_CLIENT_SECRET
                        + "&redirect_uri=" + GOOGLE_REDIRECT_URI
                        + "&grant_type=" + GOOGLE_GRANT_TYPE;
                con.setDoOutput(true);
                try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                    wr.writeBytes(postParams);
                    wr.flush();
                }
                int responseCode = con.getResponseCode();
                BufferedReader in = new BufferedReader(new InputStreamReader(
                        con.getInputStream()));
                String inputLine;
                StringBuilder responseToken = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    responseToken.append(inputLine);
                }
                in.close();
                JSONParser parser = new JSONParser();
                JSONObject json = (JSONObject) parser.parse(responseToken.toString());
                String accessToken = json.get("access_token").toString().replaceAll("\"", "");
                String link = GOOGLE_LINK_GET_USER_INFO + accessToken;
                String responseDetail = Request.Get(link).execute().returnContent().asString();
                UserGoogle googlePojo = new Gson().fromJson(responseDetail, UserGoogle.class);
                UserDAO dao = new UserDAO();
                User user = dao.checkUserByEmail(googlePojo.getEmail());
                HttpSession session = request.getSession();
                String referer = session.getAttribute("REFERER") != null ? "MainController?" + session.getAttribute("REFERER") : null;
                if (user != null) {
                    switch (user.getUserStatus()) {
                        case 0:
                            request.setAttribute("LOGIN_MESSAGE", "Your account has been deactivated. Please contact to FuJob Admin to reactivate it!");
                            break;
                        case 2:
                            request.setAttribute("LOGIN_MESSAGE", "Making sure you are secure--it's what we do. Please check your email for a link to confirm you are you!!");
                            break;
                        default:
                            session.setAttribute("LOGIN_USER", user);
                            if ((user.getRole().getRoleID()) != null) {
                                switch (user.getRole().getRoleID()) {
                                    case "AD":
                                        url = ADMIN_PAGE;
                                        break;
                                    case "US":
                                        url = referer != null ? referer : USER_PAGE;
                                        break;
                                    case "HR":
                                        url = referer != null ? referer : USER_PAGE;
                                        break;
                                    case "HRM":
                                        url = referer != null ? referer : USER_PAGE;
                                        break;
                                    default:
                                        request.setAttribute("LOGIN_MESSAGE", "Your role is not allow!");
                                        break;

                                }
                            } else {
                                request.setAttribute("LOGIN_MESSAGE", "Your role is not allow!");
                            }
                    }
                } else {
                    url = SIGNUP_PAGE + googlePojo.getEmail();
                }

            }
        } catch (Exception e) {
            request.setAttribute("LOGIN_MESSAGE", "Opp Something wrong!");
            log("Error at LoginGoogleHandler: " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }

    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginGoogleHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginGoogleHandler.class.getName()).log(Level.SEVERE, null, ex);
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
