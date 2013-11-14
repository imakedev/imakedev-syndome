package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_CONCRETE database table.
 * 
 */
@Entity
@Table(name="PST_CONCRETE",schema="PST_DB")
public class PstConcrete implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PCONCRETE_ID")
	private Long pconcreteId;

	@Column(name="PCONCRETE_NAME")
	private String pconcreteName;

	//bi-directional many-to-one association to PstJob
	/*@OneToMany(mappedBy="pstConcrete")
	private List<PstJob> pstJobs;*/

	public PstConcrete() {
	}

	public Long getPconcreteId() {
		return this.pconcreteId;
	}

	public void setPconcreteId(Long pconcreteId) {
		this.pconcreteId = pconcreteId;
	}

	public String getPconcreteName() {
		return this.pconcreteName;
	}

	public void setPconcreteName(String pconcreteName) {
		this.pconcreteName = pconcreteName;
	}

	/*public List<PstJob> getPstJobs() {
		return this.pstJobs;
	}

	public void setPstJobs(List<PstJob> pstJobs) {
		this.pstJobs = pstJobs;
	}
*/
}