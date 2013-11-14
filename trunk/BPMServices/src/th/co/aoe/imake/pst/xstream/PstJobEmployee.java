package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_JOB_EMPLOYEE database table.
 * 
 */
@XStreamAlias("PstJobEmployee")
public class PstJobEmployee extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pjId;

	private Long peId;
	
	private Long prpId;

	private BigDecimal pjeAmount;

	private String pjeExcInc;

	private BigDecimal pjePercentCubic;

	//bi-directional many-to-one association to PstEmployee
	@XStreamAlias("pstEmployee")
	private PstEmployee pstEmployee;

	//bi-directional many-to-one association to PstJob
	@XStreamAlias("pstJob")
	private PstJob pstJob;
	
	@XStreamAlias("pstRoadPump")
	private PstRoadPump pstRoadPump;

	public PstJobEmployee() {
	}

	 

	public PstJobEmployee(Long pjId, Long peId, Long prpId,BigDecimal pjeAmount,
			String pjeExcInc, BigDecimal pjePercentCubic,
			PstEmployee pstEmployee, PstJob pstJob) {
		super();
		this.pjId = pjId;
		this.peId = peId;
		this.prpId = prpId;
		this.pjeAmount = pjeAmount;
		this.pjeExcInc = pjeExcInc;
		this.pjePercentCubic = pjePercentCubic;
		this.pstEmployee = pstEmployee;
		this.pstJob = pstJob;
	}



	public BigDecimal getPjeAmount() {
		return this.pjeAmount;
	}

	public void setPjeAmount(BigDecimal pjeAmount) {
		this.pjeAmount = pjeAmount;
	}

	public String getPjeExcInc() {
		return this.pjeExcInc;
	}

	public void setPjeExcInc(String pjeExcInc) {
		this.pjeExcInc = pjeExcInc;
	}

	public BigDecimal getPjePercentCubic() {
		return this.pjePercentCubic;
	}

	public void setPjePercentCubic(BigDecimal pjePercentCubic) {
		this.pjePercentCubic = pjePercentCubic;
	}

	public PstEmployee getPstEmployee() {
		return this.pstEmployee;
	}

	public void setPstEmployee(PstEmployee pstEmployee) {
		this.pstEmployee = pstEmployee;
	}

	public PstJob getPstJob() {
		return this.pstJob;
	}

	public void setPstJob(PstJob pstJob) {
		this.pstJob = pstJob;
	}



	public Long getPjId() {
		return pjId;
	}



	public void setPjId(Long pjId) {
		this.pjId = pjId;
	}



	public Long getPeId() {
		return peId;
	}



	public void setPeId(Long peId) {
		this.peId = peId;
	}



	public PstRoadPump getPstRoadPump() {
		return pstRoadPump;
	}



	public void setPstRoadPump(PstRoadPump pstRoadPump) {
		this.pstRoadPump = pstRoadPump;
	}



	public Long getPrpId() {
		return prpId;
	}



	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}

}