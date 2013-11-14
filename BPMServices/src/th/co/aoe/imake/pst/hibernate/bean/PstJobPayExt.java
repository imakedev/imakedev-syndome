package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the PST_JOB_PAY_EXT database table.
 * 
 */
@Entity
@Table(name="PST_JOB_PAY_EXT",schema="PST_DB")
public class PstJobPayExt implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstJobPayExtPK id;

	@Column(name="PJPE_AMOUNT")
	private BigDecimal pjpeAmount;

	@Column(name="PJPE_NAME")
	private String pjpeName;

	//bi-directional one-to-one association to PstJob
	@OneToOne
	@JoinColumn(name="PJ_ID",insertable=false,updatable=false)
	private PstJob pstJob;

	public PstJobPayExt() {
	}

	public PstJobPayExtPK getId() {
		return this.id;
	}

	public void setId(PstJobPayExtPK id) {
		this.id = id;
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

}