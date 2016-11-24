package noQ;

import static com.googlecode.objectify.ObjectifyService.ofy;


import java.io.IOException;

import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class CustomerServlet extends HttpServlet {
	static {

        ObjectifyService.register(Customer.class);

    }
	
	static Integer customerCount=0;
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

        Customer cus=new Customer();
		customerCount++;
        ofy().save().entity(cus).now();
        

	}
}