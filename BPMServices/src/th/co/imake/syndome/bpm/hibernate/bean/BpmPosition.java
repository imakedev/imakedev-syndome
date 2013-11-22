package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_POSITION database table.
 * 
 */
@Entity
@Table(name="BPM_POSITION",schema="SYNDOME_BPM_DB")
public class BpmPosition implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BP_ID")
	private Long bpId;

	@Column(name="BP_NAME")
	private String bpName;

	public BpmPosition() {
	}

	public Long getBpId() {
		return this.bpId;
	}

	public void setBpId(Long bpId) {
		this.bpId = bpId;
	}

	public String getBpName() {
		return this.bpName;
	}

	public void setBpName(String bpName) {
		this.bpName = bpName;
	}

}