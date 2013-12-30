package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_REPAIRING_EXPEND database table.
 * 
 */
@XStreamAlias("BpmRepairingExpend")
public class BpmRepairingExpend  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	 
	private Long brId;
 
	private String amount;
 
	private String discount;
 
	private String serviceCost;
 
	private String total;
 
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