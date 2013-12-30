package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_LEVEL_MAPPING database table.
 * 
 */
@XStreamAlias("BpmLevelMapping")
public class BpmLevelMapping  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long blId;
 
	private Long blUserid;

	public Long getBlId() {
		return blId;
	}

	public void setBlId(Long blId) {
		this.blId = blId;
	}

	public Long getBlUserid() {
		return blUserid;
	}

	public void setBlUserid(Long blUserid) {
		this.blUserid = blUserid;
	}

	public BpmLevelMapping() {
	}
 

}