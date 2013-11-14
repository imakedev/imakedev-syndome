package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_ROAD_PUMP_DEACTIVE_MAPPING database table.
 * 
 */
@XStreamAlias("PstRoadPumpDeactiveMapping")
public class PstRoadPumpDeactiveMapping extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;


	private Long prpId;

	private Long pwtId;

	private Long pdId;

	//bi-directional many-to-one association to PstDepartment
	@XStreamAlias("pstDepartment")
	private PstDepartment pstDepartment;

	//bi-directional many-to-one association to PstWorkType
	@XStreamAlias("pstWorkType")
	private PstWorkType pstWorkType;

	public PstRoadPumpDeactiveMapping() {
	}

	 
	public PstRoadPumpDeactiveMapping(Long prpId, Long pwtId, Long pdId,
			PstDepartment pstDepartment, PstWorkType pstWorkType) {
		super();
		this.prpId = prpId;
		this.pwtId = pwtId;
		this.pdId = pdId;
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


	public Long getPrpId() {
		return prpId;
	}


	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}


	public Long getPwtId() {
		return pwtId;
	}


	public void setPwtId(Long pwtId) {
		this.pwtId = pwtId;
	}


	public Long getPdId() {
		return pdId;
	}


	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}

}