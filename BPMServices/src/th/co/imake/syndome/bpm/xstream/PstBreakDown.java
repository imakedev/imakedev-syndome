package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_BREAK_DOWN database table.
 * 
 */
@XStreamAlias("PstBreakDown")
public class PstBreakDown extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pbdId;

	private String pbdName;

	private String pbdUid;

	//bi-directional many-to-one association to PstJobWork
	/*@OneToMany(mappedBy="pstBreakDown")
	private List<PstJobWork> pstJobWorks;
*/
	public PstBreakDown() {
	}

	public PstBreakDown(Long pbdId, String pbdName, String pbdUid) {
		super();
		this.pbdId = pbdId;
		this.pbdName = pbdName;
		this.pbdUid = pbdUid;
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