package noQ;

import static com.googlecode.objectify.ObjectifyService.ofy;




import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class CustomerServedServlet extends HttpServlet {
	static {

        ObjectifyService.register(Customer.class);
    }
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		 PrintWriter writer =  response.getWriter();
	        try{
	           //Integer cid=(Customer.totalCustomers);
	    	   Integer data=Customer.served;
	           
	           
	           String dataOut = ""+data;
	           writer.write(dataOut);
	           writer.close();
	           }
	       catch(Exception ex)
	      {
	      ex.getStackTrace();
	      }
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
       
    }
	
}