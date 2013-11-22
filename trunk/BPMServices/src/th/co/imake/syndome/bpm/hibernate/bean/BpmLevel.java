package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_LEVEL database table.
 * 
 */
@Entity
@Table(name="BPM_LEVEL",schema="SYNDOME_BPM_DB")
public class BpmLevel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BL_ID")
	private Long blId;

	@Column(name="BL_NAME")
	private String blName;

	public BpmLevel() {
	}

	public Long getBlId() {
		return this.blId;
	}

	public void setBlId(Long blId) {
		this.blId = blId;
	}

	public String getBlName() {
		return this.blName;
	}

	public void setBlName(String blName) {
		this.blName = blName;
	}

}