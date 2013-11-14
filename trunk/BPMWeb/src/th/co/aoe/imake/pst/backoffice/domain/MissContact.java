package th.co.aoe.imake.pst.backoffice.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the MISS_CONTACT database table.
 * 
 */
@Entity
@Table(name="MISS_CONTACT")
public class MissContact implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="MCONTACT_ID")
	private Long mcontactId;
	@Column(name="MCONTACT_USERNAME")
	private String mcontactUsername;
	
	
	@Column(name="MCONTACT_PASSWORD")
	private String mcontactPassword;
	
	
    @Temporal( TemporalType.DATE)
	@Column(name="MCONTACT_BIRTH_DATE")
	private Date mcontactBirthDate;

	@Column(name="MCONTACT_DEPARTMENT")
	private String mcontactDepartment;

	@Column(name="MCONTACT_EMAIL")
	private String mcontactEmail;

	@Column(name="MCONTACT_EMAIL2")
	private String mcontactEmail2;

	@Column(name="MCONTACT_FAX")
	private String mcontactFax;

	@Column(name="MCONTACT_GENDER")
	private String mcontactGender;

	@Column(name="MCONTACT_LASTNAME")
	private String mcontactLastname;

	@Column(name="MCONTACT_NAME")
	private String mcontactName;

	@Column(name="MCONTACT_PHONE")
	private String mcontactPhone;

	@Column(name="MCONTACT_PICTURE_FILE_NAME")
	private String mcontactPictureFileName;

	@Column(name="MCONTACT_PICTURE_HOTLINK")
	private String mcontactPictureHotlink;

	@Column(name="MCONTACT_PICTURE_PATH")
	private String mcontactPicturePath;

	@Column(name="MCONTACT_POSTION")
	private String mcontactPostion;

	@Column(name="MCONTACT_TITLE_TYPE")
	private String mcontactTitleType;

	@Column(name="MCONTACT_REF")
	private Long mcontactRef;

	@Column(name="MCONTACT_TITLE")
	private String mcontactTitle;

	@Column(name="MCONTACT_TYPE")
	private String mcontactType;
	
	@Column(name="MCONTACT_ISADMIN")
	private String mcontactIsAdmin;
	
	@Column(name="rc_id")
	private Long rcId;
	@Column(name="MCONTACT_CREATED_TIME")
	private Timestamp mcontactCreatedTime;
	
	@Column(name="MCONTACT_UPDATED_TIME")
	private Timestamp mcontactUpdatedTime;

    public Long getRcId() {
		return rcId;
	}

	public void setRcId(Long rcId) {
		this.rcId = rcId;
	}

	public MissContact() {
    }

	public Long getMcontactId() {
		return this.mcontactId;
	}

	public void setMcontactId(Long mcontactId) {
		this.mcontactId = mcontactId;
	}

	public Date getMcontactBirthDate() {
		return this.mcontactBirthDate;
	}

	public void setMcontactBirthDate(Date mcontactBirthDate) {
		this.mcontactBirthDate = mcontactBirthDate;
	}

	public String getMcontactDepartment() {
		return this.mcontactDepartment;
	}

	public void setMcontactDepartment(String mcontactDepartment) {
		this.mcontactDepartment = mcontactDepartment;
	}

	public String getMcontactEmail() {
		return this.mcontactEmail;
	}

	public void setMcontactEmail(String mcontactEmail) {
		this.mcontactEmail = mcontactEmail;
	}

	public String getMcontactEmail2() {
		return this.mcontactEmail2;
	}

	public void setMcontactEmail2(String mcontactEmail2) {
		this.mcontactEmail2 = mcontactEmail2;
	}

	public String getMcontactFax() {
		return this.mcontactFax;
	}

	public void setMcontactFax(String mcontactFax) {
		this.mcontactFax = mcontactFax;
	}

	public String getMcontactGender() {
		return this.mcontactGender;
	}

	public void setMcontactGender(String mcontactGender) {
		this.mcontactGender = mcontactGender;
	}

	public String getMcontactLastname() {
		return this.mcontactLastname;
	}

	public void setMcontactLastname(String mcontactLastname) {
		this.mcontactLastname = mcontactLastname;
	}

	public String getMcontactName() {
		return this.mcontactName;
	}

	public void setMcontactName(String mcontactName) {
		this.mcontactName = mcontactName;
	}

	public String getMcontactPhone() {
		return this.mcontactPhone;
	}

	public void setMcontactPhone(String mcontactPhone) {
		this.mcontactPhone = mcontactPhone;
	}


	public String getMcontactPictureFileName() {
		return mcontactPictureFileName;
	}

	public void setMcontactPictureFileName(String mcontactPictureFileName) {
		this.mcontactPictureFileName = mcontactPictureFileName;
	}

	public String getMcontactPictureHotlink() {
		return this.mcontactPictureHotlink;
	}

	public void setMcontactPictureHotlink(String mcontactPictureHotlink) {
		this.mcontactPictureHotlink = mcontactPictureHotlink;
	}

	public String getMcontactPicturePath() {
		return this.mcontactPicturePath;
	}

	public void setMcontactPicturePath(String mcontactPicturePath) {
		this.mcontactPicturePath = mcontactPicturePath;
	}

	public String getMcontactPostion() {
		return this.mcontactPostion;
	}

	public void setMcontactPostion(String mcontactPostion) {
		this.mcontactPostion = mcontactPostion;
	}


	public String getMcontactTitleType() {
		return mcontactTitleType;
	}

	public void setMcontactTitleType(String mcontactTitleType) {
		this.mcontactTitleType = mcontactTitleType;
	}

	public Long getMcontactRef() {
		return this.mcontactRef;
	}

	public void setMcontactRef(Long mcontactRef) {
		this.mcontactRef = mcontactRef;
	}

	public String getMcontactTitle() {
		return this.mcontactTitle;
	}

	public void setMcontactTitle(String mcontactTitle) {
		this.mcontactTitle = mcontactTitle;
	}

	public String getMcontactType() {
		return this.mcontactType;
	}

	public void setMcontactType(String mcontactType) {
		this.mcontactType = mcontactType;
	}

	public String getMcontactUsername() {
		return mcontactUsername;
	}

	public void setMcontactUsername(String mcontactUsername) {
		this.mcontactUsername = mcontactUsername;
	}

	public String getMcontactPassword() {
		return mcontactPassword;
	}

	/*public User getMcontactUsername() {
		return mcontactUsername;
	}

	public void setMcontactUsername(User mcontactUsername) {
		this.mcontactUsername = mcontactUsername;
	}*/

	public void setMcontactPassword(String mcontactPassword) {
		this.mcontactPassword = mcontactPassword;
	}

	public String getMcontactIsAdmin() {
		return mcontactIsAdmin;
	}

	public void setMcontactIsAdmin(String mcontactIsAdmin) {
		this.mcontactIsAdmin = mcontactIsAdmin;
	}

	public Timestamp getMcontactCreatedTime() {
		return mcontactCreatedTime;
	}

	public void setMcontactCreatedTime(Timestamp mcontactCreatedTime) {
		this.mcontactCreatedTime = mcontactCreatedTime;
	}

	public Timestamp getMcontactUpdatedTime() {
		return mcontactUpdatedTime;
	}

	public void setMcontactUpdatedTime(Timestamp mcontactUpdatedTime) {
		this.mcontactUpdatedTime = mcontactUpdatedTime;
	}

}