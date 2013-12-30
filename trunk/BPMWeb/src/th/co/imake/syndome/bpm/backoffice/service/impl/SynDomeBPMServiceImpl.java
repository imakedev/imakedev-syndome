// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:14:40 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MissExamServiceImpl.java

package th.co.imake.syndome.bpm.backoffice.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.joda.time.DateTime;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.xstream.PstObject;
import th.co.imake.syndome.bpm.xstream.User;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

// Referenced classes of package th.co.imake.syndome.bpm.exam.service.impl:
//            PostCommon

public class SynDomeBPMServiceImpl extends PostCommon
    implements SynDomeBPMService
{
	private static SimpleDateFormat format_ymd = new SimpleDateFormat("yyMMdd");
	private static SimpleDateFormat format_ym = new SimpleDateFormat("yyMM");
	private static SimpleDateFormat format_y = new SimpleDateFormat("yy");
	
	private static SimpleDateFormat format_ymd_thai = new SimpleDateFormat("yyMMdd",new Locale( "th", "TH"));
	private static SimpleDateFormat format_ym_thai = new SimpleDateFormat("yyMM",new Locale( "th", "TH"));
	private static SimpleDateFormat format_y_thai = new SimpleDateFormat("yy",new Locale( "th", "TH"));
    public SynDomeBPMServiceImpl()
    {
    }
 
		@SuppressWarnings("rawtypes")
		@Override
		public List searchObject(String query) {
			// TODO Auto-generated method stub 
			PstObject pstObject = new PstObject(new String[]{query}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		        return resultMessage.getResultListObj(); 
		 
		}
		 
		@Override
		public int executeQuery(String[] query) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(query); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); 
		 
		}
		@Override
		public int executeQuery(String[] query,List<String[]> values) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(query); 
			pstObject.setValues(values);
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE_WITH_VALUES);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); 
		 
		}
		@Override
		public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(); 
			pstObject.setQueryDelete(queryDelete);
			pstObject.setQueryUpdate(queryUpdate);
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_UPDATE);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); 
		 
		}
		
		

		@Override
		public VResultMessage searchUser(User user) {
			// TODO Auto-generated method stub
			user.setServiceName(ServiceConstant.USER_SEARCH);
		    return postMessage(user, user.getClass().getName(), "user", true);
		}

		@Override
		public String saveUser(User user) {
			// TODO Auto-generated method stub
			user.setServiceName(ServiceConstant.USER_SAVE);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        user = (User)resultMessage.getResultListObj().get(0);
	        return user.getId();
		}

		@Override
		public int updateUser(User user) {
			// TODO Auto-generated method stub
			user.setServiceName(ServiceConstant.USER_UPDATE);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        user = (User)resultMessage.getResultListObj().get(0);
	        return user.getUpdateRecord().intValue();
		}

		@Override
		public int deleteUser(User user, String service) {
			// TODO Auto-generated method stub
			user.setServiceName(service);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        user = (User)resultMessage.getResultListObj().get(0);
	        return user.getUpdateRecord().intValue();
		}

		@Override
		public User findUserById(String long1) {
			// TODO Auto-generated method stub
			User user = new User();
			user.setId(long1);
			user.setServiceName(ServiceConstant.USER_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        return (User)resultMessage.getResultListObj().get(0);
		}

		@Override
		public String getRunningNo(String module,String format_year_month_day,String digit,String local) {
			// TODO Auto-generated method stub  
			java.lang.Integer runningNo=null;
			String preFix="";
			Date d=new Date();
			DateTime dt = new DateTime(d.getTime());
			int day = dt.getDayOfMonth();
			int month = dt.getMonthOfYear();
			int year = dt.getYear();
			
			String format_date="";
			String date_format="";
			String date_running="";
			if(format_year_month_day.equals("ymd")){
				 format_date="IFNULL(DATE_FORMAT(BRN_DATE,'%Y-%m-%d'),'')  ";
				 date_format=year+"-"+(month>9?month:("0"+month))+"-"+(day>9?day:("0"+day));
				 if(local.equals("th"))
					 date_running=format_ymd_thai.format(dt.toDate());
				 else
					 date_running=format_ymd.format(dt.toDate());
					 
			}else if(format_year_month_day.equals("ym")){
				 format_date="IFNULL(DATE_FORMAT(BRN_DATE,'%Y-%m'),'')  ";
				 date_format=year+"-"+(month>9?month:("0"+month));
				 if(local.equals("th"))
					 date_running=format_ym_thai.format(dt.toDate());
				 else
					 date_running=format_ym.format(dt.toDate());
			}else if(format_year_month_day.equals("y")){
				 format_date="IFNULL(DATE_FORMAT(BRN_DATE,'%Y'),'')  ";
				 date_format=year+"";
				 if(local.equals("th"))
					 date_running=format_y_thai.format(dt.toDate());
				 else
					 date_running=format_y.format(dt.toDate());
			}
			
			
			
			String date_query="";
			
		//	String query ="SELECT BRN_NO , BRN_SYSTEM,BRN_DATE,BRN_PREFIX FROM "+ServiceConstant.SCHEMA+".BPM_RUNNING_NO where BRN_SYSTEM='"+module+"'";
			String query ="SELECT BRN_NO , BRN_SYSTEM,"+format_date+",BRN_PREFIX FROM "+ServiceConstant.SCHEMA+".BPM_RUNNING_NO where BRN_SYSTEM='"+module+"'";
			//System.out.println(query);
			PstObject pstObject = new PstObject(new String[]{query}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		        List list=resultMessage.getResultListObj(); 
		        for (int i = 0; i < list.size(); i++) {
					Object[] obj=(Object[])list.get(i);
					runningNo=(java.lang.Integer)obj[0];
					preFix=(java.lang.String)obj[3];
					date_query=((java.lang.String)obj[2]).toString();
				}
		       // System.out.println(runningNo+" date_query=>"+date_query+",date_format=>"+date_format+","+date_query.equals(date_format));
		        if(runningNo!=null && runningNo.intValue()>0){
		        	String query_update=" BRN_NO="+(runningNo+1)+"";
		        	if(!date_query.equals(date_format)){
		        		query_update="BRN_DATE='"+date_format+"',BRN_NO=2";
		        		runningNo=1;
		        	}
		        	//System.out.println(runningNo);
		        	query ="UPDATE BPM_RUNNING_NO SET "+query_update+" where BRN_SYSTEM='"+module+"'";
		        	pstObject.setQuery(new String[]{query});
		        	pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE);
			         resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
			        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
			      //  System.out.println(pstObject.getUpdateRecord().intValue()); 
		        }
		        //System.out.println(preFix+String.format("%04d", runningNo));
//		        return preFix+date_running+String.format("%04d", runningNo);  
		        return preFix+date_running+String.format("%0"+digit+"d", runningNo);  
		}

		 public static void main(String[] args) {
			 SynDomeBPMServiceImpl impl=new SynDomeBPMServiceImpl(); 
			/* String role_sql="SELECT bpm_role_type_name FROM "+ServiceConstant.SCHEMA+".BPM_ROLE_MAPPING mapping left join " +
		       	  		" "+ServiceConstant.SCHEMA+".BPM_ROLE_TYPE role_type on mapping.bpm_role_type_id=role_type.bpm_role_type_id " +
		       	  		" where mapping.bpm_role_id=1" ; 
			 List list=impl.searchObject(role_sql);
			 //System.out.println(((Object[])list.get(0))[2]);
			 System.out.println((list.get(0)));*/
			System.out.println(impl.getRunningNo("SALE_ORDER_BY_YEAR","y","5","th"));
			//System.out.println(String.format("%04d", 1));
		}

}
