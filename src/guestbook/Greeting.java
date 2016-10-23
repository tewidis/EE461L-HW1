package guestbook;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Greeting implements Comparable<Greeting> {
	@Id
	Long id;
	User user;
	String title;
	String content;
	Date date;

	private Greeting() {
	}

	public Greeting(User user, String content, String title) {
		this.title  = title;
		this.user = user;
		this.content = content;
		date = new Date();
	}

	public User getUser() {
		return user;
	}

	public String getContent() {
		return content;
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getDate() {
		return date.toString();
	}

	@Override
	public int compareTo(Greeting other) {
		if (date.after(other.date)) {
			return 1;
		} else if (date.before(other.date)) {
			return -1;
		}
		return 0;
	}
	public static List<Greeting> todaysPosts(){
		List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();
		List<Greeting> today = new ArrayList<Greeting>();
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.add(Calendar.DAY_OF_MONTH, -1);
		Date dayAgo = cal.getTime();
		for(Greeting g : greetings){
			if(g.date.after(dayAgo)){
				today.add(g);
			} 
		}
		return today;
	}
}
