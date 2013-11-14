package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;


/**
 * The persistent class for the XLS database table.
 * 
 */
@Entity
@Table(name="XLS")
public class Xls implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Lob
	@Column(name="DATA_XLS")
	private byte[] dataXls;

	public Xls() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public byte[] getDataXls() {
		return this.dataXls;
	}

	public void setDataXls(byte[] dataXls) {
		this.dataXls = dataXls;
	}

}