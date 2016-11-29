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

    }
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
        /*List<CustomerCount> cc = ObjectifyService.ofy().load().type(CustomerCount.class).list();
        CustomerCount cCount = cc.get(0);
        Customer newC = new Customer();
        ofy().save().entity(newC).now();
        ofy().save().entity(cc.get(0)).now();
        */
		doPost(req,resp);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		Customer.totalCustomers += 1;
		Customer.customerWaiting += 1;
		//resp.setIntHeader("Refresh", 5);
        resp.sendRedirect("/noQLanding.jsp?cID=" + Customer.totalCustomers.toString());
	
	}
	
}