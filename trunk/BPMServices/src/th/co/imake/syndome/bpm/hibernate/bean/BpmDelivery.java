package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_DELIVERY database table.
 * 
 */
@Entity
@Table(name="BPM_DELIVERY",schema="SYNDOME_BPM_DB")
public class BpmDelivery implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BD_ID")
	private Long bdId;

	@Column(name="BD_NAME")
	private String bdName;

	public BpmDelivery() {
	}

	public Long getBdId() {
		return this.bdId;
	}

	public void setBdId(Long bdId) {
		this.bdId = bdId;
	}

	public String getBdName() {
		return this.bdName;
	}

	public void setBdName(String bdName) {
		this.bdName = bdName;
	}

}