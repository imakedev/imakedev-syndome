package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstEmployeeStatus;

public class EmployeeStatusForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private String pesIdArray;
	private PstEmployeeStatus pstEmployeeStatus;
	public EmployeeStatusForm() {
		pstEmployeeStatus=new PstEmployeeStatus();
	}

	public String getPesIdArray() {
		return pesIdArray;
	}

	public void setPesIdArray(String pesIdArray) {
		this.pesIdArray = pesIdArray;
	}

	public PstEmployeeStatus getPstEmployeeStatus() {
		return pstEmployeeStatus;
	}
	public void setPstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus) {
		this.pstEmployeeStatus = pstEmployeeStatus;
	}
	

}
