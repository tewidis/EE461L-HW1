
package guestbook;

import static com.googlecode.objectify.ObjectifyService.ofy;
import com.googlecode.objectify.ObjectifyService;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SubscriberServlet extends HttpServlet {
	static {
		ObjectifyService.register(Greeting.class);
		ObjectifyService.register(Subscriber.class);
	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		Subscriber subscriber;
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
		Subscriber s = Subscriber.isSubscribed(user);
		if(s != null){
			ObjectifyService.ofy().delete().entity(s).now();
		} else{
			ObjectifyService.ofy().save().entity(new Subscriber(user)).now();
		}
		resp.sendRedirect("/ofyguestbook.jsp");
	}
}