package th.co.imake.syndome.bpm.backoffice.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VMessage;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.Dom4JDriver;

/*import th.co.vlink.utils.Pagging;
 import th.co.vlink.xstream.common.VResultMessage;
 import th.co.vlink.xstream.common.VServiceXML;
 */

public class PostCommon {
	public static final int PAGE_SIZE = 5;

	public VResultMessage postMessage(VServiceXML vserviceXML,
			@SuppressWarnings("rawtypes") Class[] className, String endPoint,
			boolean isReturn) {
		
		
		boolean haveError=false;
	 HttpPost httppost = new HttpPost("http://localhost:3000/v1/" + endPoint);
	//HttpPost httppost = new HttpPost("http://localhost:8080/BPMServices/rest/"+endPoint);

		// HttpPost httppost = new
		// HttpPost("http://10.0.20.27:3000/v1/"+endPoint);
		// Test
		// HttpPost httppost = new
		// HttpPost("http://10.2.0.94:10000/BPSService/RestletServlet/"+endPoint);

		// Production
		// http://localhost:8080/MISSExamServices/rest/missExamGroup
		// HttpPost httppost = new
		// HttpPost("http://10.2.0.76:10000/BPSService/RestletServlet/"+endPoint);

		// HttpPost httppost = new
		// HttpPost("http://10.1.1.188:10000/BPSService/RestletServlet/"+endPoint);

		XStream xstream = new XStream(new Dom4JDriver());
		/*
		 * Class c = null; try { c = Class.forName(className); } catch
		 * (ClassNotFoundException e2) { e2.printStackTrace(); }
		 */
		xstream.processAnnotations(className);
		int startIndex = 0;
		if (vserviceXML.getPagging() == null) {
			Pagging p = new Pagging();
			p.setPageNo(1);
			p.setPageSize(PAGE_SIZE);
			vserviceXML.setPagging(p);
		}
		startIndex = vserviceXML.getPagging().getPageNo() == 1 ? 0
				: (vserviceXML.getPagging().getPageNo() - 1)
						* vserviceXML.getPagging().getPageSize();
		vserviceXML.getPagging().setStartIndex(startIndex);
		String xString = xstream.toXML(vserviceXML);
		ByteArrayEntity entity = null;
		try {
			entity = new ByteArrayEntity(xString.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		entity.setContentType("application/xml");
		httppost.setEntity(entity);
		// HttpClient httpclient = HttpClients.createDefault();// new
		// DefaultHttpClient();
		VResultMessage vresultMessage = null;
		VMessage vmessage=new VMessage();
		String  msgCode="";
		String  msgDesc="";
		//CloseableHttpClient httpClient = HttpClientBuilder.create().setProxy(proxy).build(
		CloseableHttpClient httpclient = HttpClients.createDefault();// new
	try{																// DefaultHttpClient();
		
		// HttpResponse response = null;
		CloseableHttpResponse response = null;
		HttpEntity resEntity = null;
	
		InputStream in = null;
		try {
		if(httppost!=null){
			response = httpclient.execute(httppost);
			resEntity = response.getEntity();
		}
		
			if (isReturn) {
				if (resEntity != null) {

					try {
						in = resEntity.getContent();
						xstream.processAnnotations(VResultMessage.class);
						Object obj = xstream.fromXML(in);
						if (obj != null) {
							vresultMessage = (VResultMessage) obj;

							int maxRow = 0;
							if (vresultMessage.getMaxRow() != null
									&& vresultMessage.getMaxRow().length() != 0)
								maxRow = Integer.parseInt(vresultMessage
										.getMaxRow());
							int pageSize = 0;
							if (vserviceXML.getPagging() != null)
								pageSize = vserviceXML.getPagging()
										.getPageSize();
							int lastpage = (maxRow / pageSize)
									+ ((maxRow % pageSize) == 0 ? 0 : 1);
							vresultMessage.setLastpage(lastpage + "");
						}
					} catch (IllegalStateException e) {
						haveError=true;
						 msgCode="error";
							if(e.getCause()!=null)
								msgDesc=e.getCause().getMessage();
							else
								msgDesc=e.getMessage();
						vmessage.setException(e);
						e.printStackTrace();
					} catch (IOException e) {
						haveError=true;
						e.printStackTrace();
						 msgCode="error";
							if(e.getCause()!=null)
								msgDesc=e.getCause().getMessage();
							else
								msgDesc=e.getMessage();
						vmessage.setException(e);
					} finally {
						try {
							if (in != null)
								in.close();
						} catch (IOException e) {
							haveError=true;
							 msgCode="error";
								if(e.getCause()!=null)
									msgDesc=e.getCause().getMessage();
								else
									msgDesc=e.getMessage();
							vmessage.setException(e);
							e.printStackTrace();
						}
					}
				}
				try {
					EntityUtils.consume(resEntity);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					haveError=true;
					 msgCode="error";
						if(e.getCause()!=null)
							msgDesc=e.getCause().getMessage();
						else
							msgDesc=e.getMessage();
					vmessage.setException(e);
					e.printStackTrace();
				}
			}
		} catch (ClientProtocolException e) {
			// System.out.println("xxxxxxxxxx");
			haveError=true;
			 msgCode="error";
				if(e.getCause()!=null)
					msgDesc=e.getCause().getMessage();
				else
					msgDesc=e.getMessage();
			vmessage.setException(e);
			e.printStackTrace();
		} catch (IOException e) {
		//	System.out.println("yyyyyyyyyyy");
			haveError=true;
			 msgCode="error";
				if(e.getCause()!=null)
					msgDesc=e.getCause().getMessage();
				else
					msgDesc=e.getMessage();
			vmessage.setException(e);
			e.printStackTrace();
		} finally {
			try {
				response.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				haveError=true;
				 msgCode="error";
					if(e.getCause()!=null)
						msgDesc=e.getCause().getMessage();
					else
						msgDesc=e.getMessage();
				vmessage.setException(e);
				e.printStackTrace();
			}
			//System.out.println(" finallllxxxxxxxxxx");
		}
	 }  
	finally {
         try {
        	//httpclient.getConnectionManager().shutdown();
			httpclient.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			haveError=true;
			 msgCode="error";
				if(e.getCause()!=null)
					msgDesc=e.getCause().getMessage();
				else
					msgDesc=e.getMessage();
			vmessage.setException(e);
			e.printStackTrace();
		}
       // System.out.println(" finalllllllllll"+haveError);
         if(haveError){
     		vresultMessage =new VResultMessage();
     		vmessage.setMsgCode(msgCode);
     		vmessage.setMsgDesc(msgDesc);
     		vresultMessage.setResultMessage(vmessage); 
     		return vresultMessage;
     	}
     }
	/*
	 * 
	 */
	  // System.out.println("ccccccccccccccccc");
		 // httpclient.getConnectionManager().shutdown();
		return vresultMessage;
	}

	public VResultMessage postMessage(VServiceXML vserviceXML,
			String className, String endPoint, boolean isReturn) {
		@SuppressWarnings("rawtypes")
		Class c = null;
		try {
			c = Class.forName(className);
		} catch (ClassNotFoundException e2) {
			e2.printStackTrace();
		}
		@SuppressWarnings("rawtypes")
		Class[] classArray = new Class[] { c };
		// classArray[0]=c;
		return postMessage(vserviceXML, classArray, endPoint, isReturn);
	}
}
