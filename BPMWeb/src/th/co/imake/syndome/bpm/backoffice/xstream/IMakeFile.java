package th.co.imake.syndome.bpm.backoffice.xstream;

import java.io.Serializable;

public class IMakeFile implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String hotlink;
	private String id;
	private String filepath;
	private String filename;
	public String getHotlink() {
		return hotlink;
	}
	public void setHotlink(String hotlink) {
		this.hotlink = hotlink;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
}
