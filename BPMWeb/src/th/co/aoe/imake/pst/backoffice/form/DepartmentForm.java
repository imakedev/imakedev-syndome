package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstDepartment;

public class DepartmentForm extends CommonForm implements Serializable {

		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		private PstDepartment pstDepartment;
		public DepartmentForm() {
			pstDepartment=new PstDepartment();
		}
		public PstDepartment getPstDepartment() {
			return pstDepartment;
		}
		public void setPstDepartment(PstDepartment pstDepartment) {
			this.pstDepartment = pstDepartment;
		}
}
