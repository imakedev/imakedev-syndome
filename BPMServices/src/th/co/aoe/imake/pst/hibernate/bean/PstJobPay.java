package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the PST_JOB_PAY database table.
 * 
 */
@Entity
@Table(name="PST_JOB_PAY",schema="PST_DB")
public class PstJobPay implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstJobPayPK id;

	@Column(name="PJP_AMOUNT")
	private BigDecimal pjpAmount;

	//bi-directional many-to-one association to PstCost
	@ManyToOne
	@JoinColumn(name="PC_ID",insertable=false,updatable=false)
	private PstCost pstCost;

	//bi-directional one-to-one association to PstJob
	@OneToOne
	@JoinColumn(name="PJ_ID",insertable=false,updatable=false)
	private PstJob pstJob;

	public PstJobPay() {
	}

	public PstJobPayPK getId() {
		return this.id;
	}

	public void setId(PstJobPayPK id) {
		this.id = id;
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

}