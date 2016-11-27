package noQ;

import static com.googlecode.objectify.ObjectifyService.ofy;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class DismissServlet extends HttpServlet {
	static {

        ObjectifyService.register(Customer.class);


    }
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		Customer.served += 1;
	}
}