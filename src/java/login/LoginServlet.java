package login;
import entity.Admin;
import entity.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import session.AdminFacade;
import session.CustomerFacade;


/**
 * Servlet implementation class LoginServlet
 */

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
        private CustomerFacade CustomerFacade;
        @EJB
        private AdminFacade AdminFacade;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// get request parameters for userID and password
		String user = request.getParameter("email");
		String pwd = request.getParameter("password");
                String cust = "";
                Customer customer = null;
                Admin admin = null;
            List<Customer> list= CustomerFacade.findEmail(user);
            List<Admin> list2 = null;
            
            if(!list.isEmpty()){
                customer = list.get(0);
            }else{
                list2 = AdminFacade.findEmailAdmin(user);
                if(!list2.isEmpty()){
                if(customer == null)
                    admin = list2.get(0);
            }
            }
            
            
            if(customer != null ){
		if(customer.getEmail().equals(user) && customer.getPassword().equals(pwd) ){
			HttpSession session = request.getSession();
			session.setAttribute("customer", customer);
                        session.setAttribute("user", user);
			Cookie userName = new Cookie("user", user);
			response.addCookie(userName);
			response.sendRedirect("index.jsp");
		}else{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			PrintWriter out= response.getWriter();
			out.println("<font color=red>Either user name or password is wrong.</font>");
                        out.println(list.isEmpty()+customer.getPassword()+customer.getEmail()+customer.getId());
			rd.include(request, response);
		}
            }else if(admin !=null && customer == null){
                    if(admin.getEmail().equals(user) && admin.getPassword().equals(pwd)){
                        HttpSession session = request.getSession();
			session.setAttribute("admin", admin);
                        session.setAttribute("user", user);
			Cookie userName = new Cookie("user", user);
			response.addCookie(userName);
			response.sendRedirect("index.jsp");
                
                    }else{
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			PrintWriter out= response.getWriter();
			out.println("<font color=red>Either user name or password is wrong.</font>");
                     
			rd.include(request, response);
                    }
            }else{
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			PrintWriter out= response.getWriter();
			out.println("<font color=red>Usuario no encontrado.</font>");
			rd.include(request, response);
            
            
            }

	}

}
