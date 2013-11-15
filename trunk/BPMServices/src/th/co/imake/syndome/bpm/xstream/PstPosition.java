package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_POSITION database table.
 * 
 */
@XStreamAlias("PstPosition")
public class PstPosition extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long ppId;

	private String ppName;

	//bi-directional many-to-one association to PstEmployee
	/*@OneToMany(mappedBy="pstPosition")
	private List<PstEmployee> pstEmployees;*/

	public PstPosition() {
	}

	public PstPosition(Long ppId, String ppName) {
		super();
		this.ppId = ppId;
		this.ppName = ppName;
	}

	public Long getPpId() {
		return this.ppId;
	}

	public void setPpId(Long ppId) {
		this.ppId = ppId;
	}

	public String getPpName() {
		return this.ppName;
	}

	public void setPpName(String ppName) {
		this.ppName = ppName;
	}

	/*public List<PstEmployee> getPstEmployees() {
		return this.pstEmployees;
	}

	public void setPstEmployees(List<PstEmployee> pstEmployees) {
		this.pstEmployees = pstEmployees;
	}*/

}