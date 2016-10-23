/* http://1-dot-guestbook-project-141921.appspot.com/ofyguestbook.jsp */
package guestbook;

 

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;

 



import java.io.IOException;
import java.util.Date;

 



import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PostBlog extends HttpServlet {


	static {

        ObjectifyService.register(Greeting.class);

    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        String guestbookName = req.getParameter("guestbookName");
        
        User user = userService.getCurrentUser();

        String content = req.getParameter("content");
        
        String title = req.getParameter("title");
        
        GAEJCronServlet.newPosts.add("Title: " + title + "/nContent:" + content);

        Greeting greeting = new Greeting(user, content, title);

        ofy().save().entity(greeting).now();

        resp.sendRedirect("/ofyguestbook.jsp?guestbookName=" + guestbookName);

    }

}