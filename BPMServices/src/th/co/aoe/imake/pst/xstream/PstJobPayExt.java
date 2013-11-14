package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_JOB_PAY_EXT database table.
 * 
 */
@XStreamAlias("PstJobPayExt")
public class PstJobPayExt extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;


	private Long pjId;

	private Long pjpeNo;

	private BigDecimal pjpeAmount;

	private String pjpeName;

	//bi-directional one-to-one association to PstJob
	@XStreamAlias("pstJob")
	private PstJob pstJob;

	public PstJobPayExt() {
	}

	 

	public PstJobPayExt(Long pjId, Long pjpeNo, BigDecimal pjpeAmount,
			String pjpeName, PstJob pstJob) {
		super();
		this.pjId = pjId;
		this.pjpeNo = pjpeNo;
		this.pjpeAmount = pjpeAmount;
		this.pjpeName = pjpeName;
		this.pstJob = pstJob;
	}



	public BigDecimal getPjpeAmount() {
		return this.pjpeAmount;
	}

	public void setPjpeAmount(BigDecimal pjpeAmount) {
		this.pjpeAmount = pjpeAmount;
	}

	public String getPjpeName() {
		return this.pjpeName;
	}

	public void setPjpeName(String pjpeName) {
		this.pjpeName = pjpeName;
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



	public Long getPjpeNo() {
		return pjpeNo;
	}



	public void setPjpeNo(Long pjpeNo) {
		this.pjpeNo = pjpeNo;
	}

}