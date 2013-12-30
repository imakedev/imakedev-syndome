package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_DELIVERY database table.
 * 
 */
@XStreamAlias("BpmDelivery")
public class BpmDelivery  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bdId;
 
	private String bdName;

	public BpmDelivery() {
	}

	public Long getBdId() {
		return this.bdId;
	}

	public void setBdId(Long bdId) {
		this.bdId = bdId;
	}

	public String getBdName() {
		return this.bdName;
	}

	public void setBdName(String bdName) {
		this.bdName = bdName;
	}

}