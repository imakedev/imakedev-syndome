package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_PM_MA database table.
 * 
 */
@XStreamAlias("BpmPmMa")
public class BpmPmMa  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bpmmaId;
 
	private String bpmmaName;

	public BpmPmMa() {
	}

	public Long getBpmmaId() {
		return this.bpmmaId;
	}

	public void setBpmmaId(Long bpmmaId) {
		this.bpmmaId = bpmmaId;
	}

	public String getBpmmaName() {
		return this.bpmmaName;
	}

	public void setBpmmaName(String bpmmaName) {
		this.bpmmaName = bpmmaName;
	}

}