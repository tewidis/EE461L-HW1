package noQ;
import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
@Entity
public class Customer{
	/* private fields so that we can change classes if we desire. For example, we could potentially use an Integer instead of a String for cID later on if it improves our design, but our getter would still return a String. */
	public static Integer totalCustomers = 0;
	public static Integer served = 0;
	@Id
	long id;
	public Integer cID;
	
	private Customer(){
	}
}
