
package guestbook;

import static com.googlecode.objectify.ObjectifyService.ofy;
import com.googlecode.objectify.ObjectifyService;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.IOException;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
// [END simple_includes]

// [START multipart_includes]
import java.io.InputStream;
import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import javax.activation.DataHandler;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
// [END multipart_includes]
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EmailServlet extends HttpServlet {
	static {
		ObjectifyService.register(Subscriber.class);
		ObjectifyService.register(Greeting.class);
		ObjectifyService.register(Log.class);
	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try{
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
		List<Greeting> todaysPosts = Greeting.todaysPosts();
		if(!todaysPosts.isEmpty()){
		    Properties props = new Properties();
		    Session session = Session.getDefaultInstance(props, null);
			sendSimpleMail(subscribers, todaysPosts, session);
			//resp.sendRedirect("/ofyguestbook.jsp");
		}
		}catch(Exception e){
			Log l = new Log(e);
			ObjectifyService.ofy().save().entity(e).now();
		}
		
	}
	private void sendSimpleMail(List<Subscriber> subscribers, List<Greeting> todaysPosts, Session session) {
	    // [START simple_example]

	    try {
	      Message msg = new MimeMessage(session);
	      msg.setFrom(new InternetAddress("bb@birdbloggers.appspotmail.com", "Scott Fennell"));
	      for(Subscriber s: subscribers){
	      msg.addRecipient(Message.RecipientType.TO,
	                       new InternetAddress(s.getEmail(), "Bird Blogger"));
	      }
	      msg.setSubject("Bird Blog Posts "+ (new Date()).toString().substring(0, 10));
	      String text = new String();
	      text = "today's posts!\n\n";
	      for(Greeting g: todaysPosts){
	    	  text = text + g.getDate()+ "\n" + g.getUser().getNickname() + " wrote\n"
	    			  + g.getTitle() +"\n" + g.getContent() + "\n\n";
	      }
	      msg.setText(text);
	      Transport.send(msg);
	    } catch (AddressException e) {
	    	Log l = new Log(e);
			ObjectifyService.ofy().save().entity(e).now();
	    } catch (MessagingException e) {
	    	Log l = new Log(e);
			ObjectifyService.ofy().save().entity(e).now();
	    } catch (UnsupportedEncodingException e) {
	    	Log l = new Log(e);
			ObjectifyService.ofy().save().entity(e).now();
	    }
	    // [END simple_example]
	  }
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
	doGet(req, resp);
	}
}