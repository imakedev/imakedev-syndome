package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_REPAIRING_EXPEND_ITEM database table.
 * 
 */
@XStreamAlias("BpmRepairingExpendItem")
public class BpmRepairingExpendItem  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long brId;
 
	private String amount;
 
	private String costPerUnit;
 
	private String custChange; 
	
	private String expendCode;
 
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