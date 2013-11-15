package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstEmployeeWorkMapping;

public class EmployeeWorkMappingForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstEmployeeWorkMapping pstEmployeeWorkMapping; 

	private Long[] peIds;

	private Long[] pesIds;

	private String[] prpNos;
	
	 private String pewmDateTime;
	

	public EmployeeWorkMappingForm() {
		this.pstEmployeeWorkMapping = new PstEmployeeWorkMapping();
	}

	public PstEmployeeWorkMapping getPstEmployeeWorkMapping() {
		return pstEmployeeWorkMapping;
	}

	public void setPstEmployeeWorkMapping(
			PstEmployeeWorkMapping pstEmployeeWorkMapping) {
		this.pstEmployeeWorkMapping = pstEmployeeWorkMapping;
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

	public String getPewmDateTime() {
		return pewmDateTime;
	}

	public void setPewmDateTime(String pewmDateTime) {
		this.pewmDateTime = pewmDateTime;
	}

	
}
