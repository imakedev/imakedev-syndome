package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_GROUP database table.
 * 
 */
@Entity
@Table(name="BPM_GROUP",schema="SYNDOME_BPM_DB")
public class BpmGroup implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BG_ID")
	private Long bgId;

	@Column(name="BG_NAME")
	private String bgName;

	public BpmGroup() {
	}

	public Long getBgId() {
		return this.bgId;
	}

	public void setBgId(Long bgId) {
		this.bgId = bgId;
	}

	public String getBgName() {
		return this.bgName;
	}

	public void setBgName(String bgName) {
		this.bgName = bgName;
	}

}