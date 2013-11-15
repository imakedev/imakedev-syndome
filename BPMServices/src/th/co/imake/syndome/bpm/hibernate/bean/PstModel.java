package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_MODEL database table.
 * 
 */
@Entity
@Table(name="PST_MODEL",schema="PST_DB")
public class PstModel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PM_ID")
	private Long pmId;

	@Column(name="PM_NAME")
	private String pmName;

	@Column(name="PM_TYPE")
	private String pmType;

/*	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstModel1")
	private List<PstRoadPump> pstRoadPumps1;

	//bi-directional many-to-one association to PstRoadPump
	@OneToMany(mappedBy="pstModel2")
	private List<PstRoadPump> pstRoadPumps2;*/

	public PstModel() {
	}

	public Long getPmId() {
		return this.pmId;
	}

	public void setPmId(Long pmId) {
		this.pmId = pmId;
	}

	public String getPmName() {
		return this.pmName;
	}

	public void setPmName(String pmName) {
		this.pmName = pmName;
	}

	public String getPmType() {
		return this.pmType;
	}

	public void setPmType(String pmType) {
		this.pmType = pmType;
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
*/
}