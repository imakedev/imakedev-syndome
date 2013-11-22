package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_GROUP_LEVEL database table.
 * 
 */
@Entity
@Table(name="BPM_GROUP_LEVEL",schema="SYNDOME_BPM_DB")
public class BpmGroupLevel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BGL_ID")
	private Long bglId;

	@Column(name="BGL_NAME")
	private String bglName;

	public BpmGroupLevel() {
	}

	public Long getBglId() {
		return this.bglId;
	}

	public void setBglId(Long bglId) {
		this.bglId = bglId;
	}

	public String getBglName() {
		return this.bglName;
	}

	public void setBglName(String bglName) {
		this.bglName = bglName;
	}

}