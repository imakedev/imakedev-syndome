package th.co.imake.syndome.bpm.hibernate;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.PstObjectService;
import th.co.imake.syndome.bpm.xstream.common.VMessage;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;
@Repository
@Transactional
public class HibernatePstObject extends HibernateCommon implements PstObjectService {

//	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER); HH:mm:ss
	 private static SimpleDateFormat format1 = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
	 private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy");
		private static final Logger logger1 = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
		//private static final Logger logger2 = Logger.getRootLogger();  
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@SuppressWarnings("rawtypes")
	@Override
	//public List searchObject(String query) throws DataAccessException {
	public VResultMessage searchObject(String query) throws DataAccessException {
		// TODO Auto-generated method stub
		VResultMessage vresultMessage = new VResultMessage();
		VMessage resultMessage =new VMessage();
		String msgCode="ok";
		String msgDesc="ok";
		try{ 
			 // System.out.println("query->"+query);
		    List result= this.sessionAnnotationFactory
				.getCurrentSession()
				.createSQLQuery(query).list();
		    if(result!=null && result.size()>0){ 
		    	//return result;
		    	vresultMessage.setResultListObj(result);
		    	//	Object obj[] =(Object[])result.get(i); 
		    }
		}catch (Exception e) {
			// TODO: handle exception
			//;
			System.err.println("error searchObject->"+query);
			logger1.error("error log1 searchObject->"+query);
			//logger2.error("error log2 searchObject->"+query);
			msgCode="error";
			if(e.getCause()!=null)
				msgDesc=e.getCause().getMessage();
			else
				msgDesc=e.getMessage();
			resultMessage.setException(e);
			e.printStackTrace();
			
		}finally{ 
			resultMessage.setMsgDesc(msgDesc);
			resultMessage.setMsgCode(msgCode);
			vresultMessage.setResultMessage(resultMessage); 
		}
		return vresultMessage;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	@Override
	//public int executeQuery(String[] str) throws DataAccessException {
	public VResultMessage  executeQuery(String[] str) throws DataAccessException {
		// TODO Auto-generated method stub
		VResultMessage vresultMessage = new VResultMessage();
		VMessage resultMessage =new VMessage();
		String msgCode="ok";
		String msgDesc="ok";
		Session session=sessionAnnotationFactory.getCurrentSession();
		int returnId=0;
		Query	query=null;
		StringBuffer sb=new StringBuffer();
		try{ 
			for (int i = 0; i < str.length; i++) {
				//System.out.println("str==>"+str[i]);
			//	System.out.println(getEncode(str[i]));
				sb.setLength(0);
				sb.append(str[i]);
				query= session.createSQLQuery(str[i]);
				 returnId=returnId+query.executeUpdate();
			} 
				 
		}catch(Exception e){ 
				msgCode="error";
				if(e.getCause()!=null)
					msgDesc=e.getCause().getMessage();
				else
					msgDesc=e.getMessage();
				System.err.println("error executeQuery->"+sb.toString());
				logger1.error("error log1 searchObject->"+query);
				resultMessage.setException(e);
			/*throw new MyException(e.getMessage(), "ss");
			} catch (MyException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}*/
			
			/*System.err.println("xx->"+e.getMessage());
			System.err.println("xx->"+e.getCause().getMessage());*/
			e.printStackTrace();
		}finally{
			if (session != null) {
				session = null;
			} 
			resultMessage.setMsgDesc(msgDesc);
			resultMessage.setMsgCode(msgCode);
			vresultMessage.setResultMessage(resultMessage);
			vresultMessage.setUpdateRecord(returnId);
		}
			//	return returnId;
		return vresultMessage;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	@Override
	//public int executeQueryWithValues(String[] str,List<String[]> values) throws DataAccessException {
	public VResultMessage executeQueryWithValues(String[] str,List<String[]> values) throws DataAccessException {
	
		// TODO Auto-generated method stub
		VResultMessage vresultMessage = new VResultMessage();
		VMessage resultMessage =new VMessage();
		String msgCode="ok";
		String msgDesc="ok";
		Session session=sessionAnnotationFactory.getCurrentSession();
		int returnId=0;
		Query	query=null;
		try{ 
			for (int i = 0; i < str.length; i++) {
				//System.out.println("str2==>"+str[i]);
				query= session.createSQLQuery(str[i]);
				int j=0;
				//System.out.println(values.size());
				String[] strings=(String[])values.get(i);
				for (int k = 0; k < strings.length; k++) {
					query.setParameter(k,strings[k]);
				}
				/*for (String[] strings : values) {
					query.setParameter(j++,strings);
				}*/
				 returnId=returnId+query.executeUpdate();
			} 
				 
		}catch(Exception e){
			
			msgCode="error";
			if(e.getCause()!=null)
				msgDesc=e.getCause().getMessage();
			else
				msgDesc=e.getMessage();
			resultMessage.setException(e);
			e.printStackTrace();
		}finally{
				if (session != null) {
					session = null;
				} 
				resultMessage.setMsgDesc(msgDesc);
				resultMessage.setMsgCode(msgCode);
				vresultMessage.setResultMessage(resultMessage);
				vresultMessage.setUpdateRecord(returnId);
		}
				return vresultMessage;
	}
	private String getEncode(String fromStr) {
		byte[] bytes =null;
		try {
			bytes= fromStr.getBytes("windows-874");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} // Charset to encode into
		String s2="";
		try {
			s2 = new String(bytes, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		 byte[] encoded = null;
		 return s2;
		/*try {
			//encoded = fromStr.getBytes("ISO-8859-1");
			encoded=fromStr.getBytes("CP1252");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String returnStr=null;
		try {
			returnStr = new String(encoded, "windows-874");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		returnStr=returnStr.replaceAll("\\\\", "\\\\\\\\");
		returnStr=returnStr.replaceAll("'","\\\\'"); 
		
	   return returnStr ;*/
		//return  fromStr;
	}
	 
}
