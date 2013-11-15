package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_BREAK_DOWN database table.
 * 
 */
@Entity
@Table(name="PST_BREAK_DOWN",schema="PST_DB")
public class PstBreakDown implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PBD_ID")
	private Long pbdId;

	@Column(name="PBD_NAME")
	private String pbdName;

	@Column(name="PBD_UID")
	private String pbdUid;

	//bi-directional many-to-one association to PstJobWork
	/*@OneToMany(mappedBy="pstBreakDown")
	private List<PstJobWork> pstJobWorks;
*/
	public PstBreakDown() {
	}

	public Long getPbdId() {
		return this.pbdId;
	}

	public void setPbdId(Long pbdId) {
		this.pbdId = pbdId;
	}

	public String getPbdName() {
		return this.pbdName;
	}

	public void setPbdName(String pbdName) {
		this.pbdName = pbdName;
	}

	public String getPbdUid() {
		return this.pbdUid;
	}

	public void setPbdUid(String pbdUid) {
		this.pbdUid = pbdUid;
	}

	/*public List<PstJobWork> getPstJobWorks() {
		return this.pstJobWorks;
	}

	public void setPstJobWorks(List<PstJobWork> pstJobWorks) {
		this.pstJobWorks = pstJobWorks;
	}*/

}