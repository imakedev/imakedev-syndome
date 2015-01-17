package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the BPM_RUNNING_NO database table.
 * 
 */
@Entity
@Table(name="BPM_RUNNING_NO") 
public class BpmRunningNo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BRN_SYSTEM")
	private String brnSystem;

	@Temporal(TemporalType.DATE)
	@Column(name="BRN_DATE")
	private Date brnDate;

	@Column(name="BRN_NO")
	private int brnNo;

	@Column(name="BRN_PREFIX")
	private String brnPrefix;

	public BpmRunningNo() {
	}

	public String getBrnSystem() {
		return this.brnSystem;
	}

	public void setBrnSystem(String brnSystem) {
		this.brnSystem = brnSystem;
	}

	public Date getBrnDate() {
		return this.brnDate;
	}

	public void setBrnDate(Date brnDate) {
		this.brnDate = brnDate;
	}

	public int getBrnNo() {
		return this.brnNo;
	}

	public void setBrnNo(int brnNo) {
		this.brnNo = brnNo;
	}

	public String getBrnPrefix() {
		return this.brnPrefix;
	}

	public void setBrnPrefix(String brnPrefix) {
		this.brnPrefix = brnPrefix;
	}

}