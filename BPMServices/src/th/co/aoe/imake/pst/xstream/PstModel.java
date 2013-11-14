package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_MODEL database table.
 * 
 */
@XStreamAlias("PstModel")
public class PstModel extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pmId;

	private String pmName;

	private String pmType;

/*	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstModel1")
	private List<PstRoadPump> pstRoadPumps1;

	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstModel2")
	private List<PstRoadPump> pstRoadPumps2;*/

	public PstModel() {
	}

	public PstModel(Long pmId, String pmName, String pmType) {
		super();
		this.pmId = pmId;
		this.pmName = pmName;
		this.pmType = pmType;
	}

	public Long getPmId() {
		return this.pmId;
	}

	public void setPmId(Long pmId) {
		this.pmId = pmId;
	}

	public String getPmName() {
		return this.pmName;
	}

	public void setPmName(String pmName) {
		this.pmName = pmName;
	}

	public String getPmType() {
		return this.pmType;
	}

	public void setPmType(String pmType) {
		this.pmType = pmType;
	}

	/*public List<PstRoadPump> getPstRoadPumps1() {
		return this.pstRoadPumps1;
	}

	public void setPstRoadPumps1(List<PstRoadPump> pstRoadPumps1) {
		this.pstRoadPumps1 = pstRoadPumps1;
	}

	public List<PstRoadPump> getPstRoadPumps2() {
		return this.pstRoadPumps2;
	}

	public void setPstRoadPumps2(List<PstRoadPump> pstRoadPumps2) {
		this.pstRoadPumps2 = pstRoadPumps2;
	}
*/
}