package th.co.imake.syndome.bpm.backoffice.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

@Controller
@RequestMapping(value = { "/reportPending" })
public class ReportPendingController {
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

	public static String convertFromUTF8(String s) {
        String out = null;
        try {
            out = new String(s.getBytes("ISO-8859-1"), "UTF-8");
        } catch (java.io.UnsupportedEncodingException e) {
            return null;
        }
        return out;
	}
	    
	  @RequestMapping(value={"/exportReportCMBKKTech/{typeSelect}/{deptSelect}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReportCMBKKTech(HttpServletRequest request,HttpServletResponse response ,
	    		@PathVariable String typeSelect,@PathVariable String deptSelect) throws UnsupportedEncodingException
	    {

	    	 VResultMessage vresultMessage=null;
	    	 HSSFWorkbook wb = new HSSFWorkbook();  
	    	 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 
				
				Font font2 = wb.createFont();
				font2.setFontHeightInPoints((short) 14);
				font2.setFontName("Angsana New"); 
				font2.setBoldweight(Font.BOLDWEIGHT_BOLD);
				
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();
				
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
				//cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font2);
				cellStyle2.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				cellStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setFont(font);
				//cellStyle3.setWrapText(true);
				
				cellStyle4.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle4.setFont(font2);
				
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;			
			 	int indexRow=0;

			 	String [] column_header_name1={"ลำดับ","Job No.","สถานที่ซ่อม","เขต","ที่อยู่","S/N","Model","กลุ่มงาน","ประเภทงาน","อาการ","อะไหล่","การแก้ไข","ช่าง","รับแจ้ง","แผน SLA","SLA Date","แผน","SLA","Job","อุปสรรค"};
			 	String [] column_header_name2={"ลำดับ","Job No.","สถานที่ซ่อม","จังหวัด","ที่อยู่","S/N","Model","กลุ่มงาน","ประเภทงาน","อาการ","อะไหล่","การแก้ไข","ช่าง","รับแจ้ง","แผน SLA","SLA Date","แผน","SLA","Job","อุปสรรค"};
			 	String [] column_header_name3={"ลำดับ","Job No.","สถานที่ซ่อม","เขต","ที่อยู่","S/N","Model","กลุ่มงาน","ประเภทงาน","อาการ","อะไหล่","การแก้ไข","ผู้ดำเนินการ","รับแจ้ง","แผน SLA","SLA Date","แผน","SLA","Job","อุปสรรค"};
			 	String [] column_header_name4={"ลำดับ","Job No.","สถานที่ซ่อม","จังหวัด","ที่อยู่","S/N","Model","กลุ่มงาน","ประเภทงาน","อาการ","อะไหล่","การแก้ไข","ผู้ดำเนินการ","รับแจ้ง","แผน SLA","SLA Date","แผน","SLA","Job","อุปสรรค"};
			 	
			 	String queryWhere = "";
			 	int deptId = -1;
			 	if(deptSelect.equals("techBKK"))
			 		deptId = 4;
			 	else if(deptSelect.equals("techReg"))
			 		deptId = 5;
			 	else if(deptSelect.equals("logisticBKK"))
			 		deptId = 8;
			 	else if(deptSelect.equals("logisticReg"))
			 		deptId = -1;
			 	String query = "";
			 	String query_callcenter = "";
			 	String query_services = "";
			 	query_callcenter="SELECT call_center.BCC_NO as c0, "+//0
						"IFNULL(call_center.BCC_LOCATION ,'') as c1, "+//1
						"IFNULL(call_center.BCC_ADDR3 ,'') as c2, "+//2
						"CONCAT(IFNULL(call_center.BCC_BRANCH ,''),' ',IFNULL(call_center.BCC_ADDR1 ,''),' ', IFNULL(call_center.BCC_ADDR2 ,''),' ',IFNULL(call_center.BCC_ADDR3 ,'') , ' ' ,IFNULL(call_center.BCC_PROVINCE ,''),' ',IFNULL(call_center.BCC_ZIPCODE ,'')) as c3 , "+//4
						"IFNULL(call_center.BCC_SERIAL,'') as c4, "+//4
						"IFNULL(call_center.BCC_MODEL,'') as c5, "+//5
						"IFNULL(call_center.BCC_CAUSE,'-') as c6, "+//6
						"IFNULL(sp.SPARES,'-') as c7, "+//7
						"IFNULL(sv.SBJ_JOB_PROBLEM_SOLUTION,'-') as c8, "+//8
						"IFNULL(user.firstname,'') AS c9,"+//9
						"IFNULL(dept.BDEPT_DETAIL,IFNULL(dept2.BDEPT_DETAIL,'')) as c10, "+//10
						"IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y'),'') as c11, "+//11
						"IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c12,"+//12
						"IFNULL(DATE_FORMAT(sv.SBJ_SYNDOME_SEND_DATE,'%d/%m/%Y'),'Pending') as c13, "+//13
						"IFNULL(DATE_FORMAT(sv.SBJ_CLOSE_DATE,'%d/%m/%Y'),'Pending') as c14, "+//14
						"CASE WHEN sv.SBJ_SYNDOME_RECIPIENT_DATE IS NOT NULL THEN 'Complete' "+
						"ELSE 'Pending' END  as c15, "+//15
						"IFNULL(j_status.BJS_DETAIL,'')  as c16 , "+//16
						"IFNULL(sv.SBJ_PROBLEM_CAUSE,'') as c17, "+//17
						"DATEDIFF(IFNULL(call_center.BCC_DUE_DATE,''),call_center.BCC_CREATED_TIME) as c18, "+//18
						"DATEDIFF(IFNULL(sv.SBJ_SYNDOME_SEND_DATE,''),call_center.BCC_CREATED_TIME) as c19, "+//19
						"DATEDIFF(now(), call_center.BCC_CREATED_TIME) as c20, "+//20
						"call_center.BCC_CUST_INDEX as c21, "+//21
						" case "+
	 					" when call_center.BCC_IS_MA='0' "+
	 					" then 'นอกประกัน'"+
	 					" when call_center.BCC_IS_MA='1' "+
	 					" then 'ในประกัน' "+
	 					" when call_center.BCC_IS_MA='2' "+
	 					" then CONCAT('MA No.',IFNULL(call_center.BCC_MA_NO,'')) "+
	 					" else 'ไม่ระบุ' "+
	 					" end as c22, "+//22
	 					"IFNULL(call_center.BCC_MA_NO,'') as c23, "+//23
	 					"IFNULL(call_center.BCC_REMARK,'') as c24, "+//24
	 					"IFNULL(call_center.BCC_PROVINCE ,'') as c25, "+//25
	 					" 'CM' as c26, "+
	 					" dept.BDEPT_ID as c27, "+
	 					" user.username as c28 "+
	 					
						"FROM "+schema+".BPM_CALL_CENTER call_center "+
						"left join "+schema+".BPM_SERVICE_JOB  sv  "+
						"on( call_center.BCC_NO=sv.BCC_NO) "+
						"left join  "+schema+".BPM_JOB_STATUS j_status "+
						"on (sv.SBJ_JOB_STATUS=j_status.BJS_ID and j_status.BJS_TYPE=2 ) "+
						"left join (select todo.btdl_ref,todo.BTDL_STATE,todo.BTDL_OWNER ,todo.BTLD_AI,todo.BTDL_HIDE,todo.BTDL_CREATED_TIME "+
						"		 from "+schema+".BPM_TO_DO_LIST todo "+
						"		 where todo.btdl_type='2' and "+
						"		 todo.BTLD_AI in (SELECT MAX(BTLD_AI) from "+schema+".BPM_TO_DO_LIST where BTDL_TYPE=2 group by BTDL_REF)) as todo2 "+
						"on (todo2.btdl_ref=call_center.BCC_NO) "+
						"left join "+schema+".user user  "+
						"on (user.username=todo2.BTDL_OWNER ) "+
						"left join "+schema+".BPM_DEPARTMENT_USER dept_user "+
						"on dept_user.USER_ID = user.id "+
						"left join "+schema+".BPM_DEPARTMENT dept "+
						"on dept.BDEPT_ID = dept_user.BDEPT_ID  "+
						"left join "+schema+".BPM_DEPARTMENT dept2 	"+
						"on dept2.BDEPT_HDO_USER_ID = user.id "+
						"left join  "+schema+".BPM_SYSTEM_PARAM param "+
						"on ( param.PARAM_NAME='STATE' and todo2.BTDL_STATE=param.key ) "+
						"left join ( SELECT mapping.BCC_NO,GROUP_CONCAT(IFNULL(product.IMA_ItemName,'') separator ',') AS SPARES "+
						"	FROM "+schema+".BPM_SERVICE_ITEM_MAPPING  mapping left join "+schema+".BPM_PRODUCT product on mapping.IMA_ItemID=product.IMA_ItemID  and mapping.BSIM_TYPE=2 GROUP BY mapping.BCC_NO) sp "+
						"    on sp.BCC_NO =call_center.BCC_NO "+
			 	 		" where todo2.BTDL_HIDE='1' ";
			 	
			 	//-------------------------------service------------------------------
			 	query_services = " SELECT inner_service.BISJ_NO as c0,"+
			 					" IFNULL(inner_service.BISJ_INSTALLATION_LOCATION ,'') as c1,"+
			 					" IFNULL(inner_service.BISJ_ADDR3 ,'') as c2,"+
			 					" CONCAT(IFNULL(inner_service.BISJ_INSTALLATION_LOCATION ,''),' ', IFNULL(inner_service.BISJ_ADDR1 ,''),' ',IFNULL(inner_service.BISJ_ADDR2 ,''),' ',IFNULL(inner_service.BISJ_ADDR3 ,'') , ' ' ,IFNULL(inner_service.BISJ_PROVINCE ,''),' ',IFNULL(inner_service.BISJ_ZIPCODE ,'')) as c3 ,"+ 
			 					" IFNULL(inner_service.BISJ_SERIAL ,'-') as c4, "+
			 					" IFNULL(inner_service.BISJ_MODEL ,'-') as c5,"+
			 					" '-' as c6,"+
			 					" '-' as c7,"+
			 					" '-' as c8,"+
			 					" user.firstName as c9, "+
			 					" IFNULL(dept.BDEPT_DETAIL,IFNULL(dept2.BDEPT_DETAIL,'')) as c10, "+//11
			 					" DATE_FORMAT(inner_service.BISJ_CREATED_DATE,'%d/%m/%Y') as c11, "+
			 					" DATE_FORMAT(inner_service.BISJ_DELIVERY_DUEDATE,'%d/%m/%Y') as c12, "+
			 					" 'Pending' as c13,"+
			 					" 'Pending' as c14,"+
			 					" 'Pending' as c15,"+
			 					" IFNULL(j_status.BJS_DETAIL,'')  as c16 , "+//16
			 					" '-' as c17,"+
			 					" DATEDIFF(IFNULL(inner_service.BISJ_DELIVERY_DUEDATE,''),inner_service.BISJ_CREATED_DATE) as c18, "+//18
			 					" DATEDIFF(IFNULL(inner_service.BISJ_DELIVERY_DUEDATE,''),inner_service.BISJ_CREATED_DATE) as c19, "+//19
			 					" DATEDIFF(now(), inner_service.BISJ_CREATED_DATE) as c20, "+//20
			 					" '-' as c21,"+
			 					" case "+
			 					" when inner_service.BISJ_IS_INSTALLATION='1' "+
			 					" then 'ติดตั้ง'"+
			 					" when inner_service.BISJ_IS_SERWAY_SITE='1' "+
			 					" then 'สำรวจ' "+
			 					" when inner_service.BISJ_IS_SEND_UPS='1' "+
			 					" then 'ส่งUPS' "+
			 					" when inner_service.BISJ_IS_EXT='1' "+
			 					" then IFNULL(inner_service.BISJ_EXT,'ไม่ระบุ') "+
			 					" else 'ไม่ระบุ' "+
			 					" end as c22, "+//22
			 					" '-' as c23,"+
			 					" '-' as c24,"+
			 					" IFNULL(inner_service.BISJ_PROVINCE ,'') as c25,"+
			 					" 'สนับสนุน' as c26, "+
			 					" dept.BDEPT_ID as c27, "+
			 					" user.username as c28 "+
			 					
							 	" FROM "+schema+".BPM_TO_DO_LIST todo "+
								" left join "+schema+".BPM_INNER_SERVICE_JOB inner_service "+
								"	on (inner_service.BISJ_NO = todo.BTDL_REF) "+
								" left join "+schema+".user user "+
								"	on user.username = todo.BTDL_OWNER "+
								" left join "+schema+".BPM_DEPARTMENT_USER dept_user "+
								"	on dept_user.USER_ID = user.id "+
								" left join "+schema+".BPM_DEPARTMENT dept "+
								"   on dept.BDEPT_ID = dept_user.BDEPT_ID "+
								" left join "+schema+".BPM_DEPARTMENT dept2 "+
								"	on dept2.BDEPT_HDO_USER_ID = user.id 	"+			
								" left join "+schema+".BPM_JOB_STATUS j_status  "+
								"	on (inner_service.BISJ_JOB_STATUS=j_status.BJS_ID and j_status.BJS_TYPE=4 ) "+
								" left join "+schema+".BPM_SYSTEM_PARAM param "+
								"	on ( param.PARAM_NAME='STATE' and todo.BTDL_STATE=param.key ) "+
								" where  BTDL_TYPE=4 and (todo.BTDL_HIDE='1') ";
			 	
				//queryWhere = " where todo2.BTDL_HIDE='1' ";
				
				if(deptId!=-1)
					queryWhere = " where c27="+deptId;
				
				if(deptSelect.equals("logisticReg"))
					queryWhere = " where c28='regent_admin' ";

				//String queryOrderBy = " order by call_center.BCC_NO ";
				
				query = "select * from ("+query_callcenter+" union "+query_services+" ) as pending_job "+queryWhere+" order by c0  ";
			 	//System.out.println("....aui print query_list = "+query);
			 	vresultMessage = synDomeBPMService.searchObject(query);
			
				
				List<Object[]> serviceKA_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
						//System.out.println("----aui print serviceKA_list = "+serviceKA_list);
						int serviceKA_size = serviceKA_list!=null?serviceKA_list.size():0;
						// System.out.println("....aui print serviceKA_size = "+serviceKA_size);
						if(serviceKA_size>0){ 
							 sheet = wb.createSheet();//calculateColWidth
							 
							 //sheet.setColumnWidth(2, 2400);
							 //--------report header--------
							 row = sheet.getRow(indexRow);
								if(row==null)
									row=sheet.createRow(indexRow++);
								
								cell =row.getCell(0);
								if(cell==null)									
									cell = row.createCell(0); 
								cell.setCellValue("  <==");
								cell.setCellStyle(cellStyle4);
								
								DateFormat dateFormat1 = new SimpleDateFormat("dd-MM-yyyy");
						  		DateFormat dateFormat2 = new SimpleDateFormat("dd/MM/yyyy");
						  		Date date = new Date();
						  		String currentDate1 = dateFormat1.format(date);
						  		String currentDate2 = dateFormat2.format(date);
						  		
								String headTitle="";
								if(deptSelect.equals("techBKK"))	
									  headTitle = "สรุปงานค้างCM ช่างกทม. ผู้รับผิดชอบ เป้ ทุก 10.00 น.Update "+currentDate2;
								else if(deptSelect.equals("techReg"))
									  headTitle = "สรุปงานค้างCM ช่างภูมิภาค ผู้รับผิดชอบ เป้ ทุก 10.00 น.Update "+currentDate2;
								else if(deptSelect.equals("logisticBKK"))
									  headTitle = "สรุปงานค้างจัดส่งกทม ผู้รับผิดชอบ มิ้น ทุก 10.00 น.Update "+currentDate2;
								else if(deptSelect.equals("logisticReg"))
									  headTitle = "สรุปงานค้างจัดส่งภูมิภาค ผู้รับผิดชอบ ปุ้ย ทุก 10.00 น.Update "+currentDate2;
								
								cell =row.getCell(1);
								if(cell==null)
									cell = row.createCell(1); 
								cell.setCellValue(headTitle);
								cell.setCellStyle(cellStyle4);
								
								cell =row.getCell(13);
								if(cell==null)
									cell = row.createCell(13); 
								cell.setCellValue("วันที่");
								cell.setCellStyle(cellStyle2);
								sheet.addMergedRegion(new CellRangeAddress(0,0,13,15));//merged S1-U1
								
								cell =row.getCell(16);
								if(cell==null)
									cell = row.createCell(16); 
								cell.setCellValue("Aging");
								cell.setCellStyle(cellStyle2);
								sheet.addMergedRegion(new CellRangeAddress(0,0,16,18));//merged S1-U1

							 //--------table header----------
								int column_header_size = 0;
								if(deptSelect.equals("techBKK"))	
									column_header_size=column_header_name1.length;
								else if(deptSelect.equals("techReg"))
									column_header_size=column_header_name2.length;
								else if(deptSelect.equals("logisticBKK"))
									column_header_size=column_header_name3.length;
								else if(deptSelect.equals("logisticReg"))
									column_header_size=column_header_name4.length;
								
								row = sheet.getRow(indexRow);
								if(row==null)
									row=sheet.createRow(indexRow++);

								for (int i = 0; i < column_header_size; i++) { 
									cell =row.getCell(i);
									if(cell==null)
										cell = row.createCell(i); 
									if(deptSelect.equals("techBKK"))	
										cell.setCellValue(column_header_name1[i]);
									else if(deptSelect.equals("techReg"))
										cell.setCellValue(column_header_name2[i]);
									else if(deptSelect.equals("logisticBKK"))
										cell.setCellValue(column_header_name3[i]);
									else if(deptSelect.equals("logisticReg"))
										cell.setCellValue(column_header_name4[i]);
										
									cell.setCellStyle(cellStyle2);
									 if(i==2 || i==4 || i==8 || i==9 || i==10 || i==19)
										 sheet.setColumnWidth(i, calculateColWidth(35));
									 else if(i==5||i==8)
										 sheet.setColumnWidth(i, calculateColWidth(20));
									 else if(i==6)
										 sheet.setColumnWidth(i, calculateColWidth(15));
							  }  
							//--------end table header---------- 
							  						
							  for (int i = 0; i < serviceKA_size; i++) {
								  row = sheet.getRow(indexRow);
								  if(row==null)
										row=sheet.createRow(indexRow++); 
								  		row.setHeightInPoints((2 * sheet.getDefaultRowHeightInPoints()));
										objs=serviceKA_list.get(i);
																	
										cell =row.getCell(0);//ลำดับ
										if(cell==null)
											cell = row.createCell(0); 
										cell.setCellValue(i+1);  								
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(1);
										if(cell==null)
											cell = row.createCell(1); 
										cell.setCellValue((String)objs[0]);//Job No
										cell.setCellStyle(cellStyle); 																			 						
										
										cell =row.getCell(2);
										if(cell==null)
											cell = row.createCell(2); 			
										cell.setCellValue((String)objs[1]);//Location							
										cell.setCellStyle(cellStyle3);									
										
										cell =row.getCell(3);
										if(cell==null)
											cell = row.createCell(3);	
										if(deptSelect.equals("techBKK") || deptSelect.equals("logisticBKK"))
											cell.setCellValue((String)objs[2]);//district		
										else if(deptSelect.equals("techReg") || deptSelect.equals("logisticReg"))
											cell.setCellValue((String)objs[25]);//province										
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(4);
										if(cell==null)
											cell = row.createCell(4); 
										cell.setCellValue((String)objs[3]);//address 								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(5);
										if(cell==null)
											cell = row.createCell(5); 
										cell.setCellValue((String)objs[4]);//S/N 								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(6);
										if(cell==null)
											cell = row.createCell(6); 
										if(((String)objs[5]).indexOf("Generator")!=-1){
											cell.setCellValue("GEN");								
										}
										else if(((String)objs[5]).indexOf("ATS")!=-1){
											cell.setCellValue("ATS");
										}
										else
											cell.setCellValue((String)objs[5]);//Model							
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(7);
										if(cell==null)
											cell = row.createCell(7); 
										cell.setCellValue((String)objs[26]);  //								
										cell.setCellStyle(cellStyle); 
									/*	
										String jobType = "";
										String typeId = null;
										String maNo = "";
										typeId = (String)objs[22];
										maNo = (String)objs[23];												
										if(typeId.equals("0"))
											jobType = "นอกประกัน";
										else if(typeId.equals("1"))
											jobType = "ในประกัน";
										else if(typeId.equals("2"))
											jobType = "MA No."+maNo;						
										cell =row.getCell(8);//ประเภทงาน
										if(cell==null)
											cell = row.createCell(8); 
										cell.setCellValue(jobType);  	
										cell.setCellStyle(cellStyle3); */
										
										cell =row.getCell(8);
										if(cell==null)
											cell = row.createCell(8); 
										cell.setCellValue((String)objs[22]);  //type								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(9);
										if(cell==null)
											cell = row.createCell(9); 
										cell.setCellValue((String)objs[6]);  //Cause								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(10);
										if(cell==null)
											cell = row.createCell(10); 
										cell.setCellValue((String)objs[7]);//spares  								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(11);
										if(cell==null)
											cell = row.createCell(11); 
										cell.setCellValue((String)objs[8]);//solution  								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(12);
										if(cell==null)
											cell = row.createCell(12); 
										cell.setCellValue((String)objs[9]); //owner 								
										cell.setCellStyle(cellStyle); 
										
										/*cell =row.getCell(12);
										if(cell==null)
											cell = row.createCell(12); 
										cell.setCellValue((String)objs[10]);//deptname  								
										cell.setCellStyle(cellStyle); */
										
										cell =row.getCell(13);
										if(cell==null)
											cell = row.createCell(13); 
										cell.setCellValue((String)objs[11]);  	//CREATE_DATE							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(14);
										if(cell==null)
											cell = row.createCell(14); 
										cell.setCellValue((String)objs[12]);  	//PLAN_SLA_DATE							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(15);
										if(cell==null)
											cell = row.createCell(15); 
										cell.setCellValue((String)objs[13]);  	//SLA_Date							
										cell.setCellStyle(cellStyle); 
										
										/*cell =row.getCell(16);
										if(cell==null)
											cell = row.createCell(16); 
										cell.setCellValue((String)objs[14]);  	//close_Date							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(17);
										if(cell==null)
											cell = row.createCell(17); 
										cell.setCellValue((String)objs[15]);  	//SLA_STATUS							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(18);
										if(cell==null)
											cell = row.createCell(18); 
										cell.setCellValue((String)objs[16]); //JOB_STATUS 								
										cell.setCellStyle(cellStyle); */
										
										/*cell =row.getCell(19);
										if(cell==null)
											cell = row.createCell(19); 
										cell.setCellValue((String)objs[17]);  //PROBLEM_CAUSE								
										cell.setCellStyle(cellStyle); */
										
										cell =row.getCell(16);
										if(cell==null)
											cell = row.createCell(16); 
										if(objs[18] ==null)
											cell.setCellValue("-");	
										else
											cell.setCellValue(objs[18]+"");		//Aging_PLAN			
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(17);
										if(cell==null)
											cell = row.createCell(17); 
										if(objs[19]==null)
											cell.setCellValue("-");
										else
											cell.setCellValue(objs[19]+"");  	//Aging_SLA							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(18);
										if(cell==null)
											cell = row.createCell(18); 
										if(objs[20]==null)
											cell.setCellValue("-");
										else
											cell.setCellValue(objs[20]+"");  	//Aging_Job						
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(19);
										if(cell==null)
											cell = row.createCell(19); 
										cell.setCellValue((String)objs[24]);  	//REMARK						
										cell.setCellStyle(cellStyle3);
							}
							for (int i=0; i<=column_header_size; i++){
								if(i==0 || i==3 || i==11|| i==12||i==13||i==14||i==15)
									sheet.autoSizeColumn(i);
							}
							  //sheet.setColumnWidth(3, 240);
							  //sheet.setColumnWidth(2, 2400);
							  sheet.groupColumn(4, 5);
							  sheet.groupColumn(9, 11);
							  String sheetName = "";
							  if(deptSelect.equals("techBKK"))	
								  sheetName = "งานค้างCMกทม";
							  else if(deptSelect.equals("techReg"))
								  sheetName = "งานค้างCMภูมิภาค";
							  else if(deptSelect.equals("logisticBKK"))
								  sheetName = "งานค้างจัดส่งกทม";
							  else if(deptSelect.equals("logisticReg"))
								  sheetName = "งานค้างจัดส่งภูมิภาค";
							  wb.setSheetName(wb.getSheetIndex(sheet), sheetName);
						}
						
						HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
						
			String filename = "";		
			if(deptSelect.equals("techBKK"))	
				  filename="CM_PENDING_BKK.xls";
			else if(deptSelect.equals("techReg"))
				  filename="CM_PENDING_REG.xls";
			else if(deptSelect.equals("logisticBKK"))
				  filename="LOGISTIC_PENDING_BKK.xls";
			else if(deptSelect.equals("logisticReg"))
				  filename="LOGISTIC_PENDING_REG.xls";
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

	  @RequestMapping(value={"/exportReportCMQuotation/{typeSelect}/{deptSelect}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public void exportReportCMQuotation(HttpServletRequest request,HttpServletResponse response ,
	    		@PathVariable String typeSelect,@PathVariable String deptSelect) throws UnsupportedEncodingException
	    {

	    	 VResultMessage vresultMessage=null;
	    	 HSSFWorkbook wb = new HSSFWorkbook();  
	    	 
				Font font = wb.createFont();
				font.setFontHeightInPoints((short) 14);
				font.setFontName("Angsana New"); 
				
				Font font2 = wb.createFont();
				font2.setFontHeightInPoints((short) 14);
				font2.setFontName("Angsana New"); 
				font2.setBoldweight(Font.BOLDWEIGHT_BOLD);
				
				DataFormat dataFormat = wb.createDataFormat();
				HSSFCellStyle cellStyle = wb.createCellStyle();
				HSSFCellStyle cellStyle2 = wb.createCellStyle();
				HSSFCellStyle cellStyle3 = wb.createCellStyle();
				HSSFCellStyle cellStyle4 = wb.createCellStyle();
				
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle.setFont(font);
				//cellStyle.setWrapText(true);

				cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle2.setWrapText(true);
				cellStyle2.setFont(font2);
				cellStyle2.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
				cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				cellStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
				cellStyle3.setFont(font);
				//cellStyle3.setWrapText(true);
				
				cellStyle4.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				cellStyle4.setFont(font2);
				
				//CellReference cellReference=null;
				HSSFSheet sheet=null;
				HSSFCell cell = null;
				HSSFRow row = null;
				Object[] objs=null;			
			 	int indexRow=0;

			 	String [] column_header_name1={"ลำดับ","Job No.","สถานที่ซ่อม","จังหวัด","ที่อยู่","S/N","Model","ประเภทงาน","อาการ","อะไหล่","การแก้ไข","ผู้ดำเนินการ","แผนก","เปิดJob","SLA","รับเอกสาร","คืนอะไหล่","ปิดJob","SLA","รับเอกสาร","Job","อุปสรรค"};
		
			 	String query = "";
			 	String querySelect="SELECT call_center.BCC_NO as BCC_NO, "+//1
						"IFNULL(call_center.BCC_LOCATION ,'') as LOCATION, "+//2
						"IFNULL(call_center.BCC_ADDR3 ,'') as DISTRICT, "+//3
						"CONCAT(IFNULL(call_center.BCC_BRANCH ,''),' ',IFNULL(call_center.BCC_ADDR1 ,''),' ', IFNULL(call_center.BCC_ADDR2 ,''),' ',IFNULL(call_center.BCC_ADDR3 ,'') , ' ' ,IFNULL(call_center.BCC_PROVINCE ,''),' ',IFNULL(call_center.BCC_ZIPCODE ,'')) as ADDRESS , "+//4
						"IFNULL(call_center.BCC_SERIAL,'') as BCC_SERIAL, "+//5
						"IFNULL(call_center.BCC_MODEL,'') as BCC_MODEL, "+//6
						"IFNULL(call_center.BCC_CAUSE,'-') as BCC_CAUSE, "+//7
						"IFNULL(sp.SPARES,'-') as SPARES, "+//8
						"IFNULL(sv.SBJ_JOB_PROBLEM_SOLUTION,'-') as PROBLEM_SOLUTION, "+//9
						"IFNULL(user.firstname,'') AS OWNER,"+//10
						"IFNULL(dept.BDEPT_DETAIL,IFNULL(dept2.BDEPT_DETAIL,'')) as DEPT_NAME, "+//11
						"IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y'),'') as CREATE_DATE, "+//12
						"DATE_FORMAT((call_center.BCC_CREATED_TIME + INTERVAL IFNULL(call_center.BCC_SLA,0) HOUR),'%d/%m/%Y') as PLAN_SLA_DATE,"+//13
						"IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'Pending') as SLA_Date, "+//14
						"IFNULL(DATE_FORMAT(sv.SBJ_CLOSE_DATE,'%d/%m/%Y'),'Pending') as CLOSE_Date, "+//15
						"CASE WHEN sv.SBJ_SYNDOME_RECIPIENT_DATE IS NOT NULL THEN 'Complete' "+
						"ELSE 'Pending' END  as SLA_STATUS, "+//16
						"IFNULL(j_status.BJS_DETAIL,'')  as JOB_STATUS , "+//17
						"IFNULL(sv.SBJ_PROBLEM_CAUSE,'') as PROBLEM_CAUSE, "+//18
						"DATEDIFF(IFNULL(call_center.BCC_DUE_DATE,''),call_center.BCC_CREATED_TIME) as Aging_PLAN, "+//19
						"DATEDIFF(IFNULL(sv.SBJ_SYNDOME_SEND_DATE,''),call_center.BCC_CREATED_TIME) as Aging_SLA, "+//20					
						"DATEDIFF(now(), todo2.BTDL_CREATED_TIME) as Aging, "+//21
						"call_center.BCC_CUST_INDEX, "+//22
						"call_center.BCC_IS_MA, "+//23
	 					"IFNULL(call_center.BCC_MA_NO,'') as BCC_MA_NO, "+//24
	 					"IFNULL(call_center.BCC_REMARK,'') as BCC_REMARK, "+//25
	 					"IFNULL(call_center.BCC_PROVINCE ,'') as PROVINCE, "+//26
	 					"IFNULL(DATE_FORMAT(todo2.BTDL_CREATED_TIME,'%d/%m/%Y'),'Pending') as Quotation_Date, "+//27
	 					"DATEDIFF(IFNULL(sv.SBJ_CLOSE_DATE,now()), call_center.BCC_CREATED_TIME) as Aging_Job, "+//28
	 					"IFNULL(DATE_FORMAT(sv.SBJ_BORROW_RECEIVER_DATE,'%d/%m/%Y'),'Pending') as Borrow_Receiver_Date, "+//29
	 					"todo2.BTDL_OWNER, "+//30
	 					"IFNULL(todo5.BDEPT_DETAIL,'') as techDept,"+//31
                        "IFNULL(todo5.firstname,'') as techName, "+//32
                        "IFNULL(todo5.BTDL_OWNER,'') as techOwner, "+//33
                        "IFNULL(todo5.BTDL_REQUESTOR,'') as techRequester "+//34
						
						"FROM "+schema+".BPM_CALL_CENTER call_center "+
						"left join "+schema+".BPM_SERVICE_JOB  sv  "+
						"on( call_center.BCC_NO=sv.BCC_NO) "+
						"left join  "+schema+".BPM_JOB_STATUS j_status "+
						"on (sv.SBJ_JOB_STATUS=j_status.BJS_ID and j_status.BJS_TYPE=2 ) "+
						"left join (select todo.btdl_ref,todo.BTDL_STATE,todo.BTDL_OWNER ,todo.BTLD_AI,todo.BTDL_HIDE,todo.BTDL_CREATED_TIME "+
						"		 from "+schema+".BPM_TO_DO_LIST todo "+
						"		 where todo.btdl_type='2' and "+
						"		 todo.BTLD_AI in (SELECT MAX(BTLD_AI) from "+schema+".BPM_TO_DO_LIST where BTDL_TYPE=2 group by BTDL_REF)) as todo2 "+
						"on (todo2.btdl_ref=call_center.BCC_NO) "+
						"left join "+schema+".user user  "+
						"on (user.username=todo2.BTDL_OWNER ) "+
						"left join "+schema+".BPM_DEPARTMENT_USER dept_user "+
						"on dept_user.USER_ID = user.id "+
						"left join "+schema+".BPM_DEPARTMENT dept "+
						"on dept.BDEPT_ID = dept_user.BDEPT_ID  "+
						"left join "+schema+".BPM_DEPARTMENT dept2 	"+
						"on dept2.BDEPT_HDO_USER_ID = user.id "+
						"left join  "+schema+".BPM_SYSTEM_PARAM param "+
						"on ( param.PARAM_NAME='STATE' and todo2.BTDL_STATE=param.key ) "+
						"left join ( SELECT mapping.BCC_NO,GROUP_CONCAT(IFNULL(product.IMA_ItemName,'') separator ',') AS SPARES "+
						"	FROM "+schema+".BPM_SERVICE_ITEM_MAPPING  mapping left join "+schema+".BPM_PRODUCT product on mapping.IMA_ItemID=product.IMA_ItemID  and mapping.BSIM_TYPE=2 GROUP BY mapping.BCC_NO) sp "+
						"    on sp.BCC_NO =call_center.BCC_NO "+
						
			 			"left join (select todo3.btdl_ref,todo3.BTDL_STATE,todo3.BTDL_OWNER ,todo3.BTLD_AI,todo3.BTDL_HIDE,todo3.BTDL_CREATED_TIME ,dept.BDEPT_ID, dept.BDEPT_DETAIL,user.firstname ,todo3.BTDL_REQUESTOR "+
						" from "+schema+".BPM_TO_DO_LIST todo3 "+
						" left join "+schema+".user user "+
						"	on user.username = todo3.BTDL_OWNER "+
						" left join "+schema+".BPM_DEPARTMENT_USER dept_user "+
						"	on dept_user.USER_ID = user.id "+
						" left join "+schema+".BPM_DEPARTMENT dept "+
						"	on dept.BDEPT_ID = dept_user.BDEPT_ID "+
						" where todo3.btdl_type='2' and (dept.BDEPT_ID = 3 or dept.BDEPT_ID = 4 or dept.BDEPT_ID = 5) and "+
						" todo3.BTLD_AI in "+
						" (SELECT MAX(BTLD_AI) from "+schema+".BPM_TO_DO_LIST todo4 "+
						" left join "+schema+".user user "+
						"	on user.username = todo4.BTDL_OWNER "+
						" left join "+schema+".BPM_DEPARTMENT_USER dept_user "+
						"	on dept_user.USER_ID = user.id "+
						" left join "+schema+".BPM_DEPARTMENT dept "+
						"	on dept.BDEPT_ID = dept_user.BDEPT_ID "+
						" where todo4.BTDL_TYPE=2 "+
						" and (dept.BDEPT_ID = 3 or dept.BDEPT_ID = 4 or dept.BDEPT_ID = 5) "+
						" group by BTDL_REF) ) as todo5 "+
						" on (todo5.btdl_ref=call_center.BCC_NO) ";

			 	String queryWhere = "";
			 	
				queryWhere = " where todo2.BTDL_HIDE='1' and j_status.BJS_DETAIL='ตรวจเอกสาร' and todo2.BTDL_OWNER='ROLE_KEY_ACCOUNT' ";
				
				//if(deptSelect.equals("logisticReg"))
				//	queryWhere = queryWhere+" and user.username='regent_admin' ";
				
				/*if(!filterBy.equals("ALL"))	
					queryWhere = queryWhere+" and call_center.BCC_CUST_INDEX ='"+title+"'  ";
				else if(filterBy.equals("ALL"))	//
					queryWhere = queryWhere+" and (call_center.BCC_CUST_INDEX='KTB' "+
							" or call_center.BCC_CUST_INDEX='BAY' "+
							" or call_center.BCC_CUST_INDEX='SCB' "+
							" or call_center.BCC_CUST_INDEX='BBL' "+
							" or call_center.BCC_CUST_INDEX='KBANK' "+
							" or call_center.BCC_CUST_INDEX='LHBANK' "+
							" or call_center.BCC_CUST_INDEX='UOB' "+
							" or call_center.BCC_CUST_INDEX='GSB' "+
							" or call_center.BCC_CUST_INDEX='BAAC' "+
							" or call_center.BCC_CUST_INDEX='IBANK' "+
							" or call_center.BCC_CUST_INDEX='KKBANK' "+
							" or call_center.BCC_CUST_INDEX='TNC' "+
							" or call_center.BCC_CUST_INDEX='GHBANK' "+
							" or call_center.BCC_CUST_INDEX='CIMB' "+
							" or call_center.BCC_CUST_INDEX='DLT' "+
							" or call_center.BCC_CUST_INDEX='THAIPOST' "+
							" or call_center.BCC_CUST_INDEX='BIGC') ";*/
				//if(filterJob.equals("PENDING"))	{				
				//	queryWhere = queryWhere+" and todo2.BTDL_HIDE='1' ";
				//}
				String queryOrderBy = " order by todo2.BTLD_AI";
				query = querySelect+queryWhere+queryOrderBy;
			 	//System.out.println("....aui print query_list = "+query);
			 	vresultMessage = synDomeBPMService.searchObject(query);
			
				
				List<Object[]> serviceKA_list =vresultMessage.getResultListObj();// synDomeBPMService.searchObject(query);
						//System.out.println("----aui print serviceKA_list = "+serviceKA_list);
						int serviceKA_size = serviceKA_list!=null?serviceKA_list.size():0;
						// System.out.println("....aui print serviceKA_size = "+serviceKA_size);
						if(serviceKA_size>0){ 
							
							
							 sheet = wb.createSheet();//calculateColWidth
							 
							 //sheet.setColumnWidth(2, 2400);
							 //--------report header--------
							 row = sheet.getRow(indexRow);
								if(row==null)
									row=sheet.createRow(indexRow++);
								
								cell =row.getCell(0);
								if(cell==null)									
									cell = row.createCell(0); 
								cell.setCellValue("  <==");
								cell.setCellStyle(cellStyle4);
								//cell.setCellFormula("HYPERLINK(..\..\หน้าที่รับผิดชอบ\เมนูฝ่ายบริการ1.xls\)"); 
								
								DateFormat dateFormat1 = new SimpleDateFormat("dd-MM-yyyy");
						  		DateFormat dateFormat2 = new SimpleDateFormat("dd/MM/yyyy");
						  		Date date = new Date();
						  		String currentDate1 = dateFormat1.format(date);
						  		String currentDate2 = dateFormat2.format(date);
						  		
								String headTitle="สรุปงานค้างปิดJob ผู้รับผิดชอบ ปุ้ย ทุก 10.00 น. Update "+currentDate2;
								
								cell =row.getCell(1);
								if(cell==null)
									cell = row.createCell(1); 
								cell.setCellValue(headTitle);
								cell.setCellStyle(cellStyle4);
								
								cell =row.getCell(13);
								if(cell==null)
									cell = row.createCell(13); 
								cell.setCellValue("วันที่แผนงาน");
								cell.setCellStyle(cellStyle2);
								sheet.addMergedRegion(new CellRangeAddress(0,0,13,17));//merged P1-R1
								
								cell =row.getCell(18);
								if(cell==null)
									cell = row.createCell(18); 
								cell.setCellValue("Aging");
								cell.setCellStyle(cellStyle2);
								sheet.addMergedRegion(new CellRangeAddress(0,0,18,20));//merged S1-U1

							 //--------table header----------
								int column_header_size = 0;
				
								column_header_size=column_header_name1.length;
			
								
								row = sheet.getRow(indexRow);
								if(row==null)
									row=sheet.createRow(indexRow++);

								for (int i = 0; i < column_header_size; i++) { 
									cell =row.getCell(i);
									if(cell==null)
										cell = row.createCell(i); 
			
										cell.setCellValue(column_header_name1[i]);
	
										
									cell.setCellStyle(cellStyle2);
									 if(i==2 || i==4 || i==8 || i==9 || i==10 || i==21)
										 sheet.setColumnWidth(i, calculateColWidth(35));
									 else if(i==5||i==7)
										 sheet.setColumnWidth(i, calculateColWidth(20));
									 else if(i==6)
										 sheet.setColumnWidth(i, calculateColWidth(15));
							  }  
							//--------end table header---------- 
							  String keep_BCC_NO = "";				
							  int rownum = 0;
							  for (int i = 0; i < serviceKA_size; i++) {
										  
									objs=serviceKA_list.get(i);
										
									if((String)objs[0]!=keep_BCC_NO){
										rownum++;
										row = sheet.getRow(indexRow);
										if(row==null)
											row=sheet.createRow(indexRow++); 
									  	row.setHeightInPoints((2 * sheet.getDefaultRowHeightInPoints()));
										
									  	keep_BCC_NO = (String)objs[0];
										
										cell =row.getCell(0);//ลำดับ
										if(cell==null)
											cell = row.createCell(0); 
										cell.setCellValue(rownum);  								
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(1);
										if(cell==null)
											cell = row.createCell(1); 
										cell.setCellValue((String)objs[0]);//Job No
										cell.setCellStyle(cellStyle); 																			 						
										
										cell =row.getCell(2);
										if(cell==null)
											cell = row.createCell(2); 			
										cell.setCellValue((String)objs[1]);//Location							
										cell.setCellStyle(cellStyle3);									
										
										cell =row.getCell(3);
										if(cell==null)
											cell = row.createCell(3);	
										if(((String)objs[25]).indexOf("อยุธยา")!=-1){
											cell.setCellValue("อยุธยา");								
										}else if(((String)objs[25]).indexOf("กรุงเทพ")!=-1){
											cell.setCellValue("กทม.");								
										}else if(((String)objs[25]).indexOf("สุราษ")!=-1){
											cell.setCellValue("สุราษฎร์ฯ");
										}else if(((String)objs[25]).indexOf("ประจวบ")!=-1){
											cell.setCellValue("ประจวบฯ");
										}else
											cell.setCellValue((String)objs[25]);//province	
										//cell.setCellValue((String)objs[25]);//province
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(4);
										if(cell==null)
											cell = row.createCell(4); 
										cell.setCellValue((String)objs[3]);//address 								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(5);
										if(cell==null)
											cell = row.createCell(5); 
										cell.setCellValue((String)objs[4]);//S/N 								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(6);
										if(cell==null)
											cell = row.createCell(6); 
										if(((String)objs[5]).indexOf("Generator")!=-1){
											cell.setCellValue("GEN");								
										}
										else if(((String)objs[5]).indexOf("ATS")!=-1){
											cell.setCellValue("ATS");
										}
										else
											cell.setCellValue((String)objs[5]);//Model							
										cell.setCellStyle(cellStyle3); 
										
										String jobType = "";
										String typeId = null;
										String maNo = "";
										typeId = (String)objs[22];
										maNo = (String)objs[23];												
										if(typeId.equals("0"))
											jobType = "นอกประกัน";
										else if(typeId.equals("1"))
											jobType = "ในประกัน";
										else if(typeId.equals("2"))
											jobType = "MA No."+maNo;						
										cell =row.getCell(7);//ประเภทงาน
										if(cell==null)
											cell = row.createCell(7); 
										cell.setCellValue(jobType);  	
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(8);
										if(cell==null)
											cell = row.createCell(8); 
										cell.setCellValue((String)objs[6]);  //Cause								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(9);
										if(cell==null)
											cell = row.createCell(9); 
										cell.setCellValue((String)objs[7]);//spares  								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(10);
										if(cell==null)
											cell = row.createCell(10); 
										cell.setCellValue((String)objs[8]);//solution  								
										cell.setCellStyle(cellStyle3); 
										
										cell =row.getCell(11);
										if(cell==null)
											cell = row.createCell(11); 
										cell.setCellValue((String)objs[31]); //owner 								
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(12);
										if(cell==null)
											cell = row.createCell(12); 
										if(((String)objs[32]).equals("somboon") && ((String)objs[33]).equals("sommai"))
											cell.setCellValue("กทม");
										else if(((String)objs[32]).equals("somboon") && ((String)objs[33]).equals("parinya"))
											cell.setCellValue("ภูมิภาค");
										else	
											cell.setCellValue((String)objs[30]);//deptname  								
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(13);
										if(cell==null)
											cell = row.createCell(13); 
										cell.setCellValue((String)objs[11]);  	//CREATE_DATE							
										cell.setCellStyle(cellStyle); 
			
										cell =row.getCell(14);
										if(cell==null)
											cell = row.createCell(14); 
										cell.setCellValue((String)objs[13]);  	//SLA_Date							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(15);
										if(cell==null)
											cell = row.createCell(15); 
										cell.setCellValue((String)objs[26]);  	//วันที่มาตรวจเอกสาร							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(16);
										if(cell==null)
											cell = row.createCell(16); 
										cell.setCellValue((String)objs[28]);  	//วันคืนอะไหล่							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(17);
										if(cell==null)
											cell = row.createCell(17); 
										cell.setCellValue((String)objs[14]);  	//close_Date							
										cell.setCellStyle(cellStyle); 																

										cell =row.getCell(18);
										if(cell==null)
											cell = row.createCell(18); 
										if(objs[19]==null)
											cell.setCellValue("-");
										else
											cell.setCellValue(objs[19]+"");  	//Aging_SLA							
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(19);
										if(cell==null)
											cell = row.createCell(19); 
										if(objs[20] ==null)
											cell.setCellValue("-");	
										else
											cell.setCellValue(objs[20]+"");		//Aging_BTDL_DATE			
										cell.setCellStyle(cellStyle); 																
										
										cell =row.getCell(20);
										if(cell==null)
											cell = row.createCell(20); 
										if(objs[27]==null)
											cell.setCellValue("-");
										else
											cell.setCellValue(objs[27]+"");  	//Aging_Job						
										cell.setCellStyle(cellStyle); 
										
										cell =row.getCell(21);
										if(cell==null)
											cell = row.createCell(21); 
										cell.setCellValue((String)objs[24]);  	//REMARK						
										cell.setCellStyle(cellStyle3);
									}
							}
							for (int i=0; i<=column_header_size; i++){
								if(i==0 || i==3 || i==11|| i==12||i==13||i==14||i==15||i==16||i==17|| i==18||i==19||i==20)
									sheet.autoSizeColumn(i);
							}
							  //sheet.setColumnWidth(3, 240);
							  //sheet.setColumnWidth(2, 2400);
							  sheet.groupColumn(4, 5);
							  sheet.groupColumn(8, 10);
							  String sheetName = "งานค้างปิดJob";
							  wb.setSheetName(wb.getSheetIndex(sheet), sheetName);
						}
						
						HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
						
			String filename = "CM_PENDING_CLOSE.xls";		

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
	  
	  public static int calculateColWidth(int width){ 
          if(width > 254) 
                  return 65280; // Maximum allowed column width. 
          if(width > 1){ 
                  int floor = (int)(Math.floor(((double)width)/5)); 
                  int factor = (30*floor); 
                  int value = 450 + factor + ((width-1) * 250); 
                  return value;	
          } 
          else 
                  return 450; // default to column size 1 if zero, one or negative number is passed. 
	  } 
}
