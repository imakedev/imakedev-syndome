package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_BRAND database table.
 * 
 */
@XStreamAlias("PstBrand")
public class PstBrand extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pbId;

	private String pbName;

	private String pbType;

	//bi-directional many-to-one association to PstRoadPump
	/*@OneToMany(mappedBy="pstBrand1")
	private List<PstRoadPump> pstRoadPumps1;

	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstBrand2")
	private List<PstRoadPump> pstRoadPumps2;

	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstBrand3")
	private List<PstRoadPump> pstRoadPumps3;*/

	public PstBrand() {
	}

	public PstBrand(Long pbId, String pbName, String pbType) {
		super();
		this.pbId = pbId;
		this.pbName = pbName;
		this.pbType = pbType;
	}

	public Long getPbId() {
		return this.pbId;
	}

	public void setPbId(Long pbId) {
		this.pbId = pbId;
	}

	public String getPbName() {
		return this.pbName;
	}

	public void setPbName(String pbName) {
		this.pbName = pbName;
	}

	public String getPbType() {
		return this.pbType;
	}

	public void setPbType(String pbType) {
		this.pbType = pbType;
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

	public List<PstRoadPump> getPstRoadPumps3() {
		return this.pstRoadPumps3;
	}

	public void setPstRoadPumps3(List<PstRoadPump> pstRoadPumps3) {
		this.pstRoadPumps3 = pstRoadPumps3;
	}*/

}