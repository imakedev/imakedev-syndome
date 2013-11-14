package th.co.aoe.imake.pst.backoffice.mail;

import java.io.File;

public class MailModel {
	
	private String mailSubject;
	private String mailFrom;
	private String[] mailTo;
	private String[] mailCc;
	private String[] mailBcc;
	private String mailContent;
	private String mailText;
	private File mailAttachFile;
	public File getMailAttachFile() {
		return mailAttachFile;
	}
	public void setMailAttachFile(File mailAttachFile) {
		this.mailAttachFile = mailAttachFile;
	}
	public String[] getMailBcc() {
		return mailBcc;
	}
	public void setMailBcc(String[] mailBcc) {
		this.mailBcc = mailBcc;
	}
	public String[] getMailCc() {
		return mailCc;
	}
	public void setMailCc(String[] mailCc) {
		this.mailCc = mailCc;
	}
	public String getMailContent() {
		return mailContent;
	}
	public void setMailContent(String mailContent) {
		this.mailContent = mailContent;
	}
	public String getMailFrom() {
		return mailFrom;
	}
	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}
	public String getMailSubject() {
		return mailSubject;
	}
	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}
	public String getMailText() {
		return mailText;
	}
	public void setMailText(String mailText) {
		this.mailText = mailText;
	}
	public String[] getMailTo() {
		return mailTo;
	}
	public void setMailTo(String[] mailTo) {
		this.mailTo = mailTo;
	}
	
	
}
