package th.co.aoe.imake.pst.backoffice.domain;

public class Shop {
	String name;
	
	String staffName[];
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String[] getStaffName() {
		return staffName;
	}
	public void setStaffName(String[] staffName) {
		this.staffName = staffName;
	}
	public Shop() {
	} 
}
