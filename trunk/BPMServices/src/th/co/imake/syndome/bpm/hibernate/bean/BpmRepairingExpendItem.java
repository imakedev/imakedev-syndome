package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_REPAIRING_EXPEND_ITEM database table.
 * 
 */
@Entity
@Table(name="BPM_REPAIRING_EXPEND_ITEM",schema="SYNDOME_BPM_DB")
public class BpmRepairingExpendItem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BR_ID")
	private Long brId;

	@Column(name="AMOUNT")
	private String amount;

	@Column(name="COST_PER_UNIT")
	private String costPerUnit;

	@Column(name="CUST_CHANGE")
	private String custChange;

	@Column(name="EXPEND_CODE")
	private String expendCode;

	@Column(name="ITEM_ORDER")
	private String itemOrder;

	public BpmRepairingExpendItem() {
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

	public String getCostPerUnit() {
		return this.costPerUnit;
	}

	public void setCostPerUnit(String costPerUnit) {
		this.costPerUnit = costPerUnit;
	}

	public String getCustChange() {
		return this.custChange;
	}

	public void setCustChange(String custChange) {
		this.custChange = custChange;
	}

	public String getExpendCode() {
		return this.expendCode;
	}

	public void setExpendCode(String expendCode) {
		this.expendCode = expendCode;
	}

	public String getItemOrder() {
		return this.itemOrder;
	}

	public void setItemOrder(String itemOrder) {
		this.itemOrder = itemOrder;
	}

}