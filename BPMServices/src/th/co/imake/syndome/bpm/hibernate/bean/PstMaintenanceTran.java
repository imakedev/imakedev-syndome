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
 * The persistent class for the PST_MAINTENANCE_TRAN database table.
 * 
 */
@Entity
@Table(name="PST_MAINTENANCE_TRAN")
public class PstMaintenanceTran implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstMaintenanceTranPK id;

	@Column(name="PMAINTENANCE_CUBIC_AMOUNT")
	private BigDecimal pmaintenanceCubicAmount;

	@Column(name="PMAINTENANCE_CUBIC_AMOUNT_OLD")
	private BigDecimal pmaintenanceCubicAmountOld;

	@Column(name="PMAINTENANCE_DAYS_OF_WORK")
	private BigDecimal pmaintenanceDaysOfWork;

	@Column(name="PMAINTENANCE_DAYS_OF_WORK_OLD")
	private BigDecimal pmaintenanceDaysOfWorkOld;

	@Column(name="PMAINTENANCE_HOURS_OF_WORK")
	private BigDecimal pmaintenanceHoursOfWork;

	@Column(name="PMAINTENANCE_HOURS_OF_WORK_OLD")
	private BigDecimal pmaintenanceHoursOfWorkOld;

	@Column(name="PMAINTENANCE_MILE")
	private BigDecimal pmaintenanceMile;

	@Column(name="PMAINTENANCE_MILE_OLD")
	private BigDecimal pmaintenanceMileOld;
	

	@ManyToOne
	@JoinColumn(name="PRP_ID",insertable=false,updatable=false)
	private PstRoadPump pstRoadPump;


	public PstMaintenanceTran() {
	}

	public PstMaintenanceTranPK getId() {
		return this.id;
	}

	public void setId(PstMaintenanceTranPK id) {
		this.id = id;
	}

	public BigDecimal getPmaintenanceCubicAmount() {
		return this.pmaintenanceCubicAmount;
	}

	public void setPmaintenanceCubicAmount(BigDecimal pmaintenanceCubicAmount) {
		this.pmaintenanceCubicAmount = pmaintenanceCubicAmount;
	}

	public BigDecimal getPmaintenanceCubicAmountOld() {
		return this.pmaintenanceCubicAmountOld;
	}

	public void setPmaintenanceCubicAmountOld(BigDecimal pmaintenanceCubicAmountOld) {
		this.pmaintenanceCubicAmountOld = pmaintenanceCubicAmountOld;
	}

	public BigDecimal getPmaintenanceDaysOfWork() {
		return this.pmaintenanceDaysOfWork;
	}

	public void setPmaintenanceDaysOfWork(BigDecimal pmaintenanceDaysOfWork) {
		this.pmaintenanceDaysOfWork = pmaintenanceDaysOfWork;
	}

	public BigDecimal getPmaintenanceDaysOfWorkOld() {
		return this.pmaintenanceDaysOfWorkOld;
	}

	public void setPmaintenanceDaysOfWorkOld(BigDecimal pmaintenanceDaysOfWorkOld) {
		this.pmaintenanceDaysOfWorkOld = pmaintenanceDaysOfWorkOld;
	}

	public BigDecimal getPmaintenanceHoursOfWork() {
		return this.pmaintenanceHoursOfWork;
	}

	public void setPmaintenanceHoursOfWork(BigDecimal pmaintenanceHoursOfWork) {
		this.pmaintenanceHoursOfWork = pmaintenanceHoursOfWork;
	}

	public BigDecimal getPmaintenanceHoursOfWorkOld() {
		return this.pmaintenanceHoursOfWorkOld;
	}

	public void setPmaintenanceHoursOfWorkOld(BigDecimal pmaintenanceHoursOfWorkOld) {
		this.pmaintenanceHoursOfWorkOld = pmaintenanceHoursOfWorkOld;
	}

	public BigDecimal getPmaintenanceMile() {
		return this.pmaintenanceMile;
	}

	public void setPmaintenanceMile(BigDecimal pmaintenanceMile) {
		this.pmaintenanceMile = pmaintenanceMile;
	}

	public BigDecimal getPmaintenanceMileOld() {
		return this.pmaintenanceMileOld;
	}

	public void setPmaintenanceMileOld(BigDecimal pmaintenanceMileOld) {
		this.pmaintenanceMileOld = pmaintenanceMileOld;
	}

}