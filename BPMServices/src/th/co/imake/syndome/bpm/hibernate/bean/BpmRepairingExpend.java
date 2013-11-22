package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_REPAIRING_EXPEND database table.
 * 
 */
@Entity
@Table(name="BPM_REPAIRING_EXPEND",schema="SYNDOME_BPM_DB")
public class BpmRepairingExpend implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BR_ID")
	private Long brId;

	@Column(name="AMOUNT")
	private String amount;

	@Column(name="DISCOUNT")
	private String discount;

	@Column(name="SERVICE_COST")
	private String serviceCost;

	@Column(name="TOTAL")
	private String total;

	@Column(name="TRAVEL_COST")
	private String travelCost;

	public BpmRepairingExpend() {
	}

	public Long getBrId() {
		return this.brId;
	}

	public void setBrId(Long brId) {
		this.brId = brId;
	}

	public String getAmount() {
		return this.amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getDiscount() {
		return this.discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getServiceCost() {
		return this.serviceCost;
	}

	public void setServiceCost(String serviceCost) {
		this.serviceCost = serviceCost;
	}

	public String getTotal() {
		return this.total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getTravelCost() {
		return this.travelCost;
	}

	public void setTravelCost(String travelCost) {
		this.travelCost = travelCost;
	}

}