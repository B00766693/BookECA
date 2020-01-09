package net.aisling.javaee;

public class Activity {

	private int aId;
	private String dayOn;
	private String activityName;
	private String classTime;
	private String eligibility;
	private int noOfWeeks;
	private int cost;
	private int maxClassSize;
	private int spacesAvailable;

	public Activity() {
	}

	public Activity(int aId) {
		this.setaId(aId);
	}

	public Activity(String dayOn, String activityName, String classTime, int cost) {
		this.dayOn = dayOn;
		this.activityName = activityName;
		this.classTime = classTime;
		this.cost = cost;
	}

	public Activity(String activityName) {
		this.activityName = activityName;
	}

	public Activity(String dayOn, String activityName, String classTime, String eligibility, int noOfWeeks, int cost,
			int maxClassSize, int spacesAvailable, int aId) {

		this.dayOn = dayOn;
		this.activityName = activityName;
		this.classTime = classTime;
		this.eligibility = eligibility;
		this.noOfWeeks = noOfWeeks;
		this.cost = cost;
		this.maxClassSize = maxClassSize;
		this.spacesAvailable = spacesAvailable;
		this.setaId(aId);
	}

	public Activity(String dayOn, String activityName, String classTime, String eligibility, int noOfWeeks, int cost,
			int maxClassSize, int spacesAvailable) {
		this.dayOn = dayOn;
		this.activityName = activityName;
		this.classTime = classTime;
		this.eligibility = eligibility;
		this.noOfWeeks = noOfWeeks;
		this.cost = cost;
		this.maxClassSize = maxClassSize;
		this.spacesAvailable = spacesAvailable;
	}

	public int getaId() {
		return aId;
	}

	public void setaId(int aId) {
		this.aId = aId;
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

	public String getDayOn() {
		return dayOn;
	}

	public void setDayOn(String dayOn) {
		this.dayOn = dayOn;
	}

	public String toString() {
		return activityName + " ";
	}
}
