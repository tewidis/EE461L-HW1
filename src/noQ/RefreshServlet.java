
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

public class RefreshServlet extends HttpServlet {
	static {
		ObjectifyService.register(Customer.class);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

	}
}
