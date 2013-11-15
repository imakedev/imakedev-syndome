package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_JOB_PAY database table.
 * 
 */
@XStreamAlias("PstJobPay")
public class PstJobPay extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pjId;

	private Long pcId;

	private BigDecimal pjpAmount;

	//bi-directional many-to-one association to PstCost
	@XStreamAlias("pstCost")
	private PstCost pstCost;

	//bi-directional one-to-one association to PstJob
	@XStreamAlias("pstJob")
	private PstJob pstJob;

	public PstJobPay() {
	}
 

	public PstJobPay(Long pjId, Long pcId, BigDecimal pjpAmount,
			PstCost pstCost, PstJob pstJob) {
		super();
		this.pjId = pjId;
		this.pcId = pcId;
		this.pjpAmount = pjpAmount;
		this.pstCost = pstCost;
		this.pstJob = pstJob;
	}


	public BigDecimal getPjpAmount() {
		return this.pjpAmount;
	}

	public void setPjpAmount(BigDecimal pjpAmount) {
		this.pjpAmount = pjpAmount;
	}

	public PstCost getPstCost() {
		return this.pstCost;
	}

	public void setPstCost(PstCost pstCost) {
		this.pstCost = pstCost;
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


	public Long getPcId() {
		return pcId;
	}


	public void setPcId(Long pcId) {
		this.pcId = pcId;
	}

}