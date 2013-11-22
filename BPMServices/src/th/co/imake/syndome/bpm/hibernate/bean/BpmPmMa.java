package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_PM_MA database table.
 * 
 */
@Entity
@Table(name="BPM_PM_MA",schema="SYNDOME_BPM_DB")
public class BpmPmMa implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BPMMA_ID")
	private Long bpmmaId;

	@Column(name="BPMMA_NAME")
	private String bpmmaName;

	public BpmPmMa() {
	}

	public Long getBpmmaId() {
		return this.bpmmaId;
	}

	public void setBpmmaId(Long bpmmaId) {
		this.bpmmaId = bpmmaId;
	}

	public String getBpmmaName() {
		return this.bpmmaName;
	}

	public void setBpmmaName(String bpmmaName) {
		this.bpmmaName = bpmmaName;
	}

}