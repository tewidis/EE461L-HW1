package noQ;
import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class CustomerCount{
	@Id
	Long id = (long)1;
	public int count = 0;
	public CustomerCount(){
		
	}
	
}