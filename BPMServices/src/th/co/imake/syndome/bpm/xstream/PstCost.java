package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_COSTS database table.
 * 
 */
@XStreamAlias("PstCost")
public class PstCost extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pcId;

	
	private BigDecimal pcAmount;

	private String pcName;

	private String pcUid;

	private String pcUnit;
	private String pcType;
	//bi-directional many-to-one association to PstJobPay
	/*@OneToMany(mappedBy="pstCost")
	private List<PstJobPay> pstJobPays;*/

	public PstCost() {
	}

	public PstCost(Long pcId, BigDecimal pcAmount, String pcName, String pcUid,
			String pcUnit) {
		super();
		this.pcId = pcId;
		this.pcAmount = pcAmount;
		this.pcName = pcName;
		this.pcUid = pcUid;
		this.pcUnit = pcUnit;
	}

	public Long getPcId() {
		return this.pcId;
	}

	public void setPcId(Long pcId) {
		this.pcId = pcId;
	}

 

	public BigDecimal getPcAmount() {
		return pcAmount;
	}

	public void setPcAmount(BigDecimal pcAmount) {
		this.pcAmount = pcAmount;
	}

	public String getPcName() {
		return this.pcName;
	}

	public void setPcName(String pcName) {
		this.pcName = pcName;
	}

	public String getPcUid() {
		return this.pcUid;
	}

	public void setPcUid(String pcUid) {
		this.pcUid = pcUid;
	}

	public String getPcUnit() {
		return this.pcUnit;
	}

	public void setPcUnit(String pcUnit) {
		this.pcUnit = pcUnit;
	}

	public String getPcType() {
		return pcType;
	}

	public void setPcType(String pcType) {
		this.pcType = pcType;
	}

/*	public List<PstJobPay> getPstJobPays() {
		return this.pstJobPays;
	}

	public void setPstJobPays(List<PstJobPay> pstJobPays) {
		this.pstJobPays = pstJobPays;
	}
*/
}