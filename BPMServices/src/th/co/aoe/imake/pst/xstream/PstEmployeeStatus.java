package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_EMPLOYEE_STATUS database table.
 * 
 */
@XStreamAlias("PstEmployeeStatus")
public class PstEmployeeStatus extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pesId;

	private String pesName;

	private Long pesWageRate;

	//bi-directional many-to-one association to PstEmployeeWorkMapping
	/*@OneToMany(mappedBy="pstEmployeeStatus")
	private List<PstEmployeeWorkMapping> pstEmployeeWorkMappings;*/

	public PstEmployeeStatus() {
	}

	public PstEmployeeStatus(Long pesId, String pesName, Long pesWageRate) {
		super();
		this.pesId = pesId;
		this.pesName = pesName;
		this.pesWageRate = pesWageRate;
	}

	public Long getPesId() {
		return this.pesId;
	}

	public void setPesId(Long pesId) {
		this.pesId = pesId;
	}

	public String getPesName() {
		return this.pesName;
	}

	public void setPesName(String pesName) {
		this.pesName = pesName;
	}

	public Long getPesWageRate() {
		return this.pesWageRate;
	}

	public void setPesWageRate(Long pesWageRate) {
		this.pesWageRate = pesWageRate;
	}

	/*public List<PstEmployeeWorkMapping> getPstEmployeeWorkMappings() {
		return this.pstEmployeeWorkMappings;
	}

	public void setPstEmployeeWorkMappings(List<PstEmployeeWorkMapping> pstEmployeeWorkMappings) {
		this.pstEmployeeWorkMappings = pstEmployeeWorkMappings;
	}*/

}