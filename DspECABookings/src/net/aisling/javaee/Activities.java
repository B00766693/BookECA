package net.aisling.javaee;
import java.io.Serializable;

public class Activities implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String dayOfWeek;
	private String activityName;
    private String classTime;
    private String eligibility;
    private int noOfWeeks;
    private int cost;
    private int maxClassSize;
    private int spacesAvailable;
    
    public Activities() {
    }
    
    
    public Activities(String dayOfWeek, String activityName, String classTime, String eligibility, int noOfWeeks,
    		int cost, int maxClassSize, int spacesAvailable) {
    		this.dayOfWeek = dayOfWeek;
    		this.activityName = activityName;
    		this.classTime = classTime;
    		this.eligibility = eligibility;
    		this.noOfWeeks = noOfWeeks;
    		this.cost = cost;
    		this.maxClassSize = maxClassSize;
    		this.spacesAvailable = spacesAvailable;
    		}
	
	
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getClassTime() {
		return classTime;
	}
	public void setClassTime(String classTime) {
		this.classTime = classTime;
	}
	public String getEligibility() {
		return eligibility;
	}
	public void setEligibility(String eligibility) {
		this.eligibility = eligibility;
	}
	public int getNoOfWeeks() {
		return noOfWeeks;
	}
	public void setNoOfWeeks(int noOfWeeks) {
		this.noOfWeeks = noOfWeeks;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public int getMaxClassSize() {
		return maxClassSize;
	}
	public void setMaxClassSize(int maxClassSize) {
		this.maxClassSize = maxClassSize;
	}
	public int getSpacesAvailable() {
		return spacesAvailable;
	}
	public void setSpacesAvailable(int spacesAvailable) {
		this.spacesAvailable = spacesAvailable;
	}
	
	
}
