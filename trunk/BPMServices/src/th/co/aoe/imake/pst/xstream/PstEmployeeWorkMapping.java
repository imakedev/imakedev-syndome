package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;
import java.util.Date;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_EMPLOYEE_WORK_MAPPING database table.
 * 
 */
@XStreamAlias("PstEmployeeWorkMapping")
public class PstEmployeeWorkMapping extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long peId;

	private Long pesId;

	private String prpNo;
	
	private String weekdayCollection;

	private Long[] peIds;

	private Long[] pesIds;

	private String[] prpNos;
	
	private java.util.Date pewmDateTime;

	//bi-directional many-to-one association to PstEmployee
	@XStreamAlias("pstEmployee")
	private PstEmployee pstEmployee;

	//bi-directional many-to-one association to PstEmployeeStatus
	@XStreamAlias("pstEmployeeStatus")
	private PstEmployeeStatus pstEmployeeStatus;

	public PstEmployeeWorkMapping() {
	}

	 

	public PstEmployeeWorkMapping(Long peId, Long pesId, String prpNo,
			Date pewmDateTime, PstEmployee pstEmployee,
			PstEmployeeStatus pstEmployeeStatus) {
		super();
		this.peId = peId;
		this.pesId = pesId;
		this.prpNo = prpNo;
		this.pewmDateTime = pewmDateTime;
		this.pstEmployee = pstEmployee;
		this.pstEmployeeStatus = pstEmployeeStatus;
	}



	public PstEmployee getPstEmployee() {
		return this.pstEmployee;
	}

	public void setPstEmployee(PstEmployee pstEmployee) {
		this.pstEmployee = pstEmployee;
	}

	public PstEmployeeStatus getPstEmployeeStatus() {
		return this.pstEmployeeStatus;
	}

	public void setPstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus) {
		this.pstEmployeeStatus = pstEmployeeStatus;
	}



	public Long getPeId() {
		return peId;
	}



	public void setPeId(Long peId) {
		this.peId = peId;
	}



	public Long getPesId() {
		return pesId;
	}



	public void setPesId(Long pesId) {
		this.pesId = pesId;
	}



	public String getPrpNo() {
		return prpNo;
	}



	public void setPrpNo(String prpNo) {
		this.prpNo = prpNo;
	}



	public java.util.Date getPewmDateTime() {
		return pewmDateTime;
	}

	public void setPewmDateTime(java.util.Date pewmDateTime) {
		this.pewmDateTime = pewmDateTime;
	}



	public Long[] getPeIds() {
		return peIds;
	}



	public void setPeIds(Long[] peIds) {
		this.peIds = peIds;
	}



	public Long[] getPesIds() {
		return pesIds;
	}



	public void setPesIds(Long[] pesIds) {
		this.pesIds = pesIds;
	}



	public String[] getPrpNos() {
		return prpNos;
	}



	public void setPrpNos(String[] prpNos) {
		this.prpNos = prpNos;
	}



	public String getWeekdayCollection() {
		return weekdayCollection;
	}



	public void setWeekdayCollection(String weekdayCollection) {
		this.weekdayCollection = weekdayCollection;
	}

}