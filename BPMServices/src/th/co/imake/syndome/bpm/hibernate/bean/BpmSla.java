package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BPM_SLA database table.
 * 
 */
@Entity
@Table(name="BPM_SLA",schema="SYNDOME_BPM_DB")
public class BpmSla implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BS_ID")
	private Long bsId;

	@Column(name="BS_NAME")
	private String bsName;

	public BpmSla() {
	}

	public Long getBsId() {
		return this.bsId;
	}

	public void setBsId(Long bsId) {
		this.bsId = bsId;
	}

	public String getBsName() {
		return this.bsName;
	}

	public void setBsName(String bsName) {
		this.bsName = bsName;
	}

}