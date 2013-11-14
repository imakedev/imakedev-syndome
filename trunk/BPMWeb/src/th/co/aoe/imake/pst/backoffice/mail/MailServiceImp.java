package th.co.aoe.imake.pst.backoffice.mail;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.mail.smtp.SMTPTransport;
 

public class MailServiceImp  {

	public static void main(String[]args) throws MessagingException{
		MailServiceImp service = new MailServiceImp();
		Properties prop = new Properties();
		prop.put("recipients", "missconsultexam@missconsult.com");
	//	prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.host", "mail.missconsult.com");
		prop.put("mail.smtp.port", "25");
		prop.put("protocol", "smtp");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable","true");
		//String[] to = {"chatchai_coe11@hotmail.com","chatchai@vlink.co.th"};
		String[] to = {"chatchai@lansingbs.com"};
		String[] cc = {};
		String[] bcc = {};
		MailModel mail = new MailModel();
		mail.setMailSubject("ขอเทส หน่อยนะครับ");
		mail.setMailFrom("missconsultexam@missconsult.com");
		mail.setMailTo(to);
		mail.setMailCc(cc);
		mail.setMailBcc(bcc);
		//mail.setMailFrom("bangorns@pttep.com");
		mail.setMailContent("<h3>hello world !</h3>");
		
		
		service.HtmlSendMail(prop, mail);
	}

	public boolean HtmlSendMail(Properties prop,MailModel mail) {

	 
		boolean chkMail = false;
		Session session = Session.getDefaultInstance(prop, null);
		session.setDebug(true);
//		 create a message
		MimeMessage msg = new MimeMessage(session);
		 
		try {			
			msg.setHeader("Content-Transfert-Encoding","8Bit");		
			 
		} catch (MessagingException e) {			
			e.printStackTrace();
			////ln("error mimeMessage : "+e);
		}

		InternetAddress addressFrom = null;
		
		try {			
			addressFrom = new InternetAddress(mail.getMailFrom());
			 
		} catch (AddressException e) {
			e.printStackTrace();
			////ln("error addressFrom : "+ e);	
		}
		
		
		try {
			addressFrom.setPersonal(mail.getMailFrom(), "UTF-8");
			 
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			////ln("error UnsupportedEncodingException : "+ e);
		}

		try {
			msg.setFrom(addressFrom);
		} catch (MessagingException e) {
			 
			////ln("error MessagingException : "+ e);
		}
		
		String[] to = mail.getMailTo();
		
		////ln("to lenght : "+to.length);
		
		InternetAddress[] addressTo = new InternetAddress[to.length];
		try {
			for(int i=0;i<to.length;i++){
				/*//ln(i+" "+to[i]);
				//ln("address length : "+addressTo.length);*/
			addressTo[i] = new InternetAddress(to[i]);
			}
		} catch (AddressException e) {

			 e.printStackTrace();
			////ln("error AddressException : "+ e);
		}
		
		if(null != mail.getMailCc() && mail.getMailCc().length > 0){
			 
			String[] cc = mail.getMailCc();
		//	//ln("cc length : "+cc.length);
			InternetAddress[] addressCc = new InternetAddress[cc.length];
			try {
				for(int i=0;i<cc.length;i++){
					addressCc[i] = new InternetAddress(cc[i]);
				}
//				addressCc[0] = new InternetAddress("suriya@vlink.co.th");
//				addressCc[1] = new InternetAddress("tel66894576005@gmail.com");
			} catch (AddressException e) {

				e.printStackTrace();
				////ln("error AddressException : "+ e);
			}
			
			try {
				msg.setRecipients(Message.RecipientType.CC, addressCc);
			} catch (MessagingException e) {
				
				e.printStackTrace();
				////ln("error MessagingException : "+ e);
				
			}
		}
		
		if(null != mail.getMailBcc() && mail.getMailBcc().length > 0){
			 
			String[] bcc = mail.getMailBcc();
			////ln("bcc length : "+bcc.length);
			InternetAddress[] addressBcc = new InternetAddress[bcc.length];
			try {
				for(int i=0;i<bcc.length;i++){
					addressBcc[i] = new InternetAddress(bcc[i]);
				}
			} catch (AddressException e) {

				e.printStackTrace();
				////ln("error AddressException : "+ e);
			}
			
			try {
				msg.setRecipients(Message.RecipientType.BCC, addressBcc);
			} catch (MessagingException e) {
				
				e.printStackTrace();
				////ln("error MessagingException : "+ e);
				
			}
		}
		
		
		try {
			msg.setRecipients(Message.RecipientType.TO, addressTo);
			msg.setContent(mail.getMailContent(), "text/html; charset=UTF-8");
			msg.setSubject(mail.getMailSubject(), "UTF-8");
			msg.setHeader("X-Priority","1");
		} catch (MessagingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		////ln("sending..");

		
	    SMTPTransport t =null;
		try {
			t = (SMTPTransport)session.getTransport("smtp");
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     
			try {
				//if(isAuthen)
					//t.connect("smtp.gmail.com", "chatchai@vlink.co.th", "015482543a6ee6acoder");
				t.connect("mail.missconsult.com", "missconsultexam@missconsult.com", "#missc$%");
				//else
				//	t.connect();
					//for (int i = 0; i < msgArray.length; i++) {
						//logger.debug("Chatchai Debug==>"+msgArray[0].getAllRecipients().toString());
					//	t.sendMessage(arg0, arg1)send(msgArray[i]);
						t.sendMessage(msg, msg.getAllRecipients());
					
					//}
					
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				//e.printStackTrace();
				//continue;
				e.printStackTrace();
			} 
			  finally {			 
		    	try {
					t.close();
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
		    }
		return chkMail;
	}

	 

}
