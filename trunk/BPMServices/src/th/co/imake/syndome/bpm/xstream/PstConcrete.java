package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_CONCRETE database table.
 * 
 */
@XStreamAlias("PstConcrete")
public class PstConcrete extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pconcreteId;

	private String pconcreteName;

	//bi-directional many-to-one association to PstJob
	/*@OneToMany(mappedBy="pstConcrete")
	private List<PstJob> pstJobs;*/

	public PstConcrete() {
	}

	public PstConcrete(Long pconcreteId, String pconcreteName) {
		super();
		this.pconcreteId = pconcreteId;
		this.pconcreteName = pconcreteName;
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