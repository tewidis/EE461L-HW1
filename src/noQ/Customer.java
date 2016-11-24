package guestbook;

public class Customer{
	/* private fields so that we can change classes if we desire. For example, we could potentially use an Integer instead of a String for cID later on if it improves our design, but our getter would still return a String. */
	private String cID;
	private NoQTimeStamp timeStamp;
	private Integer waitTime;
	private Integer index;
	
	public Customer(Integer index){
		//implementation of the constructor can change.
		this.index=index;
	}
	public String getcID(){
		//code for now, implementation can change. 
		return cID;
	}
	public NoQTimeStamp getTimeStamp(){
		//simple code that can change
		return timeStamp;
	}

	public Integer getWaitTime(){
		return waitTime; 
	}
}
