package net.aisling.javaee;
import java.io.Serializable;

/**
 *
 * 
 */
public class Participant implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int id;
    private String firstName;
    private String lastName;
    private String schoolClass;
    private String parentName;
    private String telNo;
    
    public Participant() {	
    }
    
    public Participant(int id) {
		this.id = id;
	}
    
	public Participant(String firstName, String lastName, String schoolClass, String parentName, String telNo) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.schoolClass = schoolClass;
		this.parentName = parentName;
		this.telNo = telNo;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getSchoolClass() {
        return schoolClass;
    }
    public void setSchoolClass(String schoolClass) {
        this.schoolClass = schoolClass;
    }
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
       
}
