// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:14:40 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MissExamServiceImpl.java

package th.co.imake.syndome.bpm.backoffice.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.CellReference; 
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFRow;
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
	private static SimpleDateFormat format_check = new SimpleDateFormat("dd_MM_yyyy");
	private static SimpleDateFormat format_report_so = new SimpleDateFormat("yyyy-MM-dd");
    public SynDomeBPMServiceImpl()
    {
    }
 
		@SuppressWarnings("rawtypes")
		@Override
		//public List searchObject(String query) {
		public VResultMessage searchObject(String query) {
			// TODO Auto-generated method stub 
			PstObject pstObject = new PstObject(new String[]{query}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		       /* VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		        return resultMessage.getResultListObj(); */
		 
		}
		@SuppressWarnings("rawtypes")
		@Override
		//public List searchObject(String query) {
		public VResultMessage searchServices(String bccNo) {
			// TODO Auto-generated method stub 
			PstObject pstObject = new PstObject(new String[]{bccNo}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH_SERVICE);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		       /* VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		        return resultMessage.getResultListObj(); */
		 
		}
		 
		@SuppressWarnings("rawtypes")
		@Override
		public VResultMessage searchTodoList(String serviceType,String serviceStatus,String username,String role,String page,String pageG,String isStore,String type,String key_job,String BTDL_CREATED_TIME){
			PstObject pstObject = new PstObject(new String[]{serviceType,serviceStatus,username,role,page,pageG,isStore,type,key_job,BTDL_CREATED_TIME}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH_TO_DO_LIST);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		       /* VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		        return resultMessage.getResultListObj(); */
		  
		}
		@SuppressWarnings("rawtypes")
		@Override
		public VResultMessage genPMMA(String duedate,String username,String BPMJ_NO,int pm_amount,int pm_year){
			PstObject pstObject = new PstObject(new String[]{duedate,username,BPMJ_NO,pm_amount+"",pm_year+""}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_GEN_PMMA);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		       /* VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		        return resultMessage.getResultListObj(); */
		  
		}
		
		@Override
		//public int executeQuery(String[] query) {
		public VResultMessage executeQuery(String[] query) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(query); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		  /*  VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		    pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		    return pstObject.getUpdateRecord().intValue(); */
		 
		}
		@Override
		//public int executeQuery(String[] query,List<String[]> values) {
		public VResultMessage executeQuery(String[] query,List<String[]> values) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(query); 
			pstObject.setValues(values);
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE_WITH_VALUES);
			return  postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		       /* VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); */
		 
		}
		@Override
	//	public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate) {
		public VResultMessage executeQueryUpdate(String[] queryDelete,String[] queryUpdate) {
			// TODO Auto-generated method stub
			
				 PstObject pstObject = new PstObject(); 
					pstObject.setQueryDelete(queryDelete);
					pstObject.setQueryUpdate(queryUpdate);
					pstObject.setServiceName(ServiceConstant.PST_OBJECT_UPDATE);
					return  postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
				        /*VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
				        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
				        return pstObject.getUpdateRecord().intValue();*/
		        
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
		public VResultMessage getRunningNo(String module,String format_year_month_day,String digit,String local) {
			// TODO Auto-generated method stub  
			VResultMessage resultMessage=null;
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
			  resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
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
		        	  if(format_year_month_day.equals("ymd")){
		        		   
		   			  }else if(format_year_month_day.equals("ym")){
		   				 format_date="IFNULL(DATE_FORMAT(BRN_DATE,'%Y-%m'),'')  ";
		   				 date_format=year+"-"+(month>9?month:("0"+month))+"-01";
		   				 //year+"-"+(month>9?month:("0"+month)+"-01");
		   				 
		   			  }else if(format_year_month_day.equals("y")){
		   				 format_date="IFNULL(DATE_FORMAT(BRN_DATE,'%Y'),'')  ";
		   				 date_format=year+"-01-01"; 
		   			  }
		        	  query_update="BRN_DATE='"+date_format+"',BRN_NO=2";
		        		runningNo=1;
		        	}
		        	//System.out.println(runningNo);
		        	query ="UPDATE BPM_RUNNING_NO SET "+query_update+" where BRN_SYSTEM='"+module+"'";
		        	pstObject.setQuery(new String[]{query});
		        	pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE);
			         resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
			        // System.out.println(resultMessage);
			       // pstObject = (PstObject)resultMessage.getResultListObj().get(0);
			      //  System.out.println(pstObject.getUpdateRecord().intValue()); 
		        }
		        if( resultMessage.getResultMessage().getMsgCode().equals("ok")){
		        	resultMessage.getResultMessage().setMsgDesc(preFix+date_running+String.format("%0"+digit+"d", runningNo));
		        }
		        //System.out.println(resultMessage.getResultMessage().getMsgDesc());
//		        return preFix+date_running+String.format("%04d", runningNo);  
		        return resultMessage;  
		}

		 public static void main(String[] args) {
			 SynDomeBPMServiceImpl impl=new SynDomeBPMServiceImpl(); 
			/* String role_sql="SELECT bpm_role_type_name FROM "+ServiceConstant.SCHEMA+".BPM_ROLE_MAPPING mapping left join " +
		       	  		" "+ServiceConstant.SCHEMA+".BPM_ROLE_TYPE role_type on mapping.bpm_role_type_id=role_type.bpm_role_type_id " +
		       	  		" where mapping.bpm_role_id=1" ; 
			 List list=impl.searchObject(role_sql);
			 //System.out.println(((Object[])list.get(0))[2]);
			 System.out.println((list.get(0)));*/
			 
			/* String service_type="1";
			 String username="methika";
			 String role="('ROLE_MANAGE_DELIVERY','ROLE_SALE_ORDER_ACCOUNT','ROLE_USER')";
			 String page="1";
			 String pageG="20";
			 String isStore="0";
			 String type="1";
			 impl.searchTodoList(service_type, username, role, page, pageG, isStore, type);*/
			 String duedate="29/03/2014";
			 String username="methika";
			 String BPMJ_NO="91";
			 int pm_amoutn=4;
			 int pm_year=2;
				//impl.genPMMA( duedate, username, BPMJ_NO, pm_amoutn, pm_year);
			 impl.servicesReport();
		//	System.out.println(impl.searchServices("14030011"));
			//System.out.println(String.format("%04d", 1));
		}

		public void servicesReport(){
			String time_from = "12_05_2014";
			String time_end =  "15_06_2014";
			// 1 - 7 , 8 - 9  
		//	DateTime dt3=null;
			DateTime dt_start=null;
			DateTime dt_end=null;
			String[] time_from_slit=time_from.split("_");
			List<DateTime[]> date_list=new ArrayList<DateTime[]>();
			DateTime dt1 = null;
			try {
				dt1 = new DateTime(format_check.parse(time_from));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			DateTime dt2 = null;
			try {
				dt2 = new DateTime(format_check.parse(time_end));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//System.out.println(dt1.dayOfMonth().getMaximumValue());
			int index_date=0;
			 do {
				 DateTime[] d_array=new DateTime[2];
				 dt_start=dt1;
				 dt_end=dt1.dayOfMonth().setCopy(dt1.dayOfMonth().getMaximumValue()+"");
				 if(index_date==0)
					 dt_start=dt1.dayOfMonth().setCopy(time_from_slit[0]+"");
				 else
					 dt_start=dt1.dayOfMonth().setCopy(dt1.dayOfMonth().getMinimumValue()+"");
				 
					  d_array[0]=dt_start; 
				 if(dt_end.isBefore(dt2.getMillis())){
					 System.out.println(" before ");
					 System.out.println(dt1);
					  d_array[1]=dt_end;
				 }
				 else{
					 System.out.println(" after ");
					 d_array[1]=dt2;
				 }
				 System.out.println("end-> "+dt2+",start->"+dt1);
				 System.out.println("end2-> "+d_array[1]+",start2->"+d_array[0]);
				 date_list.add(d_array);
				 dt1=dt1.plusMonths(1);
				 System.out.println("dt1 after plus -> "+dt1);
				// dt1=dt1.dayOfMonth().setCopy(dt1.dayOfMonth().getMaximumValue()+"");
				 index_date++;
				 System.out.println("index->"+index_date);
				} while (dt1.isBefore(dt2.getMillis()));
			/* if(!time_end_slit[1].equals(time_from_slit[1])){
			 DateTime[] d_array=new DateTime[2];
			 d_array[1]=dt2;
			 dt2=dt2.dayOfMonth().setCopy(dt2.dayOfMonth().getMinimumValue()+"");
			 d_array[0]=dt2;
			 date_list.add(d_array);
			 }*/
			int date_size=date_list.size();
			for (int i=date_size-1;i>=0;i--){//DateTime dateTime : date_list) {
				System.out.println(date_list.get(i)[1]+" , "+date_list.get(i)[0]);
			}
			 
			/* 
			
			DateTime dt = new DateTime(d);
			int day_from = dt.getDayOfMonth();
			int month_from = dt.getMonthOfYear();
			int year_from = dt.getYear();
			try {
				d = format_check.parse(time_end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			dt = new DateTime(d);
			int day_end = dt.getDayOfMonth();
			int month_end = dt.getMonthOfYear();
			int year_end = dt.getYear();*/
		//    System.out.println(day_from+"-"+month_from+"-"+year_from);
		 //   System.out.println(day_end+"-"+month_end+"-"+year_end);
	    	String filePath = "/opt/attach/ServicesReport/ServicesReport.xls";//bundle.getString("dailyReportPath")+"DailyReport.xls";
			FileInputStream fileIn = null;
			 
				
			 HSSFWorkbook wb = null;
			try {
				try {
					fileIn = new FileInputStream(filePath);
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
				POIFSFileSystem fs = null;
				try {
					fs = new POIFSFileSystem(fileIn);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				 
				try {
					wb = new HSSFWorkbook(fs);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				String firstName_lastName="";
				String day="";
				
				//String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
				//String[] column_default={"","","แขวง/ตำบล ","เขต/อำเภอ ","จ. ","      "};
				//int[] column_array_value={0,1,2,3,4,6};
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				HSSFCellStyle cellStyle_name_head = wb.createCellStyle();
				HSSFCellStyle cellStyle_name_head_center = wb.createCellStyle();
				HSSFCellStyle cellStyle_name_head_left = wb.createCellStyle();
				HSSFCellStyle cellStyle_name_topic_1 = wb.createCellStyle();
				HSSFCellStyle cellStyle_name_topic_2 = wb.createCellStyle();
				HSSFCellStyle cellStyle_name_topic_3 = wb.createCellStyle();
				HSSFCellStyle[] cellStyle_name_topic_array=new HSSFCellStyle[]{cellStyle_name_topic_1,cellStyle_name_topic_2,cellStyle_name_topic_3};
				HSSFCellStyle cellStyle_value_1 = wb.createCellStyle();
				HSSFCellStyle cellStyle_value_2 = wb.createCellStyle();
				HSSFCellStyle cellStyle_value_3 = wb.createCellStyle();
				HSSFCellStyle[] cellStyle_value_array=new HSSFCellStyle[]{cellStyle_value_1,cellStyle_value_2,cellStyle_value_3};
				HSSFCellStyle cellStyle_value_error_1 = wb.createCellStyle();
				HSSFCellStyle cellStyle_value_error_2 = wb.createCellStyle();
				HSSFCellStyle cellStyle_value_error_3 = wb.createCellStyle();
				HSSFCellStyle[] cellStyle_value_error_array=new HSSFCellStyle[]{cellStyle_value_error_1,cellStyle_value_error_2,cellStyle_value_error_3}; 
			        Font font = wb.createFont();
			        font.setColor(HSSFColor.RED.index);
			       
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle_name_head.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle_name_head.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
				cellStyle_name_head.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head.setWrapText(true);
				
				cellStyle_name_head_center.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle_name_head_center.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle_name_head_center.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_center.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_center.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_center.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_center.setWrapText(true);
				
				cellStyle_name_head_left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				cellStyle_name_head_left.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle_name_head_left.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_left.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_left.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_left.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle_name_head_left.setWrapText(true);
				//http://www.java-connect.com/apache-poi-tutorials/excel-cells-fills-and-colors-example-using-apache-poi/
				/*cellStyle_name_head.setFillForegroundColor(IndexedColors.PALE_BLUE
						.getIndex());*/
				/*cellStyle_name_head.setFillForegroundColor(IndexedColors.YELLOW
						.getIndex());*/
				/*cellStyle_name_head.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
				.getIndex());*/
				/*cellStyle_name_head.setFillPattern(CellStyle.SOLID_FOREGROUND);*/
				for (int i = 0; i < cellStyle_name_topic_array.length; i++) {
					cellStyle_name_topic_array[i].setAlignment(HSSFCellStyle.ALIGN_LEFT);
					cellStyle_name_topic_array[i].setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					cellStyle_name_topic_array[i].setBorderBottom(HSSFCellStyle.BORDER_THIN);
					cellStyle_name_topic_array[i].setBorderLeft(HSSFCellStyle.BORDER_THIN);
					cellStyle_name_topic_array[i].setBorderRight(HSSFCellStyle.BORDER_THIN);
					cellStyle_name_topic_array[i].setBorderTop(HSSFCellStyle.BORDER_THIN);
					cellStyle_name_topic_array[i].setWrapText(true);
					switch (i) {
					case 0: 
						cellStyle_name_topic_array[i].setFillForegroundColor(IndexedColors.PALE_BLUE
								.getIndex()); 
						break;
					case 1:
						cellStyle_name_topic_array[i].setFillForegroundColor(IndexedColors.YELLOW
								.getIndex()); 
						break;
					case 2:
						cellStyle_name_topic_array[i].setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
								.getIndex()); 
							break;
					default:
						break;
					}
					cellStyle_name_topic_array[i].setFillPattern(CellStyle.SOLID_FOREGROUND);
				}
			 
				
				for (int i = 0; i < cellStyle_value_array.length; i++) {  
					cellStyle_value_array[i].setAlignment(HSSFCellStyle.ALIGN_CENTER);
					cellStyle_value_array[i].setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					cellStyle_value_array[i].setBorderBottom(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_array[i].setBorderLeft(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_array[i].setBorderRight(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_array[i].setBorderTop(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_array[i].setWrapText(true);
					switch (i) {
					case 0: 
						cellStyle_value_array[i].setFillForegroundColor(IndexedColors.PALE_BLUE
								.getIndex()); 
						break;
					case 1:
						cellStyle_value_array[i].setFillForegroundColor(IndexedColors.YELLOW
								.getIndex()); 
						break;
					case 2:
						cellStyle_value_array[i].setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
								.getIndex()); 
							break;
					default:
						break;
					}
					cellStyle_value_array[i].setFillPattern(CellStyle.SOLID_FOREGROUND);
				}
				
				for (int i = 0; i < cellStyle_value_error_array.length; i++) { 
					cellStyle_value_error_array[i].setAlignment(HSSFCellStyle.ALIGN_CENTER);
					cellStyle_value_error_array[i].setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					cellStyle_value_error_array[i].setBorderBottom(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_error_array[i].setBorderLeft(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_error_array[i].setBorderRight(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_error_array[i].setBorderTop(HSSFCellStyle.BORDER_THIN);
					cellStyle_value_error_array[i].setWrapText(true);
					cellStyle_value_error_array[i].setFont(font);
					switch (i) {
					case 0: 
						cellStyle_value_error_array[i].setFillForegroundColor(IndexedColors.PALE_BLUE
								.getIndex()); 
						break;
					case 1:
						cellStyle_value_error_array[i].setFillForegroundColor(IndexedColors.YELLOW
								.getIndex()); 
						break;
					case 2:
						cellStyle_value_error_array[i].setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
								.getIndex()); 
							break;
					default:
						break;
					}
					cellStyle_value_error_array[i].setFillPattern(CellStyle.SOLID_FOREGROUND);
				}
				
				
				VResultMessage resultMessage=null;
				String query_user=" SELECT  user.id,user.username ,concat(user.firstName,' ',user.lastName),user_hod.username  as username_hod  FROM  BPM_DEPARTMENT_USER dept_user left join "+
				" user user on dept_user.user_id=user.id  left join  BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id left join   user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+    
				" where dept.bdept_id =8 "
				+ " and user.username!='rfe'";
				PstObject pstObject = new PstObject(new String[]{query_user}); 
				
				pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH); 
		         resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		         List<Object[]> user_list= resultMessage.getResultListObj();
		         int user_size=user_list.size();
		         System.out.println("user_size="+user_list.size());
				/*VResultMessage vresultMessage_1 = synDomeBPMService.searchObject(query_so);
				VResultMessage vresultMessage_2 = synDomeBPMService.searchObject(query_services);*/
		         /*int vresultMessage_1_size=(vresultMessage_1!=null && vresultMessage_1.getResultListObj()!=null)?vresultMessage_1.getResultListObj().size():0;
				int vresultMessage_2_size=(vresultMessage_2!=null && vresultMessage_2.getResultListObj()!=null)?vresultMessage_2.getResultListObj().size():0;
				System.out.println("vresultMessage_1_size="+vresultMessage_1_size);
				System.out.println("vresultMessage_2_size="+vresultMessage_2_size);*/
				List<Object[]>product_all=new ArrayList<Object[]>();
				
				//Collections.addAll(product_all, (List<Object[]>)vresultMessage_1.getResultListObj());
				/*System.out.println("vresultMessage_1 size->"+vresultMessage_1_size);
				System.out.println("vresultMessage_2 size->"+vresultMessage_2_size);
				System.out.println("product_all size->"+product_all.size());*/
				//int index_loop=0;
			 
			 	// System.out.println("size----->"+product_all.size());
				//List<Object[]> product_item =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				int product_item_size = product_all!=null?product_all.size():0;
				int index=6;
				//String[] item_label={"D","E","G","H","I","J","K","L","M","N"}; // C O
				String[] column_lable_head={"เครื่องใหม่","เสร็จ","ไม่เสร็จ","คะแนน(%)","จำนวนเครื่อง",
											"งาน (sv)","เสร็จ","ไม่เสร็จ","คะแนน(%)","จำนวนเครื่อง",
											"เครื่องใหม่+งาน(sv)","เสร็จ","ไม่เสร็จ","คะแนน(%)","จำนวนเครื่อง"};
				
						//"เสร็จ","ไม่เสร็จ","คะแนน(%)","จำนวนเครื่อง","J","K","L","M","N"}; // C O
				//int[] item_value={0,1,3};
				//String[] item_subfix={" ชิ้น","",""};
				// wb.getSheetAt(3);
				Locale locale = new Locale("th_TH");
			 for (int z=date_size-1;z>=0;z--){//DateTime dateTime : date_list) { 
						System.out.println(date_list.get(z)[1]+" , "+date_list.get(z)[0]);
						DateTime d_start=date_list.get(z)[0];
						DateTime d_end=date_list.get(z)[1];
				String sheetName="M"+d_start.monthOfYear().get()+"_"+(d_start.year().get()+543);
				int day_start=d_start.dayOfMonth().get();
				int day_end=d_end.dayOfMonth().get();
				
				int month=d_start.monthOfYear().get();
				int year=d_start.year().get();
				sheet =wb.createSheet(sheetName);
				
				int index_days=3;
				StringBuffer sb_query=new StringBuffer();
				 for (int k = day_end; k >= day_start; k--) {
					 row = sheet.getRow(1);
						if(row==null)
							row=sheet.createRow(1);
						cell =row.getCell(index_days);
						if(cell==null)
							cell = row.createCell(index_days);
						 cell.setCellValue(k+"");
						 cell.setCellStyle(cellStyle_name_head_center);  
						 index_days++;
						 
						
				 }	 
				
				 int row_user_start=17;
				 int row_user_offset=15;

				 int row_value_start=17;
				 // set header label
				 row = sheet.getRow(1);
					if(row==null)
						row=sheet.createRow(1);
					cell =row.getCell(0);
					if(cell==null)
						cell = row.createCell(0);
					 cell.setCellValue("รวมทั้งหมด");
					 cell.setCellStyle(cellStyle_name_head_center); 
					 
					 cell =row.getCell(1);
						if(cell==null)
							cell = row.createCell(1);
						 cell.setCellValue(sheetName);
						 cell.setCellStyle(cellStyle_name_head_center);
						 
						 cell =row.getCell(2);
							if(cell==null)
								cell = row.createCell(2);
							 cell.setCellValue("รวม");
							 cell.setCellStyle(cellStyle_name_head_center);
					 
				 int row_sum_start=2;
				 for (int i = 0; i < user_size; i++) {
					 Object[] objs= user_list.get(i);
					 String username= (String)objs[1];
					 sb_query.setLength(0);
					 sb_query.append(" select * from ( ");
					 for (int k = day_end; k >= day_start; k--) { } 
							/*int day_end=Integer.valueOf(xbpsTerm.getQuery()[0]);;
							int day_start=Integer.valueOf(xbpsTerm.getQuery()[1]);
							String year=xbpsTerm.getQuery()[2]; // 0 = no , 1 =yes
							
							String month=xbpsTerm.getQuery()[3]; // 1 = query , 2 = count
							String username=xbpsTerm.getQuery()[4]; // job no
*/							 
					 String[] job_query={day_end+"",day_start+"",year+"",month+"",username};
					   pstObject.setQuery(job_query);
					 // 	System.out.println("query--->"+sb_query.toString());
					 	pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH_SERVICES_REPORT); 
				         resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
				         List<Object[]> job_list= resultMessage.getResultListObj();
				         Map hashMap =new HashMap();
				         if(job_list!=null){
				        	 for (int j = 0; j < job_list.size(); j++) {
				        		 Object[] objs_value=job_list.get(j);
				        		 String day_key=((String)objs_value[0]).split("-")[2];
				        		 System.out.println("day_key->"+day_key);
				        		 hashMap.put(day_key+"_"+username, objs_value);
							}
				         }
				        // System.out.println("job_list="+job_list.get(0)[1].toString());
					 row = sheet.getRow(row_user_start);
						if(row==null)
							row=sheet.createRow(row_user_start);
						cell =row.getCell(0);
						if(cell==null)
							cell = row.createCell(0);
						 cell.setCellValue((i+1)+". "+(String)objs[2]);
						 cell.setCellStyle(cellStyle_name_head); 
						// for merce
						 row = sheet.getRow((row_user_start+row_user_offset-1));
						 if(row==null)
								row=sheet.createRow(row_user_start+row_user_offset-1);
						 cell =row.getCell(0);
						 if(cell==null)
								cell = row.createCell(0);
						
						 cell.setCellStyle(cellStyle_name_head); 
						 sheet.addMergedRegion(new CellRangeAddress(
								 row_user_start, //first row (0-based)
								 row_user_start+row_user_offset-1, //last row  (0-based)
						            0, //first column (0-based)
						            0  //last column  (0-based)
						    ));
						 row_user_start=row_user_start+row_user_offset;
						   
						 for (int j = 0; j < column_lable_head.length; j++) {
							 row = sheet.getRow(row_value_start);
								if(row==null)
									row=sheet.createRow(row_value_start);
								cell =row.getCell(1);
								if(cell==null)
									cell = row.createCell(1);
								 
								 cell.setCellValue(column_lable_head[j]);
								
								 if(j<5){
									 cell.setCellStyle(cellStyle_name_topic_1);  
								 }else if(j<10){ 
									 cell.setCellStyle(cellStyle_name_topic_2);  
								 }else{
									 cell.setCellStyle(cellStyle_name_topic_3);  
								 }
								 
								// value
								// String startColumnName="D";
								 String startColumnEnd=""; 
									int index_day=3;
								 for (int k = day_end; k >= day_start; k--) { 
									 cell =row.getCell(index_day);
									 
										if(cell==null)
											cell = row.createCell(index_day); 
										String startColumnName=CellReference.convertNumToColString(cell.getColumnIndex());
										if(j>9 &&  j!=13){
											 cell.setCellFormula("SUM("+startColumnName+((row_value_start+1)-10)+"+"+startColumnName+((row_value_start+1)-5)+")"); //C19*100/C18
										}else {
										if(j==3 || j==8 || j==13)
											 cell.setCellFormula(startColumnName+(row_value_start-1)+"*100/"+startColumnName+(row_value_start-2)); //C19*100/C18
										 else{
											/* String[] column_lable_head={"เครื่องใหม่","เสร็จ","ไม่เสร็จ","คะแนน(%)","จำนวนเครื่อง",
														"งาน (sv)","เสร็จ","ไม่เสร็จ","คะแนน(%)","จำนวนเครื่อง",
														"เครื่องใหม่+งาน(sv)","เสร็จ","ไม่เสร็จ","คะแนน(%)","จำนวนเครื่อง"};*/
											Object obj= hashMap.get((k+"_"+username));
											if(obj!=null){
												Object[] values=(Object[])obj;
												if(j== 0 || j== 1 || j== 2 )
												 cell.setCellValue(Double.valueOf(values[j+1].toString())); 
												else if(j== 9)
													 cell.setCellValue(Double.valueOf(values[j-1].toString())); 
												else
													 cell.setCellValue(Double.valueOf(values[j].toString()));
											}
											
										 } 
										}
										 if(j<5){
											 cell.setCellStyle(cellStyle_value_error_1);  
										 }else if(j<10){ 
											 cell.setCellStyle(cellStyle_value_error_2);  
										 }else{
											 cell.setCellStyle(cellStyle_value_error_3);  
										 } 
										 if(k==day_start)
											 startColumnEnd=CellReference.convertNumToColString(cell.getColumnIndex());
										 index_day++;
								}
								 
								//sum
								 cell =row.getCell(2);
								 int rowName=row.getRowNum()+1;
									if(cell==null)
										cell = row.createCell(2);
									String startColumnName=CellReference.convertNumToColString(cell.getColumnIndex());
									 if(j==3 || j==8 || j==13)
										 cell.setCellFormula(startColumnName+(row_value_start-1)+"*100/"+startColumnName+(row_value_start-2)); //C19*100/C18
									 else
										 cell.setCellFormula("SUM(D"+rowName+":"+startColumnEnd+rowName+")"); 
								  
									 if(j<5){
										 cell.setCellStyle(cellStyle_value_1);  
									 }else if(j<10){ 
										 cell.setCellStyle(cellStyle_value_2);  
									 }else{
										 cell.setCellStyle(cellStyle_value_3);  
									 } 
									 
								 row_value_start++;
						}
						
				 }
				 
				 row = sheet.getRow(row_sum_start);
					if(row==null)
						row=sheet.createRow(row_sum_start);
					cell =row.getCell(0);
					if(cell==null)
						cell = row.createCell(0);
					 cell.setCellValue("พนักงานทั้งหมด "+user_size+" คน");
					 cell.setCellStyle(cellStyle_name_head); 
					// for merce
					 row = sheet.getRow((row_sum_start+row_user_offset-1));
					 if(row==null)
							row=sheet.createRow(row_sum_start+row_user_offset-1);
					 cell =row.getCell(0);
					 if(cell==null)
							cell = row.createCell(0);
					
					 cell.setCellStyle(cellStyle_name_head); 
					 sheet.addMergedRegion(new CellRangeAddress(
							 row_sum_start, //first row (0-based)
							 row_sum_start+row_user_offset-1, //last row  (0-based)
					            0, //first column (0-based)
					            0  //last column  (0-based)
					    ));
				for (int j = 0; j < column_lable_head.length; j++) {	 
				 row = sheet.getRow(row_sum_start);
					if(row==null)
						row=sheet.createRow(row_sum_start);
					cell =row.getCell(1);
					if(cell==null)
						cell = row.createCell(1);
					 cell.setCellValue(column_lable_head[j]); 
					 if(j<5){
						 cell.setCellStyle(cellStyle_name_topic_1);  
					 }else if(j<10){ 
						 cell.setCellStyle(cellStyle_name_topic_2);  
					 }else{
						 cell.setCellStyle(cellStyle_name_topic_3);  
					 }  
					// value
					
						 String startColumnEnd="";
						 int index_day=3;
						 for (int k = day_end; k >= day_start; k--) {
							 cell =row.getCell(index_day);
								if(cell==null)
									cell = row.createCell(index_day);
								//SUM(D18+D33+D48+D63+D78+D93)
								String startColumnName=CellReference.convertNumToColString(cell.getColumnIndex());
								
								if(j>9 &&  j!=13){
									 cell.setCellFormula("SUM("+startColumnName+((row_sum_start+1)-10)+"+"+startColumnName+((row_sum_start+1)-5)+")"); //C19*100/C18
								}else {
									if(j==3 || j==8 || j==13){
										 cell.setCellFormula(startColumnName+(row_sum_start-1)+"*100/"+startColumnName+(row_sum_start-2)); //C19*100/C18
									 }
									 else{
										 String formula="SUM(";
											row_value_start=18+j;
											for (int k2 = 0; k2 < user_size; k2++) {
												formula=formula+startColumnName+row_value_start+((k2==user_size-1)?"":"+");
												row_value_start=row_value_start+row_user_offset;
											}
											formula=formula+")";
											 cell.setCellFormula(formula);
									 }
								}
								
								 
									  
								 if(j<5){
									 cell.setCellStyle(cellStyle_value_error_1);  
								 }else if(j<10){ 
									 cell.setCellStyle(cellStyle_value_error_2);  
								 }else{
									 cell.setCellStyle(cellStyle_value_error_3);  
								 } 
								 if(k==day_start)
									 startColumnEnd=CellReference.convertNumToColString(cell.getColumnIndex());
								 index_day++;
						}
						 
						//sum
						 cell =row.getCell(2);
						 int rowNum=row.getRowNum()+1;
							if(cell==null)
								cell = row.createCell(2);
							String startColumnName=CellReference.convertNumToColString(cell.getColumnIndex());
							 if(j==3 || j==8 || j==13)
								 cell.setCellFormula(startColumnName+(row_sum_start-1)+"*100/"+startColumnName+(row_sum_start-2)); //C19*100/C18
							 else
								 cell.setCellFormula("SUM(D"+rowNum+":"+startColumnEnd+rowNum+")");  
							  
							 if(j<5){
								 cell.setCellStyle(cellStyle_value_1);  
							 }else if(j<10){ 
								 cell.setCellStyle(cellStyle_value_2);  
							 }else{
								 cell.setCellStyle(cellStyle_value_3);  
							 } 
					 row_sum_start++;
				} 
				 sheet.setColumnWidth(0, (short) ((40 * 8) / ((double) 1 / 20)));
				 sheet.setColumnWidth(1, (short) ((35 * 8) / ((double) 1 / 20)));
			}	 
			/*	sheet= wb.getSheetAt(1);
				row=sheet.getRow(13);
				cell=row.getCell(0);
				cell.setCellFormula("M3_57!C3");*/
			 // Create Sum
			 sheet = wb.createSheet("Sum");
			 row = sheet.getRow(0);
				if(row==null)
					row=sheet.createRow(0);
				cell =row.getCell(3);
				if(cell==null)
					cell = row.createCell(3);
				cell.setCellValue("สะสม");
				cell.setCellStyle(cellStyle_name_head_center); 
				
				cell =row.getCell(9);
				if(cell==null)
					cell = row.createCell(9);
				cell.setCellStyle(cellStyle_name_head_center); 
				 sheet.addMergedRegion(new CellRangeAddress(
						 0, //first row (0-based)
						 0, //last row  (0-based)
				            3, //first column (0-based)
				            9  //last column  (0-based)
				    ));
				
				 row = sheet.getRow(1);
					if(row==null)
						row=sheet.createRow(1);
					cell =row.getCell(0);
					if(cell==null)
						cell = row.createCell(0);
					cell.setCellValue("ชื่อทีมจัดส่ง");
					cell.setCellStyle(cellStyle_name_head_center); 
					
					cell =row.getCell(1);
					if(cell==null)
						cell = row.createCell(1);
					cell.setCellValue("ชื่อเล่น");
					cell.setCellStyle(cellStyle_name_head_center); 
					
					cell =row.getCell(2);
					if(cell==null)
						cell = row.createCell(2);
					cell.setCellValue("พื่นที่จัดส่ง");
					cell.setCellStyle(cellStyle_name_head_center); 
					
					cell =row.getCell(3);
					if(cell==null)
						cell = row.createCell(3);
					cell.setCellValue("รวมงานทั้งหมด (เครื่องใหม่+Job)");
					cell.setCellStyle(cellStyle_name_head_center); 
					
					cell =row.getCell(6);
					if(cell==null)
						cell = row.createCell(6);
					cell.setCellValue("unit (เครื่อง)");
					cell.setCellStyle(cellStyle_name_head_center); 
					
					cell =row.getCell(7);
					if(cell==null)
						cell = row.createCell(7);
					cell.setCellValue("ค่าใช้จ่าย");
					cell.setCellStyle(cellStyle_name_head_center); 
					cell =row.getCell(9);
					if(cell==null)
						cell = row.createCell(9);
					
					cell.setCellStyle(cellStyle_name_head_center); 
					 row = sheet.getRow(2);
						if(row==null)
							row=sheet.createRow(2);
						cell =row.getCell(0);
						if(cell==null)
							cell = row.createCell(0);
						//cell.setCellValue("ชื่อทีมจัดส่ง");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(1);
						if(cell==null)
							cell = row.createCell(1);
						//cell.setCellValue("ชื่อเล่น");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(2);
						if(cell==null)
							cell = row.createCell(2);
						//cell.setCellValue("พื่นที่จัดส่ง");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(3);
						if(cell==null)
							cell = row.createCell(3);
						cell.setCellValue("รวม");
						cell.setCellStyle(cellStyle_name_head_center); 
						cell =row.getCell(4);
						if(cell==null)
							cell = row.createCell(4);
						cell.setCellValue("เสร็จ");
						cell.setCellStyle(cellStyle_name_head_center); 
						cell =row.getCell(5);
						if(cell==null)
							cell = row.createCell(5);
						cell.setCellValue("ไม่เสร็จ");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(6);
						if(cell==null)
							cell = row.createCell(6);
					//	cell.setCellValue("unit (เครื่อง)");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(7);
						if(cell==null)
							cell = row.createCell(7);
						cell.setCellValue("รวม");
						cell.setCellStyle(cellStyle_name_head_center);  
						cell =row.getCell(8);
						if(cell==null)
							cell = row.createCell(8);
						cell.setCellValue("/งาน");
						cell.setCellStyle(cellStyle_name_head_center); 
						cell =row.getCell(9);
						if(cell==null)
							cell = row.createCell(9);
						cell.setCellValue("/เครื่อง");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						// loop user
						 for (int i = 0; i < user_size; i++) {
							 Object[] objs= user_list.get(i); 
							 row = sheet.getRow(i+3);
								if(row==null)
									row=sheet.createRow(i+3);
								cell =row.getCell(0);
								if(cell==null)
									cell = row.createCell(0);
								 cell.setCellValue((i+1)+". "+(String)objs[2]);
								cell.setCellStyle(cellStyle_name_head_left); 
						}
					 createDySheet(  wb,sheet,  user_size, user_list,date_size,date_list,  cellStyle_name_head_center,  cellStyle_name_head_left);
						 sheet.setColumnWidth(0, (short) ((40 * 8) / ((double) 1 / 20)));
						 sheet.setColumnWidth(2, (short) ((40 * 8) / ((double) 1 / 20)));
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 2, //last row  (0-based)
						            0, //first column (0-based)
						            0  //last column  (0-based)
						    ));
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 2, //last row  (0-based)
						            1, //first column (0-based)
						           1  //last column  (0-based)
						    ));
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 2, //last row  (0-based)
						            2, //first column (0-based)
						           2  //last column  (0-based)
						    ));
						 
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 2, //last row  (0-based)
						            6, //first column (0-based)
						           6  //last column  (0-based)
						    ));
						 
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 1, //last row  (0-based)
						            3, //first column (0-based)
						           5  //last column  (0-based)
						    ));
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 1, //last row  (0-based)
						            7, //first column (0-based)
						           9  //last column  (0-based)
						    ));
					 
				HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
				
			} finally {
				if (fileIn != null)
					try {
						fileIn.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
			FileOutputStream fileOut=null;
	         
	         // print
			try {
				fileOut = new FileOutputStream("/opt/attach/ServicesReport/aoe.xls");
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//System.out.println("fileOut==>"+fileOut);
			try {
				wb.write(fileOut);
			} catch (IOException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}finally{
				if(fileOut!=null){
					try {
						fileOut.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		} 
		private void createDySheet( HSSFWorkbook wb,HSSFSheet sheet,int user_size,List<Object[]> user_list,int  date_size,List<DateTime[]> date_list,HSSFCellStyle cellStyle_name_head_center,HSSFCellStyle cellStyle_name_head_left){
			int index1=10;
			int index1_offset=6;
			int index1_offset2=3;
			HSSFRow  row =null;
			HSSFCell cell =null;
			for (int z=date_size-1;z>=0;z--){//DateTime dateTime : date_list) { 
					//System.out.println(date_list.get(z)[1]+" , "+date_list.get(z)[0]);
					DateTime d_start=date_list.get(z)[0];
					DateTime d_end=date_list.get(z)[1];
					String sheetName="M"+d_start.monthOfYear().get()+"_"+(d_start.year().get()+543);
					
					row= sheet.getRow(0);
					if(row==null)
						row=sheet.createRow(0);
					  cell =row.getCell(index1);
					if(cell==null)
						cell = row.createCell(index1);
					cell.setCellValue(sheetName);
					cell.setCellStyle(cellStyle_name_head_center); 
					
					cell =row.getCell(index1+index1_offset);
					if(cell==null)
						cell = row.createCell(index1+index1_offset);
					cell.setCellStyle(cellStyle_name_head_center); 
					 sheet.addMergedRegion(new CellRangeAddress(
							 0, //first row (0-based)
							 0, //last row  (0-based)
							 index1, //first column (0-based)
					            index1+index1_offset  //last column  (0-based)
					    ));
					 
					 row = sheet.getRow(1);
					 if(row==null)
							row=sheet.createRow(1);
					 
					 cell =row.getCell(index1);
						if(cell==null)
							cell = row.createCell(index1);
						cell.setCellValue("รวมงานทั้งหมด (เครื่องใหม่+Job)");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(index1+index1_offset2);
						if(cell==null)
							cell = row.createCell(index1+index1_offset2);
						cell.setCellValue("unit (เครื่อง)");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(index1+4);
						if(cell==null)
							cell = row.createCell(index1+4);
						cell.setCellValue("ค่าใช้จ่าย");
						cell.setCellStyle(cellStyle_name_head_center); 
						cell =row.getCell(index1+6);
						if(cell==null)
							cell = row.createCell(index1+6);
						
						cell.setCellStyle(cellStyle_name_head_center); 
					 
						row = sheet.getRow(2);
						if(row==null)
							row=sheet.createRow(2);
						
						cell =row.getCell(index1);
						if(cell==null)
							cell = row.createCell(index1);
						cell.setCellValue("รวม");
						cell.setCellStyle(cellStyle_name_head_center); 
						cell =row.getCell(index1+1);
						if(cell==null)
							cell = row.createCell(index1+1);
						cell.setCellValue("เสร็จ");
						cell.setCellStyle(cellStyle_name_head_center); 
						cell =row.getCell(index1+2);
						if(cell==null)
							cell = row.createCell(index1+2);
						cell.setCellValue("ไม่เสร็จ");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(index1+3);
						if(cell==null)
							cell = row.createCell(index1+3);
					//	cell.setCellValue("unit (เครื่อง)");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						cell =row.getCell(index1+4);
						if(cell==null)
							cell = row.createCell(index1+4);
						cell.setCellValue("รวม");
						cell.setCellStyle(cellStyle_name_head_center);  
						cell =row.getCell(index1+5);
						if(cell==null)
							cell = row.createCell(index1+5);
						cell.setCellValue("/งาน");
						cell.setCellStyle(cellStyle_name_head_center); 
						cell =row.getCell(index1+6);
						if(cell==null)
							cell = row.createCell(index1+6);
						cell.setCellValue("/เครื่อง");
						cell.setCellStyle(cellStyle_name_head_center); 
						
						
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 2, //last row  (0-based)
								 index1+3, //first column (0-based)
								 index1+3  //last column  (0-based)
						    ));
						 
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 1, //last row  (0-based)
								 index1 , //first column (0-based)
								 index1+2  //last column  (0-based)
						    ));
						 sheet.addMergedRegion(new CellRangeAddress(
								 1, //first row (0-based)
								 1, //last row  (0-based) 
								 index1+4, //first column (0-based)
								 index1+6  //last column  (0-based)
						    ));
					//	 HSSFSheet sheet_loop=	wb.getSheet(sheetName);
							int index_user=27;
							int index_user_offset=15;
							
							int index_user_start=3;
							// index =27 , offset 15
							// 27 , 28, 29 , 31
							  for (int i = 0; i < user_size; i++) {
								  //index1=10;
								 row = sheet.getRow(index_user_start+i);
								if(row==null)
									row=sheet.createRow(index_user_start+i);
								  cell =row.getCell(index1);
								if(cell==null)
									cell = row.createCell(index1);
								cell.setCellFormula(sheetName+"!C"+(index_user+1)); 
								//cell.setCellValue(cell_user.getNumericCellValue());
								 cell.setCellStyle(cellStyle_name_head_center);
								
								  cell =row.getCell(index1+1);
									if(cell==null)
										cell = row.createCell(index1+1);
									cell.setCellFormula(sheetName+"!C"+(index_user+2)); 
									//cell.setCellValue(cell_user.getNumericCellValue());
									 cell.setCellStyle(cellStyle_name_head_center);
									 
									  cell =row.getCell(index1+2);
										if(cell==null)
											cell = row.createCell(index1+2);
										cell.setCellFormula(sheetName+"!C"+(index_user+3)); 
										//cell.setCellValue(cell_user.getNumericCellValue());
										 cell.setCellStyle(cellStyle_name_head_center);
										 
										  cell =row.getCell(index1+3);
											if(cell==null)
												cell = row.createCell(index1+3);
											cell.setCellFormula(sheetName+"!C"+(index_user+5)); 
											//cell.setCellValue(cell_user.getNumericCellValue());
											 cell.setCellStyle(cellStyle_name_head_center);
								index_user=index_user+index_user_offset;
						}
							  index1=index1+7;		  
			 }
			
				
				
			/*int start_index_row_sum=3;	
			int start_index_column_sum=3;
			  for (int i = 0; i < user_size; i++) { }*/
						
		}

		@Override
		public VResultMessage getReportSO(String start_date, String end_date) { //format_report_so yyyy-MM-dd
			// TODO Auto-generated method stub
			//format_check
			//DateTime dt_start =null;
			PstObject pstObject = new PstObject(new String[]{start_date,end_date}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH_REPORT_SO);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		}

		@Override
		public VResultMessage getReportDeptStatus(String start_date,
				String end_date) {
			// TODO Auto-generated method stub 
			PstObject pstObject = new PstObject(new String[]{start_date,end_date}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH_REPORT_DEPT_STATUS);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		}

		@Override
		public VResultMessage getReportPMMA(String start_date, String end_date,
				String viewBy) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(new String[]{start_date,end_date,viewBy}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH_REPORT_PMMA);
			return postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		}
}
