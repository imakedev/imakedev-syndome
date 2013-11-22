package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the BPM_GROUP_MAPPING database table.
 * 
 */
@Embeddable
public class BpmGroupMappingPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="BG_ID")
	private Long bgId;

	@Column(name="BG_USERID")
	private Long bgUserid;

	@Column(name="BGL_ID")
	private Long bglId;

	public BpmGroupMappingPK() {
	}
	public Long getBgId() {
		return this.bgId;
	}
	public void setBgId(Long bgId) {
		this.bgId = bgId;
	}
	public Long getBgUserid() {
		return this.bgUserid;
	}
	public void setBgUserid(Long bgUserid) {
		this.bgUserid = bgUserid;
	}
	public Long getBglId() {
		return this.bglId;
	}
	public void setBglId(Long bglId) {
		this.bglId = bglId;
	} 
	 
}