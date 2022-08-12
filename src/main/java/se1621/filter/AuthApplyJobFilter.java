package se1621.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.sun.activation.registries.LogSupport.log;

@WebFilter(filterName = "AuthApplyJobFilter", urlPatterns = "/ApplyJobWithoutLogin")
public class AuthApplyJobFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        String uri = String.valueOf(req.getRequestURL());
        String url;
        try {
            HttpSession session = ((HttpServletRequest) request).getSession();
            session.setAttribute("REFERER", req.getParameter("referer"));
            req.getRequestDispatcher("/view/login.jsp").forward(request, response);
        } catch (Throwable t) {
            log(t.getMessage());
        }
    }
}
