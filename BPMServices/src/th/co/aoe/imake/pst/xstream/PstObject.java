package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("PstObject")
public class PstObject extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	public PstObject() {
		 
	}
	public PstObject(String[] query) {
		super();
		this.query = query;
	}
	private String[] query;
	private String[] queryUpdate;
	private String[] queryDelete;
	
	//ext
	 
	private PstMaintenance[] pstMaintenanceArray;
	private PstMaintenanceTran pstMaintenanceTran;
	private String mode;
	public String[] getQuery() {
		return query;
	}
	public void setQuery(String[] query) {
		this.query = query;
	}
	public String[] getQueryUpdate() {
		return queryUpdate;
	}
	public void setQueryUpdate(String[] queryUpdate) {
		this.queryUpdate = queryUpdate;
	}
	public String[] getQueryDelete() {
		return queryDelete;
	}
	public void setQueryDelete(String[] queryDelete) {
		this.queryDelete = queryDelete;
	}
	public PstMaintenance[] getPstMaintenanceArray() {
		return pstMaintenanceArray;
	}
	public void setPstMaintenanceArray(PstMaintenance[] pstMaintenanceArray) {
		this.pstMaintenanceArray = pstMaintenanceArray;
	}
	public PstMaintenanceTran getPstMaintenanceTran() {
		return pstMaintenanceTran;
	}
	public void setPstMaintenanceTran(PstMaintenanceTran pstMaintenanceTran) {
		this.pstMaintenanceTran = pstMaintenanceTran;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	

}
