package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the PST_JOB_EMPLOYEE database table.
 * 
 */
@Entity
@Table(name="PST_JOB_EMPLOYEE",schema="PST_DB")
public class PstJobEmployee implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstJobEmployeePK id;

	@Column(name="PJE_AMOUNT")
	private BigDecimal pjeAmount;

	@Column(name="PJE_EXC_INC")
	private String pjeExcInc;

	@Column(name="PJE_PERCENT_CUBIC")
	private BigDecimal pjePercentCubic;

	//bi-directional many-to-one association to PstEmployee
	@ManyToOne
	@JoinColumn(name="PE_ID",insertable=false,updatable=false)
	private PstEmployee pstEmployee;

	//bi-directional many-to-one association to PstJob
	@ManyToOne
	@JoinColumn(name="PJ_ID",insertable=false,updatable=false)
	private PstJob pstJob;

	@ManyToOne
	@JoinColumn(name="PRP_ID",insertable=false,updatable=false)
	private PstRoadPump pstRoadPump;
	
	public PstJobEmployee() {
	}

	public PstJobEmployeePK getId() {
		return this.id;
	}

	public void setId(PstJobEmployeePK id) {
		this.id = id;
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

	public PstRoadPump getPstRoadPump() {
		return pstRoadPump;
	}

	public void setPstRoadPump(PstRoadPump pstRoadPump) {
		this.pstRoadPump = pstRoadPump;
	}

}