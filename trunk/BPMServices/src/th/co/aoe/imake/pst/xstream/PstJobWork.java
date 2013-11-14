package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_JOB_WORK database table.
 * 
 */
@XStreamAlias("PstJobWork")
public class PstJobWork extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pjId;

	private Long prpId;

	private Long pbdId;

	private String pjwConcreteSpoil;

	private BigDecimal pjwCubicAmount;

	private BigDecimal pjwHoursOfWork;

	private BigDecimal pjwMile;

	private BigDecimal pjwTube;

	//bi-directional many-to-one association to PstBreakDown
	@XStreamAlias("pstBreakDown")
	private PstBreakDown pstBreakDown;

	//bi-directional one-to-one association to PstJob
	@XStreamAlias("pstJob")
	private PstJob pstJob;

	//bi-directional many-to-one association to PstRoadPump
	@XStreamAlias("pstRoadPump")
	private PstRoadPump pstRoadPump;

	public PstJobWork() {
	}

	 

	public PstJobWork(Long pjId, Long prpId, Long pbdId,
			String pjwConcreteSpoil, BigDecimal pjwCubicAmount,
			BigDecimal pjwHoursOfWork, BigDecimal pjwMile, BigDecimal pjwTube,
			PstBreakDown pstBreakDown, PstJob pstJob, PstRoadPump pstRoadPump) {
		super();
		this.pjId = pjId;
		this.prpId = prpId;
		this.pbdId = pbdId;
		this.pjwConcreteSpoil = pjwConcreteSpoil;
		this.pjwCubicAmount = pjwCubicAmount;
		this.pjwHoursOfWork = pjwHoursOfWork;
		this.pjwMile = pjwMile;
		this.pjwTube = pjwTube;
		this.pstBreakDown = pstBreakDown;
		this.pstJob = pstJob;
		this.pstRoadPump = pstRoadPump;
	}



	public String getPjwConcreteSpoil() {
		return this.pjwConcreteSpoil;
	}

	public void setPjwConcreteSpoil(String pjwConcreteSpoil) {
		this.pjwConcreteSpoil = pjwConcreteSpoil;
	}

	public BigDecimal getPjwCubicAmount() {
		return this.pjwCubicAmount;
	}

	public void setPjwCubicAmount(BigDecimal pjwCubicAmount) {
		this.pjwCubicAmount = pjwCubicAmount;
	}

	public BigDecimal getPjwHoursOfWork() {
		return this.pjwHoursOfWork;
	}

	public void setPjwHoursOfWork(BigDecimal pjwHoursOfWork) {
		this.pjwHoursOfWork = pjwHoursOfWork;
	}

	public BigDecimal getPjwMile() {
		return this.pjwMile;
	}

	public void setPjwMile(BigDecimal pjwMile) {
		this.pjwMile = pjwMile;
	}

	public BigDecimal getPjwTube() {
		return this.pjwTube;
	}

	public void setPjwTube(BigDecimal pjwTube) {
		this.pjwTube = pjwTube;
	}

	public PstBreakDown getPstBreakDown() {
		return this.pstBreakDown;
	}

	public void setPstBreakDown(PstBreakDown pstBreakDown) {
		this.pstBreakDown = pstBreakDown;
	}

	public PstJob getPstJob() {
		return this.pstJob;
	}

	public void setPstJob(PstJob pstJob) {
		this.pstJob = pstJob;
	}

	public PstRoadPump getPstRoadPump() {
		return this.pstRoadPump;
	}

	public void setPstRoadPump(PstRoadPump pstRoadPump) {
		this.pstRoadPump = pstRoadPump;
	}



	public Long getPjId() {
		return pjId;
	}



	public void setPjId(Long pjId) {
		this.pjId = pjId;
	}



	public Long getPrpId() {
		return prpId;
	}



	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}



	public Long getPbdId() {
		return pbdId;
	}



	public void setPbdId(Long pbdId) {
		this.pbdId = pbdId;
	}

}