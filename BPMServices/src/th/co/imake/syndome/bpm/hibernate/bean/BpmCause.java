package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_CAUSE database table.
 * 
 */
@Entity
@Table(name="BPM_CAUSE",schema="SYNDOME_BPM_DB")
public class BpmCause implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BCAUSE_ID")
	private Long bcauseId;

	@Column(name="BCAUSE_NAME")
	private String bcauseName;

	public BpmCause() {
	}

	public Long getBcauseId() {
		return this.bcauseId;
	}

	public void setBcauseId(Long bcauseId) {
		this.bcauseId = bcauseId;
	}

	public String getBcauseName() {
		return this.bcauseName;
	}

	public void setBcauseName(String bcauseName) {
		this.bcauseName = bcauseName;
	}

}