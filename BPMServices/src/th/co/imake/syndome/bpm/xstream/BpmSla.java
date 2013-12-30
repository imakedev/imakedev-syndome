package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_SLA database table.
 * 
 */
@XStreamAlias("BpmSla")
public class BpmSla  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bsId;
 
	private String bsName;

	public BpmSla() {
	}

	public Long getBsId() {
		return this.bsId;
	}

	public void setBsId(Long bsId) {
		this.bsId = bsId;
	}

	public String getBsName() {
		return this.bsName;
	}

	public void setBsName(String bsName) {
		this.bsName = bsName;
	}

}