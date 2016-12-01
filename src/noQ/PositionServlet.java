package noQ;

import static com.googlecode.objectify.ObjectifyService.ofy;





import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class PositionServlet extends HttpServlet {
	static {

        ObjectifyService.register(Customer.class);
    }
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		/*Customer.served = 0;
		Customer.totalCustomers = 0;
		Customer.customerWaiting = 0;
		resp.sendRedirect("/host.jsp");
		
		
		Integer cid=(Customer.totalCustomers);
		Integer pos=cid-Customer.served;
		System.out.println(pos);
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(pos);
		
		
		/*
		req.setAttribute("pos",pos);
		req.getRequestDispatcher("/noQLanding.jsp?position="+pos).forward(req, resp);
		*/
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        PrintWriter writer =  response.getWriter();
        try{
           //Integer cid=(Customer.totalCustomers);
    	   Integer cid=Integer.parseInt(request.getParameter("orderId"));
           Integer pos=cid-Customer.served;
           for(Integer c: Customer.canceledCustomer){
    		  // System.out.println(c+ ">"+cid);

        	   if(c>cid){
        		//   System.out.println(c+ ">"+cid);
        		   pos++;
        	   }
           }
           /*if(Customer.reset==1){
        	  pos=0;
        	  Customer.customerWaiting--;
        	  if(Customer.customerWaiting==0){
        		  Customer.reset=0;
        	  }
           }
           */
           String data = ""+pos;
           writer.write(data);
           writer.close();
         
           }
       catch(Exception ex)
      {
      ex.getStackTrace();
      }
    }
	
}