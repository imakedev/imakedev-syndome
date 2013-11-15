package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the PST_JOB_WORK database table.
 * 
 */
@Entity
@Table(name="PST_JOB_WORK",schema="PST_DB")
public class PstJobWork implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstJobWorkPK id;

	@Column(name="PJW_CONCRETE_SPOIL")
	private String pjwConcreteSpoil;

	@Column(name="PJW_CUBIC_AMOUNT")
	private BigDecimal pjwCubicAmount;

	@Column(name="PJW_HOURS_OF_WORK")
	private BigDecimal pjwHoursOfWork;

	@Column(name="PJW_MILE")
	private BigDecimal pjwMile;

	@Column(name="PJW_TUBE")
	private BigDecimal pjwTube;

	//bi-directional many-to-one association to PstBreakDown
	@ManyToOne
	@JoinColumn(name="PBD_ID",insertable=false,updatable=false)
	private PstBreakDown pstBreakDown;

	//bi-directional one-to-one association to PstJob
	@OneToOne
	@JoinColumn(name="PJ_ID",insertable=false,updatable=false)
	private PstJob pstJob;

	//bi-directional many-to-one association to PstRoadPump
	@ManyToOne
	@JoinColumn(name="PRP_ID",insertable=false,updatable=false)
	private PstRoadPump pstRoadPump;

	public PstJobWork() {
	}

	public PstJobWorkPK getId() {
		return this.id;
	}

	public void setId(PstJobWorkPK id) {
		this.id = id;
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

}