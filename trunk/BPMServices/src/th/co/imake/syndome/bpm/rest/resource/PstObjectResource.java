package th.co.imake.syndome.bpm.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.restlet.representation.Representation;
import org.restlet.representation.Variant;
import org.restlet.resource.ResourceException;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.PstObjectService;
import th.co.imake.syndome.bpm.xstream.common.VMessage;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;


public class PstObjectResource extends BaseResource {
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy"); 
	private static SimpleDateFormat format_report_so = new SimpleDateFormat("yyyy-MM-dd");
	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
//	private PSTCommonService pstCommonService;
	private PstObjectService pstObjectService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private static final String[] ignore=	 {"id","pstDepartment","pstRoadPump","pstWorkType"};
	private static final String[] ignore2=	 {"pstRoadPump"};

	 private static String SERVICE_QUERY=" SELECT "+
	  " call_center.BCC_NO as c0 ,"+
	  " IFNULL(call_center.BCC_SERIAL,'') as c1,"+
	    " IFNULL(call_center.BCC_MODEL,'') as c2,"+
	    " IFNULL(call_center.BCC_CAUSE,'') as c3,"+
	    "  call_center.BCC_CREATED_TIME  as c4,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') as c5,"+
	    " IFNULL(call_center.BCC_SLA,'') as c6,"+
	    " IFNULL(call_center.BCC_IS_MA ,'') as c7,"+
	    " IFNULL(call_center.BCC_MA_NO ,'') as c8,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_START,'%d/%m/%Y'),'') as c9,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_END,'%d/%m/%Y'),'') as c10,"+
	    " IFNULL(call_center.BCC_STATUS ,'') as c11,"+
	    " IFNULL(call_center.BCC_REMARK ,'') as c12,"+
	    " IFNULL(call_center.BCC_USER_CREATED ,'') as c13,"+
	    " IFNULL(call_center.BCC_DUE_DATE ,'') as c14,"+
	    " IFNULL(call_center.BCC_CONTACT ,'') as c15,"+
	    " IFNULL(call_center.BCC_TEL ,'') as c16,"+ 
	   /// " IFNULL(arms.CUSNAM ,'') as c17,"+ //17
	   " IFNULL(call_center.BCC_CUSTOMER_NAME ,'') as c17,"+ //17
	    " IFNULL(call_center.BCC_ADDR1 ,'') as c18,"+
	    " IFNULL(call_center.BCC_ADDR2 ,'') as c19,"+
	    " IFNULL(call_center.BCC_ADDR3 ,'') as c20,"+
	    " IFNULL(call_center.BCC_LOCATION ,'') as c21,"+
	    " IFNULL(call_center.BCC_PROVINCE ,'') as c22,"+
	    " IFNULL(call_center.BCC_ZIPCODE ,'') as c23,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c24, "+
	    " IFNULL(call_center.BCC_CUSCODE ,'') as c25,"+
	    " IFNULL(call_center.BCC_SALE_ID ,'') as c26,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') as c27, "+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') as c28, "+ 
	   " (select count(*)  FROM "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo "+ 
	   "	   where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2') as c29, "+
	   " IFNULL(call_center.BCC_STATE ,'') as c30, "+
	   "IFNULL((select so.BSO_MA_TYPE from  "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping    "+
	   " left join  "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so on   "+
	   " 	   so.BSO_ID= mapping.BSO_ID  where mapping.SERIAL=call_center.BCC_SERIAL "+
	   " and mapping.auto_k=0 ) ,'') as c31,"+
	    " IFNULL(service_job.BCC_NO ,'') as c32,"+
	    " IFNULL(service_job.BSJ_REMARK ,'') as c33,"+
	    " IFNULL(service_job.BSJ_FEEDBACK ,'') as c34,"+
	    " IFNULL(service_job.BSJ_RECOMMEND ,'') as c35,"+
	    " IFNULL(service_job.BSJ_CAUSE ,'') as c36,"+
	    " IFNULL(service_job.BSJ_SOLUTION ,'') as c37,"+
	    " IFNULL(service_job.BSJ_IS_SOLUTION1 ,'') as c38,"+
	    " IFNULL(service_job.BSJ_IS_SOLUTION2 ,'') as c39,"+
	    " IFNULL(service_job.BSJ_IS_SOLUTION3 ,'') as c40,"+
	    " IFNULL(service_job.BSJ_CREATED_TIME ,'') as c41,"+
	    " IFNULL(service_job.BSJ_STATE ,'') as c42 ,"+
	    " IFNULL(service_job.BSJ_STATUS ,'') as c43,"+
	    " IFNULL(service_job.SBJ_SYNDOME_RECIPIENT ,'') as c44,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_RECIPIENT_DATE,'%d/%m/%Y'),'') as c45, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_RECIPIENT_TIME_IN ,'%H:%i'),'') as c46,"+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_RECIPIENT_TIME_OUT,'%H:%i'),'') as c47,"+
	    " IFNULL(service_job.SBJ_CUSTOMER_SEND ,'') as c48,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_SEND_DATE,'%d/%m/%Y'),'') as c49, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_SEND_TIME_IN,'%H:%i'),'') as c50,"+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_SEND_TIME_OUT,'%H:%i'),'') as c51,"+
	    " IFNULL(service_job.SBJ_SYNDOME_ENGINEER ,'') as c52,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_ENGINEER_DATE,'%d/%m/%Y'),'') as c53, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_ENGINEER_TIME_IN,'%H:%i'),'') as c54,"+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_ENGINEER_TIME_OUT,'%H:%i'),'') as c55,"+
	    " IFNULL(service_job.SBJ_SYNDOME_SEND ,'') as c56,"+
	    " IFNULL(service_job.SBJ_SYNDOME_SEND_RFE_NO ,'') as c57,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_SEND_DATE,'%d/%m/%Y'),'') as c58, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_SEND_TIME_IN ,'%H:%i'),'') as c59,"+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_SEND_TIME_OUT,'%H:%i'),'') as c60,"+
	    " IFNULL(service_job.SBJ_CUSTOMER_RECIPIENT ,'') as c61,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_RECIPIENT_DATE,'%d/%m/%Y'),'') as c62, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_RECIPIENT_TIME_IN ,'%H:%i'),'') as c63,"+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_RECIPIENT_TIME_OUT,'%H:%i'),'') as c64,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CLOSE_DATE,'%d/%m/%Y'),'') as c65, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CONFIRM_REPAIR_DATE,'%d/%m/%Y'),'') as c66, "+
	    " IFNULL(service_job.SBJ_CUSTOMER_CONFIRM_REPAIR ,'') as c67,"+
	    " IFNULL(service_job.SBJ_IS_REPAIR ,'') as c68,"+
	    " IFNULL(service_job.SBJ_CLOSE_ACTOR ,'') as c69,"+
	    " IFNULL(service_job.SBJ_GET_BACK_1 ,'') as c70,"+
	    " IFNULL(service_job.SBJ_GET_BACK_2 ,'') as c71,"+
	    " IFNULL(service_job.SBJ_GET_BACK_3 ,'') as c72,"+
	    " IFNULL(service_job.SBJ_GET_BACK_4 ,'') as c73,"+
	    " IFNULL(service_job.SBJ_GET_BACK_EXT ,'') as c74,"+
	    " IFNULL(service_job.SBJ_ONSITE_DETECTED ,'') as c75,"+
	    " IFNULL(service_job.SBJ_ONSITE_CAUSE ,'') as c76,"+
	    " IFNULL(service_job.SBJ_ONSITE_SOLUTION ,'') as c77,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_GET_BACK ,'') as c78,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_REPLACE ,'') as c79,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_SPARE ,'') as c80,"+
	    " IFNULL(service_job.SBJ_ONSITE_BATTERY_AMOUNT ,'') as c81,"+
	    " IFNULL(service_job.SBJ_ONSITE_BATTERY_YEAR ,'') as c82,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_BATTERRY ,'') as c83,"+
	    " IFNULL(service_job.SBJ_SC_DETECTED ,'') as c84,"+
	    " IFNULL(service_job.SBJ_SC_CAUSE ,'') as c85,"+
	    " IFNULL(service_job.SBJ_SC_SOLUTION ,'') as c86,"+
	    " IFNULL(service_job.SBJ_SC_IS_CHANGE_ITEM ,'') as c87,"+
	    " IFNULL(service_job.SBJ_SC_IS_CHARGE ,'') as c88,"+
	    " IFNULL(service_job.SBJ_SC_IS_RECOMMEND ,'') as c89,"+
	    " IFNULL(service_job.SBJ_BORROW_ACTOR ,'') as c90,"+
	    " IFNULL(service_job.SBJ_BORROW_APPROVER ,'') as c91,"+
	    " IFNULL(service_job.SBJ_BORROW_SENDER ,'') as c92,"+
	    " IFNULL(service_job.SBJ_BORROW_RECEIVER ,'') as c93,"+  
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_ACTOR_DATE,'%d/%m/%Y'),'') as c94, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_APPROVER_DATE,'%d/%m/%Y'),'') as c95, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_SENDER_DATE,'%d/%m/%Y'),'') as c96, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_RECEIVER_DATE,'%d/%m/%Y'),'') as c97, "+
	    " IFNULL(service_job.SBJ_BORROW_IS_REPAIR_SITE ,'') as c98,"+
	    " IFNULL(service_job.SBJ_BORROW_IS_SPARE ,'') as c99,"+
	    " IFNULL(service_job.SBJ_BORROW_IS_CHANGE ,'') as c100,"+
	    " IFNULL(service_job.SBJ_CHECKER_1_IS_PASS ,'') as c101,"+
	    " IFNULL(service_job.SBJ_CHECKER_1_VALUE ,'') as c102,"+
	    " IFNULL(service_job.SBJ_CHECKER_2_IS_PASS ,'') as c103,"+
	    " IFNULL(service_job.SBJ_CHECKER_2_VALUE ,'') as c104,"+
	    " IFNULL(service_job.SBJ_CHECKER_3_IS_PASS ,'') as c105,"+
	    " IFNULL(service_job.SBJ_CHECKER_3_VALUE ,'') as c106,"+
	    " IFNULL(service_job.SBJ_CHECKER_4_IS_PASS ,'') as c107,"+
	    " IFNULL(service_job.SBJ_CHECKER_4_VALUE ,'') as c108,"+
	    " IFNULL(service_job.SBJ_CHECKER_5_IS_PASS ,'') as c109,"+
	    " IFNULL(service_job.SBJ_CHECKER_5_VALUE ,'') as c110,"+
	    " IFNULL(service_job.SBJ_CHECKER_6_IS_PASS ,'') as c111,"+
	    " IFNULL(service_job.SBJ_CHECKER_6_VALUE ,'') as c112,"+
	    " IFNULL(service_job.SBJ_CHECKER_7_IS_PASS ,'') as c113,"+
	    " IFNULL(service_job.SBJ_CHECKER_7_VALUE ,'') as c114,"+
	    " IFNULL(service_job.SBJ_CHECKER_8_IS_PASS ,'') as c115,"+
	    " IFNULL(service_job.SBJ_CHECKER_8_VALUE ,'') as c116,"+
	    " IFNULL(service_job.SBJ_CHECKER_9_IS_PASS ,'') as c117,"+
	    " IFNULL(service_job.SBJ_CHECKER_10_IS_PASS ,'') as c118,"+
	    " IFNULL(service_job.SBJ_CHECKER_11_IS_PASS ,'') as c119,"+
	    " IFNULL(service_job.SBJ_CHECKER_12_IS_PASS ,'') as c120,"+
	    " IFNULL(service_job.SBJ_CHECKER_13_IS_PASS ,'') as c121,"+
	    " IFNULL(service_job.SBJ_CHECKER_14_IS_PASS ,'') as c122,"+
	    " IFNULL(service_job.SBJ_CHECKER_15_IS_PASS ,'') as c123,"+
	    " IFNULL(service_job.SBJ_CHECKER_16_IS_PASS ,'') as c124,"+
	    " IFNULL(service_job.SBJ_CHECKER_17_IS_PASS ,'') as c125,"+
	    " IFNULL(service_job.SBJ_CHECKER_18_IS_PASS ,'') as c126,"+
	    " IFNULL(service_job.SBJ_CHECKER_19_VALUE ,'') as c127,"+
	    " IFNULL(service_job.SBJ_CHECKER_20_VALUE ,'') as c128,"+
	    " IFNULL(service_job.SBJ_CHECKER_21_VALUE ,'') as c129,"+
	    " IFNULL(service_job.SBJ_CHECKER_22_VALUE ,'') as c130,"+
	    " IFNULL(service_job.SBJ_CHECKER_EXT_VALUE ,'') as c131, "+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_1 ,'') as c132, "+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_2 ,'') as c133,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_3 ,'') as c134,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_4 ,'') as c135,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_5 ,'') as c136,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_6 ,'') as c137,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_7 ,'') as c138,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_1 ,'') as c139,"+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_2 ,'') as c140, "+
	   
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_3 ,'') as c141, "+
	   
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_4 ,'') as c142,"+
	   
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_5 ,'') as c143,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_6 ,'') as c144,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_7 ,'') as c145,"+
	  
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_1 ,'') as c146,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_2 ,'') as c147,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_3 ,'') as c148,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_4 ,'') as c149,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_5 ,'') as c150,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_6 ,'') as c151,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_7 ,'') as c152,"+
	    " IFNULL(service_job.SBJ_STATUS_JOB ,'') as c153,"+
	    " IFNULL(service_job.SBJ_DEPT_ID ,'') as c154,"+
	   
	    " service_job.SBJ_JOB_STATUS  as c155 , "+
	    " IFNULL(service_job.SBJ_SYNDOME_ENGINEER2 ,'') as c156,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_ENGINEER2_DATE,'%d/%m/%Y'),'') as c157, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_ENGINEER2_TIME_IN ,'%H:%i'),'') as c158,"+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_ENGINEER2_TIME_OUT,'%H:%i'),'') as c159 , "+
	    " IFNULL(service_job.SBJ_BORROW_SERAIL ,'') as c160 ,"+
	    " IFNULL(call_center.BCC_MA_TYPE ,'') as c161 , "+
	    " IFNULL(service_job.SBJ_JOB_PROBLEM_ID ,'') as c162 , "+
	    " IFNULL(service_job.SBJ_JOB_PROBLEM_SOLUTION ,'') as c163 "+ 
	   " "+
	   " FROM "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center left join  "+
	   "  "+ServiceConstant.SCHEMA+".BPM_ARMAS arms   "+
	   " on call_center.BCC_CUSCODE=arms.CUSCOD "+
	   " left join  "+
	   "  "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB service_job   "+
	   " on call_center.BCC_NO=service_job.BCC_NO "+
	  // " FROM "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER  so left join "+
	  // " "+ServiceConstant.SCHEMA+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
	   " where call_center.BCC_NO=";
	public PstObjectResource() {
		super();
		logger.debug("into constructor stObject");
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doInit() throws ResourceException {
		// TODO Auto-generated method stub
		super.doInit();
		logger.debug("into doInit");
	}
	
	@Override
	protected Representation post(Representation entity, Variant variant)
			throws ResourceException {
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub
		logger.debug("into Post PstObjectResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstObject.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstObject xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstObject();
		
		 	/*BufferedReader br = new BufferedReader(in);
			StringBuffer buff = new StringBuffer();
			String line;
			while((line = br.readLine()) != null){
			   buff.append(line);
			}
			Object p = (Object)xstream.fromXML(buff.toString());*/
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				 
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstObject) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.error(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();  
						VResultMessage vresultMessage =null;
						if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH)){
							//@SuppressWarnings({ "rawtypes" })
							//List list= pstObjectService.searchObject(xbpsTerm.getQuery()[0]);
							vresultMessage= pstObjectService.searchObject(xbpsTerm.getQuery()[0]);
							/* = new VResultMessage();
							vresultMessage.setResultListObj(list);*/ 
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH_REPORT_SO)){
							//@SuppressWarnings({ "rawtypes" })
							//List list= pstObjectService.searchObject(xbpsTerm.getQuery()[0]); 
							VResultMessage result_return = new VResultMessage();
							VMessage resultMessage =new VMessage();
							String msgCode="ok";
							String msgDesc="ok";
							resultMessage.setMsgDesc(msgDesc);
							resultMessage.setMsgCode(msgCode); 
							result_return.setResultMessage(resultMessage); 
							 List<Object[]> so_list_return=null;
							// result_return.setResultListObj(so_list_return);
							boolean isMonth=false;
							String start_date=xbpsTerm.getQuery()[0];
							String end_date=xbpsTerm.getQuery()[1];
							DateTime dt_start=null;
							DateTime dt_end=null;
							String[] time_from_slit=start_date.split("-");
							String[] time_end_slit=end_date.split("-");
							List<String[]> date_where=null;
							if(!time_from_slit[1].equals(time_end_slit[1])){
								isMonth=true;
								List<DateTime[]> date_list=new ArrayList<DateTime[]>();
								DateTime dt1 = null;
								try {
									dt1 = new DateTime(format_report_so.parse(start_date));
								} catch (ParseException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								DateTime dt2 = null;
								try {
									dt2 = new DateTime(format_report_so.parse(end_date));
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
										 dt_start=dt1.dayOfMonth().setCopy(time_from_slit[2]+"");
									 else
										 dt_start=dt1.dayOfMonth().setCopy(dt1.dayOfMonth().getMinimumValue()+""); 
										  d_array[0]=dt_start; 
									 if(dt_end.isBefore(dt2.getMillis())){ 
										  d_array[1]=dt_end;
									 }
									 else{ 
										 d_array[1]=dt2;
									 } 
									 date_list.add(d_array);
									 dt1=dt1.plusMonths(1);  
									 index_date++; 
									} while (dt1.isBefore(dt2.getMillis()));
								 
								int date_size=date_list.size(); 
								  date_where=new ArrayList<String[]>(date_size);
								for (int i=0;i<date_size;i++){//DateTime dateTime : date_list) {
									//System.out.println(date_list.get(i)[1]+" , "+date_list.get(i)[0]);
									String date_start=date_list.get(i)[0].year().get()+"-"+date_list.get(i)[0].monthOfYear().get()+"-"+date_list.get(i)[0].dayOfMonth().get();
									String date_end=date_list.get(i)[1].year().get()+"-"+date_list.get(i)[1].monthOfYear().get()+"-"+date_list.get(i)[1].dayOfMonth().get();
									 date_where.add(new String[]{date_start,date_end});
								}
							}else{
								String query_date=" "+
												  " select DATE_FORMAT(so.BSO_CREATED_DATE,'%Y-%m-%d'),DATE_FORMAT(so.BSO_CREATED_DATE,'%d/%m/%Y')  from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so   "+
												  " where so.BSO_CREATED_DATE between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59' "+
												  " and so.bso_type_no is not null  "+
												  " group by DATE_FORMAT(so.bso_created_date,'%Y-%m-%d') ";
								vresultMessage= pstObjectService.searchObject(query_date);
							 
						         List<Object[]> date_list= vresultMessage.getResultListObj();
						       if(date_list!=null){
						    	   int date_size=date_list.size();
							         date_where=new ArrayList<String[]>(date_size);
						         for (int j = 0; j < date_size; j++) {
					        		 Object[] objs_value=date_list.get(j);
					        		 date_where.add(new String[]{(String)objs_value[0],(String)objs_value[0]}); 
								}
							}  
						}
							
						if(date_where!=null && date_where.size()>0){
							int date_where_size=date_where.size(); 
							  so_list_return=new ArrayList<Object[]>(date_where_size);;
							for (int b = 0; b < date_where_size; b++) {  
								String start =date_where.get(b)[0];
								String end =date_where.get(b)[1];
							String query =" "+
									" ( select count(*) from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner "+
									" where so_inner.BSO_CREATED_DATE between '"+start+" 00:00:00' and '"+end+" 23:59:59'  and so_inner.bso_type_no is not null ) "+
									" union all "+
									" ( select count(*) from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner  "+
									" where so_inner.BSO_CREATED_DATE  between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.bso_is_delivery='1' and so_inner.bso_is_installation='0' and so_inner.bso_type_no is not null  "+
									"  ) "+
									" union all "+
									" ( select count(*) from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner "+
									" where so_inner.BSO_CREATED_DATE   between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.bso_is_installation='1'  and so_inner.bso_is_delivery='0'  and so_inner.bso_type_no is not null  "+
									"  )  "+
									" union all "+
									" ( select count(*) from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner "+
									" where so_inner.BSO_CREATED_DATE    between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.bso_is_installation='1'  and so_inner.bso_is_delivery='1'  "+
									" and so_inner.bso_type_no is not null "+
									"  )  "+
									" union all "+
									" ( select count(*) from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner "+
									" where so_inner.BSO_CREATED_DATE    between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.BSO_IS_DELIVERY_INSTALLATION='1' and so_inner.bso_type_no is not null "+
									"  )  "+
									" union all "+
									" ( select count(*) from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner "+
									" where so_inner.BSO_CREATED_DATE    between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.BSO_IS_NO_DELIVERY='1' and so_inner.bso_type_no is not null  "+
									"  ) "+
									" union all "+
									" (SELECT "+ 
									"  count(*) "+
									"  FROM  "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING item_mapping left join "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner on so_inner.BSO_ID=item_mapping.BSO_ID  "+
									" where item_mapping.IS_SERIAL=1  and so_inner.BSO_CREATED_DATE between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.bso_type_no is not null )   "+
									" union all "+
									" (SELECT "+
									"   sum(item.PRICE *item.amount)  "+
									"  FROM   "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING item_mapping left join "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner on so_inner.BSO_ID=item_mapping.BSO_ID  left join "+
									"  "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM item "+
									"   on item_mapping.BSO_ID=item.BSO_ID "+
									" where      so_inner.BSO_CREATED_DATE between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.bso_type_no is not null ) "+
									" union all "+
									" (SELECT "+
									"   sum(item.PRICE_COST*item.amount)  "+
									"  FROM    "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING item_mapping left join "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner on so_inner.BSO_ID=item_mapping.BSO_ID  left join "+
									"  "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM item "+
									"   on item_mapping.BSO_ID=item.BSO_ID "+
									" where   so_inner.BSO_CREATED_DATE between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.bso_type_no is not null ) "+
									" union all "+
									" (SELECT "+
									"   sum((item.PRICE*item.amount)-(item.PRICE_COST*item.amount))  "+
									"  FROM   "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING item_mapping left join "+
									" "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner on so_inner.BSO_ID=item_mapping.BSO_ID  left join "+
									"  "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM item "+
									"   on item_mapping.BSO_ID=item.BSO_ID "+
									" where  so_inner.BSO_CREATED_DATE between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and so_inner.bso_type_no is not null ) ";
							//System.out.println("...report so query = "+query);
							vresultMessage= pstObjectService.searchObject(query);
							 
					         List<Object> so_list= vresultMessage.getResultListObj();
					         int so_size=so_list.size(); 
					         Object[] so_result=new Object[11];
					         String[] day_start_show=start.split("-");
					         String[] day_end_show=end.split("-");
					         if(isMonth){
					        	 so_result[0]=day_start_show[2]+" - "+day_end_show[2]+" ["+day_start_show[1]+"/"+day_start_show[0]+"]";
					         }else{
					        	 so_result[0]=day_start_show[2]+"/"+day_start_show[1]+"/"+day_start_show[0];
					         }
					         
					         for (int i = 0; i < so_size; i++) {
					        	 so_result[i+1]=((java.math.BigDecimal)so_list.get(i)) ;
							 }
					         
					         so_list_return.add(so_result);
								// result_return.setResultListObj(so_list_return);
						  }
							result_return.setResultListObj(so_list_return);
						}
							/* = new VResultMessage();
							vresultMessage.setResultListObj(list);*/ 
							return getRepresentation(entity, result_return, xstream);
						}
						else if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH_REPORT_DEPT_STATUS)){
							//@SuppressWarnings({ "rawtypes" })
							//List list= pstObjectService.searchObject(xbpsTerm.getQuery()[0]); 
							VResultMessage result_return = new VResultMessage();
							VMessage resultMessage =new VMessage();
							String msgCode="ok";
							String msgDesc="ok";
							resultMessage.setMsgDesc(msgDesc);
							resultMessage.setMsgCode(msgCode); 
							result_return.setResultMessage(resultMessage); 
							 List<Object[]> so_list_return=null;
							// result_return.setResultListObj(so_list_return);
							boolean isMonth=false;
							String start_date=xbpsTerm.getQuery()[0];
							String end_date=xbpsTerm.getQuery()[1];
							DateTime dt_start=null;
							DateTime dt_end=null;
							String[] time_from_slit=start_date.split("-");
							String[] time_end_slit=end_date.split("-");
							List<String[]> date_where=null;
							if(!time_from_slit[1].equals(time_end_slit[1])){
								isMonth=true;
								List<DateTime[]> date_list=new ArrayList<DateTime[]>();
								DateTime dt1 = null;
								try {
									dt1 = new DateTime(format_report_so.parse(start_date));
								} catch (ParseException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								DateTime dt2 = null;
								try {
									dt2 = new DateTime(format_report_so.parse(end_date));
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
										 dt_start=dt1.dayOfMonth().setCopy(time_from_slit[2]+"");
									 else
										 dt_start=dt1.dayOfMonth().setCopy(dt1.dayOfMonth().getMinimumValue()+""); 
										  d_array[0]=dt_start; 
									 if(dt_end.isBefore(dt2.getMillis())){ 
										  d_array[1]=dt_end;
									 }
									 else{ 
										 d_array[1]=dt2;
									 } 
									 date_list.add(d_array);
									 dt1=dt1.plusMonths(1);  
									 index_date++; 
									} while (dt1.isBefore(dt2.getMillis()));
								 
								int date_size=date_list.size(); 
								  date_where=new ArrayList<String[]>(date_size);
								for (int i=0;i<date_size;i++){//DateTime dateTime : date_list) {
									//System.out.println(date_list.get(i)[1]+" , "+date_list.get(i)[0]);
									String date_start=date_list.get(i)[0].year().get()+"-"+date_list.get(i)[0].monthOfYear().get()+"-"+date_list.get(i)[0].dayOfMonth().get();
									String date_end=date_list.get(i)[1].year().get()+"-"+date_list.get(i)[1].monthOfYear().get()+"-"+date_list.get(i)[1].dayOfMonth().get();
									 date_where.add(new String[]{date_start,date_end});
								}
							}else{ 
								String query_date=" "+
												  " select DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d'),DATE_FORMAT(sv.BSJ_CREATED_TIME,'%d/%m/%Y')  from "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv  "+
												// " left join   "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv.bcc_no=call_center.bcc_no "+
												  " where sv.BSJ_CREATED_TIME between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59' "+
												 // " and so.bso_type_no is not null  "+
												  " group by DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d') ";
								vresultMessage= pstObjectService.searchObject(query_date);
							 
						         List<Object[]> date_list= vresultMessage.getResultListObj();
						       if(date_list!=null){
						    	   int date_size=date_list.size();
							         date_where=new ArrayList<String[]>(date_size);
						         for (int j = 0; j < date_size; j++) {
					        		 Object[] objs_value=date_list.get(j);
					        		 date_where.add(new String[]{(String)objs_value[0],(String)objs_value[0]}); 
								}
							}  
						}
							
						if(date_where!=null && date_where.size()>0){
							int date_where_size=date_where.size(); 
							  so_list_return=new ArrayList<Object[]>(date_where_size);;
							for (int b = 0; b < date_where_size; b++) {  
								String start =date_where.get(b)[0];
								String end =date_where.get(b)[1];
							String query =" "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59'  "+
									" )   "+ //-- as job_all
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_DEPT_ID=2) "+ // -- as st_1
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_DEPT_ID=3)    "+//--  as st_2 
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_DEPT_ID=4)    "+//-- as st_3
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_DEPT_ID=5)   "+//-- as st_4
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME   between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_DEPT_ID=1)   "+//-- as st_5 
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_JOB_STATUS=2)    "+//-- as st_6 
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_JOB_STATUS=3)    "+//-- as st_7 
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_JOB_STATUS=6)     "+//-- as st_8
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+
									" sv_inner.BSJ_CREATED_TIME between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_JOB_STATUS=7  "+
									" )    "+//-- as job_commplete 
									" union all  "+
									" ( SELECT COUNT(*) FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner left join  "+
									" "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
									" where    "+ 
									" sv_inner.BSJ_CREATED_TIME  between '"+start+" 00:00:00' and '"+end+" 23:59:59' "+
									" and sv_inner.SBJ_JOB_STATUS!=7  "+
									" )  ";// --  as job_not_commplete
									
									 
							vresultMessage= pstObjectService.searchObject(query);
							 
					         List<Object> so_list= vresultMessage.getResultListObj();
					         int so_size=so_list.size(); 
					         Object[] so_result=new Object[13];
					         String[] day_start_show=start.split("-");
					         String[] day_end_show=end.split("-");
					         so_result[12]=start+"_"+end;
					         if(isMonth){
					        	 so_result[0]=day_start_show[2]+" - "+day_end_show[2]+" ["+day_start_show[1]+"/"+day_start_show[0]+"]";
					         }else{
					        	 so_result[0]=day_start_show[2]+"/"+day_start_show[1]+"/"+day_start_show[0];
					         }
					         
					         for (int i = 0; i < so_size; i++) {
					        	 so_result[i+1]=((java.math.BigInteger)so_list.get(i)) ;
							 }
					         
					         so_list_return.add(so_result);
								// result_return.setResultListObj(so_list_return);
						  }
							result_return.setResultListObj(so_list_return);
						}
							/* = new VResultMessage();
							vresultMessage.setResultListObj(list);*/ 
							return getRepresentation(entity, result_return, xstream);
						}
						else if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH_REPORT_PMMA)){ 
							VResultMessage result_return = new VResultMessage();
							VMessage resultMessage =new VMessage();
							String msgCode="ok";
							String msgDesc="ok";
							resultMessage.setMsgDesc(msgDesc);
							resultMessage.setMsgCode(msgCode); 
							result_return.setResultMessage(resultMessage); 
							String start_date=xbpsTerm.getQuery()[0];
							String end_date=xbpsTerm.getQuery()[1];
							String viewBy=xbpsTerm.getQuery()[2];
							String viewBy_where="";
							 List<Object[]> pm_list_return=null;
							  List<Object[]> viewBy_list=null; 
							 // center_list
							 String query_center=" "+
									  " SELECT u.id,concat(bc_name,'[', u.firstName,' ',u.lastName,']') FROM "+ServiceConstant.SCHEMA+".BPM_CENTER center left join SYNDOME_BPM_DB.user u "+ 
									  " on center.uid=u.id  ";
									  
							 vresultMessage= pstObjectService.searchObject(query_center); 
							 
							 List<Object[]> center_list= vresultMessage.getResultListObj();
							 String query_viewBy="";
			                 if(viewBy.equals("1")){ //provices 
			                	 query_viewBy=" select  so.BSO_INSTALLATION_PROVINCE as c1,  so.BSO_INSTALLATION_PROVINCE as c2 from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma "+    
			                			 " left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id  "+
			                		//	 " left join SYNDOME_BPM_DB.BPM_ARMAS armas on armas.CUSCOD=so.CUSCOD  "+   
			                		//	 " left join SYNDOME_BPM_DB.user user on user.id=pmma.BPMJ_CENTER  "+  
			                			 " where pmma.bpmj_job_status=1 "+   
			                			 " and pmma.BPMJ_DUEDATE   "+
			                			 " between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59'   "+
			                			 " and so.BSO_INSTALLATION_PROVINCE is not null and so.BSO_INSTALLATION_PROVINCE!='' "+ 
			                			 " group by so.BSO_INSTALLATION_PROVINCE  order by so.BSO_INSTALLATION_PROVINCE "; 
			                	 viewBy_where=" and so.BSO_INSTALLATION_PROVINCE";
			                 }else if(viewBy.equals("2")){ // 2 cust
			                	 query_viewBy=" select pmma.BPMJ_CUST_NAME as c1,  pmma.BPMJ_CUST_NAME as c2 from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma   "+  
			                			 " left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id  "+  
			                			 " where pmma.bpmj_job_status=1 "+   
			                			 " and pmma.BPMJ_DUEDATE   "+
			                			 " between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59'     "+
			                			 " and pmma.BPMJ_CUST_NAME is not null  and pmma.BPMJ_CUST_NAME!='' "+ 
			                			 " group by pmma.BPMJ_CUST_NAME  order by pmma.BPMJ_CUST_NAME  "; 
			                	 viewBy_where=" and pmma.BPMJ_CUST_NAME";
			                 }else if(viewBy.equals("3")){ // 3 model
			                	 query_viewBy=" select pmma.BPMJ_UPS_MODEL as c1,pmma.BPMJ_UPS_MODEL as c2 from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma   "+   
			                			 " where pmma.bpmj_job_status=1 "+   
			                			 " and pmma.BPMJ_DUEDATE   "+
			                			 " between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59'     "+
			                			 " and pmma.BPMJ_UPS_MODEL is not null  and pmma.BPMJ_UPS_MODEL!='' "+
			                			 " group by pmma.BPMJ_UPS_MODEL  order by pmma.BPMJ_UPS_MODEL ";
			                	 viewBy_where=" and pmma.BPMJ_UPS_MODEL";
			                 }
			                 vresultMessage= pstObjectService.searchObject(query_viewBy); 
							 
		                	 viewBy_list= vresultMessage.getResultListObj();
							boolean isMonth=false;
							
							DateTime dt_start=null;
							DateTime dt_end=null;
							String[] time_from_slit=start_date.split("-");
							String[] time_end_slit=end_date.split("-");
							List<String[]> date_where=null;
							if(!time_from_slit[1].equals(time_end_slit[1])){
								isMonth=true;
								List<DateTime[]> date_list=new ArrayList<DateTime[]>();
								DateTime dt1 = null;
								try {
									dt1 = new DateTime(format_report_so.parse(start_date));
								} catch (ParseException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								DateTime dt2 = null;
								try {
									dt2 = new DateTime(format_report_so.parse(end_date));
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
										 dt_start=dt1.dayOfMonth().setCopy(time_from_slit[2]+"");
									 else
										 dt_start=dt1.dayOfMonth().setCopy(dt1.dayOfMonth().getMinimumValue()+""); 
										  d_array[0]=dt_start; 
									 if(dt_end.isBefore(dt2.getMillis())){ 
										  d_array[1]=dt_end;
									 }
									 else{ 
										 d_array[1]=dt2;
									 } 
									 date_list.add(d_array);
									 dt1=dt1.plusMonths(1);  
									 index_date++; 
									} while (dt1.isBefore(dt2.getMillis()));
								 
								int date_size=date_list.size(); 
								  date_where=new ArrayList<String[]>(date_size);
								for (int i=0;i<date_size;i++){//DateTime dateTime : date_list) {
									//System.out.println(date_list.get(i)[1]+" , "+date_list.get(i)[0]);
									String date_start=date_list.get(i)[0].year().get()+"-"+date_list.get(i)[0].monthOfYear().get()+"-"+date_list.get(i)[0].dayOfMonth().get();
									String date_end=date_list.get(i)[1].year().get()+"-"+date_list.get(i)[1].monthOfYear().get()+"-"+date_list.get(i)[1].dayOfMonth().get();
									 date_where.add(new String[]{date_start,date_end});
								}
							}else{  
								/* String query_date=" "+
												  " select DATE_FORMAT(pmma.BPMJ_DUEDATE,'%Y-%m-%d'),DATE_FORMAT(pmma.BPMJ_DUEDATE,'%d/%m/%Y')  from "+ServiceConstant.SCHEMA+".BPM_PM_MA_JOB pmma  "+
												
												  " where  pmma.bpmj_job_status=1  and  pmma.BPMJ_DUEDATE  between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59' "+
												 // " and so.bso_type_no is not null  "+
												  " group by DATE_FORMAT(pmma.BPMJ_DUEDATE ,'%Y-%m-%d') order by pmma.BPMJ_DUEDATE ";
								vresultMessage= pstObjectService.searchObject(query_date);
							 
						         List<Object[]> date_list= vresultMessage.getResultListObj();
						       if(date_list!=null){
						    	   int date_size=date_list.size();
							         date_where=new ArrayList<String[]>(date_size);
						         for (int j = 0; j < date_size; j++) {
					        		 Object[] objs_value=date_list.get(j);
					        		 date_where.add(new String[]{(String)objs_value[0],(String)objs_value[0]}); 
								}
							} 
							*/ 
						}
						StringBuffer sb=new StringBuffer();
						if(viewBy_list!=null && viewBy_list.size()>0 ){
							int viewBy_size=viewBy_list.size();
							
						//	pm_list_return=new ArrayList<Object[]>(viewBy_size*date_where_size);
							pm_list_return=new ArrayList<Object[]>();
							int center_size=center_list.size(); 
							for (int i = 0; i < viewBy_size; i++) { 
								 Object[] objs_value=viewBy_list.get(i);
								 String objs_value_view=(String)objs_value[0];
				        		// date_where.add(new String[]{(String)objs_value[0],(String)objs_value[0]}); 
								 if(time_from_slit[1].equals(time_end_slit[1])){
										String query_date=" "+
														  " select DATE_FORMAT(pmma.BPMJ_DUEDATE,'%Y-%m-%d'),DATE_FORMAT(pmma.BPMJ_DUEDATE,'%d/%m/%Y')  from "+ServiceConstant.SCHEMA+".BPM_PM_MA_JOB pmma  "+
														  " left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id  "+
														  " where  pmma.bpmj_job_status=1  and  pmma.BPMJ_DUEDATE  between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59' "+
														 // " and so.bso_type_no is not null  "+
														 "  "+viewBy_where+"='"+objs_value_view+"'	"+
														  " group by DATE_FORMAT(pmma.BPMJ_DUEDATE ,'%Y-%m-%d') order by pmma.BPMJ_DUEDATE ";
										vresultMessage= pstObjectService.searchObject(query_date);
									 
								         List<Object[]> date_list= vresultMessage.getResultListObj();
								       if(date_list!=null){
								    	   int date_size=date_list.size();
									         date_where=new ArrayList<String[]>(date_size);
								         for (int j = 0; j < date_size; j++) {
							        		 Object[] objs_date_value=date_list.get(j);
							        		 date_where.add(new String[]{(String)objs_date_value[0],(String)objs_date_value[0]}); 
										}
									}
								}

									int date_where_size=date_where.size(); 
								 for (int j = 0; j < date_where_size; j++) {
									 sb.setLength(0);
									 String start =date_where.get(j)[0];
										String end =date_where.get(j)[1];
										for (int k = 0; k < center_size; k++) {
										   Object obj_uid=	center_list.get(k)[0];
										   String union_all=(k!=center_size-1)?" union all ":"";
										   sb.append("select count(*)   from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma "+
												   " left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id  "+
													" where pmma.bpmj_job_status=1  "+
													"  and pmma.BPMJ_DUEDATE  	"+
													"  between '"+start+" 00:00:00' and '"+end+" 23:59:59'	"+  
													"  "+viewBy_where+"='"+objs_value_view+"'	"+
													"  and pmma.bpmj_center='"+obj_uid+"'");
										   sb.append(union_all);
										}
										vresultMessage= pstObjectService.searchObject(sb.toString());
										 
								         List<Object> pmma_list= vresultMessage.getResultListObj();
								         int pmma_size=pmma_list.size(); 
								         Object[] pmma_result=new Object[center_size+3];
								         String[] day_start_show=start.split("-");
								         String[] day_end_show=end.split("-");
								         pmma_result[center_size+2]=start+"_"+end;
								         pmma_result[0]=objs_value_view;
								         if(isMonth){
								        	 pmma_result[1]=day_start_show[2]+" - "+day_end_show[2]+" ["+day_start_show[1]+"/"+day_start_show[0]+"]";
								         }else{
								        	 pmma_result[1]=day_start_show[2]+"/"+day_start_show[1]+"/"+day_start_show[0];
								         }
								         for (int k = 0; k < pmma_size; k++) {
								        	 pmma_result[k+2]=((java.math.BigInteger)pmma_list.get(k)) ;
										 } 
								         pm_list_return.add(pmma_result);
								}

							}
							result_return.setResultListObj(pm_list_return);
						} 
							return getRepresentation(entity, result_return, xstream);
						}
						
						//----Aui add KA Report---//
						else if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH_REPORT_KA)){
							System.out.println("------aui print PstObj KA -------");
							VResultMessage result_return = new VResultMessage();
							VMessage resultMessage =new VMessage();
							String msgCode="ok";
							String msgDesc="ok";
							resultMessage.setMsgDesc(msgDesc);
							resultMessage.setMsgCode(msgCode); 
							result_return.setResultMessage(resultMessage); 
							String start_date=xbpsTerm.getQuery()[0];
							String end_date=xbpsTerm.getQuery()[1];
							String viewBy=xbpsTerm.getQuery()[2];
							String viewBy_where="";
							List<Object[]> ka_list_return=null;
							List<Object[]> viewBy_list=null; 
							
							String query_list="SELECT call_center.BCC_NO as BCC_NO, "+//1
						 			"IFNULL(call_center.BCC_ADDR1 ,'') as BRANCH, "+//2
						 			"IFNULL(call_center.BCC_PROVINCE ,'') as PROVINCE, "+//3
						 			"CONCAT(IFNULL(call_center.BCC_ADDR1 ,''),' ', "+
						 			"IFNULL(call_center.BCC_ADDR2 ,''),' ',IFNULL(call_center.BCC_ADDR3 ,'') , ' ' ,IFNULL(call_center.BCC_PROVINCE ,''),' ',IFNULL(call_center.BCC_ZIPCODE ,'')) as ADDRESS , "+//4
						 			"IFNULL(call_center.BCC_SERIAL,'') as BCC_SERIAL, "+//5
						 			"IFNULL(call_center.BCC_MODEL,'') as BCC_MODEL, "+//6
						 			"IFNULL(call_center.BCC_CAUSE,'') as BCC_CAUSE, "+//7
						 			"IFNULL(sp.SPARES,'') as SPARES, "+//8
						 			"IFNULL(job_status.BJS_STATUS,'')  as JOB_STATUS ,	"+//9
						 			"IFNULL(service_job.SBJ_PROBLEM_CAUSE,'') as PROBLEM_CAUSE, "+//10
						 			"IFNULL(service_job.SBJ_JOB_PROBLEM_SOLUTION,'') as PROBLEM_SOLUTION, "+//11
						 			"CONCAT(IFNULL(user.firstname,''),' ',IFNULL(user.lastname,'')) AS OWNER, "+//12
						 			"IFNULL(dept.BDEPT_DETAIL,'') as DEPT_NAME, "+//13
						 			"IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y'),'') as CREATE_DATE, "+//14
						 			"IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'Pending') as SLA_Date, "+//15
						 			"CASE "+
						 				"WHEN call_center.BCC_DUE_DATE IS NOT NULL "+
						 			"THEN 'Complete' "+
						 			"ELSE '' "+
						 			"END  as PLAN_CLOSE, "+//16
						 			"DATEDIFF(IFNULL(call_center.BCC_DUE_DATE,now()),call_center.BCC_CREATED_TIME) as Aging_SLA, "+//17
						 			"IFNULL(TIMESTAMPDIFF(day, call_center.BCC_CREATED_TIME,now()),'') as Aging_Job "+//18
			    
									"FROM SYNDOME_BPM_DB.BPM_TO_DO_LIST todo "+
									"left join SYNDOME_BPM_DB.BPM_SYSTEM_PARAM param "+ 
										"on (param.param_name='FLOW_NAME' and param.`key`=todo.btdl_type) "+
									"left join SYNDOME_BPM_DB.BPM_CALL_CENTER call_center "+
										"on (todo.BTDL_REF=call_center.BCC_NO) "+
									"left join SYNDOME_BPM_DB.BPM_SERVICE_JOB service_job "+
										"on (call_center.BCC_NO=service_job.BCC_NO)   "+
									"left join SYNDOME_BPM_DB.BPM_JOB_STATUS job_status "+
										"on (job_status.BJS_ID=service_job.SBJ_JOB_STATUS and job_status.BJS_TYPE=2)   "+
									"left join SYNDOME_BPM_DB.BPM_SYSTEM_PARAM param2 "+
										"on (param2.param_name='STATE' and param2.`key`=todo.BTDL_STATE) "+
									"left join ( "+
										"SELECT mapping.BCC_NO,GROUP_CONCAT(IFNULL(product.IMA_ItemName,'') separator ',') AS SPARES "+
										"FROM SYNDOME_BPM_DB.BPM_SERVICE_ITEM_MAPPING  mapping "+
										"left join SYNDOME_BPM_DB.BPM_PRODUCT product "+
											"on mapping.IMA_ItemID=product.IMA_ItemID  and mapping.BSIM_TYPE=2 "+
										"GROUP BY mapping.BCC_NO) sp "+
										"on sp.BCC_NO =call_center.BCC_NO "+ 
									"left join SYNDOME_BPM_DB.user user "+
										"on user.username = todo.BTDL_OWNER "+
									"left join SYNDOME_BPM_DB.BPM_DEPARTMENT_USER dept_user "+
										"on dept_user.USER_ID = user.id "+
									"left join SYNDOME_BPM_DB.BPM_DEPARTMENT dept "+
										"on dept.BDEPT_ID = dept_user.BDEPT_ID "+
			    
									//"where "+
									"where todo.BTDL_HIDE='1' "+
										"and todo.BTDL_TYPE='2' "+
										"and call_center.BCC_LOCATION like N'%"+viewBy+"%' "+
										//" call_center.BCC_LOCATION like N'%ATM%' ";
										"and call_center.BCC_CREATED_TIME "+
										" between '"+start_date+" 00:00:00' and '"+end_date+" 23:59:59'     ";		
							
							 vresultMessage= pstObjectService.searchObject(query_list);
							   
							 
							return getRepresentation(entity, vresultMessage, xstream);
							
						}
						
						else if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH_SERVICE)){
							//int updateRecord=pstObjectService.executeQuery(xbpsTerm.getQuery());
							String query=SERVICE_QUERY+"'"+xbpsTerm.getQuery()[0]+"'"; 
				//System.out.println(query);
							vresultMessage=pstObjectService.searchObject(query);
							return getRepresentation(entity, vresultMessage, xstream);
							//return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH_TO_DO_LIST)){
							//logger.error("...aui in PstObjectResource 1111111111");
							//int updateRecord=pstObjectService.executeQuery(xbpsTerm.getQuery());
							//String query=SERVICE_QUERY+"'"+xbpsTerm.getQuery()[0]+"'"; 
							// PstObject pstObject = new PstObject(new String[]{serviceType,username,role,page,isStore});
							//searchTodoList(serviceType,username,role,page,pageG,isStore);
							String service_type=xbpsTerm.getQuery()[0];
							String service_status=xbpsTerm.getQuery()[1];
							String usernameG=xbpsTerm.getQuery()[2];
							String rolesG=xbpsTerm.getQuery()[3];
							int _page=Integer.valueOf(xbpsTerm.getQuery()[4]);;
							int _perpageG=Integer.valueOf(xbpsTerm.getQuery()[5]);
							String isStore=xbpsTerm.getQuery()[6]; // 0 = no , 1 =yes
							
							String type=xbpsTerm.getQuery()[7]; // 1 = query , 2 = count
							String job_key=xbpsTerm.getQuery()[8]; // job no
							String BTDL_CREATED_TIME=xbpsTerm.getQuery()[9]; // d_m_y-d_m_y
							String queryall=getTodoListQuery(service_type, service_status,usernameG, rolesG, _page, _perpageG, isStore,job_key,BTDL_CREATED_TIME,type);
							//System.out.println("-----aui print 11111 queryall="+queryall);
							int limitRow=(_page>1)?((_page-1)*_perpageG):0;
						    String queryObject="";
							  if(type.equals("1")){
								  queryObject="  "+queryall+"   limit "+limitRow+", "+_perpageG;
								  //System.out.println("queryObject-->1 ="+queryObject);
							  }else{
								  //queryObject=" select count(*) from (  "+queryall+" ) as x";
								  queryObject=queryall;
								  //System.out.println("queryObject-->2 ="+queryObject);
							  }
							  //System.out.println(queryObject);
							vresultMessage=pstObjectService.searchObject(queryObject);
							   
							return getRepresentation(entity, vresultMessage, xstream);
							//return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH_SERVICES_REPORT)){
							  
							int day_end=Integer.valueOf(xbpsTerm.getQuery()[0]);;
							int day_start=Integer.valueOf(xbpsTerm.getQuery()[1]);
							String year=xbpsTerm.getQuery()[2]; // 0 = no , 1 =yes
							
							String month=xbpsTerm.getQuery()[3]; // 1 = query , 2 = count
							String username=xbpsTerm.getQuery()[4]; // job no
							String queryReport= getServicesReportQueryV2(  day_end,  day_start,  year,  month,  username) ;
						 
							  //System.out.println(queryObject);
							vresultMessage=pstObjectService.searchObject(queryReport);
							   
							return getRepresentation(entity, vresultMessage, xstream);
							//return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_OBJECT_GEN_PMMA)){
							//int updateRecord=pstObjectService.executeQuery(xbpsTerm.getQuery()); 
							String duedate=xbpsTerm.getQuery()[0];
							String username=xbpsTerm.getQuery()[1];
							String BPMJ_NO=xbpsTerm.getQuery()[2];
							//  BPMJ_NO="83";
							int pm_amount=Integer.valueOf(xbpsTerm.getQuery()[3]);
							int pm_year=Integer.valueOf(xbpsTerm.getQuery()[4]);
							//duedate,username,BPMJ_NO,pm_amount
							//Date d=new Date();  
							String query="SELECT  so.BSO_ID as c0, "+
										" IFNULL(so.CUSCOD,'') as c1, "+
										  "  CASE  "+
											 "    WHEN (select so.BSO_IS_DELIVERY='1')   "+
											 "         THEN   "+
											 " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'')  "+
											 "       WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1')   "+
											 "         THEN   "+
											 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'')  "+
											 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
											 "         THEN   "+
											 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'')  "+
											 "         ELSE "+
										     "  			 ''"+
											 "        END as c2, "+ 
										" IFNULL(so.BSO_INSTALLATION_SITE_LOCATION,'') as c3, "+
										" IFNULL(so.BSO_INSTALLATION_CONTACT,'') as c4, "+
										" IFNULL(so.BSO_INSTALLATION_TEL_FAX,'') as c5, "+ 
										" IFNULL(so.BSO_INSTALLATION_ADDR1,'') as c6, "+
										" IFNULL(so.BSO_INSTALLATION_ADDR2,'') as c7, "+
										" IFNULL(so.BSO_INSTALLATION_ADDR3,'') as c8, "+ 
										" IFNULL(so.BSO_INSTALLATION_PROVINCE,'') as c9, "+
										" IFNULL(so.BSO_INSTALLATION_ZIPCODE,'') as c10 ,  "+ 
										 "  CASE  "+
										 "    WHEN (select so.BSO_IS_DELIVERY='1')   "+
										 "         THEN   "+
										 " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i'),'')  "+
										 "       WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1')   "+
										 "         THEN   "+
										 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i'),'')  "+
										 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
										 "         THEN   "+
										 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i'),'')  "+
										 "         ELSE "+
									     "  			 ''"+
										 "        END as c11 ,  "+
									     " case when(mapping.is_serial='0') then 'ไม่ระบุ'  else IFNULL(mapping.serial,'') end as c12, "+
									     "IFNULL(product.IMA_ItemName,'') as c13, "+
									     "IFNULL(so.BSO_TYPE_NO,'') as c14, "+
									     " ifnull(armas.CUSNAM,'') as c15 "+
										" FROM  "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping left join "+
										ServiceConstant.SCHEMA+".BPM_SALE_ORDER so  on mapping.BSO_ID=so.BSO_ID left join "+
										ServiceConstant.SCHEMA+".BPM_PRODUCT product on mapping.IMA_ItemID=product.IMA_ItemID left join "+
										ServiceConstant.SCHEMA+".BPM_ARMAS armas  on armas.CUSCOD=so.CUSCOD  "
											//	+ " where so.BSO_ID="+BPMJ_NO+" AND mapping.serial != '0001'  ";
											+ " where so.BSO_ID="+BPMJ_NO+" AND mapping.is_serial = '1' and mapping.IMA_ItemID like '9%' ";
										//and mapping.AUTO_K=0";
							// System.out.println(query);
							vresultMessage=pstObjectService.searchObject(query);
							if(vresultMessage.getResultMessage().getMsgCode().equals("ok")){
								List<Object[]> list=vresultMessage.getResultListObj();
								if(list!=null && list.size()>0){
									int size=list.size();
									for (int i = 0; i < size; i++) {
										Object[] obj=list.get(i);
										String BPMJ_CUST_CODE=(String)obj[1];
										String BPMJ_LOCATION=(String)obj[3];
										String BPMJ_ADDR1=(String)obj[6];
										String BPMJ_ADDR2=(String)obj[7];
										String BPMJ_ADDR3=(String)obj[8];
										String BPMJ_PROVINCE=(String)obj[9];
										String BPMJ_ZIPCODE=(String)obj[10];
										String BPMJ_TEL_FAX=(String)obj[5];
										String BPMJ_CONTACT_NAME=(String)obj[4];
										String BPMJ_CONTACT_SURNAME="";
										String BPMJ_CONTACT_POSITION="";
										String BPMJ_CONTACT_MOBILE=(String)obj[5];
										String BPMJ_UPS_MODEL=(String)obj[13];
										String BPMJ_SERAIL=(String)obj[12];
									//	String BPMJ_ORDER=(String)obj[3];
										String BPMJ_DUEDATE=(String)obj[2];
										String  BPMJ_CUST_NAME= ((String)obj[3]);
										String BPMJ_DUEDATE_START_TIME=(String)obj[11];
										String BPMJ_SO_NO=(String)obj[14];
										if(BPMJ_DUEDATE_START_TIME.length()>0){
											BPMJ_DUEDATE_START_TIME="'"+BPMJ_DUEDATE_START_TIME+"'";
										}else{
											BPMJ_DUEDATE_START_TIME="null";
										}
										
										DateTime dt=null;
										if(BPMJ_DUEDATE!=null && BPMJ_DUEDATE.length()>0){
											try {
												dt = new DateTime(format1.parse(BPMJ_DUEDATE));
											} catch (ParseException e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
										}else{
											Date d=new Date();
											dt =new DateTime(d.getTime());
										} 
										DateTime dt2=dt.plusYears(pm_year); 
										int index=1;
										 ArrayList<String> querylist = new ArrayList<String>();
										 ArrayList<String[]> querylist_value = new ArrayList<String[]>();
										 do {
											dt=dt.plusMonths(pm_amount); 
												BPMJ_DUEDATE="'"+dt.getYear()+"-"+dt.monthOfYear().get()+"-"+dt.dayOfMonth().get()+" 00:00:00'";
											 
											//2014-01-07 00:00:00
											//System.out.println(dt); 
												/*var query="insert into "+SCHEMA_G+".user set username=?, password=?,firstName=?,lastName=?,email=?,mobile=?,detail=?,enabled=1,type=0,BPM_ROLE_ID="+role_id;
												if($("#mode").val()=='edit'){
													 query="update "+SCHEMA_G+".user set username=?, password=?,firstName=?,lastName=?,email=?,mobile=?,detail=?,BPM_ROLE_ID="+role_id+" where id=${id}";
												}*/
											String queryinsert=" INSERT INTO "+ServiceConstant.SCHEMA+".BPM_PM_MA_JOB "+
													" ( BPMJ_NO, BPMJ_CREATED_DATE, BPMJ_DUEDATE, BPMJ_DUEDATE_START_TIME, BPMJ_CUST_CODE, "+
													"  BPMJ_LOCATION, BPMJ_ADDR1, BPMJ_ADDR2, BPMJ_ADDR3, BPMJ_PROVINCE, BPMJ_ZIPCODE, "+
													" BPMJ_TEL_FAX, BPMJ_CONTACT_NAME, BPMJ_CONTACT_SURNAME, BPMJ_CONTACT_POSITION, BPMJ_CONTACT_MOBILE, "+
													" BPMJ_UPS_MODEL, BPMJ_SERAIL,BPMJ_ORDER ,bpmj_job_status,BPMJ_SO_NO,BPMJ_CUST_NAME) VALUES  "+
											"('"+BPMJ_NO+"',now(), "+BPMJ_DUEDATE+", "+BPMJ_DUEDATE_START_TIME+", '"+BPMJ_CUST_CODE+"',"+
											" '"+BPMJ_LOCATION+"', '"+BPMJ_ADDR1+"', '"+BPMJ_ADDR2+"', '"+BPMJ_ADDR3+"', '"+BPMJ_PROVINCE+"', '"+BPMJ_ZIPCODE+"',"+
											"  '"+BPMJ_TEL_FAX+"', '"+BPMJ_CONTACT_NAME+"', '"+BPMJ_CONTACT_SURNAME+"', '"+BPMJ_CONTACT_POSITION+"', '"+BPMJ_CONTACT_MOBILE+"',"+
											" '"+BPMJ_UPS_MODEL+"', '"+BPMJ_SERAIL+"',"+(index++)+",0,'"+BPMJ_SO_NO+"','"+BPMJ_CUST_NAME+"' )";
											querylist.add(queryinsert);
											
											/* String[] querys_value = new String[]{BPMJ_CUST_NAME};
											 querylist_value.add(querys_value);	*/										 
											//System.out.println(queryinsert); 
										} while (dt.isBefore(dt2.getMillis())); 
										   /*query="insert into "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
													"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
													"('"+BPMJ_NO+"','3','wait_for_planing','ROLE_MANAGE_PM_MA','2','PM/MA wait for Planing','',0,now(),	null,'1','"+username+"','"+BPMJ_NO+"',null) ";
										 querylist.add(query); */
										 String[] querys = new String[querylist.size()];
										 querys = querylist.toArray(querys);
										 vresultMessage=pstObjectService.executeQuery(querys);
										// vresultMessage=pstObjectService.executeQueryWithValues(querys, querylist_value);
										 // synExpress
										// synExpress(querys);
									}
									
									
								}
							}
							return getRepresentation(entity, vresultMessage, xstream);
							//return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						
						else if(serviceName.equals(ServiceConstant.PST_OBJECT_EXECUTE)){
							//int updateRecord=pstObjectService.executeQuery(xbpsTerm.getQuery());
							vresultMessage=pstObjectService.executeQuery(xbpsTerm.getQuery());
							return getRepresentation(entity, vresultMessage, xstream);
							//return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_OBJECT_EXECUTE_WITH_VALUES)){
							// int updateRecord=pstObjectService.executeQueryWithValues(xbpsTerm.getQuery(),xbpsTerm.getValues());
							vresultMessage=pstObjectService.executeQueryWithValues(xbpsTerm.getQuery(),xbpsTerm.getValues());
							return getRepresentation(entity, vresultMessage, xstream);
							//return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}  
						
					} else {
					}
				}

			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			logger.debug(" into Finally Call");
			try {
				if (in != null)
					in.close();

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	
	}
	private String getServicesReportQuery(int day_end,int day_start,String year,String month,String username){
		// sb_query.setLength(0);
		 StringBuffer sb_query=new StringBuffer();
		 sb_query.append(" select * from ( ");
		 for (int k = day_end; k >= day_start; k--) {
		 sb_query.append("  ( select count(*) as job_all_so_"+k+" from ( SELECT  "+
				 	" ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=so.bso_id  "+
				 	"	and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 	" so.bso_job_status,j_status.BJS_STATUS ,so.BSO_TYPE_NO,  "+
				 	" so. BSO_STATUS,so.BSO_CANCEL_CAUSE ,so.BSO_DELIVERY_DUE_DATE   "+
				 	" FROM "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so left join  "+
				 	" "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+ 
				 " (so.BSO_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=1)     "+
				 " where  "+
				 " so.bso_job_status   in (1,4,5,6,7)   "+
				 "   and so.bso_delivery_due_date between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 " ) as so2  "+
				 " where so2.cc ='"+username+"' "+
				 " ) as job_all_so_"+k+"  "+
				 " , "+
				 " ( select count(*) as job_complete_so_"+k+" from ( SELECT   "+
				 " ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=so.bso_id  "+
				 " and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 " so.bso_job_status,j_status.BJS_STATUS ,so.BSO_TYPE_NO,  "+
				 " so. BSO_STATUS,so.BSO_CANCEL_CAUSE ,so.BSO_DELIVERY_DUE_DATE   "+
				 "  FROM "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+
				 " (so.BSO_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=1)     "+
				 " where  "+
				 "  so.bso_job_status   in (7)   "+
				 "   and so.bso_delivery_due_date between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 " ) as so2  "+
				 " where so2.cc ='"+username+"' "+
				 " ) as job_complete_so_"+k+" "+
				 " ,  "+
				 " ( select count(*) as job_not_complete_so_"+k+" from ( SELECT   "+
				 " ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=so.bso_id  "+
				 " and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 " so.bso_job_status,j_status.BJS_STATUS ,so.BSO_TYPE_NO,  "+
				 " so. BSO_STATUS,so.BSO_CANCEL_CAUSE ,so.BSO_DELIVERY_DUE_DATE   "+
				 "  FROM "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+
				 " (so.BSO_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=1)    "+ 
				 " where  "+
				 "  so.bso_job_status   in (1,4,5,6)   "+
				 "   and so.bso_delivery_due_date between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 " ) as so2  "+
				 " where so2.cc ='"+username+"' "+
				 " ) as job_not_complete_so_"+k+"  "+
				 " , "+
				 " ( select count(*) as job_unit_so_"+k+" from ( SELECT   "+
				 " ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=so.bso_id  "+
				 " and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 " so.bso_job_status,j_status.BJS_STATUS ,so.BSO_TYPE_NO,  "+
				 " so. BSO_STATUS,so.BSO_CANCEL_CAUSE ,so.BSO_DELIVERY_DUE_DATE   "+
				 " FROM "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping left join  "+
				 "  "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so  on (mapping.bso_id=so.bso_id  "+
				 "  )left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+ 
				 " (so.BSO_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=1)     "+
				 " where  "+
				 "  so.bso_job_status   in (1,4,5,6)   "+
				 "   and so.bso_delivery_due_date between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 "  and mapping.IMA_ITEMID like '9%' and mapping.is_serial ='1' "+
				 " ) as so2  "+
				 " where so2.cc ='"+username+"' "+
				 " ) as job_unit_so_"+k+" "+
				 "  , "+
				 " ( select count(*) as job_all_sv_"+k+" from ( SELECT   "+
				 " ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=sv.BCC_NO  "+
				 " and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 " sv.sbj_job_status,j_status.BJS_STATUS ,sv.BCC_NO  "+
				 "   ,call_center.BCC_DUE_DATE  "+
				 "  FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv.BCC_NO=call_center.BCC_NO left join   "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+
				 " (sv.SBJ_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=2)     "+
				 " where  "+
				 "  sv.sbj_job_status  not in (0)   "+
				 "   and call_center.BCC_DUE_DATE between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 " ) as sv2  "+
				 " where sv2.cc ='"+username+"' "+
				 " ) as job_all_sv_"+k+" "+
				 " , "+
				 " ( select count(*) as job_complete_sv_"+k+" from ( SELECT   "+
				 " ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=sv.BCC_NO  "+
				 " and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 " sv.sbj_job_status,j_status.BJS_STATUS ,sv.BCC_NO  "+
				 "   ,call_center.BCC_DUE_DATE  "+
				 "  FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv.BCC_NO=call_center.BCC_NO left join   "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+
				 " (sv.SBJ_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=2)     "+
				 " where  "+
				 "  sv.sbj_job_status    in (7)   "+
				 "  and call_center.BCC_DUE_DATE between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 " ) as sv2  "+
				 " where sv2.cc ='"+username+"' "+
				 " ) as job_complete_sv_"+k+" "+
				 " , "+
				 " ( select count(*) as job_not_complete_sv_"+k+" from ( SELECT   "+
				 " ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=sv.BCC_NO  "+
				 " and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 " sv.sbj_job_status,j_status.BJS_STATUS ,sv.BCC_NO  "+
				 "   ,call_center.BCC_DUE_DATE  "+
				 "  FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv.BCC_NO=call_center.BCC_NO left join   "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+
				 " (sv.SBJ_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=2)     "+
				 " where  "+
				 " sv.sbj_job_status  not in (7)   "+
				 "   and call_center.BCC_DUE_DATE between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 " ) as sv2  "+
				 " where sv2.cc ='"+username+"' "+
				 " ) as job_not_complete_sv_"+k+" "+
				 " ,  ( select count(*) as job_unit_sv_"+k+" from ( SELECT   "+
				 " ( select btdl_owner from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST where BTDL_REF=sv.BCC_NO  "+
				 " and btdl_state like 'wait_for_oper%' order by BTDL_CREATED_TIME desc limit 1 ) as cc,  "+
				 " sv.sbj_job_status,j_status.BJS_STATUS ,sv.BCC_NO  "+
				 "   ,call_center.BCC_DUE_DATE  "+
				 " FROM "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv.BCC_NO=call_center.BCC_NO left join   "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+
				 " (sv.SBJ_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=2)     "+
				 " where   "+
				 "  sv.sbj_job_status  not in (0)   "+
				 "   and call_center.BCC_DUE_DATE between '"+year+"-"+month+"-"+k+" 00:00:00' and '"+year+"-"+month+"-"+k+" 23:59:59' "+
				 " ) as sv2  "+
				 " where sv2.cc ='"+username+"'  "+
				 " ) as job_unit_sv_"+k+"  "); 
		  if(k!=day_start)
			  sb_query.append(", ");
		 }
		 sb_query.append(" ) ");
		 return sb_query.toString();
	}
	private String getServicesReportQueryV2(int day_end,int day_start,String year,String month,String username){
		// sb_query.setLength(0);
		 StringBuffer sb_query=new StringBuffer();
		 sb_query.append(""+
				 " select  "+
				 " date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')  , "+
				 " (select count(*) as job_all_so from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner left join "+
				 "  "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner on todo_inner.BTDL_REF=so_inner.bso_id   "+
				 "  where date_format(so_inner.bso_delivery_due_date,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')  "+
				 "   and btdl_state like 'wait_for_oper%' and so_inner.bso_job_status   in (1,4,5,6,7)   "+
				 " ) as   job_all_so , "+
				 " (select count(*) as job_complete_so from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner left join  "+
				 "  "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner on todo_inner.BTDL_REF=so_inner.bso_id  "+
				 "  where date_format(so_inner.bso_delivery_due_date,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')  "+
				 "  and btdl_state like 'wait_for_oper%' and so_inner.bso_job_status   in (7) "+
				 " ) as   job_complete_so , "+
				 " (select count(*) as job_not_complete_so from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner left join  "+
				 "  "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner on todo_inner.BTDL_REF=so_inner.bso_id   "+
				 "   where date_format(so_inner.bso_delivery_due_date,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')  "+
				 "   and btdl_state like 'wait_for_oper%' and so_inner.bso_job_status   in (1,4,5,6) "+
				 " ) as   job_not_complete_so , "+
				 " (select count(*) as job_unit_so FROM "+ServiceConstant.SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping left join "+
				 "   "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner  on (mapping.bso_id=so_inner.bso_id "+
				 "  ) left join "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on "+
				 " (so_inner.BSO_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=1)  "+
				 " left join  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner  on todo_inner.BTDL_REF=so_inner.bso_id  "+
				 "  where date_format(so_inner.bso_delivery_due_date,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d') "+
				 "  and btdl_state like 'wait_for_oper%' and so_inner.bso_job_status   in (1,4,5,6,7)  "+
				 " and mapping.IMA_ITEMID like '9%' and mapping.is_serial ='1' "+
				 " ) as   job_unit_so  ,"+ 
				 // -- Services 
				 " (select count(*) as job_all_sv from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner left join   "+ 
				 "  "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner on todo_inner.BTDL_REF=sv_inner.BCC_NO    "+ 
				 " left join   "+ 
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv_inner.BCC_NO=call_center.BCC_NO   "+ 
				 "   where date_format(call_center.BCC_DUE_DATE,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')   "+ 
				 "  and btdl_state like 'wait_for_oper%' and sv_inner.sbj_job_status  not in (0)    "+ 
				 " ) as   job_all_sv ,  "+ 
				 " (select count(*) as job_complete_sv from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner left join   "+ 
				 "  "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner on todo_inner.BTDL_REF=sv_inner.BCC_NO    "+ 
				 " left join   "+ 
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv_inner.BCC_NO=call_center.BCC_NO   "+ 
				 "   where date_format(call_center.BCC_DUE_DATE,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')   "+ 
				 "   and btdl_state like 'wait_for_oper%' and sv_inner.sbj_job_status    in (7)    "+ 
				 " ) as   job_complete_sv ,  "+ 
				 " (select count(*) as job_not_complete_sv from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner left join   "+ 
				 "  "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner on todo_inner.BTDL_REF=sv_inner.BCC_NO    "+ 
				 " left join   "+ 
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv_inner.BCC_NO=call_center.BCC_NO   "+ 
				 "   where date_format(call_center.BCC_DUE_DATE,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')   "+ 
				 "   and btdl_state like 'wait_for_oper%' and sv_inner.sbj_job_status   not in (7)    "+ 
				 " ) as   job_not_complete_sv ,   "+ 
				 " (select count(*) as job_unit_sv from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo_inner left join   "+ 
				 "  "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB sv_inner on todo_inner.BTDL_REF=sv_inner.BCC_NO    "+ 
				 " left join   "+ 
				 " "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center on sv_inner.BCC_NO=call_center.BCC_NO   "+ 
				 "   where date_format(call_center.BCC_DUE_DATE,'%Y-%m-%d')=date_format(so.BSO_DELIVERY_DUE_DATE,'%Y-%m-%d')   "+ 
				 "   and btdl_state like 'wait_for_oper%' and sv_inner.sbj_job_status  not in (0)    "+ 
				 " ) as   job_unit_sv  ,  "+ 
				 " todo.btdl_owner  "+
				 " from "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so on todo.BTDL_REF=so.bso_id left join  "+
				 " "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS j_status on  "+
				 " (so.BSO_JOB_STATUS=j_status.BJS_ID and   j_status.BJS_TYPE=1)  "+
				 " where btdl_state like 'wait_for_oper%' and so.bso_job_status   in (1,4,5,6,7)   "+
				 "  and so.bso_delivery_due_date between '"+year+"-"+month+"-"+day_start+" 00:00:00' and '"+year+"-"+month+"-"+day_end+" 23:59:59'  "+
				 "  and todo.btdl_owner='"+username+"'  "+
				 " group by so.BSO_DELIVERY_DUE_DATE "+
				 

				 " order by so.BSO_DELIVERY_DUE_DATE desc  ");
		// sb_query.append(" select * from ( ");
		 
		 return sb_query.toString();
	}
	private String getTodoListQuery(String service_type,String service_status,String usernameG,String rolesG,int _page,int _perpageG,String isStore,String job_key,String BTDL_CREATED_TIME,String type){
		String service_query="";
		String BTDL_CREATED_TIME_query="";
		/*String service_type=xbpsTerm.getQuery()[0];
		String usernameG=xbpsTerm.getQuery()[1];
		String rolesG=xbpsTerm.getQuery()[2];
		int _page=Integer.valueOf(xbpsTerm.getQuery()[3]);;
		int _perpageG=Integer.valueOf(xbpsTerm.getQuery()[4]);
		String isStore=xbpsTerm.getQuery()[5]; // 0 = no , 1 =yes
*/		 
		/*if(!service_type.equals("0"))
			service_query=" where BTDL_TYPE='"+service_type+"' "; */
		boolean haveWhere=false;
		if(!service_type.equals("-1")){
			service_query=" where c32='"+service_type+"' ";
			haveWhere=true;
		}
		if(!service_status.equals("-1")){
			service_query=service_query+((haveWhere)?(" and c47="+service_status+" "):(" where c47="+service_status+""));
			haveWhere=true;
		}
		if(job_key.length()>0){
			service_query=service_query+((haveWhere)?(" and c0 like'%"+job_key+"%' "):(" where c0 like '%"+job_key+"%'"));
			haveWhere=true;
		}
		if(BTDL_CREATED_TIME.length()>0){
			String[] years=BTDL_CREATED_TIME.split("-"); // d m y
			String[] d1=years[0].split("_"); // d m y
			String[] d2=years[1].split("_"); // d m y
			String created_time_start=d1[2]+"-"+d1[1]+"-"+d1[0];
			String created_time_end=d2[2]+"-"+d2[1]+"-"+d2[0];
			BTDL_CREATED_TIME_query=BTDL_CREATED_TIME_query+((haveWhere)?(" and c38 between '"+created_time_start+" 00:00:00' and  '"+created_time_end+" 23:59:59'"):(" where c38 between '"+created_time_start+" 00:00:00' and '"+created_time_end+" 23:59:59'"));
			//BTDL_CREATED_TIME_query=BTDL_CREATED_TIME_query+((haveWhere)?(" and c5 between '"+created_time_start+" 00:00:00' and  '"+created_time_end+" 23:59:59'"):(" where c5 between '"+created_time_start+" 00:00:00' and '"+created_time_end+" 23:59:59'"));
			haveWhere=true;
		}
		String query_so=" SELECT "+
		"so.BSO_TYPE_NO as c0,"+//" call_center.BCC_NO ,"+
		"'-' as c1,"+//" IFNULL(call_center.BCC_SERIAL,'') ,"+
	    "'-' as c2,"+//" IFNULL(call_center.BCC_MODEL,'') ,"+
	    "'-' as c3,"+//" IFNULL(call_center.BCC_CAUSE,'') ,"+
	    "null as c4,"+//"  call_center.BCC_CREATED_TIME  ,"+ 
	    " IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%d/%m/%Y %H:%i'),'')  as c5 ,"+
	    "'-' as c6,"+// " IFNULL(call_center.BCC_SLA,'') ,"+
	    "'-' as c7,"+// " IFNULL(call_center.BCC_IS_MA ,'') ,"+
	    "'-' as c8,"+// " IFNULL(call_center.BCC_MA_NO ,'') ,"+
	    "'-' as c9,"+// " IFNULL(call_center.BCC_MA_START ,'') ,"+
	    "'-' as c10,"+// " IFNULL(call_center.BCC_MA_END ,'') ,"+
	    "'-' as c11,"+//" IFNULL(call_center.BCC_STATUS ,'') ,"+
	    "'-' as c12,"+//" IFNULL(call_center.BCC_REMARK ,'') ,"+
	    "'-' as c13,"+//" IFNULL(call_center.BCC_USER_CREATED ,'') ,"+
	    "'-' as c14,"+//" IFNULL(call_center.BCC_DUE_DATE ,'') ,"+
	   // "IFNULL(so.BSO_DELIVERY_CONTACT,'') as c15,"+// " IFNULL(call_center.BCC_CONTACT ,'') ,"+
	//  CONTACT
	 // TELNUM
	    "  CASE  "+
		 "    WHEN (select so.BSO_IS_DELIVERY='1')   "+
		 "         THEN   "+
		 " CONCAT(IFNULL(so.BSO_DELIVERY_LOCATION ,''),' ',IFNULL(so.BSO_DELIVERY_TEL_FAX ,''))   "+
		 "       WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1')   "+
		 "         THEN   "+
		 " CONCAT(IFNULL(so.BSO_INSTALLATION_CONTACT ,''),' ',IFNULL(so.BSO_INSTALLATION_TEL_FAX ,''))   "+
		 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
		 "         THEN   "+
		 " CONCAT(IFNULL(so.BSO_INSTALLATION_CONTACT ,''),' ',IFNULL(so.BSO_INSTALLATION_TEL_FAX ,''))   "+
		 "         ELSE "+
	    "  			 ''"+
		 "        END as c15, "+
		  "IFNULL(so.BSO_DELIVERY_TEL_FAX,'') as c16,"+//" IFNULL(call_center.BCC_TEL ,'') ,"+
	    "'-' as c17,"+//" IFNULL(call_center.BCC_CUSTOMER_NAME ,'') ,"+ //17  
	    "'-' as c18,"+//" IFNULL(call_center.BCC_ADDR1 ,'') ,"+
	    "'-' as c19,"+//" IFNULL(call_center.BCC_ADDR2 ,'') ,"+
	    "'-' as c20,"+//" IFNULL(call_center.BCC_ADDR3 ,'') ,"+
	   // "'-' as c21,"+//" IFNULL(call_center.BCC_LOCATION ,'') ,"+
	    
	     "  CASE  "+
		 "    WHEN (select so.BSO_IS_DELIVERY='1')   "+
		 "         THEN   "+
		 " CONCAT(IFNULL(so.BSO_DELIVERY_LOCATION ,''),' ',IFNULL(so.BSO_DELIVERY_ADDR1 ,''),' ',IFNULL(so.BSO_DELIVERY_ADDR2 ,''),' ',IFNULL(so.BSO_DELIVERY_ADDR3 ,'') , ' ' "+
		   " 		,IFNULL(so.BSO_DELIVERY_PROVINCE ,''),' ',IFNULL(so.BSO_DELIVERY_ZIPCODE ,''))   "+
		 "       WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1')   "+
		 "         THEN   "+
		 " CONCAT(IFNULL(so.BSO_INSTALLATION_SITE_LOCATION ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR1 ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR2 ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR3 ,'') , ' ' "+
		   " 		,IFNULL(so.BSO_INSTALLATION_PROVINCE ,''),' ',IFNULL(so.BSO_INSTALLATION_ZIPCODE ,''))   "+
		 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
		 "         THEN   "+
		 " CONCAT(IFNULL(so.BSO_INSTALLATION_SITE_LOCATION ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR1 ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR2 ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR3 ,'') , ' ' "+
		   " 		,IFNULL(so.BSO_INSTALLATION_PROVINCE ,''),' ',IFNULL(so.BSO_INSTALLATION_ZIPCODE ,''))   "+
		 "         ELSE "+
	     "  			 ''"+
		 "        END as c21, "+
	    "'-' as c22,"+//" IFNULL(call_center.BCC_PROVINCE ,'') ,"+
	    "'-' as c23,"+//" IFNULL(call_center.BCC_ZIPCODE ,'') ,"+
	    //"'-' as c24,"+//" IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') , "+
	   //   "'-' as c5,"+//" IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') ,"+
	      "  CASE  "+
		 "    WHEN (select so.BSO_IS_DELIVERY='1')   "+
		 "         THEN   "+
		 " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y %H:%i'),'')  "+
		 "       WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1')   "+
		 "         THEN   "+
		 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y %H:%i'),'')  "+
		 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
		 "         THEN   "+
		 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y %H:%i'),'')  "+
		 "         ELSE "+
	     "  			 ''"+
		 "        END as c24, "+
	    "'-' as c25,"+// " IFNULL((select BTDL_STATE  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
	    //"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by BTDL_CREATED_TIME desc limit 1 ) ,''), "+
	    "'-' as c26,"+// " IFNULL((select BTDL_OWNER  FROM  "+ServiceConstant.SCHEMAServiceConstant.SCHEMAServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
		  	//"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by BTDL_CREATED_TIME desc limit 1 ) ,''), "+
		 "'-' as c27,"+//" IFNULL(call_center.BCC_STATE ,'') ,  "+	
		 "'-' as c28,"+//" IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') , "+
		 "'-' as c29,"+//" IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') , "+ 
		"param.value as c30,"+ //30
		" todo.BTDL_REF as c31,"+
		" todo.BTDL_TYPE as c32,"+
		" todo.BTDL_STATE as c33,"+
		" todo.BTDL_OWNER as c34,"+
		" todo.BTDL_OWNER_TYPE as c35,"+
		" todo.BTDL_MESSAGE as c36,"+
		" todo.BTDL_SLA as c37,"+
		//" IFNULL(DATE_FORMAT(todo.BTDL_CREATED_TIME,'%Y-%m-%d %H:%i:%s'),'') as c38,"+
		" todo.BTDL_CREATED_TIME as c38,"+
		" IFNULL(DATE_FORMAT(todo.BTDL_DUE_DATE,'%Y-%m-%d %H:%i:%s'),'') as c39,"+ 
		" todo.BTDL_HIDE as c40,"+
		" todo.BTDL_REQUESTOR as c41,"+
		" todo.REF_NO as c42, "+
		" case when (select todo.BTDL_SLA_UNIT=3600 )  "+
		"  then  concat(todo.BTDL_SLA,' ช.ม.')  "+
		" when (select todo.BTDL_SLA_UNIT=60 ) "+
	   " then  concat(todo.BTDL_SLA,' นาที')  "+
	   " else '' "+
	   "	end as c43 ,   "+
		//" todo.BTDL_SLA_UNIT as c43 , "+   
		" IFNULL(DATE_FORMAT( BTDL_SLA_LIMIT_TIME,'%d/%m/%Y %H:%i:%s'),'') as c44 ,  "+ 
		 "CASE "+
	     " WHEN (select todo.btdl_action_time IS NULL) "+ 
	     " THEN  "+
	     " IFNULL(TIMESTAMPDIFF(MINUTE,now(),todo.btdl_sla_limit_time),'') "+ 
	     " ELSE "+
	     " IFNULL(TIMESTAMPDIFF(MINUTE,todo.btdl_action_time,todo.btdl_sla_limit_time),'') "+ 
	     " END as c45 , " + 
	     " IFNULL(job_status.BJS_STATUS,'')   as c46 ,"+
	     " so.BSO_JOB_STATUS   as c47 ,  "+
		 " param2.VALUE   as c48 ,"+
		 " todo.BTLD_AI as c49 ,  "+
		 " IFNULL(TIMESTAMPDIFF(day,so.BSO_CREATED_DATE,now()),'') as c50 ";
		if(isStore.equals("1")){
			query_so=query_so+""+
	     " ,( SELECT so_1.bso_store_prepare_count from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_1 "+
	     " where so_1.bso_id =todo.btdl_ref 	 ) as c51 ,"+// bso_store_prepare_count , "+
	     " ( SELECT IFNULL(DATE_FORMAT(so_2.bso_store_prepare_date,'%Y-%m-%d %H:%i:%s'),'') from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_2 "+
		 " where so_2.bso_id =todo.btdl_ref 	 ) as c52 ";// bso_store_prepare_date ";
	      
		}
		query_so=query_so+""+
		" FROM "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param "+
		"on (param.param_name='FLOW_NAME' and param.key=todo.btdl_type) "+
		" left join "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so "+
		 " on ( so.bso_id =todo.btdl_ref)   "+
		 " left join "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS job_status "+
		 " on (job_status.BJS_ID=so.BSO_JOB_STATUS and job_status.BJS_TYPE=1)   "+  
		" left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param2 "+
			"on (param2.param_name='STATE' and param2.key=todo.BTDL_STATE) "+
		" where ";
		if(isStore.equals("1")){
		query_so=query_so+""+
		" exists( "+
		"		 SELECT * from "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so_inner  "+
		"		 where (so_inner.bso_store_pre_send !='1' or so_inner.bso_store_pre_send is null ) "+
		"		 and so_inner.bso_id =todo.btdl_ref "+
		"		) and ";
		}
		query_so=query_so+""+
		" ( ( todo.BTDL_OWNER in "+rolesG+" and todo.BTDL_OWNER_TYPE='2' )  "+
		" OR ( todo.BTDL_OWNER='"+usernameG+"' and todo.BTDL_OWNER_TYPE='1' ) )  and todo.BTDL_HIDE='1' and todo.BTDL_TYPE='1' "; 
		
		String query_services=" SELECT "+ 
			 " call_center.BCC_NO as c0,"+
			  " IFNULL(call_center.BCC_SERIAL,'') as c1,"+
			    " IFNULL(call_center.BCC_MODEL,'') as c2,"+
			    " IFNULL(call_center.BCC_CAUSE,'') as c3,"+
			    "  call_center.BCC_CREATED_TIME  as c4,"+ 
			    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') as c5,"+
			    " IFNULL(call_center.BCC_SLA,'') as c6,"+
			    " IFNULL(call_center.BCC_IS_MA ,'') as c7,"+
			    " IFNULL(call_center.BCC_MA_NO ,'') as c8,"+
			    " IFNULL(call_center.BCC_MA_START ,'') as c9,"+
			    " IFNULL(call_center.BCC_MA_END ,'') as c10,"+
			    " IFNULL(call_center.BCC_STATUS ,'') as c11,"+
			    " IFNULL(call_center.BCC_REMARK ,'') as c12,"+
			    " IFNULL(call_center.BCC_USER_CREATED ,'') as c13,"+
			    " IFNULL(call_center.BCC_DUE_DATE ,'') as c14,"+
			   // " IFNULL(call_center.BCC_CONTACT ,'') as c15,"+
			    " CONCAT(IFNULL(call_center.BCC_CONTACT ,''),' ',IFNULL(call_center.BCC_TEL ,'')) as c15 ,  "+
			    " IFNULL(call_center.BCC_TEL ,'') as c16,"+
			    " IFNULL(call_center.BCC_CUSTOMER_NAME ,'') as c17,"+ //17
			    " IFNULL(call_center.BCC_ADDR1 ,'') as c18,"+
			    " IFNULL(call_center.BCC_ADDR2 ,'') as c19,"+
			    " IFNULL(call_center.BCC_ADDR3 ,'') as c20,"+
			   // " IFNULL(call_center.BCC_LOCATION ,'') as c21,"+
			   // "+data[i][21]+" "+data[i][18]+" "+data[i][19]+" "+data[i][20]+" "+data[i][22]+" "+data[i][23]+" "
			   " CONCAT(IFNULL(call_center.BCC_LOCATION ,''),' ',IFNULL(call_center.BCC_ADDR1 ,''),' ',IFNULL(call_center.BCC_ADDR2 ,''),' ',IFNULL(call_center.BCC_ADDR3 ,'') , ' ' "+
			   " 		,IFNULL(call_center.BCC_PROVINCE ,''),' ',IFNULL(call_center.BCC_ZIPCODE ,'')) as c21 , "+
			    " IFNULL(call_center.BCC_PROVINCE ,'') as c22,"+
			    " IFNULL(call_center.BCC_ZIPCODE ,'') as c23,"+
			    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c24, "+
			    /*-----------aui comment for error sql-------------*/
			    //" IFNULL((select BTDL_STATE  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
			  	//"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by btld_ai desc limit 1 ) ,'') as c25, "+
			  	//" IFNULL((select BTDL_OWNER  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
				//  	"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by btld_ai desc limit 1 ) ,'') as c26, "+
			  	/*--------------------------------------------------*/ 
			  	/*-----------------Begin aui edit for solve sql error--------------*/
			  	" IFNULL(todo2.BTDL_STATE,'') as c25, "+
			  	" IFNULL(todo2.BTDL_OWNER,'') as c26, "+
			  	/*------------------End aui edit for solve sql error--------------*/
				 " IFNULL(call_center.BCC_STATE ,'') as c27,  "+	
			 	 " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') as c28, "+
			 	 " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') as c29, "+ 
		" param.value as c30,"+  //30
		" todo.BTDL_REF as c31,"+
		" todo.BTDL_TYPE as c32,"+
		" todo.BTDL_STATE as c33,"+
		" todo.BTDL_OWNER as c34,"+
		" todo.BTDL_OWNER_TYPE as c35,"+
		" todo.BTDL_MESSAGE as c36,"+
		" todo.BTDL_SLA as c37,"+
		//" IFNULL(DATE_FORMAT(todo.BTDL_CREATED_TIME,'%Y-%m-%d %H:%i:%s'),'') as c38,"+
		" todo.BTDL_CREATED_TIME as c38,"+
		" IFNULL(DATE_FORMAT(todo.BTDL_DUE_DATE,'%Y-%m-%d %H:%i:%s'),'') as c39,"+ 
		" todo.BTDL_HIDE as c40,"+
		" todo.BTDL_REQUESTOR as c41,"+
		" todo.REF_NO as c42, "+
		" case when (select todo.BTDL_SLA_UNIT=3600 )  "+
		"  then  concat(todo.BTDL_SLA,' ช.ม.')  "+
		" when (select todo.BTDL_SLA_UNIT=60 ) "+
	   " then  concat(todo.BTDL_SLA,' นาที')  "+
	   " else '' "+
	   "	end as c43 ,   "+
		//" todo.BTDL_SLA_UNIT as c43 , "+   
		" IFNULL(DATE_FORMAT( BTDL_SLA_LIMIT_TIME,'%d/%m/%Y %H:%i:%s'),'') as c44, "+ 
		 "CASE "+
	     " WHEN (select todo.btdl_action_time IS NULL) "+ 
	     " THEN  "+
	     " IFNULL(TIMESTAMPDIFF(MINUTE,now(),todo.btdl_sla_limit_time),'') "+ 
	     " ELSE "+
	     " IFNULL(TIMESTAMPDIFF(MINUTE,todo.btdl_action_time,todo.btdl_sla_limit_time),'') "+ 
	     " END as c45 , " + 
	     " IFNULL(job_status.BJS_STATUS,'') as c46 ,"+
	     " service_job.SBJ_JOB_STATUS as c47, "+
		 " param2.VALUE   as c48 ,"+
		 " todo.BTLD_AI as c49 ,"+
		" IFNULL(TIMESTAMPDIFF(day, call_center.BCC_CREATED_TIME,now()),'') as c50 ";
	     if(isStore.equals("1")){
				query_services=query_services+""+
				 " ,0 as c51 ,"+//bso_store_prepare_count , "+
			     " '-' as c52";// bso_store_prepare_date ";
			} 
	     query_services=query_services+""+
		" FROM "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param "+
		"on (param.param_name='FLOW_NAME' and param.key=todo.btdl_type) left join "+ServiceConstant.SCHEMA+".BPM_CALL_CENTER call_center "+
		 " on (todo.BTDL_REF=call_center.BCC_NO)   "+ 
		" left join "+ServiceConstant.SCHEMA+".BPM_SERVICE_JOB service_job "+
		 " on (call_center.BCC_NO=service_job.BCC_NO)   "+ 
		 " left join "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS job_status "+
		 " on (job_status.BJS_ID=service_job.SBJ_JOB_STATUS and job_status.BJS_TYPE=2)   "+ 
		 " left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param2 "+
			"on (param2.param_name='STATE' and param2.key=todo.BTDL_STATE) "+
		 /*-----------------Begin aui edit for solve sql error--------------*/
		 " left join (select BTDL_STATE,BTDL_OWNER,btdl_ref,BTDL_CREATED_TIME  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo   "+ 
		 			" where todo.btdl_type='2' order by btld_ai desc limit 1 ) as todo2 "+
				    " on todo2.btdl_ref=call_center.BCC_NO "+
		/*------------------End aui edit for solve sql error--------------*/
		" where "+ 
		" ( ( todo.BTDL_OWNER in "+rolesG+" and todo.BTDL_OWNER_TYPE='2' )  "+
		" OR ( todo.BTDL_OWNER='"+usernameG+"' and todo.BTDL_OWNER_TYPE='1' ) )  and todo.BTDL_HIDE='1'  and todo.BTDL_TYPE='2' "; 
		
		String query_pm_ma=" SELECT "+ 
		// " so.BSO_TYPE_NO as c0,"+ 
		" CONCAT(so.BSO_TYPE_NO,' [',CAST(pmma.BPMJ_ORDER as CHAR(50)),'/',CAST((select count(*) "
		+ " from "+ServiceConstant.SCHEMA+".BPM_PM_MA_JOB pmma_inner where pmma_inner.BPMJ_NO=pmma.BPMJ_NO  ) as CHAR(50)),']' ) as c0, "+
		  " IFNULL(pmma.BPMJ_SERAIL ,'') as c1,"+
		  " IFNULL(pmma.BPMJ_UPS_MODEL ,'') as c2,"+ 
		    " '' as c3,"+
		    "  pmma.BPMJ_CREATED_DATE  as c4,"+ 
		    " IFNULL(DATE_FORMAT(pmma.BPMJ_CREATED_DATE,'%d/%m/%Y %H:%i'),'') as c5,"+
		    " '' as c6,"+
		    " '' as c7,"+
		    " '' as c8,"+
		    " '' as c9,"+
		    " '' as c10,"+
		    " '' as c11,"+
		    " '' as c12,"+
		    " '' as c13,"+
		    " '' as c14,"+
		    " IFNULL(pmma.BPMJ_CONTACT_NAME ,'') as c15,"+ 
		    " '' as c16,"+
		    " '' as c17,"+ //17
		    " '' as c18,"+
		    " '' as c19,"+
		    " '' as c20,"+
		    " CONCAT(IFNULL(pmma.BPMJ_LOCATION ,''),' ',IFNULL(pmma.BPMJ_ADDR1 ,''),' ',IFNULL(pmma.BPMJ_ADDR2 ,''),' ',IFNULL(pmma.BPMJ_ADDR3 ,'') , ' ' "+
			   " 		,IFNULL(pmma.BPMJ_PROVINCE ,''),' ',IFNULL(pmma.BPMJ_ZIPCODE ,'')) as c21 , "+
		    " IFNULL(pmma.BPMJ_PROVINCE ,'') as c22,"+
		    " IFNULL(pmma.BPMJ_ZIPCODE ,'') as c23,"+
		    " CONCAT(IFNULL(DATE_FORMAT(pmma.BPMJ_DUEDATE,'%d/%m/%Y'),''),' ',IFNULL(DATE_FORMAT(pmma.BPMJ_DUEDATE_START_TIME,'%H:%i'),'') ) as c24, "+
		    //" '' as c25, '' as c26,"+
		    " IFNULL((select BTDL_STATE  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
		  //	"  where todo.btdl_ref=pmma.BPMJ_NO and todo.REF_NO=pmma.BPMJ_ORDER  and todo.btdl_type='3' order by BTDL_CREATED_TIME desc limit 1 ) ,'') as c25, "+
		  "  where concat(pmma.BPMJ_NO,'_',pmma.BPMJ_SERAIL,'_',pmma.BPMJ_ORDER)=todo.BTDL_REF  and todo.btdl_type='3' order by btld_ai desc limit 1 ) ,'') as c25, "+
		  	 " IFNULL((select BTDL_OWNER  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
			  //	"  where todo.btdl_ref=pmma.BPMJ_NO and todo.REF_NO=pmma.BPMJ_ORDER and todo.btdl_type='3' order by BTDL_CREATED_TIME desc limit 1 ) ,'') as c26, "+
			  	 "  where concat(pmma.BPMJ_NO,'_',pmma.BPMJ_SERAIL,'_',pmma.BPMJ_ORDER)=todo.BTDL_REF  and todo.btdl_type='3' order by btld_ai desc limit 1 ) ,'') as c26, "+
			    " '' as c27,"+
			    " '' as c28,"+
			  //	" IFNULL(pmma.BISJ_STATE ,'') as c27,  "+	
		 	 // " IFNULL(DATE_FORMAT(pmma.BISJ_DELIVERY_DUEDATE_TIME,'%H:%i'),'') as c28, "+
		 	 " '' as c29, "+ 
	" param.value as c30,"+  //30
	" todo.BTDL_REF as c31,"+
	" todo.BTDL_TYPE as c32,"+
	" todo.BTDL_STATE as c33,"+
	" todo.BTDL_OWNER as c34,"+
	" todo.BTDL_OWNER_TYPE as c35,"+
	" todo.BTDL_MESSAGE as c36,"+
	" todo.BTDL_SLA as c37,"+
	//" IFNULL(DATE_FORMAT(todo.BTDL_CREATED_TIME,'%Y-%m-%d %H:%i:%s'),'') as c38,"+
	" todo.BTDL_CREATED_TIME as c38,"+
	" IFNULL(DATE_FORMAT(todo.BTDL_DUE_DATE,'%Y-%m-%d %H:%i:%s'),'') as c39,"+ 
	" todo.BTDL_HIDE as c40,"+
	" todo.BTDL_REQUESTOR as c41,"+
	" todo.REF_NO as c42, "+
	" case when (select todo.BTDL_SLA_UNIT=3600 )  "+
	"  then  concat(todo.BTDL_SLA,' ช.ม.')  "+
	" when (select todo.BTDL_SLA_UNIT=60 ) "+
   " then  concat(todo.BTDL_SLA,' นาที')  "+
   " else '' "+
   "	end as c43 ,   "+
	//" todo.BTDL_SLA_UNIT as c43 , "+   
	" IFNULL(DATE_FORMAT( BTDL_SLA_LIMIT_TIME,'%d/%m/%Y %H:%i:%s'),'') as c44, "+ 
	"CASE "+
	" WHEN (select todo.btdl_action_time IS NULL) "+ 
	" THEN  "+
	" IFNULL(TIMESTAMPDIFF(MINUTE,now(),todo.btdl_sla_limit_time),'') "+ 
	" ELSE "+
	" IFNULL(TIMESTAMPDIFF(MINUTE,todo.btdl_action_time,todo.btdl_sla_limit_time),'') "+ 
	" END as  c45 , " + 
	" IFNULL(job_status.BJS_STATUS,'') as c46 ,"+
	" pmma.BPMJ_JOB_STATUS as c47 ,"+
		 " param2.VALUE   as c48 ,"+
		 " todo.BTLD_AI as c49, "+
		" IFNULL(TIMESTAMPDIFF(day,pmma.BPMJ_CREATED_DATE,now()),'') as c50 ";
		 if(isStore.equals("1")){
			 query_pm_ma=query_pm_ma+""+
					 " ,0 as c51 , "+//bso_store_prepare_count , "+
						" '-' as c52 ";//  bso_store_prepare_date ";
			} 
		 query_pm_ma=query_pm_ma+""+
	" FROM "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param "+
	"on (param.param_name='FLOW_NAME' and param.key=todo.btdl_type) "+
	" left join "+ServiceConstant.SCHEMA+".BPM_PM_MA_JOB pmma "+
	//" on (todo.BTDL_REF=pmma.BPMJ_NO and todo.REF_NO=pmma.BPMJ_ORDER)   "+  
	" on (pmma.BPMJ_NO=todo.BTDL_REF ) "+
	//" on (concat(pmma.BPMJ_NO,'_',pmma.BPMJ_SERAIL,'_',pmma.BPMJ_ORDER)=todo.BTDL_REF ) "+
	 " left join "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS job_status "+
	 " on (job_status.BJS_ID=pmma.BPMJ_JOB_STATUS and job_status.BJS_TYPE=3)   "+ 
	 " left join "+ServiceConstant.SCHEMA+".BPM_SALE_ORDER so "+
	 " on ( so.bso_id =pmma.BPMJ_NO)   "+
	 " left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param2 "+
		"on (param2.param_name='STATE' and param2.key=todo.BTDL_STATE) "+
	" where "+ 
	" ( ( todo.BTDL_OWNER in "+rolesG+" and todo.BTDL_OWNER_TYPE='2' )  "+
	" OR ( todo.BTDL_OWNER='"+usernameG+"' and todo.BTDL_OWNER_TYPE='1' ) )  and todo.BTDL_HIDE='1'  and todo.BTDL_TYPE='3' "; 

		 String query_inner_services=" SELECT "+ 
				 " service_job.BISJ_NO as c0,"+
				  " '' as c1,"+
				    " '' as c2,"+
				    " '' as c3,"+
				    "  service_job.BISJ_CREATED_DATE  as c4,"+ 
				    " IFNULL(DATE_FORMAT(service_job.BISJ_CREATED_DATE,'%d/%m/%Y %H:%i'),'') as c5,"+
				    " '' as c6,"+
				    " '' as c7,"+
				    " '' as c8,"+
				    " '' as c9,"+
				    " '' as c10,"+
				    " IFNULL(service_job.BISJ_STATUS ,'') as c11,"+
				    " '' as c12,"+
				    " IFNULL(service_job.BISJ_CREATED_BY ,'') as c13,"+
				    " IFNULL(service_job.BISJ_DELIVERY_DUEDATE ,'') as c14,"+
				    " IFNULL(service_job.BISJ_CONTACT ,'') as c15,"+
				    " IFNULL(service_job.BISJ_TEL_FAX ,'') as c16,"+
				    " '' as c17,"+ //17
				    " IFNULL(service_job.BISJ_ADDR1 ,'') as c18,"+
				    " IFNULL(service_job.BISJ_ADDR2 ,'') as c19,"+
				    " IFNULL(service_job.BISJ_ADDR3 ,'') as c20,"+
				    " IFNULL(service_job.BISJ_INSTALLATION_LOCATION ,'') as c21,"+
				    " IFNULL(service_job.BISJ_PROVINCE ,'') as c22,"+
				    " IFNULL(service_job.BISJ_ZIPCODE ,'') as c23,"+
				   // " IFNULL(DATE_FORMAT(service_job.BISJ_DELIVERY_DUEDATE,'%d/%m/%Y'),'') as c24, "+
				    " CONCAT(IFNULL(DATE_FORMAT(service_job.BISJ_DELIVERY_DUEDATE,'%d/%m/%Y'),''),' ',IFNULL(DATE_FORMAT(service_job.BISJ_DELIVERY_DUEDATE_TIME,'%H:%i'),'') ) as c24, "+
				    " IFNULL((select BTDL_STATE  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
				  	"  where todo.btdl_ref=service_job.BISJ_NO and todo.btdl_type='4' order by btld_ai desc limit 1 ) ,'') as c25, "+
				  	 " IFNULL((select BTDL_OWNER  FROM  "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo  "+
					  	"  where todo.btdl_ref=service_job.BISJ_NO and todo.btdl_type='4' order by btld_ai desc limit 1 ) ,'') as c26, "+
					 " IFNULL(service_job.BISJ_STATE ,'') as c27,  "+	
				 	 " IFNULL(DATE_FORMAT(service_job.BISJ_DELIVERY_DUEDATE_TIME,'%H:%i'),'') as c28, "+
				 	 " '' as c29, "+ 
			" param.value as c30,"+  //30
			" todo.BTDL_REF as c31,"+
			" todo.BTDL_TYPE as c32,"+
			" todo.BTDL_STATE as c33,"+
			" todo.BTDL_OWNER as c34,"+
			" todo.BTDL_OWNER_TYPE as c35,"+
			" todo.BTDL_MESSAGE as c36,"+
			" todo.BTDL_SLA as c37,"+
			//" IFNULL(DATE_FORMAT(todo.BTDL_CREATED_TIME,'%Y-%m-%d %H:%i:%s'),'') as c38,"+
			" todo.BTDL_CREATED_TIME as c38,"+
			" IFNULL(DATE_FORMAT(todo.BTDL_DUE_DATE,'%Y-%m-%d %H:%i:%s'),'') as c39,"+ 
			" todo.BTDL_HIDE as c40,"+
			" todo.BTDL_REQUESTOR as c41,"+
			" todo.REF_NO as c42, "+
			" case when (select todo.BTDL_SLA_UNIT=3600 )  "+
			"  then  concat(todo.BTDL_SLA,' ช.ม.')  "+
			" when (select todo.BTDL_SLA_UNIT=60 ) "+
		   " then  concat(todo.BTDL_SLA,' นาที')  "+
		   " else '' "+
		   "	end as c43 ,   "+
			// " todo.BTDL_SLA_UNIT as c43 , "+   
			" IFNULL(DATE_FORMAT( BTDL_SLA_LIMIT_TIME,'%d/%m/%Y %H:%i:%s'),'') as c44, "+ 
			"CASE "+
			" WHEN (select todo.btdl_action_time IS NULL) "+ 
			" THEN  "+
			" IFNULL(TIMESTAMPDIFF(MINUTE,now(),todo.btdl_sla_limit_time),'') "+ 
			" ELSE "+
			" IFNULL(TIMESTAMPDIFF(MINUTE,todo.btdl_action_time,todo.btdl_sla_limit_time),'') "+ 
			" END as  c45 , " + 
			" IFNULL(job_status.BJS_STATUS,'') as c46 ,"+
			" service_job.BISJ_JOB_STATUS as c47, "+
		    " param2.VALUE   as c48 ,"+
		 " todo.BTLD_AI as c49, "+
		 " IFNULL(TIMESTAMPDIFF(day,service_job.BISJ_CREATED_DATE,now()),'') as c50 ";
				 if(isStore.equals("1")){
					 query_inner_services=query_inner_services+""+
							 " ,0 as c51 , "+//bso_store_prepare_count , "+
								" '-' as c52 ";//  bso_store_prepare_date ";
					} 
				 query_inner_services=query_inner_services+""+
			" FROM "+ServiceConstant.SCHEMA+".BPM_TO_DO_LIST todo left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param "+
			"on (param.param_name='FLOW_NAME' and param.key=todo.btdl_type) left join "+ServiceConstant.SCHEMA+".BPM_INNER_SERVICE_JOB service_job "+
			" on (todo.BTDL_REF=service_job.BISJ_NO)   "+  
			 " left join "+ServiceConstant.SCHEMA+".BPM_JOB_STATUS job_status "+
			 " on (job_status.BJS_ID=service_job.BISJ_JOB_STATUS and job_status.BJS_TYPE=4)   "+ 
			 " left join "+ServiceConstant.SCHEMA+".BPM_SYSTEM_PARAM param2 "+
				"on (param2.param_name='STATE' and param2.key=todo.BTDL_STATE) "+
			" where "+ 
			" ( ( todo.BTDL_OWNER in "+rolesG+" and todo.BTDL_OWNER_TYPE='2' )  "+
			" OR ( todo.BTDL_OWNER='"+usernameG+"' and todo.BTDL_OWNER_TYPE='1' ) )  and todo.BTDL_HIDE='1'  and todo.BTDL_TYPE='4' "; 
				// System.out.println("query_pm_ma->"+query_pm_ma);
	String queryall="";
	String queryall1="";
	if(type.equals("1")){
		//System.out.println("---aui print case 11111");
		//queryall=" select * from ( "+query_so+" union "+query_services+" union "+query_inner_services+"  union "+query_pm_ma+" ) as syndome  "+service_query+BTDL_CREATED_TIME_query+" order by c0";
		queryall=" select * from ( "+query_so+" union "+query_services+" union "+query_inner_services+" ) as syndome  "+service_query+BTDL_CREATED_TIME_query+" order by c0";
		
		// queryObject="  "+queryall+"   limit "+limitRow+", "+_perpageG;
	  }else{
		  //System.out.println("---aui print case 22222");
		  //queryall=" select count(*) from ( "+query_so+" union "+query_services+" union "+query_inner_services+"  union "+query_pm_ma+" ) as syndome  "+service_query+BTDL_CREATED_TIME_query+" ";
		  //queryall=" select count(*) from ( "+query_so+" union "+query_services+" union "+query_inner_services+" ) as syndome  "+service_query+BTDL_CREATED_TIME_query+" ";
		  queryall=" select * from ( "+query_so+" union "+query_services+" union "+query_inner_services+" ) as syndome  "+service_query+BTDL_CREATED_TIME_query+" ";
		  queryall=" select count(*) from (  "+queryall+" ) as x"; 
	  }
	//System.out.println("---aui print-----2323232323");
	//System.out.println("----aui print todolist queryall1 = "+queryall1);
	//System.out.println("----aui print todolist queryall = "+queryall);
		return queryall;
	}
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstObject xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstObject> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstObject>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	} 

	public PstObjectService getPstObjectService() {
		return pstObjectService;
	}

	public void setPstObjectService(PstObjectService pstObjectService) {
		this.pstObjectService = pstObjectService;
	}

	/*public PSTCommonService getPstCommonService() {
		return pstCommonService;
	}

	public void setPstCommonService(PSTCommonService pstCommonService) {
		this.pstCommonService = pstCommonService;
	}
*/
	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}
	private String getEncode(String fromStr) {
		 byte[] encoded = null;
		try {
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
		
	   return returnStr ;
		//return  fromStr;
	}
	public void synExpress( String[] querys ) {
		 
		 
		/*
		 * BPM_ARMAS`.`CUSCOD`, `BPM_ARMAS`.`CUSTYP`, `BPM_ARMAS`.`PRENAM`,
		 * `BPM_ARMAS`.`CUSNAM`, `BPM_ARMAS`.`ADDR01`, `BPM_ARMAS`.`ADDR02`,
		 * `BPM_ARMAS`.`ADDR03`, `BPM_ARMAS`.`ZIPCOD`, `BPM_ARMAS`.`TELNUM`,
		 * `BPM_ARMAS`.`CONTACT`, `BPM_ARMAS`.`CUSNAM2`, `BPM_ARMAS`.`TAXID`,
		 * `BPM_ARMAS`.`TAXTYP`, `BPM_ARMAS`.`TAXRAT`, `BPM_ARMAS`.`TAXGRP`,
		 * `BPM_ARMAS`.`TAXCOND`, `BPM_ARMAS`.`SHIPTO`, `BPM_ARMAS`.`SLMCOD`,
		 * `BPM_ARMAS`.`AREACOD`, `BPM_ARMAS`.`PAYTRM`, `BPM_ARMAS`.`PAYCOND`,
		 * `BPM_ARMAS`.`PAYER`, `BPM_ARMAS`.`TABPR`, `BPM_ARMAS`.`DISC`,
		 * `BPM_ARMAS`.`BALANCE`, `BPM_ARMAS`.`CHQRCV`, `BPM_ARMAS`.`CRLINE`,
		 * `BPM_ARMAS`.`LASIVC`, `BPM_ARMAS`.`ACCNUM`, `BPM_ARMAS`.`REMARK`,
		 * `BPM_ARMAS`.`DLVBY`, `BPM_ARMAS`.`TRACKSAL`, `BPM_ARMAS`.`CREBY`,
		 * `BPM_ARMAS`.`CREDAT`, `BPM_ARMAS`.`USERID`, `BPM_ARMAS`.`CHGDAT`,
		 * `BPM_ARMAS`.`STATUS`, `BPM_ARMAS`.`INACTDAT`,
		 * `BPM_ARMAS`.`SYN_DATETIME` FROM `SYNDOME_BPM_DB`.`BPM_ARMAS`;
		 */ 
		String DB_SCHEMA="SYNDOME_BPM_DB";
		String	 DB_JDBC_URL="jdbc:mysql://localhost:3306/SYNDOME_BPM_DB";
		String	 DB_JDBC_DRIVER_CLASS_NAME="com.mysql.jdbc.Driver";
		String	 DB_USERNAME="root";
		String	 DB_PASSWORD="015482543a6e";
		Connection con = null;
		try {
			Class.forName(DB_JDBC_DRIVER_CLASS_NAME).newInstance();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(DB_JDBC_URL, DB_USERNAME,
					DB_PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		StringBuffer query = new StringBuffer();//"SELECT count(*) FROM " + DB_SCHEMA
				//+ ".BPM_ARMAS where CUSCOD='0' ";

		ResultSet rs = null;
		PreparedStatement pst1 = null;
		int index=0;
		if (con != null) {
			try {
				for (int i = 0; i < querys.length; i++) {  
					query.setLength(0); 
					query.append(querys[i]);
					pst1 = con.prepareStatement(query.toString());
					  pst1.executeUpdate();
					 
				} 
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		  {
			if (pst1 != null)
				try {
					pst1.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	}

}
