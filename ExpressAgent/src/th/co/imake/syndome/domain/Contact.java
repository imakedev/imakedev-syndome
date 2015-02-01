package th.co.imake.syndome.domain;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * The persistent class for the CONTACT database table.
 * 
 */

public class Contact implements Serializable {
	private static final long serialVersionUID = 1L;

	//@Id
	//@Column(name="contact_code")
	private String contactCode;

	//@Column(name="account_name")
	private String accountName;

	//@Column(name="assigned_user_name")
	private String assignedUserName;

	private String assistant;

	//@Column(name="assistant_phone")
	private String assistantPhone;

	private Timestamp birthdate;

	//@Column(name="citizen_id")
	private String citizenId;

	private String department;

	private String description;

	private String email1;

	//@Column(name="first_name")
	private String firstName;

	//@Column(name="last_name")
	private String lastName;

	//@Column(name="lead_source")
	private String leadSource;

	//@Column(name="phone_fax")
	private String phoneFax;

	//@Column(name="phone_home")
	private String phoneHome;

	//@Column(name="phone_mobile")
	private String phoneMobile;

	//@Column(name="phone_other")
	private String phoneOther;

	//@Column(name="phone_work")
	private String phoneWork;

	private String salutation;

	private String title;

	private String type;

	public Contact() {
	}

	public String getContactCode() {
		return this.contactCode;
	}

	public void setContactCode(String contactCode) {
		this.contactCode = contactCode;
	}

	public String getAccountName() {
		return this.accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAssignedUserName() {
		return this.assignedUserName;
	}

	public void setAssignedUserName(String assignedUserName) {
		this.assignedUserName = assignedUserName;
	}

	public String getAssistant() {
		return this.assistant;
	}

	public void setAssistant(String assistant) {
		this.assistant = assistant;
	}

	public String getAssistantPhone() {
		return this.assistantPhone;
	}

	public void setAssistantPhone(String assistantPhone) {
		this.assistantPhone = assistantPhone;
	}

	public Timestamp getBirthdate() {
		return this.birthdate;
	}

	public void setBirthdate(Timestamp birthdate) {
		this.birthdate = birthdate;
	}

	public String getCitizenId() {
		return this.citizenId;
	}

	public void setCitizenId(String citizenId) {
		this.citizenId = citizenId;
	}

	public String getDepartment() {
		return this.department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEmail1() {
		return this.email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLeadSource() {
		return this.leadSource;
	}

	public void setLeadSource(String leadSource) {
		this.leadSource = leadSource;
	}

	public String getPhoneFax() {
		return this.phoneFax;
	}

	public void setPhoneFax(String phoneFax) {
		this.phoneFax = phoneFax;
	}

	public String getPhoneHome() {
		return this.phoneHome;
	}

	public void setPhoneHome(String phoneHome) {
		this.phoneHome = phoneHome;
	}

	public String getPhoneMobile() {
		return this.phoneMobile;
	}

	public void setPhoneMobile(String phoneMobile) {
		this.phoneMobile = phoneMobile;
	}

	public String getPhoneOther() {
		return this.phoneOther;
	}

	public void setPhoneOther(String phoneOther) {
		this.phoneOther = phoneOther;
	}

	public String getPhoneWork() {
		return this.phoneWork;
	}

	public void setPhoneWork(String phoneWork) {
		this.phoneWork = phoneWork;
	}

	public String getSalutation() {
		return this.salutation;
	}

	public void setSalutation(String salutation) {
		this.salutation = salutation;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

}