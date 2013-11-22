package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BPM_APPLICATION_LOG database table.
 * 
 */
@Entity
@Table(name="BPM_APPLICATION_LOG",schema="SYNDOME_BPM_DB")
public class BpmApplicationLog implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private BpmApplicationLogPK id;

	@Column(name="BAL_ACTION")
	private String balAction;

	@Column(name="BAL_CREATED_DATE")
	private String balCreatedDate;

	@Column(name="BAL_STATUS")
	private String balStatus;

	public BpmApplicationLog() {
	}

	public BpmApplicationLogPK getId() {
		return this.id;
	}

	public void setId(BpmApplicationLogPK id) {
		this.id = id;
	}

	public String getBalAction() {
		return this.balAction;
	}

	public void setBalAction(String balAction) {
		this.balAction = balAction;
	}

	public String getBalCreatedDate() {
		return this.balCreatedDate;
	}

	public void setBalCreatedDate(String balCreatedDate) {
		this.balCreatedDate = balCreatedDate;
	}

	public String getBalStatus() {
		return this.balStatus;
	}

	public void setBalStatus(String balStatus) {
		this.balStatus = balStatus;
	}

}