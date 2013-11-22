package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BPM_ASSIGN database table.
 * 
 */
@Entity
@Table(name="BPM_ASSIGN",schema="SYNDOME_BPM_DB")
public class BpmAssign implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BA_TYPE")
	private Long baType;

	@Column(name="BA_CREATED_DATE")
	private String baCreatedDate;

	@Column(name="BA_REF")
	private String baRef;

	@Column(name="BA_STAFF")
	private String baStaff;

	public BpmAssign() {
	}

	public Long getBaType() {
		return this.baType;
	}

	public void setBaType(Long baType) {
		this.baType = baType;
	}

	public String getBaCreatedDate() {
		return this.baCreatedDate;
	}

	public void setBaCreatedDate(String baCreatedDate) {
		this.baCreatedDate = baCreatedDate;
	}

	public String getBaRef() {
		return this.baRef;
	}

	public void setBaRef(String baRef) {
		this.baRef = baRef;
	}

	public String getBaStaff() {
		return this.baStaff;
	}

	public void setBaStaff(String baStaff) {
		this.baStaff = baStaff;
	}

}