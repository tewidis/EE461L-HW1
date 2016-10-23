package guestbook;

import java.util.Queue;

class CustomerQueue{

/* Thanks to information hiding, if we decide we don't want to use the Queue class we can use something else instead in our implementation of CustomerQueue. If we want to add features we can increase the complexity of the internals without changing the parameters and return values of the methods. We are also hiding methods for the Queue class that we don't need, such as addAll, simplifying the design to only the functions that we need. */

	private Queue<Customer> customers; 
	private NoQTimer timer;

	public void add(Customer c){
		/*again, if we decide not to use a Queue we can change the implementation of add() */
		customers.add(c); 	
	}
	public void remove(){
		/*same thing*/
		customers.remove();
	}

	public void size(){
		customers.size();
	}

}


