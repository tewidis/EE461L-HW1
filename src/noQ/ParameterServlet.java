
package noQ;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.googlecode.objectify.ObjectifyService;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
}