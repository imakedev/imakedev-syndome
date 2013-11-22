package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BPM_PRODUCT database table.
 * 
 */
@Entity
@Table(name="BPM_PRODUCT",schema="SYNDOME_BPM_DB")
public class BpmProduct implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BP_PRO_COD")
	private String bpProCod;

	@Column(name="BP_NAME")
	private String bpName;

	public BpmProduct() {
	}

	public String getBpProCod() {
		return this.bpProCod;
	}

	public void setBpProCod(String bpProCod) {
		this.bpProCod = bpProCod;
	}

	public String getBpName() {
		return this.bpName;
	}

	public void setBpName(String bpName) {
		this.bpName = bpName;
	}

}