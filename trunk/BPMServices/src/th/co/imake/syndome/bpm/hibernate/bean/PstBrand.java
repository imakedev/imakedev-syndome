package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_BRAND database table.
 * 
 */
@Entity
@Table(name="PST_BRAND",schema="PST_DB")
public class PstBrand implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PB_ID")
	private Long pbId;

	@Column(name="PB_NAME")
	private String pbName;

	@Column(name="PB_TYPE")
	private String pbType;

	//bi-directional many-to-one association to PstRoadPump
	/*@OneToMany(mappedBy="pstBrand1")
	private List<PstRoadPump> pstRoadPumps1;

	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstBrand2")
	private List<PstRoadPump> pstRoadPumps2;

	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstBrand3")
	private List<PstRoadPump> pstRoadPumps3;*/

	public PstBrand() {
	}

	public Long getPbId() {
		return this.pbId;
	}

	public void setPbId(Long pbId) {
		this.pbId = pbId;
	}

	public String getPbName() {
		return this.pbName;
	}

	public void setPbName(String pbName) {
		this.pbName = pbName;
	}

	public String getPbType() {
		return this.pbType;
	}

	public void setPbType(String pbType) {
		this.pbType = pbType;
	}

	/*public List<PstRoadPump> getPstRoadPumps1() {
		return this.pstRoadPumps1;
	}

	public void setPstRoadPumps1(List<PstRoadPump> pstRoadPumps1) {
		this.pstRoadPumps1 = pstRoadPumps1;
	}

	public List<PstRoadPump> getPstRoadPumps2() {
		return this.pstRoadPumps2;
	}

	public void setPstRoadPumps2(List<PstRoadPump> pstRoadPumps2) {
		this.pstRoadPumps2 = pstRoadPumps2;
	}

	public List<PstRoadPump> getPstRoadPumps3() {
		return this.pstRoadPumps3;
	}

	public void setPstRoadPumps3(List<PstRoadPump> pstRoadPumps3) {
		this.pstRoadPumps3 = pstRoadPumps3;
	}*/

}