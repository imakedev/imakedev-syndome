package th.co.imake.syndome.domain;

import java.io.Serializable;
 

/**
 * The persistent class for the ACCOUNT database table.
 * 
 */
 
public class Account implements Serializable {
	private static final long serialVersionUID = 1L;

	/*@Id
	@Column(name="account_code")*/
	private String accountCode;

	//@Column(name="account_type")
	private String accountType;

	//@Column(name="annual_revenue")
	private String annualRevenue;

	//@Column(name="assigned_user_name")
	private String assignedUserName;

	private String description;

	private String email1;

	private String industry;

	//@Column(name="name_en")
	private String nameEn;

	//@Column(name="name_th")
	private String nameTh;

	//@Column(name="no_of_employees")
	private String noOfEmployees;

	//@Column(name="phone_alternate")
	private String phoneAlternate;

	//@Column(name="phone_fax")
	private String phoneFax;

	//@Column(name="phone_office")
	private String phoneOffice;

	private String status;

	private String type;

	private String website;

	public Account() {
	}

	public String getAccountCode() {
		return this.accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getAccountType() {
		return this.accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public String getAnnualRevenue() {
		return this.annualRevenue;
	}

	public void setAnnualRevenue(String annualRevenue) {
		this.annualRevenue = annualRevenue;
	}

	public String getAssignedUserName() {
		return this.assignedUserName;
	}

	public void setAssignedUserName(String assignedUserName) {
		this.assignedUserName = assignedUserName;
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

	public String getIndustry() {
		return this.industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getNameEn() {
		return this.nameEn;
	}

	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}

	public String getNameTh() {
		return this.nameTh;
	}

	public void setNameTh(String nameTh) {
		this.nameTh = nameTh;
	}

	public String getNoOfEmployees() {
		return this.noOfEmployees;
	}

	public void setNoOfEmployees(String noOfEmployees) {
		this.noOfEmployees = noOfEmployees;
	}

	public String getPhoneAlternate() {
		return this.phoneAlternate;
	}

	public void setPhoneAlternate(String phoneAlternate) {
		this.phoneAlternate = phoneAlternate;
	}

	public String getPhoneFax() {
		return this.phoneFax;
	}

	public void setPhoneFax(String phoneFax) {
		this.phoneFax = phoneFax;
	}

	public String getPhoneOffice() {
		return this.phoneOffice;
	}

	public void setPhoneOffice(String phoneOffice) {
		this.phoneOffice = phoneOffice;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getWebsite() {
		return this.website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

}