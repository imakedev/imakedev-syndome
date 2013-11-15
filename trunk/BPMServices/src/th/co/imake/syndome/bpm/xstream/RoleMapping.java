package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("RoleMapping")
public class RoleMapping  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long rcId; 

	private Long rtId;
	
	private String[] rtIds;

	public Long getRcId() {
		return rcId;
	}

	public void setRcId(Long rcId) {
		this.rcId = rcId;
	}

	public Long getRtId() {
		return rtId;
	}

	public void setRtId(Long rtId) {
		this.rtId = rtId;
	}

	public String[] getRtIds() {
		return rtIds;
	}

	public void setRtIds(String[] rtIds) {
		this.rtIds = rtIds;
	}
	
}
