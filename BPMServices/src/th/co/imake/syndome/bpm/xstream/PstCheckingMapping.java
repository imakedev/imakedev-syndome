package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_CHECKING_MAPPING database table.
 * 
 */
@XStreamAlias("PstCheckingMapping")
public class PstCheckingMapping extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private String pcmType;

	private Long pcmRefTypeNo;

	private Long pdId;

	private Long pwtId;

	//bi-directional many-to-one association to PstDepartment
	@XStreamAlias("pstDepartment")
	private PstDepartment pstDepartment;

	//bi-directional many-to-one association to PstWorkType
	@XStreamAlias("pstWorkType")
	private PstWorkType pstWorkType;

	public PstCheckingMapping() {
	}

	 

	public PstCheckingMapping(String pcmType, Long pcmRefTypeNo, Long pdId,
			Long pwtId, PstDepartment pstDepartment, PstWorkType pstWorkType) {
		super();
		this.pcmType = pcmType;
		this.pcmRefTypeNo = pcmRefTypeNo;
		this.pdId = pdId;
		this.pwtId = pwtId;
		this.pstDepartment = pstDepartment;
		this.pstWorkType = pstWorkType;
	}



	public PstDepartment getPstDepartment() {
		return this.pstDepartment;
	}

	public void setPstDepartment(PstDepartment pstDepartment) {
		this.pstDepartment = pstDepartment;
	}

	public PstWorkType getPstWorkType() {
		return this.pstWorkType;
	}

	public void setPstWorkType(PstWorkType pstWorkType) {
		this.pstWorkType = pstWorkType;
	}



	public String getPcmType() {
		return pcmType;
	}



	public void setPcmType(String pcmType) {
		this.pcmType = pcmType;
	}



	public Long getPcmRefTypeNo() {
		return pcmRefTypeNo;
	}



	public void setPcmRefTypeNo(Long pcmRefTypeNo) {
		this.pcmRefTypeNo = pcmRefTypeNo;
	}



	public Long getPdId() {
		return pdId;
	}



	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}



	public Long getPwtId() {
		return pwtId;
	}



	public void setPwtId(Long pwtId) {
		this.pwtId = pwtId;
	}

}