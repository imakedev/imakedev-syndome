package th.co.imake.syndome.bpm.hibernate;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.joda.time.DateTime;
import org.springframework.beans.BeanUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.BpmCallCenterService;
import th.co.imake.syndome.bpm.xstream.BpmCallCenter;
@Repository
@Transactional
public class HibernateBpmCallCenter extends HibernateCommon implements BpmCallCenterService {
	private static SimpleDateFormat format_ym = new SimpleDateFormat("yyMM");
	//private static SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
	 //2012-05-21 23:59:59.0
	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Override
	public BpmCallCenter findBpmCallCenterById(String bccNo)
			throws DataAccessException {

		// TODO Auto-generated method stub
		th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter bpmCallCenter = null;
		th.co.imake.syndome.bpm.xstream.BpmCallCenter xntcCalendarReturn =null;
		Session session=sessionAnnotationFactory.getCurrentSession();
		Query query=session.createQuery(" select bpmCallCenter from BpmCallCenter bpmCallCenter where bpmCallCenter.bccNo=:bccNo ");
		query.setParameter("bccNo", bccNo);
		String bsjJobStatusStr="";
		Object obj=query.uniqueResult(); 	 
		if(obj!=null){
			bpmCallCenter=(th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter)obj;
			xntcCalendarReturn= new th.co.imake.syndome.bpm.xstream.BpmCallCenter();
		
			BeanUtils.copyProperties(bpmCallCenter,xntcCalendarReturn,new String[]{"coopGroup","coopAccount"});
			String queryString ="SELECT BCC_NO , SBJ_JOB_STATUS  FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB where BCC_NO='"+bccNo+"'";
			
			  query=session.createSQLQuery(queryString);
			// bsjJobStatus
/*			 List list=	query.list();
		    for (int i = 0; i < list.size(); i++) {*/
				obj=query.uniqueResult();
				if(obj!=null){
					Object[] sv=(Object[])obj;
					int bsjJobStatus=(java.lang.Integer)sv[1];
					switch (bsjJobStatus) {
					case 1:
						bsjJobStatusStr="รับเครื่อง/เช็คไซต์";
						break;
					case 2:
						bsjJobStatusStr="เสนอราคา";
						break;
					case 3:
						bsjJobStatusStr="รออนุมัติซ่อม";
						break;
					case 4:
						bsjJobStatusStr="ซ่อม";
						break;
					case 5:
						bsjJobStatusStr="ส่งเครื่อง";
						break;
					case 6:
						bsjJobStatusStr="ตรวจสอบเอกสาร";
						break;
					case 7:
						bsjJobStatusStr="ปิดงานเรียบร้อย";
						break;

					default:
						break;
					} 
				} 
		 	}
		xntcCalendarReturn.setBsjJobStatus(bsjJobStatusStr);
	  return xntcCalendarReturn;
	
	}
	@Override
	public String saveBpmCallCenter(
			th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter transientInstance)
			throws DataAccessException { 
		// TODO Auto-generated method stub
		String recordReturn="";
		java.lang.Integer runningNo=null;
		String preFix="";
		String date_query="";
		String digit="4";
		Date d=new Date();
		DateTime dt = new DateTime(d.getTime());
		int day = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();
		 
		String date_running=""; 
		
		 date_running=format_ym.format(dt.toDate());
		String format_date="IFNULL(DATE_FORMAT(BRN_DATE,'%Y-%m'),'')  ";
		String date_format=year+"-"+(month>9?month:("0"+month));
		Session session=sessionAnnotationFactory.getCurrentSession();
		String queryString ="SELECT BRN_NO , BRN_SYSTEM,"+format_date+",BRN_PREFIX FROM "+ServiceConstant.SCHEMA+".BPM_RUNNING_NO where BRN_SYSTEM='CALL_CENTER'";
		
		Query query=session.createSQLQuery(queryString);
		
		 List list=	query.list();
	    for (int i = 0; i < list.size(); i++) {
			Object[] obj=(Object[])list.get(i);
			runningNo=(java.lang.Integer)obj[0];
			preFix=(java.lang.String)obj[3];
			date_query=((java.lang.String)obj[2]).toString();
		}
	  
	//	ym","4","en"
		   
	       // System.out.println(runningNo+" date_query=>"+date_query+",date_format=>"+date_format+","+date_query.equals(date_format));
	        if(runningNo!=null && runningNo.intValue()>0){
	        	String query_update=" BRN_NO="+(runningNo+1)+"";
	        	if(!date_query.equals(date_format)){  
	        		 System.out.println("date_query->"+date_query);
	   				 format_date="IFNULL(DATE_FORMAT(BRN_DATE,'%Y-%m'),'')  ";
	   				// date_format=year+"-"+(month>9?month:("0"+month)+"-01"); 
	   				date_format=year+"-"+(month>9?month:("0"+month))+"-01"; 
	   				 System.out.println("date_format->"+date_format);
	   			//2014-10+(month>9?month:("0"+month))+"-01"; 
	        	  query_update="BRN_DATE='"+date_format+"',BRN_NO=2";
	        		runningNo=1;
	        	}
	        	//System.out.println(runningNo);
	        	queryString ="UPDATE BPM_RUNNING_NO SET "+query_update+" where BRN_SYSTEM='CALL_CENTER'";
	        	System.out.println("queryString->"+queryString);
	        	query= session.createSQLQuery(queryString);
				 query.executeUpdate(); 
		        // System.out.println(resultMessage);
		       // pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		      //  System.out.println(pstObject.getUpdateRecord().intValue()); 
	        }
	        recordReturn=preFix+date_running+String.format("%0"+digit+"d", runningNo);
	        transientInstance.setBccNo(recordReturn);
			Object obj_return = session.save(transientInstance);
		 //  System.out.println("obj_return->"+obj_return);
			/*if(obj_return!=null){
				recordReturn =(Long) obj_return;
			}*/
		  
		 return recordReturn;
	
	
	} 
}
