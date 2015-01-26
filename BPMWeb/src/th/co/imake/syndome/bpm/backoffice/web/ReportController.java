package th.co.imake.syndome.bpm.backoffice.web;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.backoffice.service.impl.PostCommon;
import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.xstream.PstObject;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

@Controller
@RequestMapping(value = { "/report" })
public class ReportController {
	@Autowired
	private SynDomeBPMService pstService;
	@Autowired
	private SynDomeBPMService synDomeBPMService;
	
	private static SimpleDateFormat format = new SimpleDateFormat("MMM_yyyy");
	
	private static SimpleDateFormat format_check = new SimpleDateFormat("dd_MM_yyyy");

	private static Locale locale = new Locale("th", "TH");
	public static NumberFormat format_number = NumberFormat.getNumberInstance();
	static {
		format_number.setGroupingUsed(false);
	}
	// Locale.
	private static ResourceBundle bundle;
	static {
		bundle = ResourceBundle.getBundle("config");

	}

	private String schema=bundle.getString("schema");
	private static final String SCHEMA = bundle.getString("schema");

	@RequestMapping(value = { "/init" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String eptNormReport(Model model) {
		// return "exam/template/empty";
		return "backoffice/template/empty";
	}

	@RequestMapping(value = { "/page/{pagename}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String page(Model model, @PathVariable String pagename,HttpServletRequest request) {
		//return "backoffice/template/" + pagename;
		
		return "backoffice/template/empty";
	}

	// @SuppressWarnings({ "deprecation", "unchecked" })
	@RequestMapping(value = { "/dailyReport/{username}/{duedate_start}/{duedate_end}/{bcpId}/{bcrId}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void dailyReport(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest,@PathVariable String username,@PathVariable String duedate_start,@PathVariable String duedate_end,@PathVariable String bcpId,@PathVariable String bcrId) {
		String time_from = duedate_start;
		String time_end = duedate_end;
		Date d = null;
		try {
			d = format_check.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
		int year_end = dt.getYear();
	//    System.out.println(day_from+"-"+month_from+"-"+year_from);
	 //   System.out.println(day_end+"-"+month_end+"-"+year_end);
    	String filePath = bundle.getString("dailyReportPath")+"DailyReport.xls";
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
			VResultMessage vresultMessage = null;
			String bcr_name="";
			if(!bcrId.equals("0")){
				String query_bcrId="SELECT BCR_ID, BCR_NAME FROM SYNDOME_BPM_DB.BPM_CAR_REGISTRATION where BCR_ID="+bcrId;
				vresultMessage=synDomeBPMService.searchObject(query_bcrId);
				if(vresultMessage!=null && vresultMessage.getResultListObj()!=null && vresultMessage.getResultListObj().size()>0){
					List<Object[]>bcr_obj=vresultMessage.getResultListObj();
					bcr_name=" ทะเบียนรถ "+(String)bcr_obj.get(0)[1];
				}
			}
			String bcp_name="";
			if(!bcpId.equals("0")){
				String query_bcpId="SELECT   bcp_id,concat(BCP_FIRST_NAME,' ',bcp_sure_name) FROM SYNDOME_BPM_DB.BPM_CAR_PERSON where bcp_id="+bcpId;
				vresultMessage=synDomeBPMService.searchObject(query_bcpId);
				if(vresultMessage!=null && vresultMessage.getResultListObj()!=null && vresultMessage.getResultListObj().size()>0){
					List<Object[]>bcp_obj=vresultMessage.getResultListObj();
					bcp_name=" พนักงานขับรถ "+(String)bcp_obj.get(0)[1];
				}
			}
			String firstName_lastName="";
			String day="";
			String query_so="SELECT concat(u.firstName,\" \",u.lastName )   as c0," +
					" IFNULL(DATE_FORMAT(to_do.BTDL_DUE_DATE,'%d/%m/%Y'),'')  as c1 ," +
					 "  CASE  "+
					 "    WHEN (select so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )   "+
					 "         THEN   "+ 
					 "  ifnull(so.BSO_DELIVERY_LOCATION,'')  " +
					 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
					 "         THEN   "+
					 "  ifnull(so.BSO_INSTALLATION_SITE_LOCATION,'')  " +
					 "         ELSE "+
				     "  			 ''"+
					 "        END as c2, "+ 
					 "  CASE  "+
					 "    WHEN (select so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )   "+
					 "         THEN   "+ 
					" concat(ifnull(so.BSO_DELIVERY_ADDR1,''),\" \",ifnull(so.BSO_DELIVERY_ADDR2,''),\" \",ifnull(so.BSO_DELIVERY_ADDR3,''),\" \",ifnull(so.BSO_DELIVERY_PROVINCE,'')) " +
					 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
					 "         THEN   "+
					 " concat(ifnull(so.BSO_INSTALLATION_ADDR1,''),\" \",ifnull(so.BSO_INSTALLATION_ADDR2,''),\" \",ifnull(so.BSO_INSTALLATION_ADDR3,''),\" \",ifnull(so.BSO_INSTALLATION_PROVINCE,'')) " +
					 "         ELSE "+
				     "  			 ''"+
					 "        END as c3, "+ 
				
				" ifnull(status_job.BJS_STATUS,'')  as c4," +
					" so.BSO_TYPE_NO  as c5," +
					" \"\"  as c6, "+
					" \"\"  as c7, "+
					 "  CASE  "+
					 "    WHEN (select so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )   "+
					 "         THEN   "+ 
					 " concat(ifnull(so.BSO_DELIVERY_CONTACT,''),\" \",ifnull(so.BSO_DELIVERY_TEL_FAX,''))  " +
					 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
					 "         THEN   "+
					 " concat(ifnull(so.BSO_INSTALLATION_CONTACT,''),\" \",ifnull(so.BSO_INSTALLATION_TEL_FAX,''))  " +
					 "         ELSE "+
				     "  			 ''"+
					 "        END as c8, "+ 
					" \"\"  as c9, "+
					" \"\"  as c10, "+
				//	" IFNULL(DATE_FORMAT(to_do.BTDL_DUE_DATE,'%d/%m/%Y  %H:%i'),'')    as c11," +
				 "  CASE  "+
				 "    WHEN (select ( so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )  and DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i') !='00:00' )  "+
				 "         THEN   "+
				 " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y %H:%i'),'')  "+ 
				 " WHEN (select (so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1') and DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i') ='00:00' ) "+   
			     "   THEN    "+
			     " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'') "+  
				 "       WHEN (select so.BSO_IS_INSTALLATION='1' and DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i') !='00:00' )   "+
				 "         THEN   "+
				 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y %H:%i'),'')  "+
				 " WHEN (select so.BSO_IS_INSTALLATION='1' and DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i') ='00:00' )   "+
			      " THEN   "+
			     " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'') "+  
				 "         ELSE "+
			     "  			 ''"+
				 "        END as c11, "+  
					" so.BSO_TYPE_NO as c12, "+
					 " concat(so.BSO_ID,'') as c13 , "+
					 " to_do.BTDL_TYPE as c14 "+
					" FROM "+schema+".BPM_TO_DO_LIST to_do left join " +
					" "+schema+".user u on to_do.BTDL_OWNER=u.username  left join "+schema+".BPM_SALE_ORDER so" +
					//" on (to_do.REF_NO=so.BSO_TYPE_NO and to_do.BTDL_REF=so.BSO_ID)" +
					" on (to_do.REF_NO=so.BSO_TYPE_NO)" +
					 " left join  "+schema+".BPM_JOB_STATUS status_job  on " +
						" ( status_job.BJS_TYPE=1 and so.BSO_JOB_STATUS=status_job.BJS_ID)  " +
				//	" where ( to_do.BTDL_STATE='wait_for_operation_delivery' or " +
				//	" to_do.BTDL_STATE='wait_for_operation_install' )" +
				" where ( to_do.BTDL_STATE like 'wait_for_operation%' )" +
					" and to_do.BTDL_OWNER_TYPE='1'" +
					"   and CASE  " +
					"   WHEN (select so.BSO_IS_DELIVERY='1' or so.BSO_IS_DELIVERY_INSTALLATION='1')    " +
					"	       THEN    " +
					"		   so.BSO_DELIVERY_DUE_DATE  between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
				    " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " +
					"	    WHEN (select so.BSO_IS_INSTALLATION='1')   " +
					"	        THEN   " +
				   " so.BSO_INSTALLATION_DUE_DATE between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
				   " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " +
					" END  " +
					/*"   and CASE  " +
					"   WHEN (select so.BSO_IS_DELIVERY='1' or so.BSO_IS_DELIVERY_INSTALLATION='1')    " +
					"	       THEN    " +
					"		   so.BSO_DELIVERY_DUE_DATE  between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
				    " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " +
					"	    WHEN (select so.BSO_IS_INSTALLATION='1')   " +
					"	        THEN   " +
				   " so.BSO_INSTALLATION_DUE_DATE between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
				   " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " +
					" END  " +*/
					 
					// " and to_do.BTDL_DUE_DATE between '"+year+"-"+month+"-"+day_from+" 00:00:00' and" +
					//" '"+year+"-"+month+"-"+day_from+" 23:59:59' " +
					" and lower(to_do.BTDL_OWNER)=lower('"+username+"') " +
					" and to_do.btdl_hide='1' and to_do.BTDL_TYPE='1'  ";
			String query_services="SELECT concat(u.firstName,\" \",u.lastName )   as c0," +
					" IFNULL(DATE_FORMAT(to_do.BTDL_DUE_DATE,'%d/%m/%Y'),'')  as c1 ," +
					" call_center.BCC_LOCATION  as c2," +
					" concat(call_center.BCC_ADDR1,\" \",call_center.BCC_ADDR2,\" \",call_center.BCC_ADDR2,\" \",call_center.BCC_ADDR3,\" \",call_center.BCC_PROVINCE) as c3," +
					" ifnull(status_job.BJS_STATUS,'')  as c4," +
					" call_center.BCC_NO  as c5," +
					" "+
					" case when call_center.bcc_is_ma='0' "+
					" then concat(ifnull(call_center.BCC_MODEL,''),' [นอกประกัน]')		 "+
					" when call_center.bcc_is_ma='1' "+
					"  then concat(ifnull(call_center.BCC_MODEL,''),' [ในประกัน]') "+
					" when call_center.bcc_is_ma='2' "+
					"  then  concat(ifnull(call_center.BCC_MODEL,''),' ','[MA',' ',ifnull(call_center.bcc_ma_no,''),']') "+
					" else "+
					"  ifnull(call_center.BCC_MODEL,'') "+
					" end as c6,"+
				//	" ifnull(BCC_MODEL,'')  as c6, "+
					" ifnull(BCC_SERIAL,'') as c7, "+
					" concat(call_center.BCC_CONTACT,\" \",call_center.BCC_TEL)  as c8 ," +
					" \"\"  as c9, "+
					" \"\"  as c10, "+
				//	" IFNULL(DATE_FORMAT(to_do.BTDL_DUE_DATE,'%d/%m/%Y  %H:%i'),'')    as c11," +
			
				// " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'')  "+ 
				"  case when call_center.BCC_DUE_DATE_START is null && call_center.BCC_DUE_DATE_end is null "+
				"   then IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'')  "+
				"  when call_center.BCC_DUE_DATE_START is not  null && call_center.BCC_DUE_DATE_end is  null "+
				"  then concat(IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),''),'',DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i')) "+
				"  when call_center.BCC_DUE_DATE_START is    null && call_center.BCC_DUE_DATE_end is not null "+
				"  then concat(IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),''),'-',DATE_FORMAT(call_center.BCC_DUE_DATE_end,'%H:%i')) "+
				"  when call_center.BCC_DUE_DATE_START is  not  null && call_center.BCC_DUE_DATE_end is not null "+
				" then concat(IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),''),' ',DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'-',DATE_FORMAT(call_center.BCC_DUE_DATE_end,'%H:%i'))  "+
				"  end "+
				 "         as c11, "+ 
					" call_center.BCC_NO as c12 ,"+
				    " call_center.BCC_NO as c13 , "+
				    "  to_do.BTDL_TYPE as c14 "+
					" FROM "+schema+".BPM_TO_DO_LIST to_do left join " +
					" "+schema+".user u on to_do.BTDL_OWNER=u.username  left join "+schema+".BPM_CALL_CENTER call_center" +
					//" on (to_do.REF_NO=so.BSO_TYPE_NO and to_do.BTDL_REF=so.BSO_ID)" +
					" on (to_do.REF_NO=call_center.BCC_NO)" +
					" left join  "+schema+".BPM_SERVICE_JOB service_job on  " +
					" (to_do.REF_NO=service_job.BCC_NO) " +
					 " left join  "+schema+".BPM_JOB_STATUS status_job  on " +
					" ( status_job.BJS_TYPE=2 and service_job.SBJ_JOB_STATUS=status_job.BJS_ID)  " +
					" where ( to_do.BTDL_STATE like 'wait_for_operation%'" +
					// " or " +
					//" to_do.BTDL_STATE='wait_for_operation_install'" +
					 " )" +
					" and to_do.BTDL_OWNER_TYPE='1'" +
					"   and   " +
					"		   call_center.BCC_DUE_DATE  between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
				    " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " + 
					/*"		   call_center.BCC_DUE_DATE  between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
				    " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " + */
					
					" and lower(to_do.BTDL_OWNER)=lower('"+username+"') " +
					" and to_do.btdl_hide='1' and to_do.BTDL_TYPE='2'  ";
			
			String query=" select c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12 from ( "+query_so+" union all "+query_services+" ) as syndome limit 0 ,10";
			
			//String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
			//String[] column_default={"","","แขวง/ตำบล ","เขต/อำเภอ ","จ. ","      "};
			//int[] column_array_value={0,1,2,3,4,6};
			CellReference cellReference=null;
			HSSFSheet sheet=null;
			HSSFCell cell = null;
			HSSFRow row = null;
			Object obj=null;
			  //System.out.println("query1->"+query_so);
		//	 System.out.println("query2->"+query_services);
			// System.out.println("query->"+query);
			VResultMessage vresultMessage_1 = synDomeBPMService.searchObject(query_so);
			VResultMessage vresultMessage_2 = synDomeBPMService.searchObject(query_services);
			int vresultMessage_1_size=(vresultMessage_1!=null && vresultMessage_1.getResultListObj()!=null)?vresultMessage_1.getResultListObj().size():0;
			int vresultMessage_2_size=(vresultMessage_2!=null && vresultMessage_2.getResultListObj()!=null)?vresultMessage_2.getResultListObj().size():0;
		/*	System.out.println("vresultMessage_1_size="+vresultMessage_1_size);
			System.out.println("vresultMessage_2_size="+vresultMessage_2_size);*/
			List<Object[]>product_all=new ArrayList<Object[]>(vresultMessage_1_size+vresultMessage_2_size);
			
			//Collections.addAll(product_all, (List<Object[]>)vresultMessage_1.getResultListObj());
			/*System.out.println("vresultMessage_1 size->"+vresultMessage_1_size);
			System.out.println("vresultMessage_2 size->"+vresultMessage_2_size);
			System.out.println("product_all size->"+product_all.size());*/
			//int index_loop=0;
		if(vresultMessage_1!=null && vresultMessage_1.getResultListObj()!=null){
			List<Object[]> product_item_1 =vresultMessage_1.getResultListObj();
			for (int i = 0; i < product_item_1.size(); i++) {
				product_all.add((Object[])product_item_1.get(i));
			}
		}
		if(vresultMessage_2!=null && vresultMessage_2.getResultListObj()!=null){
			List<Object[]> product_item_2 =vresultMessage_2.getResultListObj();
			for (int i = 0; i < product_item_2.size(); i++) {
				product_all.add((Object[])product_item_2.get(i));
			}
		}
		 	// System.out.println("size----->"+product_all.size());
			//List<Object[]> product_item =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
			int product_item_size = product_all!=null?product_all.size():0;
			int index=6;
			String[] item_label={"D","E","G","H","I","J","K","L","M","N"}; // C O
			//int[] item_value={0,1,3};
			//String[] item_subfix={" ชิ้น","",""};
			if(product_item_size>0){ 
				sheet = wb.getSheetAt(0);
				 firstName_lastName="ช่างเทคนิค  "+(String)product_all.get(0)[0];
				 day="ใบสรุปผลการปฎิบัติงาน / รายงานประจำวัน  "+(String)product_all.get(0)[1];
				for (int i = 0; i < product_item_size; i++) {
					//String IS_SERIAL=(String)product_item.get(i)[2];
					cellReference= new CellReference("C"+index);
					row = sheet.getRow(cellReference.getRow());
					if(row==null)
						row=sheet.createRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					if(cell==null)
						cell = row.createCell((int)cellReference.getCol());
					cell.setCellValue((i+1)+"");
					for (int j = 0; j < item_label.length; j++) {
						//System.out.println(item_label[j]+index);
						cellReference= new CellReference(item_label[j]+index);
						row = sheet.getRow(cellReference.getRow());
						if(row==null)
							row=sheet.createRow(cellReference.getRow());
						cell =row.getCell((int)cellReference.getCol());
						if(cell==null)
							cell = row.createCell((int)cellReference.getCol());
						//System.out.println("cell->"+cell);
						obj=product_all.get(i)[j+2];
						//System.out.println(obj);
						if(obj!=null){
							String 	value=(String)obj;
							if(j==2)
								if(value.equals("1")) // ขนส่ง
									value="ขนส่ง";
							cell.setCellValue(value);
						}
						else
							cell.setCellValue("");
					}
					
					if(((String)product_all.get(i)[14]).equals("1")){
						StringBuffer model_so=new StringBuffer();
						StringBuffer serail_so=new StringBuffer();
						List<String[]> result_model_serails=getModelSerail((String)product_all.get(i)[13]);
						if(result_model_serails!=null && result_model_serails.size()>0){
							int model_serail_size=result_model_serails.size();
							for (int j = 0; j < model_serail_size; j++) {
								if(j<model_serail_size-1){
									model_so.append(result_model_serails.get(j)[0]+",");
									serail_so.append(result_model_serails.get(j)[1]+",");
								}
								else{
									model_so.append(result_model_serails.get(j)[0]);
									serail_so.append(result_model_serails.get(j)[1]);
								}
							}
						}
						// model
						cellReference= new CellReference("I"+index);
						row = sheet.getRow(cellReference.getRow());
						if(row==null)
							row=sheet.createRow(cellReference.getRow());
						cell =row.getCell((int)cellReference.getCol());
						if(cell==null)
							cell = row.createCell((int)cellReference.getCol());
						cell.setCellValue(model_so.toString());
						
						// serail
						cellReference= new CellReference("J"+index);
						row = sheet.getRow(cellReference.getRow());
						if(row==null)
							row=sheet.createRow(cellReference.getRow());
						cell =row.getCell((int)cellReference.getCol());
						if(cell==null)
							cell = row.createCell((int)cellReference.getCol());
						cell.setCellValue(serail_so.toString());
						//System.out.println("model_so->"+model_so);
						//System.out.println("serail_so->"+serail_so);
					} 
					index++;
					
				}
				cellReference= new CellReference("B2");
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				cell.setCellValue(day);
				
				cellReference= new CellReference("B3");
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				cell.setCellValue(firstName_lastName);
				
				cellReference= new CellReference("G3");
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				cell.setCellValue(bcp_name+bcr_name);
			}
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
		String filename=username+"_"+duedate_start+".xls";
		String userAgent = request.getHeader("user-agent");
		boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
		
		byte[] fileNameBytes=null;
		try {
			fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		 String dispositionFileName = "";
		 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
	    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

		 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
		 response.setHeader("Content-disposition", disposition);
					      OutputStream out=null;
						try {
							out = response.getOutputStream();
						} catch (IOException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						} 
						try {
							wb.write(out);
						
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} finally {
					         if (out != null) {
					            try { 
									  out.flush();
								      out.close();
								} catch (IOException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
					         }
						 }
	
	}
	  @RequestMapping(value={"/storeReport/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void storeReport(HttpServletRequest request,HttpServletResponse response
	    		,@PathVariable String id)
	    {
	    	String filePath = bundle.getString("storePath")+"StoreReport.xls";
			FileInputStream fileIn = null;
			HSSFWorkbook wb = null;
			String BSO_RFE_NO="";
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
				
				String query="SELECT " +
						" so.bso_type_no," +
						" so.BSO_SALE_ID," +
						" so.CUSCOD," +
						" cust.CONTACT," +
						" cust.CUSNAM," +
						" cust.ADDR01," +
						" cust.TELNUM," +
						" IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y %H:%i'),'') as d1 , "+ 
						" so.BSO_DELIVERY_CONTACT," +
						" so.BSO_DELIVERY_LOCATION," +
						" so.BSO_DELIVERY_ADDR1, " +
						" so.BSO_DELIVERY_ADDR2," +
						" so.BSO_DELIVERY_ADDR3," +
						" so.BSO_DELIVERY_PROVINCE," +
						" so.BSO_DELIVERY_ZIPCODE," +
						" so.BSO_DELIVERY_TEL_FAX, " +
						" so.BSO_IS_DELIVERY," + //16
						" so.BSO_IS_INSTALLATION," +
						" so.BSO_IS_DELIVERY_INSTALLATION," +
						" so.BSO_IS_NO_DELIVERY , " +
						" so.bso_borrow_no   " +
						" FROM "+schema+".BPM_SALE_ORDER so   left join "+schema+".BPM_ARMAS cust" +
						" on( so.cuscod=cust.cuscod)" +
						" WHERE so.BSO_ID="+id;
				VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
				List<Object[]> sale_order =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				
				int sale_order_size = sale_order!=null?sale_order.size():0;
				String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
				//String[] column_default={"","","แขวง/ตำบล ","เขต/อำเภอ ","จ. ","      "};
				//int[] column_array_value={0,1,2,3,4,6};
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 7);
				
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
/*
				cellStyle.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
						.getIndex());*/
				cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font);
				
				CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object obj=null;
				if(sale_order_size>0){ 
					sheet = wb.getSheetAt(0);  
					BSO_RFE_NO	=(String)sale_order.get(0)[0];
					for (int i = 0; i < column_array.length; i++) {
						cellReference= new CellReference(column_array[i]);
						row = sheet.getRow(cellReference.getRow());
						if(row==null)
							row=sheet.createRow(cellReference.getRow());
						cell =row.getCell((int)cellReference.getCol());
						if(cell==null)
							cell = row.createCell((int)cellReference.getCol());
						obj=sale_order.get(0)[i];
						if(obj!=null)
							cell.setCellValue((String)obj);
						else
							cell.setCellValue("");
						
					}
					cellReference= new CellReference("B10");
					row = sheet.getRow(cellReference.getRow());
					if(row==null)
						row=sheet.createRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					if(cell==null)
						cell = row.createCell((int)cellReference.getCol());
					obj=sale_order.get(0)[16];
					String BSO_IS_DELIVERY="";
						if(obj!=null)
							BSO_IS_DELIVERY=(String)obj;
					
					obj=sale_order.get(0)[17];
					String BSO_IS_INSTALLATION="";
						if(obj!=null)
							BSO_IS_INSTALLATION=(String)obj;
					
					obj=sale_order.get(0)[18];
					String BSO_IS_DELIVERY_INSTALLATION="";
						if(obj!=null)
							BSO_IS_DELIVERY_INSTALLATION=(String)obj;
					
					obj=sale_order.get(0)[19];
					String BSO_IS_NO_DELIVERY="";
						if(obj!=null)
							BSO_IS_NO_DELIVERY=(String)obj;
					StringBuffer type=new StringBuffer();
					if(BSO_IS_DELIVERY.equals("1"))
						type.append("[x] ส่งของ   ");
					else
						type.append("[ ] ส่งของ   ");
					if(BSO_IS_INSTALLATION.equals("1"))
						type.append("[x] ติดตั้ง   ");
					else
						type.append("[ ] ติดตั้ง   ");
					if(BSO_IS_DELIVERY_INSTALLATION.equals("1"))
						type.append("[x] ส่งของพร้อมติดตั้ง   ");
					else
						type.append("[ ] ส่งของพร้อมติดตั้ง   ");
					if(BSO_IS_NO_DELIVERY.equals("1"))
						type.append("[x] ไม่ส่งของ   ");
					else
						type.append("[ ] ไม่ส่งของ   ");
				 
					cell.setCellValue(type.toString());
					cellReference= new CellReference("D12");
					row = sheet.getRow(cellReference.getRow());
					if(row==null)
						row=sheet.createRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					if(cell==null)
						cell = row.createCell((int)cellReference.getCol());
					obj=sale_order.get(0)[20];
					String BSO_BORROW_NO="";
						if(obj!=null)
							BSO_BORROW_NO=(String)obj;
						cell.setCellValue(BSO_BORROW_NO);
				}	
			/*	 query=" SELECT " +
				 	  " item_map.IMA_ItemID," +
				 	  " product.ima_itemname," +
				 	  " item_map.IS_SERIAL," +
				 	  " item_map.SERIAL " +
				 	  " FROM "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING item_map" +
				 	  " left join "+schema+".BPM_PRODUCT product on item_map.ima_itemid=product.ima_itemid "+ 
					 " WHERE item_map.BSO_ID="+id;*/
				query=" SELECT   item.IMA_ITEMID,product.ima_itemname, " +
						" ( SELECT item_map.IS_SERIAL " +
						" 	 	    FROM  "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING item_map " +  
						" 		  WHERE item_map.BSO_ID=item.BSO_ID and item_map.IMA_ItemID=item.IMA_ITEMID " +
						" and item_map.AUTO_K=item.AUTO_K "+
						" 	      order by item_map.SERIAL asc limit 1 )as is_serail, " + 
						" item.AMOUNT,item.DETAIL, "+
						" ( SELECT item_map.SERIAL " +
						" 	 	    FROM  "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING item_map " +  
						" 		  WHERE item_map.BSO_ID=item.BSO_ID and item_map.IMA_ItemID=item.IMA_ITEMID " +
						" and item_map.AUTO_K=item.AUTO_K "+
						" 	      order by item_map.SERIAL asc limit 1 )as start_serail, " +
						" ( SELECT item_map.SERIAL " +
						" 	 	    FROM  "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING item_map " +  
						" 		  WHERE item_map.BSO_ID=item.BSO_ID and item_map.IMA_ItemID=item.IMA_ITEMID " +
						" and item_map.AUTO_K=item.AUTO_K "+
						" 	      order by item_map.SERIAL desc limit 1 )as end_serail , " +
						" item.IS_REPLACE,"+
						" item.REPLACE_NAME "+ 
						" 	 	    FROM  "+schema+".BPM_SALE_PRODUCT_ITEM item " +
						" 	 	    left join  "+schema+".BPM_PRODUCT product   " +
						"             on item.ima_itemid=product.ima_itemid  " +
						" 		  where item.BSO_ID="+id+" and item.IMA_ItemID not in('900002','900004','90100002') order by item.CREATED_TIME asc ";
				 vresultMessage = synDomeBPMService.searchObject(query);
				List<Object[]> product_item =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				int product_item_size = product_item!=null?product_item.size():0;
				int index=16;
				String[] item_label={"B","C","G","K"};
				int[] item_value={0,1,3,4};
				//String[] item_subfix={" ชิ้น","",""};
				if(product_item_size>0){ 
					// sheet = wb.getSheetAt(0);  
					for (int i = 0; i < product_item_size; i++) {
						String IMA_ITEMID=(String)product_item.get(i)[0];
						String IS_REPLACE="0";
						  if(product_item.get(i)[7]!=null){ 
							  IS_REPLACE=(String)product_item.get(i)[7];
						  }
						 String name ="";
					     if(IS_REPLACE.equals("1")){
					    	 if(product_item.get(i)[8]!=null)
					    		 name=(String)product_item.get(i)[8];;
					     }else
					    	 name=(String)product_item.get(i)[1];
						String ima_itemname=(String)product_item.get(i)[1];
						String IS_SERIAL=(String)product_item.get(i)[2];
						 String AMOUNT=null;
						 if(product_item.get(i)[3]!=null)
							 AMOUNT=(Integer)product_item.get(i)[3]+"";
						String DETAIL=null;
						 if(product_item.get(i)[4]!=null)
							 DETAIL=(String)product_item.get(i)[4];
						 
					     String START_SERAIL=null;
							 if(product_item.get(i)[5]!=null)
								 START_SERAIL=(String)product_item.get(i)[5];
							 
					    String END_SERAIL=null;
							 if(product_item.get(i)[6]!=null)
								 END_SERAIL=(String)product_item.get(i)[6];
						
						
						for (int j = 0; j < item_label.length; j++) {
							//System.out.println(item_label[j]+index);
							cellReference= new CellReference(item_label[j]+index);
							row = sheet.getRow(cellReference.getRow());
							if(row==null)
								row=sheet.createRow(cellReference.getRow());
							cell =row.getCell((int)cellReference.getCol());
							if(cell==null)
								cell = row.createCell((int)cellReference.getCol());
						//	System.out.println("cell->"+cell);
							
							//System.out.println(obj);
							//if(obj!=null){
								String 	value=null;
								if(item_value[j]==3){
									//obj=product_item.get(i)[item_value[j]];
									if(IS_SERIAL.equals("0"))
										value="ไม่ระบุ";
									else{
									//	value=(String)obj;
										if(AMOUNT!=null && Integer.valueOf(AMOUNT)>1)
											value=START_SERAIL+"-"+END_SERAIL;
										else
											value=START_SERAIL;
									}
								}else if(item_value[j]==1){
									//value=(String)obj;
									//value=ima_itemname;
									value=name;
										value=(i+1)+". "+value;
										/*if(AMOUNT!=null)
											value=value+" "+AMOUNT+" ชิ้น ";*/
										if(DETAIL!=null)
											value=value+" "+DETAIL+"";
								}else if(item_value[j]==4){
									value=AMOUNT;
								}else{
									value=IMA_ITEMID;
								}
								cell.setCellValue(value);
								/* if(item_value[j]==1){
									cell.setCellStyle(cellStyle2);
								}else
									cell.setCellStyle(cellStyle); */
								
							//}
							/*else
								cell.setCellValue("");
								*/	
					}
						index++;
					}
				}
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
			String filename=BSO_RFE_NO+".xls";
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			
			byte[] fileNameBytes=null;
			try {
				fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			 String dispositionFileName = "";
			 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
		    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

			 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
			 response.setHeader("Content-disposition", disposition);
						      OutputStream out=null;
							try {
								out = response.getOutputStream();
							} catch (IOException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} 
							try {
								wb.write(out);
							
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} finally {
						         if (out != null) {
						            try { 
										  out.flush();
									      out.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
						         }
							 }
		}
	@RequestMapping(value = { "/export_form" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export_form(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) { 
		String type = request.getParameter("type");  
		String path="/opt/form/Delivery_Form.xls"; 
		
	    String file_name="ฟอร์มจัดส่ง";
	    if(type.equals("2")){
	    	file_name="ฟอร์มติดตั้ง";
	    	path="/opt/form/Installation_Form.xls";
	    }
		HSSFWorkbook wb=null;
		try {
			wb = new HSSFWorkbook(new FileInputStream(path));
		} catch (FileNotFoundException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = file_name+".xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = { "/deliveryReport/{time_from}/{time_end}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void deliveryReport(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest,@PathVariable String time_from,@PathVariable String time_end) {  
		/*String time_from = "12_05_2014";
		String time_end =  "15_06_2014";*/
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
			//	 System.out.println(" before ");
			//	 System.out.println(dt1);
				  d_array[1]=dt_end;
			 }
			 else{
			//	 System.out.println(" after ");
				 d_array[1]=dt2;
			 }
			// System.out.println("end-> "+dt2+",start->"+dt1);
			// System.out.println("end2-> "+d_array[1]+",start2->"+d_array[0]);
			 date_list.add(d_array);
			 dt1=dt1.plusMonths(1);
			// System.out.println("dt1 after plus -> "+dt1);
			// dt1=dt1.dayOfMonth().setCopy(dt1.dayOfMonth().getMaximumValue()+"");
			 index_date++;
			// System.out.println("index->"+index_date);
			} while (dt1.isBefore(dt2.getMillis()));
		/* if(!time_end_slit[1].equals(time_from_slit[1])){
		 DateTime[] d_array=new DateTime[2];
		 d_array[1]=dt2;
		 dt2=dt2.dayOfMonth().setCopy(dt2.dayOfMonth().getMinimumValue()+"");
		 d_array[0]=dt2;
		 date_list.add(d_array);
		 }*/
		int date_size=date_list.size();
		/*for (int i=date_size-1;i>=0;i--){//DateTime dateTime : date_list) {
			System.out.println(date_list.get(i)[1]+" , "+date_list.get(i)[0]);
		}*/
		 
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
    //	String filePath = "/opt/attach/deliverSumReportPath/ServicesReport.xls";//bundle.getString("dailyReportPath")+"DailyReport.xls";
    	String filePath = bundle.getString("deliverySumReportPath")+"ServicesReport.xls";
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
			/*PstObject pstObject = new PstObject(new String[]{query_user}); 
			
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH); */
	         resultMessage = synDomeBPMService.searchObject(query_user);//postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
	         List<Object[]> user_list= resultMessage.getResultListObj();
	         int user_size=user_list.size();
	        // System.out.println("user_size="+user_list.size());
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
					//System.out.println(date_list.get(z)[1]+" , "+date_list.get(z)[0]);
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
				 PstObject pstObject = new PstObject(job_query); 
				 
				 // 	System.out.println("query--->"+sb_query.toString());
				 	pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH_SERVICES_REPORT); 
				 	PostCommon postCommon=new PostCommon();
			         resultMessage =  postCommon.postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
			         List<Object[]> job_list= resultMessage.getResultListObj();
			         Map hashMap =new HashMap();
			         if(job_list!=null){
			        	 for (int j = 0; j < job_list.size(); j++) {
			        		 Object[] objs_value=job_list.get(j);
			        		 String day_key=((String)objs_value[0]).split("-")[2];
			        		// System.out.println("day_key->"+day_key);
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
		 sheet = wb.getSheetAt(1);//createSheet("Sum");
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
		
		String filename="DeliveryReport.xls";
		String userAgent = request.getHeader("user-agent");
		boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
		
		byte[] fileNameBytes=null;
		try {
			fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		 String dispositionFileName = "";
		 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
	    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

		 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
		 response.setHeader("Content-disposition", disposition);
					      OutputStream out=null;
						try {
							out = response.getOutputStream();
						} catch (IOException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						} 
						try {
							wb.write(out);
						
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} finally {
					         if (out != null) {
					            try { 
									  out.flush();
								      out.close();
								} catch (IOException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
					         }
						 }
		/*				
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
	*/
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
	@RequestMapping(value = { "/repport1" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void repport1(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) { 
		String type = request.getParameter("type");  
		String path="/Users/imake/Desktop/aoe.xlsx"; 
		
	    String file_name="job57";
	    
	    XSSFWorkbook wb=null;
		try {
			wb = new XSSFWorkbook(new FileInputStream(path));
		} catch (FileNotFoundException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = file_name+".xlsx";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private List<String[]> getModelSerail(String bsoID){
	//	System.out.println("bso_id===>"+bsoID);
		String query="SELECT IMA_ITEMID as c0,BSO_ID as c1 FROM  "+schema+".BPM_SALE_PRODUCT_ITEM where bso_id="+bsoID+" and IMA_ITEMID like '9%' ";
		VResultMessage vresultMessage_1 = synDomeBPMService.searchObject(query);
		StringBuffer sb=new StringBuffer("");
		 
		List<String[]> results=new ArrayList<String[]>();
		if(vresultMessage_1!=null && vresultMessage_1.getResultListObj()!=null){
			List<Object[]> product_item_1 =vresultMessage_1.getResultListObj();
			for (int i = 0; i < product_item_1.size(); i++) {
				sb.setLength(0);
				
				sb.append("select (SELECT p1.IMA_ItemName FROM "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING m1 left join "+
 ""+schema+".BPM_PRODUCT p1 on m1.IMA_ItemID=p1.IMA_ItemID  where m1.bso_id="+bsoID+" and m1.IS_SERIAL='1' "+
" and m1.IMA_ITEMID like '"+(String)product_item_1.get(i)[0]+"'  "+
" order by m1.SERIAL asc "+
"  limit 1 ) "+
" , "
+ "case when (select count(*) FROM SYNDOME_BPM_DB.BPM_SALE_PRODUCT_ITEM_MAPPING where bso_id="+bsoID+" and IS_SERIAL='1' "+
" and IMA_ITEMID like '"+(String)product_item_1.get(i)[0]+"') >1 then "
+ "concat('[',(SELECT SERIAL FROM "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING where bso_id="+bsoID+" and IS_SERIAL='1' "+
" and IMA_ITEMID like '"+(String)product_item_1.get(i)[0]+"'  "+
" order by SERIAL asc "+
"  limit 1 ),'-',(SELECT SERIAL FROM "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING where bso_id="+bsoID+" and IS_SERIAL='1' "+
" and IMA_ITEMID like '"+(String)product_item_1.get(i)[0]+"'  "+
" order by SERIAL desc "+
"  limit 1 ),']') "
+ " else "
+ " concat('[',(SELECT SERIAL FROM SYNDOME_BPM_DB.BPM_SALE_PRODUCT_ITEM_MAPPING where bso_id="+bsoID+" and IS_SERIAL='1' "+
" and IMA_ITEMID like '"+(String)product_item_1.get(i)[0]+"'  "+
" order by SERIAL asc "+
"  limit 1 ),']') "+
" end as cc "+
"  from  "+schema+".BPM_SALE_PRODUCT_ITEM_MAPPING where bso_id="+bsoID+" and IS_SERIAL='1' "+
" and IMA_ITEMID like '"+(String)product_item_1.get(i)[0]+"' limit 1");
				VResultMessage vresultMessage_inner = synDomeBPMService.searchObject(sb.toString());
				if(vresultMessage_inner!=null && vresultMessage_inner.getResultListObj()!=null && vresultMessage_inner.getResultListObj().size()>0){
					List<Object[]> product_item_innder =vresultMessage_inner.getResultListObj();
					String [] result={(String)product_item_innder.get(0)[0], (String)product_item_innder.get(0)[1]}; // model , serail
					results.add(result);
					//sb_result.append(vresultMessage_inner.getResultListObj().get(0))
				}
			}
		}
		return results;
	}
	
	  @RequestMapping(value={"/exportReport3/{deptType}/{deptId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReport3(HttpServletRequest request,HttpServletResponse response ,
	    		@PathVariable String deptType,@PathVariable String deptId)
	    {
		/*  <option value="sommai,1">ฝ่าย IT กทม ปริฯ</option> 
			 <option value="siwaporn,1">ฝ่าย IT ภูมิภาค</option>
			 <option value="maytazzawan,1">ฝ่ายขนส่ง กทม ปริฯ</option>
			 <option value="regent_admin,1">ฝ่ายขนส่ง ภูมิภาค</option>
			 <option value="numfon,1">ฝ่าย SC</option>
			<!--  <option value="pmma_admin,1">ฝ่าย PM/MA</option> -->
			 <option value="ROLE_QUOTATION_ACCOUNT,2">Sale</option> 
			 var dep_select_values=$("#dep_select_id").val().split(",");
	if(dep_select_values[1]=='1'){
		var query=" SELECT role_type.bpm_role_type_id,role_type.bpm_role_type_name FROM "+SCHEMA_G+".BPM_ROLE_MAPPING mapping left join "+
		 SCHEMA_G+".BPM_ROLE_TYPE role_type on role_type.BPM_ROLE_TYPE_ID=mapping.BPM_ROLE_TYPE_ID "+
		" where mapping.BPM_ROLE_ID=(select bpm_role_id from "+SCHEMA_G+".user u where u.username='"+dep_select_values[0]+"') "; 
		 
	SynDomeBPMAjax.searchObject(query,{
		callback:function(data){
			if(data.resultMessage.msgCode=='ok'){
				data=data.resultListObj;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			var roles="";
			if(data!=null && data.length>0){
				//alert(data[0][1])
				var sql_inner="("; 
				   for(var i=0;i<data.length;i++){
					   sql_inner=sql_inner+"'"+data[i][1]+"'";
					   if(i!=(data.length-1)){
						   sql_inner=sql_inner+",";
					   }
				   }
				   sql_inner=sql_inner+")"; 
				   roles=sql_inner;
			}
			 
			renderAllServices(service_type,service_status,dep_select_values[0],roles,_perpage,_page)
		}
	});
	}else{
		//alert(dep_select_values[0])
		renderAllServices(service_type,service_status,dep_select_values[0],"('"+dep_select_values[0]+"')",_perpage,_page)
	}	 
			 */
		  String service_status="-1";//service_status_array[0];
		  String service_type="-1";//service_status_array[1];
		 	 
		  String _perpage="3000";
		  String _page="1";
		  String isStore="0";
		  String todolistType="1";
		   String key_job="";//jQuery.trim($("#key_job").val().replace(/'/g,"''"));
		  VResultMessage vresultMessage=null;
			HSSFWorkbook wb = new HSSFWorkbook();  
				if(!deptType.equals("1")){
					String query_role=" SELECT role_type.bpm_role_type_id,role_type.bpm_role_type_name FROM "+schema+".BPM_ROLE_MAPPING mapping left join "+
							schema+".BPM_ROLE_TYPE role_type on role_type.BPM_ROLE_TYPE_ID=mapping.BPM_ROLE_TYPE_ID "+
								" where mapping.BPM_ROLE_ID=(select bpm_role_id from "+schema+".user u where u.username='"+deptId+"') ";
					vresultMessage= synDomeBPMService.searchObject(query_role);
					List<Object[]> role_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
					String roles="";
					String sql_inner="("; 
					   for(int i=0;i<role_list.size();i++){
						   sql_inner=sql_inner+"'"+role_list.get(i)[1]+"'";
						   if(i!=(role_list.size()-1)){
							   sql_inner=sql_inner+",";
						   }
					   }
					   sql_inner=sql_inner+")"; 
					   roles=sql_inner;
					 
					 //SynDomeBPMAjax.searchTodoList(service_type,service_status,username,roles,_page+"",_perpageG+"",isStore,"1",key_job,{ 
						  
					   vresultMessage = synDomeBPMService.searchTodoList(service_type, service_status, deptId, roles, _page,_perpage ,isStore, todolistType,key_job,"");
				}else
					vresultMessage = synDomeBPMService.searchTodoList(service_type, service_status, deptId, "('"+deptId+"')",  _page,_perpage ,isStore, todolistType,key_job,"");
				 
				  
				List<Object[]> work_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				
				int work_size = work_list!=null?work_list.size():0;
			//	String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
			 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 

				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
/*
				cellStyle.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
						.getIndex());*/
				cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font);
				cellStyle2.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
						.getIndex());  
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;
			 	int indexRow=0;
			 	String [] column_header_name_1={"เลขที่เอกสาร","สถานะงาน","Service Type","State"};
			 	String [] column_header_name_2={"อาการเสีย","สถานที่","ผู้ติดต่อ","เวลานัดหมาย","วันที่เปิดเอกสาร","Requestor","จำนวนวันค้าง"};
			 	//,"หมายเลขเครื่อง/Model",
			 	 
			 	int[] column_index_1={0,46,30,48};
			 	
			 	int[] column_index_2={3,21,15,24,5,41,50};
/*
 *    "  <td> <span style=\"text-align: left;cursor: pointer;\">"+data[i][0]+"</span>";
			        	  
			           str=str+ " </td>"+
					   "  		<td style=\"text-align: left;\">"+data[i][46]+"</td>"+   
					   "  		<td style=\"text-align: center;\">"+data[i][30]+"</td>"+    
					   "  		<td style=\"text-align: center;\">"+data[i][48]+"</td>"+   
					   "  		<td style=\"text-align: left;\">"+data[i][1]+"/"+data[i][2]+"</td>"+    
					   "  		<td style=\"text-align: left;\">"+data[i][3]+"</td>"+     
				      
				        "    	<td style=\"text-align: left;\">"+data[i][21]+"</td>  "+
				      
				        "    	<td style=\"text-align: left;\">"+data[i][15]+"</td>  "+
				      
				        "    	<td style=\"text-align: left;\">"+data[i][24]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][5]+"</td>  "+ 
				         "    	<td style=\"text-align: left;\">"+data[i][41]+"</td>  "+
				         "    	<td style=\"text-align: left;\">"+data[i][50]+"</td>  "; 
				        str=str+ "  	</tr>  "; 
 */
				   
				if(work_size>0){ 
					  sheet = wb.createSheet(); 
					  int column_header_size_1=column_header_name_1.length;
					  row = sheet.getRow(indexRow);
						if(row==null)
							row=sheet.createRow(indexRow++);
						 
					  for (int i = 0; i < column_header_size_1; i++) { 
								  cell =row.getCell(i);
								if(cell==null)
									cell = row.createCell(i); 
								 cell.setCellValue(column_header_name_1[i]);
								 cell.setCellStyle(cellStyle2);
					  }  
					  cell =row.getCell(column_header_size_1);
						if(cell==null)
							cell = row.createCell(column_header_size_1); 
						 cell.setCellValue("หมายเลขเครื่อง/Model");
						 cell.setCellStyle(cellStyle2);
					  int column_header_size_2=column_header_name_2.length;
					  for (int i = 0; i < column_header_size_2; i++) {
						  cell =row.getCell(column_header_size_1+i+1); 
							 if(cell==null)
								cell = row.createCell(column_header_size_1+i+1); 
							  cell.setCellValue(column_header_name_2[i]);
								 cell.setCellStyle(cellStyle2);
					 } 
					for (int i = 0; i < work_size; i++) {
						 row = sheet.getRow(indexRow);
							if(row==null)
								row=sheet.createRow(indexRow++); 
							objs=work_list.get(i);
								  for (int j = 0; j < column_header_size_1; j++) {
									  cell =row.getCell(j);
										if(cell==null)
											cell = row.createCell(j);  
										 cell.setCellValue((String)objs[column_index_1[j]]);
										 cell.setCellStyle(cellStyle);
								  } 
								  cell =row.getCell(column_header_size_1);
								  if(cell==null)
										cell = row.createCell(column_header_size_1); 
									 cell.setCellValue((String)objs[1] +"/"+(String)objs[2]); // data[i][1]+"     ["+data[i][0]+"]";
									 cell.setCellStyle(cellStyle);
									 
									 for (int j = 0; j < column_header_size_2; j++) {
										  cell =row.getCell(column_header_size_1+1+j);
											if(cell==null)
												cell = row.createCell(column_header_size_1+1+j);  
											 cell.setCellValue((String)objs[column_index_2[j]]);
											 cell.setCellStyle(cellStyle);
									  } 
					 
					}
				}
				HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
				
			 
			String filename="WorkPending.xls";
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			
			byte[] fileNameBytes=null;
			try {
				fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			 String dispositionFileName = "";
			 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
		    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

			 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
			 response.setHeader("Content-disposition", disposition);
						      OutputStream out=null;
							try {
								out = response.getOutputStream();
							} catch (IOException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} 
							try {
								wb.write(out);
							
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} finally {
						         if (out != null) {
						            try { 
										  out.flush();
									      out.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
						         }
							 }
		}
	  @RequestMapping(value={"/exportReport4/{startdate}/{enddate}/{btdlOwner}/{typeId}/{deptId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReport4(HttpServletRequest request,HttpServletResponse response
	    		,@PathVariable String startdate,@PathVariable String enddate,
	    		@PathVariable String btdlOwner,@PathVariable String typeId,
	    		@PathVariable String deptId)
	    {
		  //var src = "report/exportReport4/"+start_date+"/"+end_date+"/"+btdl_owner+"/"+type_id+"/"+BDEPT_ID;
	    //	String filePath = bundle.getString("storePath")+"StoreReport.xls";
			//FileInputStream fileIn = null;
			HSSFWorkbook wb =new HSSFWorkbook(); 
				//String typeId=deptId;
				String sub_query="";
				if(!typeId.equals("0")){
				  if(typeId.equals("1")){
					  sub_query= " and  exists (SELECT username FROM "+schema+".BPM_DEPARTMENT_USER dept_user left join "+schema+".user u  "+ 
					  " on dept_user.USER_ID=u.id where dept_user.BDEPT_ID="+deptId+" and u.username= todo_list.btdl_owner )    ";
				  }else if(typeId.equals("2")){
					  sub_query=" and exists (SELECT u.username FROM SYNDOME_BPM_DB.BPM_CENTER center left join SYNDOME_BPM_DB.user u "+
						  " on center.uid=u.id where center.bc_id not in (1,12,13) and u.id="+deptId+" and u.username= todo_list.btdl_owner) ";
				  }else{
					  sub_query=" and todo_list.btdl_owner='"+btdlOwner+"'  ";
				  }
				}
				 
					    	 String[] START_DATE_PICKER_array=startdate.split("_"); // dd/mm/yyyy
					    	 String[] END_DATE_PICKER_array=enddate.split("_"); 
					    	 
					    	 String query=" select "+
					    		" todo_list.btdl_owner as c0,concat(user_outer.firstname,' ',user_outer.lastname) as c1, "+
					    		" ifnull(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c2, "+
					    		" ifnull(DATE_FORMAT(todo_list.btdl_action_time,'%d/%m/%Y'),'') as c3, "+
					    		" ifnull(DATE_FORMAT(todo_list.btdl_sla_limit_time,'%d/%m/%Y'),'') as c4, "+
					    		" CASE  "+ 
					    		"      WHEN (select call_center.BCC_DUE_DATE IS NULL) "+ 
					    		"        THEN   "+
					    		"       ifnull(DATE_FORMAT(todo_list.btdl_sla_limit_time ,'%d/%m/%Y'),'') "+
					    		"      ELSE  "+
					    		"       ifnull(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') "+
					    		"       END   as c5 , "+//sla_limit ,  "+
					    		" CASE  "+ 
					    		"      WHEN (select call_center.BCC_DUE_DATE IS NULL) "+ 
					    		"        THEN   "+
					    		"       TIMESTAMPDIFF(day,todo_list.btdl_sla_limit_time,now()) "+   
					    		"       WHEN (select todo_list.btdl_action_time IS NULL)  "+
					    		" 	THEN "+
					    		"       TIMESTAMPDIFF(day,call_center.BCC_DUE_DATE,now()) "+ 
					    		"       else "+
					    		" 	TIMESTAMPDIFF(day,call_center.BCC_DUE_DATE,todo_list.btdl_action_time) "+ 
					    		"       END as c6 ,  "+
					    		" concat(ifnull(call_center.BCC_SERIAL,''),'/',ifnull(call_center.bcc_model,''))  as c7 , "+
					    		" concat(ifnull(call_center.bcc_location,''),' ', "+
					    		" ifnull(call_center.bcc_addr1,''),' ',ifnull(call_center.bcc_addr2,''),' ', "+
								" ifnull(call_center.bcc_addr3,''),' ',ifnull(call_center.bcc_province,''),' ', "+
								" ifnull(call_center.bcc_zipcode,'')) as c8 ,"+ 
								" call_center.BCC_NO as c9 ,"+
								" concat( ifnull(call_center.bcc_contact,''),'/',ifnull(call_center.bcc_tel,'')) as c10  "+
					    		// call_center.BCC_DUE_DATE_START,
					    		//call_center.BCC_DUE_DATE_END, 
					    		//todo_list.BTDL_CREATED_TIME,

					    		//todo_list.* 
					    		 " from "+schema+".BPM_TO_DO_LIST todo_list left join  "+
					    		 " "+schema+".BPM_SERVICE_JOB sv  on( todo_list.BTDL_REF=sv.bcc_no   and todo_list.btdl_type=2) "+
					    		 " left join "+schema+".BPM_CALL_CENTER call_center on (call_center.BCC_NO=sv.BCC_NO) "+
					    		 " left join "+schema+".user user_outer on user_outer.username=todo_list.btdl_owner "+
					    		// " where    todo_list.BTDL_CREATED_TIME between DATE_FORMAT(todo_list.BTDL_CREATED_TIME,'%Y-%m-%d 00:00:00') and "+ 
					    		// " DATE_FORMAT(todo_list.BTDL_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+ 
					    		 " where    todo_list.BTDL_CREATED_TIME between  '"+START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0]+" 00:00:00' and '"+END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]+" 23:59:59' "+
					    		 " and todo_list.btdl_state like 'wait_for_oper%' "+
					    		 " and todo_list.btdl_type=2  "+
					    		// -- and sv.SBJ_JOB_STATUS=4 and todo_list.btdl_hide='1' 
					    		 sub_query+
					    		  " group by todo_list.btdl_owner, DATE_FORMAT(todo_list.BTDL_CREATED_TIME,'%Y-%m-%d 00:00:00')  "+
					    		  " order by todo_list.btdl_owner,todo_list.BTDL_CREATED_TIME ";
				VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
				List<Object[]> sla_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				
				int sla_size = sla_list!=null?sla_list.size():0;
			//	String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
			 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 
				DataFormat dataFormat = wb.createDataFormat();
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
				cellStyle.setDataFormat(dataFormat.getFormat("#,##0.##")); // 99
/*
				cellStyle.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
						.getIndex());*/
				cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font);
				cellStyle2.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
						.getIndex());  
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;
			 	int indexRow=0;
			 	String [] column_header_name={"เลขที่ job","รุ่น/model","สถานที่","ผู้ติดต่อ/เบอร์โทร","วันนัดหมาย","วันปฏิบัติงาน"};
			 	
			 	//String [] column_header_name_ext={"ในเวลา","นอกเวลา","Max Time","Min Time","จำนวนวันที่เกิน"};
			 	//String [] column_header_name_ext={"ภายใน 1 วัน","เกิน 1 วัน","จำนวนวันที่เกิน"};
			 	String [] column_header_name_ext={"ภายใน 1 วัน","เกิน 1 วัน","SLA"};
			 	/*
			 	 [ 0 --> 0.00% ], [ 1 --> 100.00% ], [ 1 --> 100.00%],[ 0 ], จำนวนวันที่เกิน[ 1 ]
			 	จำนวนวันที่เกิน*/
			 	int[] column_index={9,7,8,10,5,3};
			 	int column_index_size=column_index.length;
/*
				   "  		<td style=\"text-align: left;\">"+data[i][9]+"</td>"+   
				   "  		<td style=\"text-align: left;\">"+data[i][7]+"</td>"+   
				   "  		<td style=\"text-align: left;\">"+data[i][8]+"</td>"+   
				   "  		<td style=\"text-align: left;\">"+data[i][10]+"</td>"+   
				   "  		<td style=\"text-align: left;\">"+data[i][2]+"</td>"+   
				   "  		<td style=\"text-align: left;\">"+data[i][3]+"</td>"+    
				   "  		<td style=\"text-align: left;\">"+data[i][5]+"</td>"+    
				   "  		<td style=\"text-align: center;\">"+((data[i][6]>0)?data[i][6]:"")+"</td>";*/
				   
				if(sla_size>0){ 
					  sheet = wb.createSheet(); 
					  int column_header_size=column_header_name.length;
					  row = sheet.getRow(indexRow);
						if(row==null)
							row=sheet.createRow(indexRow++);
						  cell =row.getCell(0); 
						  if(cell==null)
							cell = row.createCell(0); 
						  cell.setCellValue("ผู้ปฏิบัติงาน");
							 cell.setCellStyle(cellStyle2);
					  for (int i = 0; i < column_header_size; i++) { 
								  cell =row.getCell(i+1);
								if(cell==null)
									cell = row.createCell(i+1); 
								 cell.setCellValue(column_header_name[i]);
								 cell.setCellStyle(cellStyle2);
					  }
					  int column_header_ext_size=column_header_name_ext.length;
					  for (int i = 0; i < column_header_ext_size; i++) {
						  cell =row.getCell(column_header_size+i+1); 
							 if(cell==null)
								cell = row.createCell(column_header_size+i+1); 
							  cell.setCellValue(column_header_name_ext[i]);
								 cell.setCellStyle(cellStyle2);
					}
					  
						// ในเวลา[ 0 --> 0.00% ], นอกเวลา[ 1 --> 100.00% ], Max Time[ 1 --> 100.00%], Min Time[ 0 ], จำนวนวันที่เกิน[ 1 ]
					for (int i = 0; i < sla_size; i++) {
						 row = sheet.getRow(indexRow);
						 objs=sla_list.get(i);
							if(row==null)
								row=sheet.createRow(indexRow++);
							  cell =row.getCell(0);
							if(cell==null)
								cell = row.createCell(0); 
							 cell.setCellValue((String)objs[1] +" ["+(String)objs[0]+"]"); // data[i][1]+"     ["+data[i][0]+"]";
							 cell.setCellStyle(cellStyle);
							  
								  for (int j = 0; j < column_index_size; j++) {
									  cell =row.getCell(j+1);
										if(cell==null)
											cell = row.createCell(j+1); 
										//cell.setCellFormula(sheetName+"!C"+(index_user+1)); 
										 cell.setCellValue((String)objs[column_index[j]]);
										 cell.setCellStyle(cellStyle);
								 }  
								  double timediff=((java.math.BigInteger) objs[6])
											.doubleValue();
								 int in_time=0;
								 int out_time=0;
									  if(timediff>0){
										  in_time=0;
										  out_time=1;
									  }else{
										  in_time=1;
										  out_time=0;
									  }
								  // In Time
							    cell  =row.getCell(column_index_size+1);
									if(cell==null)
										cell = row.createCell(column_index_size+1);  
									cell.setCellStyle(cellStyle);
									cell.setCellValue(in_time);
								
									// Out Time
									cell =row.getCell(column_index_size+2);
										if(cell==null)
											cell = row.createCell(column_index_size+2);  
										cell.setCellStyle(cellStyle);
										cell.setCellValue(out_time);
										
										// Over Time count 
										cell =row.getCell(column_index_size+3);
									 if(cell==null)
										 cell = row.createCell(column_index_size+3);  
									 cell.setCellStyle(cellStyle);
									 if(in_time==1)
										 cell.setCellValue(1);
									 else
										 cell.setCellValue(timediff+1);
													 
					 
					}
					 row = sheet.getRow(indexRow); 
						if(row==null)
							row=sheet.createRow(indexRow++);
						 // In Time
					    cell  =row.getCell(column_index_size+1);
							if(cell==null)
								cell = row.createCell(column_index_size+1);  
							cell.setCellStyle(cellStyle2);
							cell.setCellFormula("sum(H2:H"+(sla_size+1)+")");
							
							// Out Time
							cell =row.getCell(column_index_size+2);
								if(cell==null)
									cell = row.createCell(column_index_size+2);  
								cell.setCellStyle(cellStyle2);
								cell.setCellFormula("sum(I2:I"+(sla_size+1)+")");
								
								// Over Time count 
								cell =row.getCell(column_index_size+3);
							 if(cell==null)
								 cell = row.createCell(column_index_size+3);  
							 cell.setCellStyle(cellStyle2);
							 cell.setCellFormula("sum(J2:J"+(sla_size+1)+")");
							 
							 row = sheet.getRow(indexRow); 
								if(row==null)
									row=sheet.createRow(indexRow++);
								cell =row.getCell(column_index_size+2);
								 if(cell==null)
									 cell = row.createCell(column_index_size+2);  
								 cell.setCellStyle(cellStyle2);
								 cell.setCellValue("MAX Time");
								 
								 cell =row.getCell(column_index_size+3);
								 if(cell==null)
									 cell = row.createCell(column_index_size+3);  
								 cell.setCellStyle(cellStyle);
								 cell.setCellFormula("MAX(J2:J"+(sla_size+1)+")");
								 
								
								 row = sheet.getRow(indexRow); 
									if(row==null)
										row=sheet.createRow(indexRow++);
									cell =row.getCell(column_index_size+2);
									 if(cell==null)
										 cell = row.createCell(column_index_size+2);  
									 cell.setCellStyle(cellStyle2);
									 cell.setCellValue("MIN Time");
									 
									 cell =row.getCell(column_index_size+3);
									 if(cell==null)
										 cell = row.createCell(column_index_size+3);  
									 cell.setCellStyle(cellStyle);
									 cell.setCellFormula("MIN(J2:J"+(sla_size+1)+")");
						  
				}
				HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
				
			 
			String filename="SLA_"+startdate+"-"+startdate+".xls";
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			
			byte[] fileNameBytes=null;
			try {
				fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			 String dispositionFileName = "";
			 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
		    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

			 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
			 response.setHeader("Content-disposition", disposition);
						      OutputStream out=null;
							try {
								out = response.getOutputStream();
							} catch (IOException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} 
							try {
								wb.write(out);
							
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} finally {
						         if (out != null) {
						            try { 
										  out.flush();
									      out.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
						         }
							 }
		} 
	  @RequestMapping(value={"/exportReport5/{startdate}/{enddate}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReport5(HttpServletRequest request,HttpServletResponse response ,
	    		@PathVariable String startdate,@PathVariable String enddate)
	    {
		/*   SynDomeBPMAjax.getReportSO(start_date,end_date,{
			 */

	    	 String[] START_DATE_PICKER_array=startdate.split("_"); // dd/mm/yyyy
	    	 String[] END_DATE_PICKER_array=enddate.split("_"); 
	    	 String start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 String end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]; 
		  VResultMessage vresultMessage=null;
			HSSFWorkbook wb = new HSSFWorkbook();   
					vresultMessage = synDomeBPMService.getReportSO(start_date, end_date);
				 
				  
				List<Object[]> so_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				
				int so_size = so_list!=null?so_list.size():0;
			//	String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
			 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 
				DataFormat dataFormat = wb.createDataFormat();
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				HSSFCellStyle cellStyle3 = wb.createCellStyle();
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
				cellStyle.setDataFormat(dataFormat.getFormat("#,##0.##")); // 99
				
				cellStyle3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setFont(font);
				cellStyle3.setDataFormat(dataFormat.getFormat("#,###.00")); // 99.00
				 
				cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font);
				cellStyle2.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
						.getIndex());  
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;
			 	int indexRow=0;
			 	String [] column_header_name={"SO ทั้งหมด","SO (ส่งของ)","SO (ติดตั้ง)","SO (ส่งของ,ติดตั้ง)","SO (ส่งของพร้อมติดตั้ง)","SO (ไม่ส่งของ)","จำนวนเครื่อง","ยอดขาย","ต้นทุน","กำไร"};
			 	//,วันที่",,
			 	 
			 	int[] column_index={1,2,3,4,5,6,7,8,9,10}; 
/*
 str=str+ "  	<tr >"+
								       "  <td style=\"text-align: center;\"><span> "+data[i][0]+"</span>"; 
								           str=str+ " </td>"+
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][1]+"", {format:"#,###.##", locale:"us"})+"</td>"+   
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][2]+"", {format:"#,###.##", locale:"us"})+"</td>"+    
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][3]+"", {format:"#,###.##", locale:"us"})+"</td>"+   
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][4]+"", {format:"#,###.##", locale:"us"})+ "</td>"+    
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][5]+"", {format:"#,###.##", locale:"us"})+"</td>"+  
									        "    	<td style=\"text-align: center;\">"+$.formatNumber(data[i][6]+"", {format:"#,###.##", locale:"us"})+"</td>  "+ 
									        "    	<td style=\"text-align: center;\">"+$.formatNumber(data[i][7]+"", {format:"#,###.##", locale:"us"})+"</td>  "+ 
									        "    	<td style=\"text-align: center;\">"+$.formatNumber(data[i][8]+"", {format:"#,###.00", locale:"us"})+"</td>  "+
									        "    	<td style=\"text-align: center;\">"+$.formatNumber(data[i][9]+"", {format:"#,###.00", locale:"us"})+"</td>  "+ 
									         "    	<td style=\"text-align: center;\">"+$.formatNumber(data[i][10]+"", {format:"#,###.00", locale:"us"})+"</td>  "; 
									        str=str+ "  	</tr>  "; 
*/
				   
				if(so_size>0){ 
					  sheet = wb.createSheet(); 
					  int column_header_size=column_header_name.length;
					  row = sheet.getRow(indexRow);
						if(row==null)
							row=sheet.createRow(indexRow++);
						 cell =row.getCell(0);
							if(cell==null)
								cell = row.createCell(0); 
							 cell.setCellValue("วันที่");
							 cell.setCellStyle(cellStyle2);
					  for (int i = 0; i < column_header_size; i++) { 
								  cell =row.getCell(i+1);
								if(cell==null)
									cell = row.createCell(i+1); 
								 cell.setCellValue(column_header_name[i]);
								 cell.setCellStyle(cellStyle2);
					  }  
					  
					for (int i = 0; i < so_size; i++) {
						 row = sheet.getRow(indexRow);
							if(row==null)
								row=sheet.createRow(indexRow++); 
							objs=so_list.get(i);
							 cell =row.getCell(0);
							  if(cell==null)
									cell = row.createCell(0); 
								 cell.setCellValue((String)objs[0]); // data[i][1]+"     ["+data[i][0]+"]";
								 cell.setCellStyle(cellStyle);
								  for (int j = 0; j < column_header_size; j++) {
									  cell =row.getCell(j+1);
										if(cell==null)
											cell = row.createCell(j+1);  
										 cell.setCellValue(((java.math.BigDecimal) objs[column_index[j]])
													.doubleValue() );
										 if(j>6)
											 cell.setCellStyle(cellStyle3);
										 else
											 cell.setCellStyle(cellStyle);
										
								  }  
					 
					}
				}
				HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
				
			 
			String filename="SO_"+start_date+"_"+end_date+".xls";
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			
			byte[] fileNameBytes=null;
			try {
				fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			 String dispositionFileName = "";
			 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
		    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

			 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
			 response.setHeader("Content-disposition", disposition);
						      OutputStream out=null;
							try {
								out = response.getOutputStream();
							} catch (IOException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} 
							try {
								wb.write(out);
							
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} finally {
						         if (out != null) {
						            try { 
										  out.flush();
									      out.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
						         }
							 }
		}
	  @RequestMapping(value={"/exportReport6/{startdate}/{enddate}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReport6(HttpServletRequest request,HttpServletResponse response ,
	    		@PathVariable String startdate,@PathVariable String enddate)
	    {
		/*   SynDomeBPMAjax.getReportSO(start_date,end_date,{
			 */

	    	 String[] START_DATE_PICKER_array=startdate.split("_"); // dd/mm/yyyy
	    	 String[] END_DATE_PICKER_array=enddate.split("_"); 
	    	 String start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 String end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]; 
		  VResultMessage vresultMessage=null;
			HSSFWorkbook wb = new HSSFWorkbook();   
					vresultMessage = synDomeBPMService.getReportDeptStatus(start_date, end_date);
				 
				  
				List<Object[]> status_dept_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				
				int status_dept_size = status_dept_list!=null?status_dept_list.size():0;
			//	String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
			 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 
				DataFormat dataFormat = wb.createDataFormat();
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				HSSFCellStyle cellStyle3 = wb.createCellStyle();
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
				cellStyle.setDataFormat(dataFormat.getFormat("#,##0.##")); // 99
				
				cellStyle3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setFont(font);
				cellStyle3.setDataFormat(dataFormat.getFormat("#,###.00")); // 99.00
				 
				cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font);
				cellStyle2.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
						.getIndex());  
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;
			 	int indexRow=0;
			 	String [] column_header_name={"Job ทั้งหมด","เสร็จ","ไม่เสร็จ","รับเครื่อง/เช็คไซต์ [IT กทม ปริฯ]","รับเครื่อง/เช็คไซต์ [IT ภูมิภาค]","ขนส่ง กทม ปริฯ","ขนส่ง ภูมิภาค","ซ่อม [SC]","เสนอราคา [Sale]","รออนุมัติซ่อม [Sale]","ตรวจสอบเอกสาร [AdminCenter]"};
			 	//,วันที่","Job ทั้งหมด","เสร็จ/ไม่เสร็จ",
			 	 
			 	int[] column_index={1,10,11,2,3,4,5,6,7,8,9}; 
			 	
/*
"  		<th width=\"7%\"><div class=\"th_class\">วันที่</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">Job ทั้งหมด</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">เสร็จ/ไม่เสร็จ</div></th> "+   
					        "  		<th width=\"5%\"><div class=\"th_class\">รับเครื่อง/เช็คไซต์ [IT กทม ปริฯ]</div></th> "+ 
					        "  		<th width=\"5%\"><div class=\"th_class\">รับเครื่อง/เช็คไซต์ [IT ภูมิภาค]</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">ขนส่ง กทม ปริฯ</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">ขนส่ง ภูมิภาค</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">ซ่อม [SC]</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">เสนอราคา [Sale]</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">รออนุมัติซ่อม [Sale]</div></th> "+   
					        "  		<th width=\"5%\"><div class=\"th_class\">ตรวจสอบเอกสาร [AdminCenter]</div></th> "+
					         job_all_str=data[i][1];
				   job_complete_str=data[i][10];
				   job_not_complete_str=data[i][11];
				   job_1_str=data[i][2];
				   job_2_str=data[i][3];
				   job_3_str=data[i][4];
				   job_4_str=data[i][5];
				   job_5_str=data[i][6];
				   job_6_str=data[i][7];
				   job_7_str=data[i][8];
				   job_8_str=data[i][9];
*/
			 	
				   
				if(status_dept_size>0){ 
					  sheet = wb.createSheet(); 
					  int column_header_size=column_header_name.length;
					  row = sheet.getRow(indexRow);
						if(row==null)
							row=sheet.createRow(indexRow++);
						 cell =row.getCell(0);
							if(cell==null)
								cell = row.createCell(0); 
							 cell.setCellValue("วันที่");
							 cell.setCellStyle(cellStyle2);
							 
							/* cell =row.getCell(1);
							 if(cell==null)
								cell = row.createCell(1); 
								 cell.setCellValue("Job ทั้งหมด");
								 cell.setCellStyle(cellStyle2);
							
							cell =row.getCell(2);
							if(cell==null)
								 cell = row.createCell(2); 
								 cell.setCellValue("เสร็จ/ไม่เสร็จ");
								 cell.setCellStyle(cellStyle2); */
					  for (int i = 0; i < column_header_size; i++) { 
								  cell =row.getCell(i+1);
								if(cell==null)
									cell = row.createCell(i+1); 
								 cell.setCellValue(column_header_name[i]);
								 cell.setCellStyle(cellStyle2);
					  }  
					  
					for (int i = 0; i < status_dept_size; i++) {
						 row = sheet.getRow(indexRow);
							if(row==null)
								row=sheet.createRow(indexRow++); 
							objs=status_dept_list.get(i);
							 cell =row.getCell(0);
							  if(cell==null)
									cell = row.createCell(0); 
								 cell.setCellValue((String)objs[0]);  
								 cell.setCellStyle(cellStyle);
								
							/*cell =row.getCell(1);
								  if(cell==null)
									cell = row.createCell(1); 
									 cell.setCellValue(((java.math.BigInteger) objs[1])
												.intValue());  
									 cell.setCellStyle(cellStyle);
							
							cell =row.getCell(2);
								  if(cell==null)
									cell = row.createCell(2); 
								  cell.setCellValue(((java.math.BigInteger) objs[10])
											.intValue()+"/"+((java.math.BigInteger) objs[11])
											.intValue()  ); 
								   cell.setCellStyle(cellStyle); */
								  for (int j = 0; j < column_header_size; j++) {
									  cell =row.getCell(j+1);
										if(cell==null)
											cell = row.createCell(j+1);  
										 cell.setCellValue(((java.math.BigInteger) objs[column_index[j]])
													.doubleValue() ); 
											 cell.setCellStyle(cellStyle);
										
								  }  
					 
					}
				}
				HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
				
			 
			String filename="DeptStatus_"+start_date+"_"+end_date+".xls";
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			
			byte[] fileNameBytes=null;
			try {
				fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			 String dispositionFileName = "";
			 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
		    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

			 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
			 response.setHeader("Content-disposition", disposition);
						      OutputStream out=null;
							try {
								out = response.getOutputStream();
							} catch (IOException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} 
							try {
								wb.write(out);
							
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} finally {
						         if (out != null) {
						            try { 
										  out.flush();
									      out.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
						         }
							 }
		}
	  @RequestMapping(value={"/exportReport7/{startdate}/{enddate}/{username}/{deptType}/{deptId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReport7(HttpServletRequest request,HttpServletResponse response ,
	    		@PathVariable String startdate,@PathVariable String enddate,@PathVariable String username,@PathVariable String deptType,@PathVariable String deptId)
	    {
	 
	    	 String[] START_DATE_PICKER_array=startdate.split("_"); // dd/mm/yyyy
	    	 String[] END_DATE_PICKER_array=enddate.split("_"); 
	    	 String start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 String end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]; 
		  VResultMessage vresultMessage=null;
			HSSFWorkbook wb = new HSSFWorkbook();   
			/*
			 * <option value="-1,-1_-1"> ALL </option> 
										 <option value="sommai,1_4">ฝ่าย IT กทม ปริฯ</option> 
										 <option value="siwaporn,1_5">ฝ่าย IT ภูมิภาค</option>
										 <option value="maytazzawan,5_8">ฝ่ายขนส่ง กทม ปริฯ</option>
										 <option value="regent_admin,5_9">ฝ่ายขนส่ง ภูมิภาค</option>
										 <option value="numfon,4_3">ฝ่าย SC</option> 
										    var dep_select_array=$("#dep_select_id").val().split(",");
			   var dep_select_id_array=dep_select_array[1].split("_"); 
			 // var dep_id=dep_select_id_array[1];
			  var _username=dep_select_array[0];
			  var _deptType=dep_select_id_array[0];
			  var _deptId=dep_select_id_array[1];
			 */
		  
				    	 String BDEPT_ID_QUERY="  u.username= todo_list.btdl_owner";
				    	 if(!deptType.equals("-1")){
				    		 BDEPT_ID_QUERY=" dept_user.BDEPT_ID="+deptId+" and u.username= todo_list.btdl_owner";
				    	 }
				    	 String query="select DATE_FORMAT(sv.BSJ_CREATED_TIME,'%d/%m/%Y'),todo_list.btdl_owner,count(*) , concat(user_outer.firstname,' ',user_outer.lastname) ,DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d') "+
				    	  " from "+schema+".BPM_TO_DO_LIST todo_list left join  "+
				    	  "  "+schema+".BPM_SERVICE_JOB sv  on( todo_list.BTDL_REF=sv.bcc_no and todo_list.btdl_type=2) "+ 
				    	  "  left join "+schema+".user user_outer on user_outer.username=todo_list.btdl_owner "+
				    	  " 	 where    sv.BSJ_CREATED_TIME between '"+START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0]+" 00:00:00' and '"+END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]+" 23:59:59'  "+ 
				    	
				    	  " and todo_list.btdl_hide='1'   and  exists (SELECT username FROM "+schema+".BPM_DEPARTMENT_USER dept_user left join "+schema+".user u  "+
				    	  "  on dept_user.USER_ID=u.id where "+BDEPT_ID_QUERY+" "+
				    	 
				    	  ")    "+
				    	  "  group by todo_list.btdl_owner , DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00')  "+
				    		" order by btdl_owner, sv.BSJ_CREATED_TIME limit 1000 ";
					vresultMessage = synDomeBPMService.searchObject(query);
				 
				  
				List<Object[]> status_dept_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				
				int status_dept_size = status_dept_list!=null?status_dept_list.size():0;
			//	String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
			 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 
				DataFormat dataFormat = wb.createDataFormat();
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				HSSFCellStyle cellStyle3 = wb.createCellStyle();
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
				cellStyle.setDataFormat(dataFormat.getFormat("#,##0.##")); // 99
				
				cellStyle3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setFont(font);
				cellStyle3.setDataFormat(dataFormat.getFormat("#,###.00")); // 99.00
				 
				cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font);
				cellStyle2.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
						.getIndex());  
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;
			 	int indexRow=0;
			 	String [] column_header_name={"จำนวนงานค้าง"};
			 	//"ผู้ปฏิบัติงาน",
			 	 
			 	int[] column_index={2}; 
			 	
/*
   name_show=data[i][3]+"     ["+data[i][1]+"]"; 
										  
									   str=str+ "  	<tr >"+
								       "  <td style=\"text-align: center;\"><span>"+name_show+"</span>"; 
								           str=str+ " </td>"+
										   "  		<td style=\"text-align: left;\">"+data[i][0]+"</td>"+    
										   "  		<td style=\"text-align: center;\"><span style=\"text-decoration: underline;cursor: pointer;\"+data[i][2]+"</span></td>";
									        str=str+ "  	</tr>  "; 
									        
*/
			 	
				   
				if(status_dept_size>0){ 
					  sheet = wb.createSheet(); 
					  int column_header_size=column_header_name.length;
					  row = sheet.getRow(indexRow);
						if(row==null)
							row=sheet.createRow(indexRow++);
						 cell =row.getCell(0);
							if(cell==null)
								cell = row.createCell(0); 
							 cell.setCellValue("ผู้ปฏิบัติงาน");
							 cell.setCellStyle(cellStyle2);
							 cell =row.getCell(1);
								if(cell==null)
									cell = row.createCell(1); 
								 cell.setCellValue("วันที่");
								 cell.setCellStyle(cellStyle2); 
					  for (int i = 0; i < column_header_size; i++) { 
								  cell =row.getCell(i+2);
								if(cell==null)
									cell = row.createCell(i+2); 
								 cell.setCellValue(column_header_name[i]);
								 cell.setCellStyle(cellStyle2);
					  }  
					  
					for (int i = 0; i < status_dept_size; i++) {
						 row = sheet.getRow(indexRow);
							if(row==null)
								row=sheet.createRow(indexRow++); 
							objs=status_dept_list.get(i);
							 cell =row.getCell(0);
							  if(cell==null)
									cell = row.createCell(0); 
								 cell.setCellValue((String)objs[3]+" ["+(String)objs[1]+"]");  
								 cell.setCellStyle(cellStyle); 
							 
								 cell =row.getCell(1);
								  if(cell==null)
										cell = row.createCell(1); 
									 cell.setCellValue((String)objs[0]);  
									 cell.setCellStyle(cellStyle); 
								 
								  for (int j = 0; j < column_header_size; j++) {
									  cell =row.getCell(j+2);
										if(cell==null)
											cell = row.createCell(j+2);  
										 cell.setCellValue(((java.math.BigInteger) objs[column_index[j]])
													.doubleValue() ); 
											 cell.setCellStyle(cellStyle);
										
								  }  
					 
					}
				}
				HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
				
			 
			String filename="OperStatus_"+start_date+"_"+end_date+".xls";
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			
			byte[] fileNameBytes=null;
			try {
				fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			 String dispositionFileName = "";
			 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
		    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

			 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
			 response.setHeader("Content-disposition", disposition);
						      OutputStream out=null;
							try {
								out = response.getOutputStream();
							} catch (IOException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} 
							try {
								wb.write(out);
							
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} finally {
						         if (out != null) {
						            try { 
										  out.flush();
									      out.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
						         }
							 }
		}
	  @RequestMapping(value={"/exportReport8/{startdate}/{enddate}/{filterBy}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReport8(HttpServletRequest request,HttpServletResponse response ,
	    		@PathVariable String startdate,@PathVariable String enddate,@PathVariable String filterBy)
	    {
	 
	    	 String[] START_DATE_PICKER_array=startdate.split("_"); // dd/mm/yyyy
	    	 String[] END_DATE_PICKER_array=enddate.split("_"); 
	    	 String start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 String end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]; 
		  VResultMessage vresultMessage=null;
			HSSFWorkbook wb = new HSSFWorkbook();  
			String title=""; 
			  if(filterBy.equals("1"))
				  title="จังหวัด";
			  if(filterBy.equals("2"))
				  title="ลูกค้า";
			  if(filterBy.equals("3"))
				  title="รุ่น";
			/*
			 
	     var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val(); 
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
	    
	    	 var start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 var end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
	  
					  SynDomeBPMAjax.getReportPMMA(start_date,end_date,viewSelect,{
			 */
			  String query="SELECT u.id,concat(bc_name,'[', u.firstName,' ',u.lastName,']') FROM "+schema+".BPM_CENTER center left join "+schema+".user u "+ 
				    	" on center.uid=u.id  ";
				     
				    	vresultMessage = synDomeBPMService.searchObject(query);
				    	//vresultMessage = synDomeBPMService.getReportPMMA(start_date,end_date,filterBy);
				  
				List<Object[]> user_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
				
				int user_size = user_list!=null?user_list.size():0;
			//	String[] column_array={"J1","C4","E4","C5","C6","C7","C9","H4","G5","G6","G7","G8","G9","G10","G11","G12"};
			 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 
				DataFormat dataFormat = wb.createDataFormat();
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				HSSFCellStyle cellStyle3 = wb.createCellStyle();
				/*HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();*/
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
				cellStyle.setDataFormat(dataFormat.getFormat("#,##0.##")); // 99
				
				cellStyle3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setFont(font);
				cellStyle3.setDataFormat(dataFormat.getFormat("#,###.00")); // 99.00
				 
				cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font);
				cellStyle2.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE
						.getIndex());  
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;
			 	int indexRow=0;
			 	String [] column_header_name={title,"วันที่นัดหมาย"};
			 	//"ผู้ปฏิบัติงาน",
			 	String [] column_header_name2=null;
			 	if(user_size>0){
			 		column_header_name2=new String[user_size];
			 		for (int i = 0; i < user_size; i++) {
			 			objs=user_list.get(i);
			 			column_header_name2[i]=(String)objs[1];
			 		}
			 	}
			 	//int[] column_index_1={2}; 
			 	
/*
  name_show=data[i][0];  
										  
									   str=str+ "  	<tr >"+
								       "  <td style=\"text-align: center;\"><span>"+name_show+"</span>"; 
								           str=str+ " </td>"+
										   "  		<td style=\"text-align: left;\">"+data[i][1]+"</td>"+    
										   "  		<td style=\"text-align: center;\"><span style=\"text-decoration: underline;cursor: pointer;\"+data[i][2]+"</span></td>";
									        str=str+ "  	</tr>  "; 
									        
*/
			 	 
			 		 vresultMessage = synDomeBPMService.getReportPMMA(start_date,end_date,filterBy);
					  
						List<Object[]> pmma_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
						int pmma_size = pmma_list!=null?pmma_list.size():0;
						 
				if(pmma_size>0){ 
					 sheet = wb.createSheet();
					  int column_header_size=column_header_name.length;
					  row = sheet.getRow(indexRow);
						if(row==null)
							row=sheet.createRow(indexRow++);
					/*	 cell =row.getCell(0);
							if(cell==null)
								cell = row.createCell(0); 
							 cell.setCellValue("ผู้ปฏิบัติงาน");
							 cell.setCellStyle(cellStyle2);
							 cell =row.getCell(1);
								if(cell==null)
									cell = row.createCell(1); 
								 cell.setCellValue("วันที่");
								 cell.setCellStyle(cellStyle2);*/ 
					  for (int i = 0; i < column_header_size; i++) { 
								  cell =row.getCell(i);
								if(cell==null)
									cell = row.createCell(i); 
								 cell.setCellValue(column_header_name[i]);
								 cell.setCellStyle(cellStyle2);
					  }  
					   
					  for (int i = 0; i < user_size; i++) { 
						  cell =row.getCell(i+2);
						if(cell==null)
							cell = row.createCell(i+2); 
						 cell.setCellValue(column_header_name2[i]);
						 cell.setCellStyle(cellStyle2);
			         }
					
					  for (int i = 0; i < pmma_size; i++) {
					  
						 row = sheet.getRow(indexRow);
							if(row==null)
								row=sheet.createRow(indexRow++); 
							objs=pmma_list.get(i);
							 cell =row.getCell(0);
							  if(cell==null)
									cell = row.createCell(0); 
								 cell.setCellValue((String)objs[0]);  
								 cell.setCellStyle(cellStyle); 
							 
								 cell =row.getCell(1);
								  if(cell==null)
										cell = row.createCell(1); 
									 cell.setCellValue((String)objs[1]);  
									 cell.setCellStyle(cellStyle); 
								 
								  for (int j = 0; j < user_size; j++) {
									  cell =row.getCell(j+2);
										if(cell==null)
											cell = row.createCell(j+2);  
										 cell.setCellValue(((java.math.BigInteger) objs[j+2])
													.doubleValue() ); 
											 cell.setCellStyle(cellStyle);
										
								  }  
					 
					}
				}
				HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
				
			 
			String filename="Planing_"+start_date+"_"+end_date+".xls";
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			
			byte[] fileNameBytes=null;
			try {
				fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			 String dispositionFileName = "";
			 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
		    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

			 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
			 response.setHeader("Content-disposition", disposition);
						      OutputStream out=null;
							try {
								out = response.getOutputStream();
							} catch (IOException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} 
							try {
								wb.write(out);
							
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} finally {
						         if (out != null) {
						            try { 
										  out.flush();
									      out.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
						         }
							 }
		}
}
