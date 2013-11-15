package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_TITLE database table.
 * 
 */
@XStreamAlias("PstTitle")
public class PstTitle extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;


	private Long ptId;

	private String ptName;

	//bi-directional many-to-one association to PstEmployee
	/*@OneToMany(mappedBy="pstTitle")
	private List<PstEmployee> pstEmployees;*/

	public PstTitle() {
	}

	public PstTitle(Long ptId, String ptName) {
		super();
		this.ptId = ptId;
		this.ptName = ptName;
	}

	public Long getPtId() {
		return this.ptId;
	}

	public void setPtId(Long ptId) {
		this.ptId = ptId;
	}

	public String getPtName() {
		return this.ptName;
	}

	public void setPtName(String ptName) {
		this.ptName = ptName;
	}

	/*public List<PstEmployee> getPstEmployees() {
		return this.pstEmployees;
	}

	public void setPstEmployees(List<PstEmployee> pstEmployees) {
		this.pstEmployees = pstEmployees;
	}*/

}