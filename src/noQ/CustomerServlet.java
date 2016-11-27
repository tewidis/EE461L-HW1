package noQ;

import static com.googlecode.objectify.ObjectifyService.ofy;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class CustomerServlet extends HttpServlet {
	static {

        ObjectifyService.register(Customer.class);
        ObjectifyService.register(CustomerCount.class);
        ofy().save().entity(new CustomerCount()).now();

    }
	
	static Integer customerCount=0;
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
        List<CustomerCount> cc = ObjectifyService.ofy().load().type(CustomerCount.class).list();
        ofy().save().entity(new Customer()).now();
        cc.get(0).count = cc.get(0).count + 1;
        ofy().save().entity(cc.get(0)).now();
        resp.sendRedirect("/noQLanding.jsp");

	}
}