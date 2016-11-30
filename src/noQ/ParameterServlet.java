
package noQ;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.googlecode.objectify.ObjectifyService;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.*;

public class ParameterServlet extends HttpServlet {
	static {
		ObjectifyService.register(Parameter.class);
	}

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		Integer avgWaitTime =Integer.parseInt(req.getParameter("avgWaitTime"));
		Parameter.setTime(avgWaitTime);
		resp.sendRedirect("/host.jsp?avgWaitTime=" + avgWaitTime.toString());
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{

        PrintWriter writer =  resp.getWriter();
        try{
           //Integer cid=(Customer.totalCustomers);
    	   Integer cid=Integer.parseInt(req.getParameter("orderId"));
           Integer avgWT=(cid-Customer.served)*Parameter.avgWaitTime;
           if(avgWT<0){avgWT=0;}
           String data = ""+avgWT;
           writer.write(data);
           writer.close();
           }
       catch(Exception ex)
      {
      ex.getStackTrace();
      }
	}
	
}