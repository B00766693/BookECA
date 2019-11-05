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
    private String firstName;
    private String lastName;
    private String schoolClass;
    
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
}
