
package guestbook;

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

public class OfySignGuestbookServlet extends HttpServlet {
	static {
		ObjectifyService.register(Greeting.class);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		Greeting greeting;
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		String guestbookName = req.getParameter("guestbookName");
		String content = req.getParameter("content");
		String title = req.getParameter("title");
		greeting = new Greeting(user, content, title);
		if(title.trim().length() != 0){
		ObjectifyService.ofy().save().entity(greeting).now();
		}
		resp.sendRedirect("/ofyguestbook.jsp?guestbookName=" + guestbookName);
	}
}
