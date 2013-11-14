package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the PST_CHECKING_MAPPING database table.
 * 
 */
@Entity
@Table(name="PST_CHECKING_MAPPING",schema="PST_DB")
public class PstCheckingMapping implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstCheckingMappingPK id;

	//bi-directional many-to-one association to PstDepartment
	@ManyToOne
	@JoinColumn(name="PD_ID",insertable=false,updatable=false)
	private PstDepartment pstDepartment;

	//bi-directional many-to-one association to PstWorkType
	@ManyToOne
	@JoinColumn(name="PWT_ID",insertable=false,updatable=false)
	private PstWorkType pstWorkType;

	public PstCheckingMapping() {
	}

	public PstCheckingMappingPK getId() {
		return this.id;
	}

	public void setId(PstCheckingMappingPK id) {
		this.id = id;
	}

	public PstDepartment getPstDepartment() {
		return this.pstDepartment;
	}

	public void setPstDepartment(PstDepartment pstDepartment) {
		this.pstDepartment = pstDepartment;
	}

	public PstWorkType getPstWorkType() {
		return this.pstWorkType;
	}

	public void setPstWorkType(PstWorkType pstWorkType) {
		this.pstWorkType = pstWorkType;
	}

}