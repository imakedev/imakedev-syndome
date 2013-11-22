package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BPM_GROUP_MAPPING database table.
 * 
 */
@Entity
@Table(name="BPM_GROUP_MAPPING",schema="SYNDOME_BPM_DB")
public class BpmGroupMapping implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private BpmGroupMappingPK id;

	public BpmGroupMapping() {
	}

	public BpmGroupMappingPK getId() {
		return this.id;
	}

	public void setId(BpmGroupMappingPK id) {
		this.id = id;
	}

}