package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_PRODUCT database table.
 * 
 */
@XStreamAlias("BpmProduct")
public class BpmProduct  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private String bpProCod;
 
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