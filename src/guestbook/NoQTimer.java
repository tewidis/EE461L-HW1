package guestbook;

/* while this is a functional version of the timer, you will see later on in part B that we were able to change NoQTimer to a singleton without affecting other classes. */
class NoQTimer{
	public Clock getTimer(){
		return Clock.getInstance();
	};
	
}
