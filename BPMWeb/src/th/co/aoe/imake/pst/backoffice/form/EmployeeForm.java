package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstEmployee;

public class EmployeeForm  extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private String peIdArray;
	private PstEmployee pstEmployee;
	private Long ppId;
	private Long ptId;
	public EmployeeForm() {
		pstEmployee=new PstEmployee();
	}
	public String getPeIdArray() {
		return peIdArray;
	}
	public void setPeIdArray(String peIdArray) {
		this.peIdArray = peIdArray;
	}
	public PstEmployee getPstEmployee() {
		return pstEmployee;
	}
	public void setPstEmployee(PstEmployee pstEmployee) {
		this.pstEmployee = pstEmployee;
	}
	public Long getPpId() {
		return ppId;
	}
	public void setPpId(Long ppId) {
		this.ppId = ppId;
	}
	public Long getPtId() {
		return ptId;
	}
	public void setPtId(Long ptId) {
		this.ptId = ptId;
	}

}
