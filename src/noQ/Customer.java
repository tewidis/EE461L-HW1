package noQ;

public class Customer{
	/* private fields so that we can change classes if we desire. For example, we could potentially use an Integer instead of a String for cID later on if it improves our design, but our getter would still return a String. */
	private int cID;
	private long timestamp;
	
	public Customer(){
	timestamp = System.currentTimeMillis();
	}
	public int getcID(){
		//code for now, implementation can change. 
		return cID;
	}
}
