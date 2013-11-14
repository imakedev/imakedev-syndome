package th.co.aoe.imake.pst.xstream.common;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;


@XStreamAlias("vmessage")
public class VMessage implements Serializable {

	private static final long serialVersionUID = 1L;
	@XStreamAlias("msgCode")
	private String msgCode;
	
	@XStreamAlias("msgDesc")
	private String msgDesc;
	
	private Exception exception;
	
	public VMessage(){
	}

	public VMessage(String msgCode){
		this.setMsgCode(msgCode);
	}

	public VMessage(String msgCode, String msgDesc){
		this.msgCode = msgCode;
		this.msgDesc = msgDesc;
	}

	public VMessage(String msgCode, Exception exception){
		this.setMsgCode(msgCode);
		this.setException(exception);
	}

	public VMessage(String msgCode, String msgDesc, Exception exception){
		this.msgCode = msgCode;
		this.msgDesc = msgDesc;
		this.setException(exception);
	}
	
	public Exception getException() {
		return exception;
	}
	public void setException(Exception exception) {
		this.exception = exception;
	}
	public String getMsgCode() {
		return msgCode;
	}
	public void setMsgCode(String msgCode) {
		this.msgCode = msgCode;
		
	}
	public String getMsgDesc() {
		return msgDesc;
	}
	public void setMsgDesc(String msgDesc) {
		this.msgDesc = msgDesc;
	}
	
}	
