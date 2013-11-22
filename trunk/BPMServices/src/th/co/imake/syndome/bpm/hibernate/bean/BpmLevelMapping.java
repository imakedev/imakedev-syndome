package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BPM_LEVEL_MAPPING database table.
 * 
 */
@Entity
@Table(name="BPM_LEVEL_MAPPING",schema="SYNDOME_BPM_DB")
public class BpmLevelMapping implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private BpmLevelMappingPK id;

	public BpmLevelMapping() {
	}

	public BpmLevelMappingPK getId() {
		return this.id;
	}

	public void setId(BpmLevelMappingPK id) {
		this.id = id;
	}

}