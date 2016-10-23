package guestbook;

import java.util.Date;
import java.util.List;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

public class Parameter {
	
	long avgWaitTime;		//wait time for a line
	long maxLineLength;		//maximum number of customers before it resets
	long notifFreq;			//how often to remind customers
	String companyLogo;		//image of the company
	
	public Parameter(){
		avgWaitTime = 300;
		maxLineLength = 50;
		notifFreq = 180;
		companyLogo = "";
	}
	
	public long getTime(){
		return avgWaitTime;
	}
	
	public long getLine(){
		return maxLineLength;
	}
	
	public long getFreq(){
		return notifFreq;
	}
	
	public String getLogo(){
		return companyLogo;
	}
	
	public long setTime(long wait){
		avgWaitTime = wait;
		return avgWaitTime;
	}
	
	public long setLine(long length){
		maxLineLength = length;
		return maxLineLength;
	}
	
	public long setFreq(long freq){
		notifFreq = freq;
		return notifFreq;
	}
	
	public String setLogo(String image){
		companyLogo = image;
		return companyLogo;
	}


}
