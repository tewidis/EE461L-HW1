package guestbook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
@SuppressWarnings("serial")

public class GAEJCronServlet extends HttpServlet {
	private static final Logger logger = Logger.getLogger(GAEJCronServlet.class.getName());
	public static ArrayList<User> subscribedUsers = new ArrayList<User>();
	public static ArrayList<String>	newPosts = new ArrayList<String>();
	
public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	logger.info("Test");
	logger.info(subscribedUsers.get(0).getEmail());
	try {
	//Extract out the To, Subject and Body of the Email to be sent
		for(int i = 0; i < subscribedUsers.size(); i++)
		{
			if(true)
			{
				String strTo = subscribedUsers.get(i).getEmail();
				String strSubject = "Lavanya and Tanner's Daily Update";
				String strBody = new String();
				String strFrom = "testmail@tannerandlavanyahw1.appspotmail.com";
				for(int j = 0; j < newPosts.size(); j++)
				{
					strBody += newPosts.get(j);
				}
				Properties props = new Properties();
				Session session = Session.getInstance(props, null);
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress(strFrom));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(strTo));
				msg.setSubject(strSubject);
				msg.setText(strBody);
				Transport.send(msg);
			}
		}
		logger.info("Cron Job has been executed");
	//newPosts.clear();
	}
	catch (Exception ex) {
		logger.info("Cron Job has NOT been executed");
        logger.info(ex.getMessage());
	}
}
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String userName = req.getParameter("userName");
		
		if (subscribedUsers.contains(user)){
			subscribedUsers.remove(user);
		} else {
			subscribedUsers.add(user);
		}
		resp.sendRedirect("/ofyguestbook.jsp?userName=" + userName);
	}
}