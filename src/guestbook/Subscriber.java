package guestbook;

import java.util.Date;
import java.util.List;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Subscriber{
	@Id
	Long id;
	String email;
	User user;

	private Subscriber() {
	}

	public Subscriber(User user) {
		this.user = user;
		this.email = user.getEmail();
	}
	public static Subscriber isSubscribed(User user){
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
		for(Subscriber s: subscribers){
			if(s.email.equalsIgnoreCase(user.getEmail())){
				return s;
			}
		}
		return null;
	}
	public String getEmail() {
		return email;
	}	
}