package th.co.imake.syndome.bpm.backoffice.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import th.co.imake.syndome.bpm.backoffice.domain.MyUserDetails;
import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.backoffice.xstream.IMakeFile;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.google.gson.Gson;
@Controller
public class UploadController {	
	//private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	//private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	private static Logger logger = Logger.getRootLogger();
	private static Locale locale = new Locale("th_TH");
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	@Autowired
	private SynDomeBPMService synDomeBPMService;
	private static ResourceBundle bundle;
	static{
		bundle =  ResourceBundle.getBundle( "config" );				
	}
	private String schema=bundle.getString("schema");
	/* @Autowired
    public UploadController(MissExamService missExamService)
    {
        logger.debug("########################### @Autowired WelcomeController #######################");
        this.missExamService = missExamService;
    }*/
    @RequestMapping(value={"/upload/{module}/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
    @ResponseBody
    public  String doUpload(HttpServletRequest request, Model model, @PathVariable String module,@PathVariable String id)
    {
    	 String ndPathFileGen=null;
    	// MissFile missFile =new MissFile();
    	 String hotLink="";
    	 String s="";
    	 String pathFolder="";
    	 String ndFilePath="";
       /* logger.debug("xxxxxxxxxxxxxxxxxxxxxxxx="+request.getParameter("test"));
        Map m =request.getParameterMap();
        for (Iterator iterator = m.keySet().iterator(); iterator.hasNext();) {
			String type = (String) iterator.next();
			String[] key=(String[])m.get(type);
			for (int i = 0; i < key.length; i++) {
			}
		}*/
    	  MultipartHttpServletRequest multipartRequest =(MultipartHttpServletRequest)request;
        MultipartFile multipart = multipartRequest.getFile("userfile");
		if(multipart!=null){
                String contentType = multipart.getContentType();
                 s = multipart.getOriginalFilename();
                logger.debug("fileName ===> "+s);
                logger.debug("contentType ===> "+contentType);
                s = FilenameUtils.getName(s);
                logger.debug("fileName2 ===> "+s);
                String monthStr= "";
				  String yearStr="";
				  
				  //String pathFolder="";
                FileOutputStream fos = null;
					try {  
						byte []filesize = multipart.getBytes(); 
						logger.debug("xxxxxxxxxxxxx="+filesize.length);
						if(filesize.length>0){									
							long current = System.currentTimeMillis();
						org.joda.time.DateTime    dt1  = new org.joda.time.DateTime (new Date().getTime()); 
							
						  monthStr= dt1.getMonthOfYear()+"";
						  yearStr= dt1.getYear()+"";
						  monthStr = monthStr.length()>1?monthStr:"0"+monthStr;
					
						  pathFolder=yearStr+"_"+monthStr+"";
						  ndFilePath = bundle.getString(module+"Path")+pathFolder;
						  String path =ndFilePath;
						  if(!module.equals("stock")){
						  createDirectoryIfNeeded(path);
						  }
						  String filename =s ;// multipart.getOriginalFilename();
						  String []filenameSplit  =filename.split("\\.");
						  String extension ="";
						  if(filenameSplit!=null && filenameSplit.length>0){
							  extension =filenameSplit[filenameSplit.length-1];
						  }
						  hotLink=current+""+genToken();
						 ndPathFileGen =hotLink+"."+extension; 
						 pathFolder=pathFolder+"/"+ndPathFileGen;
					//	 FileInputStream fin= new FileInputStream(file)
						 if(module.equals("stock")){
							 ndPathFileGen=module+".xls"; 
							 path= bundle.getString(module+"Path");
						 }else{	
						 }

						 fos = new FileOutputStream(path+"/"+ndPathFileGen);
						 fos.write(filesize);
						}
					}catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
					finally{
						if(fos!=null)
							try {
								fos.close();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}	 
					} 
				if(module.equals("delivery")){
					String query="UPDATE "+schema+".BPM_DELIVERY_TRAN SET BDT_DOC_ATTACH_NAME ='"+s+"'," +
							"BDT_DOC_ATTACH_PATH ='"+pathFolder+"', " +
							"BDT_DOC_ATTACH_HOTLINK = '"+hotLink+"' " +
							" WHERE BSO_ID="+id;
					synDomeBPMService.executeQuery(new String[]{query});
					/* MissAccount missAccount = new MissAccount();
					 missAccount.setMaId(Long.parseLong(id));
					 missAccount.setMaCustomizeLogoFileName(s);
					 missAccount.setMaCustomizeLogoHotlink(hotLink);
					  missAccount.setMaCustomizeLogoPath(pathFolder);
					  missExamService.updateMissAccountLogo(missAccount);*/
				}else if(module.equals("Installation")){
					//${bsoId}_${ima_itemid}_${serial}
					//System.out.println("Installation id->"+id);
					String bsoId="";
					String ima_itemid="";
					String serial="";
					String index="";
					String[] id_array=id.split("_");
					String update_filename="";
					String update_filepath="";
					String update_hotlink="";
					if(id_array.length>3){ 
						bsoId=id_array[0];
						ima_itemid=id_array[1];
						serial=id_array[2];
						index=id_array[3];
						 
						update_filename=" BIT_ATTACH_NAME_"+index+" ='"+s+"' "; 
						update_filepath=" BIT_ATTACH_PATH_"+index+" ='"+pathFolder+"' " ;
						update_hotlink=" BIT_ATTACH_HOTLINK_"+index+" = '"+hotLink+"' " ;
					}else{
						update_filename=" BIT_DOC_ATTACH_NAME ='"+s+"' "; 
						update_filepath=" BIT_DOC_ATTACH_PATH ='"+pathFolder+"' " ;
						update_hotlink=" BIT_DOC_ATTACH_HOTLINK = '"+hotLink+"' " ;
						bsoId=id_array[0];
						ima_itemid=id_array[1];
						serial=id_array[2];
					}
					//System.out.println(id_array.length);
					id=index;
					String query="UPDATE "+schema+".BPM_INSTALLATION_TRAN SET "+update_filename+" , "+
							update_filepath+" , " +
							update_hotlink +
							" WHERE BSO_ID="+bsoId +" and IMA_ItemID='"+ima_itemid+"' and SERIAL='"+serial+"'";
					synDomeBPMService.executeQuery(new String[]{query});
					/* MissAccount missAccount = new MissAccount();
					 missAccount.setMaId(Long.parseLong(id));
					 missAccount.setMaCustomizeLogoFileName(s);
					 missAccount.setMaCustomizeLogoHotlink(hotLink);
					  missAccount.setMaCustomizeLogoPath(pathFolder);
					  missExamService.updateMissAccountLogo(missAccount);*/
				}else if(module.equals("Services")){
					//${bsoId}_${ima_itemid}_${serial}
					//System.out.println("Installation id->"+id);
					String bccNo="";
					String index="";
					String[] id_array=id.split("_");
					String update_filename="";
					String update_filepath="";
					String update_hotlink=""; 
						bccNo=id_array[0];
						index=id_array[1];  
						
						update_filename=" SBJ_DOC_ATTACH_NAME_"+index+" ='"+s+"' "; 
						update_filepath=" SBJ_DOC_ATTACH_PATH_"+index+" ='"+pathFolder+"' " ;
						update_hotlink=" SBJ_DOC_ATTACH_HOTLINK_"+index+" = '"+hotLink+"' " ;
					 
					//System.out.println(id_array.length);
					
					String query="UPDATE "+schema+".BPM_SERVICE_JOB SET "+update_filename+" , "+
							update_filepath+" , " +
							update_hotlink +
							" WHERE BCC_NO='"+bccNo +"' ";
					//System.out.println(query);
					id=index;
					synDomeBPMService.executeQuery(new String[]{query});
				}else if(module.equals("PMMA")){
					//335_1212123123451_1
					//${bsoId}_${ima_itemid}_${serial}
					//System.out.println("Installation id->"+id);
					String bsoID="";
					String serail="";
					String order="";
					String index="";
					String[] id_array=id.split("_");
					String update_filename="";
					String update_filepath="";
					String update_hotlink=""; 
					bsoID=id_array[0];
					serail=id_array[1];
					order =id_array[2];
						index=id_array[3];  
						
						update_filename=" BPMJ_DOC_ATTACH_NAME_"+index+" ='"+s+"' "; 
						update_filepath=" BPMJ_DOC_ATTACH_PATH_"+index+" ='"+pathFolder+"' " ;
						update_hotlink=" BPMJ_DOC_ATTACH_HOTLINK_"+index+" = '"+hotLink+"' " ;
					 
					//System.out.println(id_array.length);
						 
					String query="UPDATE "+schema+".BPM_PM_MA_JOB SET "+update_filename+" , "+
							update_filepath+" , " +
							update_hotlink +
							" WHERE BPMJ_NO='"+bsoID +"'  and BPMJ_SERAIL='"+serail+"' and BPMJ_ORDER="+order;
					//System.out.println(query);
					id=index;
					System.out.println("index="+id);
					synDomeBPMService.executeQuery(new String[]{query});
				}else if(module.equals("candidateImg")){
					/* MissCandidate missCandidate = new MissCandidate();
					 missCandidate.setMcaId(Long.parseLong(id));
					 missCandidate.setMcaPictureFileName(s);
					 missCandidate.setMcaPictureHotlink(hotLink);
					  missCandidate.setMcaPicturePath(pathFolder);
					  missExamService.updateMissCandidatePhoto(missCandidate);*/
				}else if(module.equals("contactImg")){
								
					/* MissContact missContact = new MissContact();
					 missContact.setMcontactId(Long.parseLong(id));
					 missContact.setMcontactPictureFileName(s);
					 missContact.setMcontactPictureHotlink(hotLink);
					  missContact.setMcontactPicturePath(pathFolder);
					  missExamService.updateMissContactPhoto(missContact);*/
				}/*else if(module.equals("attachManual")){
					 MissManual missManual = new MissManual();
					 MissSery missSery=new MissSery();
					 missSery.setMsId(Long.parseLong(id));
					 missManual.setMissSery(missSery);
					 missManual.setMmId(Long.parseLong(id));
					 missManual.setMmFileName(s);
					 missManual.setMmHotlink(hotLink);
					  missManual.setMmPath(pathFolder);
					  missExamService.updateMissManual(missManual);
				}else if(module.equals("questionImg")){
					 MissAttach missAttach = new MissAttach();
					 //missAttach.setMatId((Long.parseLong(id));
					 missAttach.setMatFileName(s);
					 missAttach.setMatHotlink(hotLink);
					 missAttach.setMatPath(pathFolder);
					 missAttach.setMatRef(Long.parseLong(id));
					 missAttach.setMatModule(module);
					 missExamService.updateMissAttach(missAttach);
				}else if(module.equals("template")){
					 MissSeriesAttach missSeriesAttach = new MissSeriesAttach();
					 missSeriesAttach.setMsatRef1(Long.parseLong(id));
					 missSeriesAttach.setMsatModule(module);
					 missSeriesAttach.setMsatHotlink(hotLink);
					 missSeriesAttach.setMsatPath(pathFolder);
					 missSeriesAttach.setMsatFileName(s);
					 missExamService.updateMissSeriesAttach(missSeriesAttach);
				}*/else if(module.equals("evaluation")){
					//String[] ids=id.split("_");
					 /* MissSeriesAttach missSeriesAttach = new MissSeriesAttach();
 
					 missSeriesAttach.setMsatRef1(Long.parseLong(id));
					 missSeriesAttach.setMsatModule(module);
					 missSeriesAttach.setMsatHotlink(hotLink);
					 missSeriesAttach.setMsatPath(pathFolder);
					 missSeriesAttach.setMsatFileName(s);
					 missSeriesAttach.setRootPath(bundle.getString(module+"Path"));
					 missExamService.updateMissSeriesAttach(missSeriesAttach);*/
				}else if(module.equals("doc")){
					//	String[] ids=id.split("_");
				/*	MissDoc missDoc=new MissDoc();
					missDoc.setMdDocName(s);
					missDoc.setMdDocHotlink(hotLink);
					missDoc.setMdDocPath(pathFolder);
					missDoc.setMdDocFileName(s);
					missExamService.saveMissDoc(missDoc);*/
						//MissSeriesAttach missSeriesAttach =missExamService.findMissSeriesAttachSearch(module,Long.parseLong(ids[0]),Long.parseLong(ids[1]),hotlink);
						
					}
		}
       // return missCandidate;
		IMakeFile imkeFile=new IMakeFile();
		imkeFile.setHotlink(hotLink);
		imkeFile.setFilename(s);
		imkeFile.setFilepath(pathFolder) ;
		imkeFile.setId(id);
		Gson gson=new Gson();
		//gson.toJson(imkeFile );
		//System.out.println(hotLink);
	 	//return hotLink;
		  return gson.toJson(imkeFile );
    }
    @RequestMapping(value={"/getRFE/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    public void getRFE(HttpServletRequest request,HttpServletResponse response
    		,@PathVariable String id)
    {
    	String filePath = bundle.getString("rfePath")+"Delivery_Form.xls";
		FileInputStream fileIn = null;
		HSSFWorkbook wb = null;
		String BSO_RFE_NO="";
		String BSO_DELIVERY_DUE_DATE="";
		String BSO_DELIVERY_DUE_DATE_TIME="";
		String BSO_CREATED_DATE="";
		String BSO_CREATED_DATE_TIME="";
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
			
			String query="SELECT so.BSO_DELIVERY_LOCATION as c0," +
					" so.BSO_DELIVERY_ADDR1 as c1 , " +
					/*" concat(\"แขวง/ตำบล \",so.BSO_DELIVERY_ADDR2), " +
					" concat(\"เขต/อำเภอ \",so.BSO_DELIVERY_ADDR3), " +
					" concat(\"จ. \",so.BSO_DELIVERY_PROVINCE)," +*/
					"  so.BSO_DELIVERY_ADDR2 as c2, " +
					"  so.BSO_DELIVERY_ADDR3 as c3, " +
					"  so.BSO_DELIVERY_PROVINCE as c4," +
					" so.BSO_DELIVERY_ZIPCODE as c5," +
					//" concat(\"      \",so.BSO_DELIVERY_TEL_FAX ), " +
					" so.BSO_DELIVERY_TEL_FAX as c6, " +
					" so.BSO_RFE_NO as c7, "+ 
					"concat(\"Tel \\: \",so.BSO_DELIVERY_TEL_FAX,\" \",so.BSO_DELIVERY_CONTACT) as c8,"+
					" IFNULL(DATE_FORMAT(now(),'%d/%m/%Y'),'') as c9 ," +
					" IFNULL(DATE_FORMAT(now(),'%H:%i'),'') as c10 ," +
					/*" IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'') as c9 ," +
					" IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i'),'') as c10 ," +*/
					 " IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%d/%m/%Y'),'') as c11 ," + 
					" IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%H:%i'),'') as c12 ,"+
					" so.BSO_TYPE_NO as c13"+
				    " FROM "+schema+".BPM_SALE_ORDER so  " +
					" WHERE so.BSO_ID="+id;
			VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
			List<Object[]> sale_order =vresultMessage.getResultListObj();
			int sale_order_size = sale_order.size();
			String[] column_array={"H1","H2","H3","K3","K4","H5"};
			String[] column_default={"","","แขวง/ตำบล ","เขต/อำเภอ ","จ. ","      "};
			int[] column_array_value={0,1,2,3,4,6};
			
			// Sticker
			String[] column_sticker_head_array={"F1","M1","F8","M8"}; // id=7
			
			String[] column_sticker_detail_array={"B2","B3","C4","G4","D5","B6"};
			String[] column_sticker_default_array={"","","","","",""};
			int[] column_sticker_value_array={0,1,2,3,4,8};
			CellReference cellReference=null;
			HSSFSheet sheet=null;
			HSSFCell cell = null;
			HSSFRow row = null;
			Object obj=null;
			if(sale_order_size>0){ 
				BSO_RFE_NO=(String)sale_order.get(0)[7];
				BSO_DELIVERY_DUE_DATE=(String)sale_order.get(0)[9];
				BSO_DELIVERY_DUE_DATE_TIME=(String)sale_order.get(0)[10];
				BSO_CREATED_DATE=(String)sale_order.get(0)[11];
				BSO_CREATED_DATE_TIME=(String)sale_order.get(0)[12];
				String BSO_TYPE_NO=(String)sale_order.get(0)[13];
				 sheet = wb.getSheetAt(0);  
				for (int i = 0; i < column_array.length; i++) {
					cellReference= new CellReference(column_array[i]);
					row = sheet.getRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					obj=sale_order.get(0)[column_array_value[i]];
					if(obj!=null)
						cell.setCellValue(column_default[i]+(String)obj);
					else
						cell.setCellValue("");
				}
				cellReference= new CellReference("E9");
				row = sheet.getRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				cell.setCellValue("เลขที่เอกสาร "+BSO_TYPE_NO);
				String[] date_array={"G","G","K","K"};
				String[] date_value={BSO_CREATED_DATE,BSO_CREATED_DATE_TIME,BSO_DELIVERY_DUE_DATE,BSO_DELIVERY_DUE_DATE_TIME};
				//int[] index_date={16,17,16,17};
				int[] index_date={15,16,15,16};
				for (int i = 0; i < date_array.length; i++) {
					cellReference= new CellReference(date_array[i]+index_date[i]);
					row = sheet.getRow(cellReference.getRow());
					if(row==null)
						row=sheet.createRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					if(cell==null)
						cell = row.createCell((int)cellReference.getCol());
					cell.setCellValue(date_value[i]);
				} 
				
				sheet = wb.getSheetAt(1); 
				for (int i = 0; i < column_sticker_detail_array.length; i++) {
					cellReference= new CellReference(column_sticker_detail_array[i]);
					row = sheet.getRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					obj=sale_order.get(0)[column_sticker_value_array[i]];
					if(obj!=null)
						cell.setCellValue(column_sticker_default_array[i]+(String)obj);
					else
						cell.setCellValue("");
				}
				for (int i = 0; i < column_sticker_head_array.length; i++) {
					cellReference= new CellReference(column_sticker_head_array[i]);
					row = sheet.getRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					obj=sale_order.get(0)[7];
					if(obj!=null)
						cell.setCellValue((String)obj);
					else
						cell.setCellValue("");
				}
			}	
			 query="SELECT "
			 		+ " case when ( AMOUNT_RFE!=0 || AMOUNT_RFE is not null ) "
					+" then item.AMOUNT_RFE "
					+ " else "
			 		 + "item.amount"
			 		//+ " '' "
			 		+ " end ," +
			 		" item.weight," +
		            " case when (item.REPLACE_NAME!='') " +
                    "  then item.replace_name " +
                    " else  product.ima_itemname " +
                    " end as c3 "+
			 		//" product.ima_itemname , " +
			 		//" ifnull(item.replace_name,'') "+
			 		" FROM SYNDOME_BPM_DB.BPM_SALE_PRODUCT_ITEM item " +
					" left join "+schema+".BPM_PRODUCT product on item.ima_itemid=product.ima_itemid "+ 
					" WHERE item.BSO_ID="+id;
			// System.out.println(query);
			vresultMessage = synDomeBPMService.searchObject(query);
			List<Object[]> product_item = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
			int product_item_size = product_item.size();
			int index=10;
			String[] item_label={"A","C","E"};
			int[] item_value={0,1,2};
			String[] item_subfix={" ชิ้น","",""};
			if(product_item_size>0){ 
				 sheet = wb.getSheetAt(0);  
				for (int i = 0; i < product_item_size; i++) {
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
						obj=product_item.get(i)[item_value[j]];
						//System.out.println(obj);
						if(obj!=null){
							String value="";
							if(j==0){
								java.lang.Integer x=(java.lang.Integer)obj;
								value=x+"";
							}else
								value=(String)obj;
							//System.out.println("value->"+value);
							if(!value.equals("0"))
								cell.setCellValue(value+item_subfix[j]);
						}
						else
							cell.setCellValue("");
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
    @RequestMapping(value={"/getfile/{module}/{id}/{hotlink}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    public void getFile(HttpServletRequest request,HttpServletResponse response,@PathVariable String module
    		,@PathVariable String id,@PathVariable String hotlink)
    {
    	//String hotlink = request.getQueryString();
		//String []adminview = hotlink.split("&mode=");
    	
		//	String filePath = "/usr/local/Work/TestDownload/1338218105884kqyoujf6uwhsqqwgwqitedq89kpl01u8nitc.jpg";
    	 
    	                                          
    	String  content_type= "image/jpeg";
    	//String  content_disposition= "";
    	String  filename= "";
    	String path= bundle.getString(module+"Path");
    	String ndPathFileGen="";
    	//path+"/"+ndPathFileGen
    	if(module.equals("delivery")){
			String query="SELECT BSO_ID , " +
					" BDT_CUST_NAME, " +
					" BDT_DOC_ATTACH_NAME ,"+ 
					" BDT_DOC_ATTACH_PATH ,"+
					" BDT_IS_INTERNAL ,"+
					" BDT_CREATED_DATE ,"+
					" BDT_CREATED_BY ,"+
					" BDT_DOC_ATTACH_HOTLINK FROM "+schema+".BPM_DELIVERY_TRAN  " +
					" WHERE BSO_ID="+id;
			VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
			List<Object[]> status = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
			int status_size = status.size();
			if(status_size>0){ 
						ndPathFileGen=path+(String)status.get(0)[3];	
						filename=(String)status.get(0)[2];
			}
			content_type="application/octet-stream";
			/* MissAccount missAccount = new MissAccount();
			 missAccount.setMaId(Long.parseLong(id));
			 missAccount.setMaCustomizeLogoFileName(s);
			 missAccount.setMaCustomizeLogoHotlink(hotLink);
			  missAccount.setMaCustomizeLogoPath(pathFolder);
			  missExamService.updateMissAccountLogo(missAccount);*/
		}
    	/*if(module.equals("mcLogo")){
    		MissAccount missAccount= missExamService.findMissAccountById(Long.parseLong(id));
    		ndPathFileGen=path+missAccount.getMaCustomizeLogoPath();
		}*/else if(module.equals("Installation")){
			
			String bsoId="";
			String ima_itemid="";
			String serial="";
			String index="";
			String[] id_array=id.split("_");
			String update_filename="";
			String update_filepath="";
			String update_hotlink="";
			if(id_array.length>3){ 
				bsoId=id_array[0];
				ima_itemid=id_array[1];
				serial=id_array[2];
				index=id_array[3];
				 
				update_filename=" BIT_ATTACH_NAME_"+index; 
				update_filepath=" BIT_ATTACH_PATH_"+index;
				update_hotlink=" BIT_ATTACH_HOTLINK_"+index;
			}else{
				update_filename=" BIT_DOC_ATTACH_NAME"; 
				update_filepath=" BIT_DOC_ATTACH_PATH"; 
				update_hotlink=" BIT_DOC_ATTACH_HOTLINK"; 
				bsoId=id_array[0];
				ima_itemid=id_array[1];
				serial=id_array[2];
			}
			//System.out.println(id_array.length);
			 
			String query="SELECT "+update_filename+" , " +
					""+update_filepath+" FROM "+schema+".BPM_INSTALLATION_TRAN  " +
					" WHERE BSO_ID="+bsoId +" and IMA_ItemID='"+ima_itemid+"' and SERIAL='"+serial+"'";
			VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
			List<Object[]> status = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
			int status_size = status.size();
			if(status_size>0){ 
						ndPathFileGen=path+(String)status.get(0)[1];	
						filename=(String)status.get(0)[0];
			}
			content_type="application/octet-stream";
		}else if(module.equals("Services")){
			String bccNo="";
			String index="";
			String[] id_array=id.split("_");
			String update_filename="";
			String update_filepath="";
			String update_hotlink="";
		
			bccNo=id_array[0];
			index=id_array[1];  
			 
				 
				update_filename=" SBJ_DOC_ATTACH_NAME_"+index; 
				update_filepath=" SBJ_DOC_ATTACH_PATH_"+index;
				update_hotlink=" SBJ_DOC_ATTACH_HOTLINK_"+index;
			
			//System.out.println(id_array.length);
			 
			String query="SELECT "+update_filename+" , " +
					""+update_filepath+" FROM "+schema+".BPM_SERVICE_JOB  " +
					" WHERE BCC_NO='"+bccNo +"'";
			VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
			List<Object[]> status = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
			int status_size = status.size();
			if(status_size>0){ 
						ndPathFileGen=path+(String)status.get(0)[1];	
						filename=(String)status.get(0)[0];
			}
			content_type="application/octet-stream";
		}else if(module.equals("PMMA")){
			String bsoID="";
			String serail="";
			String order="";
			String index="";
			String[] id_array=id.split("_");
			String update_filename="";
			String update_filepath="";
			String update_hotlink="";
		
			bsoID=id_array[0];
			serail=id_array[1];
			order =id_array[2];
		    index=id_array[3];  
			  
			 
				 
				update_filename=" BPMJ_DOC_ATTACH_NAME_"+index; 
				update_filepath=" BPMJ_DOC_ATTACH_PATH_"+index;
				update_hotlink=" BPMJ_DOC_ATTACH_HOTLINK_"+index;
				 
			//System.out.println(id_array.length);
			  
				
			String query="SELECT "+update_filename+" , " +
					""+update_filepath+" FROM "+schema+".BPM_PM_MA_JOB  " +
					" WHERE BPMJ_NO='"+bsoID +"'  and BPMJ_SERAIL='"+serail+"' and BPMJ_ORDER="+order;
			VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
			List<Object[]> status = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
			int status_size = status.size();
			if(status_size>0){ 
						ndPathFileGen=path+(String)status.get(0)[1];	
						filename=(String)status.get(0)[0];
			}
			content_type="application/octet-stream";
		}else if(module.equals("candidateImg")){
			/*MissCandidate missCandidate =missExamService.findMissCandidateById(Long.parseLong(id));
			 ndPathFileGen=path+missCandidate.getMcaPicturePath();*/
		}else if(module.equals("contactImg")){
		/*	MissContact missContact=missExamService.findMissContactById(Long.parseLong(id));
			 ndPathFileGen=path+missContact.getMcontactPicturePath();*/
		}else if(module.equals("attachManual")){
			/*MissManual missManual=missExamService.findMissManualById(Long.parseLong(id));
			 ndPathFileGen=path+missManual.getMmPath();
			 content_type="application/pdf";
			 //content_disposition="attachment; filename="+missManual.getMmFileName();
			 filename=missManual.getMmFileName();*/
		}else if(module.equals("questionImg")){
			/*MissAttach missAttach =missExamService.findMissAttachById(module,Long.parseLong(id),hotlink);
			 ndPathFileGen=path+missAttach.getMatPath();*/
		}else if(module.equals("template")){ // jasper
			/*MissSeriesAttach missSeriesAttach =missExamService.findMissSeriesAttachSearch(module,Long.parseLong(id),null,hotlink);
			 ndPathFileGen=path+missSeriesAttach.getMsatPath();
			 content_type="";
			 //content_disposition="attachment; filename="+missSeriesAttach.getMsatFileName();
			 filename=missSeriesAttach.getMsatFileName();*/
		}else if(module.equals("evaluation")){
		/*//	String[] ids=id.split("_");
			MissSeriesAttach missSeriesAttach =missExamService.findMissSeriesAttachSearch(module,Long.parseLong(id),null,hotlink);
			//MissSeriesAttach missSeriesAttach =missExamService.findMissSeriesAttachSearch(module,Long.parseLong(ids[0]),Long.parseLong(ids[1]),hotlink);
			 ndPathFileGen=path+missSeriesAttach.getMsatPath();
			 content_type="application/vnd.ms-excel";
			 //content_disposition="attachment; filename="+missSeriesAttach.getMsatFileName();
			 filename=missSeriesAttach.getMsatFileName();*/
			 //content_disposition="attachment; filename=ทดสอบ.xls";
		}
		else if(module.equals("doc")){
			//	String[] ids=id.split("_");
			  /* MissDoc missDoc =missExamService.findMissDocById(Long.parseLong(id));
				//MissSeriesAttach missSeriesAttach =missExamService.findMissSeriesAttachSearch(module,Long.parseLong(ids[0]),Long.parseLong(ids[1]),hotlink);
				 ndPathFileGen=path+missDoc.getMdDocPath();
				 content_type="application/pdf";
				// content_disposition="attachment; filename="+missDoc.getMdDocFileName();
				 filename=missDoc.getMdDocFileName();*/
			}
    	//String filePath =  bundle.getString(module+"Path")+hotlink+".jpg";
		//	String fileName = null;
			  
			//	String filenameStr ="เทสfชาติชาย.jpg";// fileName.trim().replaceAll(" ","_");
				//response.setHeader("Content-Type", "application/octet-stream; charset=tis620");
    	    if(content_type.length()>0)
				response.setHeader("Content-Type", content_type);
			if(filename.length()>0){
				String userAgent = request.getHeader("user-agent");
				boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
				// filename="ทดสอบ โอ๋.xls";
				//System.out.println(fileName);
				byte[] fileNameBytes=null;
				try {
					fileNameBytes = filename.getBytes((isInternetExplorer) ? ("windows-1250") : ("utf-8"));
				} catch (UnsupportedEncodingException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				//byte[] fileNameBytes=null;
				/*try {
					fileNameBytes = fileName.getBytes(("utf-8"));
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}*/
			    String dispositionFileName = "";
				 //for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);
			    for (byte b: fileNameBytes) dispositionFileName += (char)(b & 0xff);

				 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
				 response.setHeader("Content-disposition", disposition);
				//response.addHeader("Content-Disposition",content_disposition);
			}
			//	logger.debug(" filenameStr==>"+filenameStr);
			/*	response.addHeader("content-disposition",
				        "attachment; filename=\"\u0e01เทสfชาติชาย.jpg\"");*/
			/*	response.addHeader("content-disposition",
				        "inline; filename="+filenameStr.trim());*/
			File file = new File(ndPathFileGen);
//System.out.println(ndPathFileGen);
			boolean fileExists = file.exists();
			if(fileExists){
				InputStream in = null;
			      OutputStream out=null;
				try {
					out = response.getOutputStream();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} 
			      InputStream stream  = null;
			      try {   
			    		  stream = new FileInputStream(file);
			    		 
					         in = new BufferedInputStream(stream);
			         while (true) {
			            int data = in.read();
			            if (data == -1) {
			               break;
			            }
			            out.write(data);
			         }
			      }catch (Exception e) {
			    	  e.printStackTrace();
					// TODO: handle exception
				 } finally {
			         if (in != null) {
			            try {
							in.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
			         }
			         if (stream != null) {
			        	 try {
							stream.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				         } 
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
    
    @RequestMapping(value={"/getTag/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    public void getTag(HttpServletRequest request,HttpServletResponse response
    		,@PathVariable String id)
    {
    	//String outputFile="/Users/imake/Desktop/"+id+".pdf";
    	//String filePath = bundle.getString("jobServicesPath")+"JobServices.xls";
    	String filePath = bundle.getString("getTagPath");
    	String inputFile=filePath+"tag.xls";
    	String outputFile=filePath+id+".pdf";
		FileInputStream fileIn = null;
		FileOutputStream fileOut = null;
		HSSFWorkbook wb = null; 
		String query=" SELECT "+
	  " call_center.BCC_NO as c0 ,"+// C2
	  " IFNULL(call_center.BCC_CUSTOMER_TICKET,'') as c1 ,"+// E2
	  " IFNULL(call_center.BCC_SERIAL,'') as c2 ,"+// B5
	    " IFNULL(call_center.BCC_MODEL,'') as c3 ,"+// C5
	    " IFNULL(call_center.BCC_CAUSE,'') as c4 ,"+ // D5
	    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') as c5 ,"+ // H5
	    " IFNULL(call_center.BCC_SLA,'') as c6 ,"+
	    " IFNULL(call_center.BCC_IS_MA ,'') as c7 ,"+
	    " IFNULL(call_center.BCC_MA_NO ,'') as c8 ,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_START,'%d/%m/%Y'),'') as c9,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_END,'%d/%m/%Y'),'') as c10,"+
	    " IFNULL(call_center.BCC_STATUS ,'') as c11 ,"+
	    " IFNULL(call_center.BCC_REMARK ,'') as c12 ,"+
	    " IFNULL(call_center.BCC_USER_CREATED ,'')  as c13,"+
	    " IFNULL(call_center.BCC_DUE_DATE ,'') as c14,"+
	    " IFNULL(call_center.BCC_CONTACT ,'') as c15,"+
	    " IFNULL(call_center.BCC_TEL ,'') as c16,"+
	    " IFNULL(call_center.BCC_CUSTOMER_NAME ,'') as c17,"+  
	    " concat(IFNULL(call_center.BCC_BRANCH ,''),' ',IFNULL(call_center.BCC_ADDR1 ,'')) as c18,"+
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
	   " IFNULL(call_center.BCC_STATE ,'') as c29, "+
	   " IFNULL(call_center.BCC_CANCEL_CAUSE ,'') as c30, "+
	   " ifnull(call_center.BCC_MA_TYPE,'') as c31,  "+
	   " ifnull(call_center.BCC_CUSTOMER_TICKET,'') as c32 , "+
	   " concat(IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),''),' ',IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),''),'-',IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') ) as c33 ,"+
	   " concat(IFNULL(DATE_FORMAT(call_center.BCC_MA_START,'%d/%m/%Y'),''),' - ', IFNULL(DATE_FORMAT(call_center.BCC_MA_END,'%d/%m/%Y'),'') ) as c34 "+
	    
	   " FROM "+schema+".BPM_CALL_CENTER call_center left join  "+
	   "  "+schema+".BPM_ARMAS arms   "+
	   " on call_center.BCC_CUSCODE=arms.CUSCOD "+
	  // " FROM "+SCHEMA_G+".BPM_SALE_ORDER  so left join "+
	  // " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+ 
" 	     where call_center.BCC_NO='"+id+"'";
		//System.out.println("query->"+query);
 	VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
	List<Object[]> jobs = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
		try {
			try {
				fileIn = new FileInputStream(inputFile);
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
			CellReference cellReference=null;
			HSSFSheet sheet=	  wb.getSheetAt(0);
			HSSFCell cell = null;
			HSSFRow row = null;
			//Object obj=null; 
			if(jobs!=null && jobs.size()>0){
			String[] cell_array={"C2","E2","B5","C5","D5","H5","C11","C14","C15","C16","C17","C18","C19","C20","C21","C22","C23","C8"};
			int[] cell_index={0,1,2,3,4,5,12,33,17,21,15,16,18,19,20,22,23,34};
			//String[] cell_values={"","","","","        ","","","","","","                           ","","","",""};
			for (int i = 0; i < cell_array.length; i++) {
				cellReference= new CellReference(cell_array[i]);
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				cell.setCellValue((String)jobs.get(0)[cell_index[i]]);
				//System.out.println("value=>"+(String)jobs.get(0)[i]);
			} 
			HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
			//x                                                   x      /
			String C7="";
			//x           
			String E7="";
			
			String BCC_IS_MA=(String)jobs.get(0)[7]; // 1 อยู่ในประกัน , 0 ไม่อยู่ในประกัน , 2 อยู่ในประกัน MA เลขที่ี่ c8
			// String BSO_MA_TYPE=(String)jobs.get(0)[16];
			String BSO_MA_TYPE=(String)jobs.get(0)[32]; // 1 Gold ,2 Silver 3 Bronze
			//x                                                   x                   x                   x
			String BCC_STATUS=(String)jobs.get(0)[11]; // 1 Gold ,2 Silver 3 Bronze
			if(BCC_IS_MA.equals("1")){
				C7=C7+"อยู่ในประกัน";
			}else if(BCC_IS_MA.equals("2")){
				C7=C7+"อยู่ในประกัน MA เลขที่ "+((String)jobs.get(0)[8]);
			}
			else if(BCC_IS_MA.equals("0")){
				C7=C7+"ไม่อยู่ในประกัน";   
			}
			
			if(BCC_STATUS.equals("0")){
				E7=E7+"[ เสนอราคาซ่อม ]";
			}else if(BCC_STATUS.equals("1")){
				E7=E7+"[ ให้ดำเนินการซ่อม Onsite (ช่าง IT) ]";
			}
			else if(BCC_STATUS.equals("2")){
				E7=E7+"[ ให้ดำเนินการซ่อม Onsite (ช่างภูมิภาค) ]";   
			 }else if(BCC_STATUS.equals("3")){
				C7=E7+"[ ให้ซ่อมภายใน SC ]";
			}
			else if(BCC_STATUS.equals("4")){
				E7=E7+"[ ให้ดำเนินการรับเครื่อง (ขนส่งรับจ้าง) ]";   
			 }else if(BCC_STATUS.equals("5")){
				 E7=E7+"[ ให้ดำเนินการรับเครื่อง (ขนส่งต่างจังหวัด) ]";
			}
			else if(BCC_STATUS.equals("6")){
				E7=E7+"[ ตรวจสอบเอกสาร ]";   
			}

			String B9="";
			if(BSO_MA_TYPE.equals("1")){
				B9=B9+"Gold";
			}else if(BSO_MA_TYPE.equals("2")){
				B9=B9+"Silver";
			}
			else if(BSO_MA_TYPE.equals("3")){
				B9=B9+"Bronze";
			} 
			
			String[] ma_cell={"C7","B9","E7"};
			String[] ma_cell_value={C7,B9,E7};
			for (int j = 0; j < ma_cell.length; j++) {
				cellReference= new CellReference(ma_cell[j]);
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				cell.setCellValue(ma_cell_value[j]);
				//System.out.println("xx->"+ma_cell_value[j]);
			} 
			} 
			 
			try {
				fileOut = new FileOutputStream(filePath+id+".xls");
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
			}
			
			//String inputFile="/Users/imake/Desktop/JobServices.xls";
			
			// connect to an OpenOffice.org instance running on port 8100
			OpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
			try {
				connection.connect();
			} catch (ConnectException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//	  ByteArrayOutputStream bOutput = new ByteArrayOutputStream();
			// convert
			DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
			converter.convert(new File(filePath+id+".xls"), new File(outputFile));
			 
			// close the connection
			connection.disconnect();
			String filename=id+".pdf";
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
		    response.setContentType("application/pdf");
			// String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
		   // String disposition = "attachment; inline=\"" + dispositionFileName + "\"";
		    
			 //response.setHeader("Content-disposition", disposition);
			 
			// Document document = new Document();
			 ServletOutputStream servletOutputStream=null;
				try {
					servletOutputStream = response.getOutputStream();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				InputStream buf=null;
				try {
					buf = new BufferedInputStream(new FileInputStream(outputFile));
				} catch (FileNotFoundException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			      int readBytes = 0;

			      //read from the file; write to the ServletOutputStream
			      try {
					while ((readBytes = buf.read()) != -1)
						  servletOutputStream.write(readBytes);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}finally{
					try {
						buf.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			 
					    try {
							servletOutputStream.flush();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					       try {
							servletOutputStream.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} 
		} finally {
			if (fileIn != null)
				try {
					fileIn.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (fileOut != null)
				try {
					fileOut.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}//String outputFile="/Users/imake/Desktop/"+id+".pdf";
			  Path path = Paths.get(filePath, id+".pdf");
			  Path path2 = Paths.get(filePath, id+".xls");
			try {
				Files.deleteIfExists(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				Files.deleteIfExists(path2);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
					      
	}
    @RequestMapping(value={"/getJobServices/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    public void getJobServices(HttpServletRequest request,HttpServletResponse response
    		,@PathVariable String id)
    {
    	//String outputFile="/Users/imake/Desktop/"+id+".pdf";
    	//String filePath = bundle.getString("jobServicesPath")+"JobServices.xls";
    	String filePath = bundle.getString("jobServicesPath");
    	String inputFile=filePath+"JobServices.xls";
    	String outputFile=filePath+id+".pdf";
		FileInputStream fileIn = null;
		FileOutputStream fileOut = null;
		HSSFWorkbook wb = null; 
		String query="select service_job.BCC_NO ,  "+
 " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y'),'') as c1,   "+ 
 //" IFNULL(arms.CUSNAM ,'')AS c2,   "+
// " IFNULL(call_center.BCC_CUSTOMER_NAME ,'')AS c2,   "+
" IFNULL(call_center.BCC_LOCATION ,'') AS c2,   "+
 //" IFNULL(BCC_SALE_ID,'') as  c3,  "+
 " IFNULL(BCC_CUSTOMER_NAME,'') as  c3,  "+ // from sale id
 
 " IFNULL(call_center.BCC_CONTACT,'') AS c4,   "+

" IFNULL(BCC_TEL,'')as c5 ,  "+ 
" concat(IFNULL(BCC_BRANCH,''),' ',IFNULL(BCC_ADDR1,''),' ',IFNULL(BCC_ADDR2,''),' ',IFNULL(BCC_ADDR3,'')  "+
" ,' ',IFNULL(BCC_PROVINCE,''),' ',IFNULL(BCC_ZIPCODE,'')) as c6,  "+
/*" concat( REPLACE(BCC_LOCATION,'-',''),' ',REPLACE(BCC_ADDR1,'-',''),' ',REPLACE(BCC_ADDR2,'-',''),' ',REPLACE(BCC_ADDR3,'-','')  "+
" ,' ',REPLACE(BCC_PROVINCE,'-',''),' ',REPLACE(BCC_ZIPCODE,'-','')) as c6,  "+
*/
" '' as c7 ," + // fax
" IFNULL(BCC_MODEL,'') as c8 ,  "+
" IFNULL(BCC_SERIAL,'') as c9,  "+
" IFNULL(BCC_CAUSE,'') as c10,  "+
" '' as c11 ,"+// NC
" IFNULL(BCC_MA_NO,'') c12 ,   "+
"  IFNULL(DATE_FORMAT(call_center.BCC_MA_START,'%d/%m/%Y'),'') as c13,  "+ 
"  IFNULL(DATE_FORMAT(call_center.BCC_MA_END,'%d/%m/%Y'),'') as c14  ,  "+
" IFNULL(call_center.BCC_IS_MA ,'') as c15 ,"+
//" IFNULL(call_center.BSO_MA_TYPE ,'') as c16 "+
"IFNULL((select so.BSO_MA_TYPE from   BPM_SALE_PRODUCT_ITEM_MAPPING mapping    "+
" left join   BPM_SALE_ORDER so on   "+
" 	   so.BSO_ID= mapping.BSO_ID  where mapping.SERIAL=call_center.BCC_SERIAL "+
"   ) ,'') as c16 , "+
" IFNULL(call_center.BCC_MA_TYPE ,'') as c17  "+
"   FROM  BPM_CALL_CENTER call_center left join  "+   
"     BPM_ARMAS arms      "+
"      on call_center.BCC_CUSCODE=arms.CUSCOD  "+  
"     left join     "+
"     BPM_SERVICE_JOB service_job  "+   
"     on call_center.BCC_NO=service_job.BCC_NO  "+  
 
" 	     where call_center.BCC_NO='"+id+"' ";
		//System.out.println("query->"+query);
 	VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
	List<Object[]> jobs = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
		try {
			try {
				fileIn = new FileInputStream(inputFile);
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
			CellReference cellReference=null;
			HSSFSheet sheet=	  wb.getSheetAt(0);
			HSSFCell cell = null;
			HSSFRow row = null;
			//Object obj=null; 
			if(jobs!=null && jobs.size()>0){
			String[] cell_array={"G1","G2","B3","F3","B4","G4","B5","G5","B6","G6","B7","I7","E8","G8","G9"};
			String[] cell_values={"","","     ","","        ","","","","","","                           ","","","",""};
			for (int i = 0; i < cell_array.length; i++) {
				cellReference= new CellReference(cell_array[i]);
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				cell.setCellValue(cell_values[i]+""+(String)jobs.get(0)[i]);
				//System.out.println("value=>"+(String)jobs.get(0)[i]);
			} 
			HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
			//x                                                   x      /
			String A8="";
			//x                                                   x                   x                   x
			String A9="";
			String BCC_IS_MA=(String)jobs.get(0)[15]; // 1 อยู่ในประกัน , 0 ไม่อยู่ในประกัน , 2 อยู่ในปะรกันเลขที่ 
			// String BSO_MA_TYPE=(String)jobs.get(0)[16];
			String BSO_MA_TYPE=(String)jobs.get(0)[17]; // 1 Gold ,2 Silver 3 Bronze
			//x                                                   x                   x                   x
			if(BCC_IS_MA.equals("1")){
				A8=A8+"x";
			}else if(BCC_IS_MA.equals("2")){
				A8=A8+"                                                    x";
			}
			if(BCC_IS_MA.equals("0")){
				A9=A9+"x                                                   ";
			}
			if(BSO_MA_TYPE.equals("1")){
				A9=A9+"                                                    x                                        ";
			}else if(BSO_MA_TYPE.equals("2")){
				A9=A9+"                                                                        x                    ";
			}
			else if(BSO_MA_TYPE.equals("3")){
				A9=A9+"                                                                                            x";
			}
			String[] ma_cell={"A8","A9"};
			String[] ma_cell_value={A8,A9};
			for (int j = 0; j < ma_cell.length; j++) {
				cellReference= new CellReference(ma_cell[j]);
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				cell.setCellValue(ma_cell_value[j]);
				//System.out.println("xx->"+ma_cell_value[j]);
			} 
			} 
			 
			try {
				fileOut = new FileOutputStream(filePath+id+".xls");
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
			}
			
			//String inputFile="/Users/imake/Desktop/JobServices.xls";
			
			// connect to an OpenOffice.org instance running on port 8100
			OpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
			try {
				connection.connect();
			} catch (ConnectException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//	  ByteArrayOutputStream bOutput = new ByteArrayOutputStream();
			// convert
			DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
			converter.convert(new File(filePath+id+".xls"), new File(outputFile));
			 
			// close the connection
			connection.disconnect();
			String filename=id+".pdf";
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
		    response.setContentType("application/pdf");
			// String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
		   // String disposition = "attachment; inline=\"" + dispositionFileName + "\"";
		    
			 //response.setHeader("Content-disposition", disposition);
			 
			// Document document = new Document();
			 ServletOutputStream servletOutputStream=null;
				try {
					servletOutputStream = response.getOutputStream();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				InputStream buf=null;
				try {
					buf = new BufferedInputStream(new FileInputStream(outputFile));
				} catch (FileNotFoundException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			      int readBytes = 0;

			      //read from the file; write to the ServletOutputStream
			      try {
					while ((readBytes = buf.read()) != -1)
						  servletOutputStream.write(readBytes);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}finally{
					try {
						buf.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			 
					    try {
							servletOutputStream.flush();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					       try {
							servletOutputStream.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} 
		} finally {
			if (fileIn != null)
				try {
					fileIn.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (fileOut != null)
				try {
					fileOut.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}//String outputFile="/Users/imake/Desktop/"+id+".pdf";
			  Path path = Paths.get(filePath, id+".pdf");
			  Path path2 = Paths.get(filePath, id+".xls");
			try {
				Files.deleteIfExists(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				Files.deleteIfExists(path2);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
					      
	}
    @RequestMapping(value={"/getQuotationServices/{id}/{type}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    public void getQuotationServices(HttpServletRequest request,HttpServletResponse response
    		,@PathVariable String id,@PathVariable String type)
    {
    	//String outputFile="/Users/imake/Desktop/"+id+".pdf";
    	//String filePath = bundle.getString("jobServicesPath")+"JobServices.xls";
    	String filePath = bundle.getString("quotationServicesPath");
    	String inputFile=filePath+"Quotation_Services.xls";
    	String outputFile=filePath+"QT_"+id+".pdf";
		FileInputStream fileIn = null;
		FileOutputStream fileOut = null;
		HSSFWorkbook wb = null; 
		/*MyUserDetails userDetails =
				 (MyUserDetails)SecurityContextHolder.getContext().getAuthentication();
		
        System.out.println("xx->"+userDetails.getMyUser().getFullName());*/
		//Locale locale = new Locale("th", "TH");
		Authentication authen=SecurityContextHolder.getContext().getAuthentication();		
		//System.out.println(authen.getDetails().getClass());
		//System.out.println(authen.getCredentials().getClass());
		//System.out.println(authen.getPrincipal().getClass());
 
				MyUserDetails saleDetail =(MyUserDetails)authen.getPrincipal();
				//System.out.println(xx.getMyUser().getFullName());
		  String query=" SELECT "+
				  " call_center.BCC_NO as c0 ,"+
				  "  DATE_FORMAT(now(),'%d/%m/%Y')  as c1,"+
				  " IFNULL(call_center.BCC_LOCATION ,'') as c2,"+ //
				  " IFNULL(call_center.BCC_CONTACT ,'') as c3,"+
				  " concat(IFNULL(call_center.BCC_BRANCH ,''),' ',IFNULL(call_center.BCC_ADDR1 ,''),' ',IFNULL(call_center.BCC_ADDR2 ,''),' ',IFNULL(call_center.BCC_ADDR3 ,''),' '"
				  + " ,IFNULL(call_center.BCC_PROVINCE ,''),' ',IFNULL(call_center.BCC_ZIPCODE ,'') ) as c4,"+
				  " IFNULL(call_center.BCC_TEL ,'') as c5,"+ 
				  " '' as c6,"+ 
				  " IFNULL(call_center.BCC_MODEL,'') as c7,"+ 
				  " IFNULL(call_center.BCC_SERIAL,'') as c8,"+ 
				    " IFNULL(call_center.BCC_CAUSE,'') as c9,"+
				    " IFNULL(call_center.BCC_QUOTAION_REMARK,'') as c10,"+ 
				    "  concat('วันที่','  ',DATE_FORMAT(now(),'%d/%m/%Y'))  as c11,"+
				    "  concat('วันที่','  ',DATE_FORMAT(now(),'%d/%m/%Y'))  as c12 ,"+
				    " case when (call_center.BCC_IS_MA='1') "+
				    " then 'ในประกัน' "+
				    " when (call_center.BCC_IS_MA='0')"+
				    " then 'นอกประกัน' "+
				     " else "+
				    " '' "+
				     " end as c13 , "+
				     " case when (call_center.BCC_IS_MA='2') "+
					    " then  ifnull(call_center.BCC_MA_NO,'')"+
					     " else "+
					    " '' "+
					     " end as c14  "+ 
				   " FROM "+schema+".BPM_CALL_CENTER call_center left join  "+
				   "  "+schema+".BPM_ARMAS arms   "+
				   " on call_center.BCC_CUSCODE=arms.CUSCOD "+
				   /*
				   " left join  "+
				   "  "+schema+".BPM_SERVICE_JOB service_job   "+
				   " on call_center.BCC_NO=service_job.BCC_NO "+*/
				  // " FROM "+SCHEMA_G+".BPM_SALE_ORDER  so left join "+
				  // " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
				   " where call_center.BCC_NO='"+id+"'";
		// System.out.println("query->"+query);
 	VResultMessage vresultMessage = synDomeBPMService.searchObject(query);
	List<Object[]> jobs = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
		try {
			try {
				fileIn = new FileInputStream(inputFile);
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
			CellReference cellReference=null;
			HSSFSheet sheet=	  wb.getSheetAt(0);
			HSSFCell cell = null;
			HSSFRow row = null;
			//Object obj=null; 
			if(jobs!=null && jobs.size()>0){
			String[] cell_array={"F4","F5","B6","E6","B7","B8","E8","A10","C10","B11","B33","A38","A41","D10","E10"}; 
			for (int i = 0; i < cell_array.length; i++) {
				cellReference= new CellReference(cell_array[i]);
				row = sheet.getRow(cellReference.getRow());
				if(row==null)
					row=sheet.createRow(cellReference.getRow());
				cell =row.getCell((int)cellReference.getCol());
				if(cell==null)
					cell = row.createCell((int)cellReference.getCol());
				/*if(i==1){
					DateTime dt=null;
					try {
						dt = new DateTime(format1.parse((String)jobs.get(0)[i]));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					cell.setCellValue(dt.dayOfMonth().getAsText()+" "+dt.monthOfYear().getAsText(locale)+" "+dt.year().get()+543);  
				}else*/
					cell.setCellValue((String)jobs.get(0)[i]);
				//System.out.println("value=>"+(String)jobs.get(0)[i]);
			} 
			    query=" SELECT  mapping.IMA_ItemID as c0 ,product.IMA_ItemName as c1, concat('',mapping.BQ_AMOUNT) as c2, "+
			    		" ifnull(mapping.PRICE,'0')  as c3 , "+
			    		 " ifnull(mapping.PRICE_COST,'')  as c4  "+ 
			    		" FROM  "+schema+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING  mapping left join  "+schema+".BPM_PRODUCT product   "+
			    		"  on mapping.IMA_ItemID=product.IMA_ItemID  where mapping.BQ_TYPE='2' AND mapping.BQ_REF='"+id+"'"; 
					   
			// System.out.println("query->"+query);
	 	  vresultMessage = synDomeBPMService.searchObject(query);
		List<Object[]> items = vresultMessage.getResultListObj();//synDomeBPMService.searchObject(query);
		String[] columns={"A","B","D","E","F"};
		int index=13;
		if(items!=null && items.size()>0){
			for (int i = 0; i < items.size(); i++) {
				for (int j = 0; j < columns.length; j++) {
					cellReference= new CellReference(columns[j]+""+index);
					row = sheet.getRow(cellReference.getRow());
					if(row==null)
						row=sheet.createRow(cellReference.getRow());
					cell =row.getCell((int)cellReference.getCol());
					if(cell==null)
						cell = row.createCell((int)cellReference.getCol()); 
					if(j==2||j==3)
						cell.setCellValue(Double.valueOf((String)items.get(i)[j]));
					else if(j==4)
						cell.setCellFormula("E"+index+"*"+"D"+index);
					else
						cell.setCellValue( (String)items.get(i)[j]);
				} 
				index++;
			}
		}
		
		cellReference= new CellReference("A37");
		row = sheet.getRow(cellReference.getRow());
		if(row==null)
			row=sheet.createRow(cellReference.getRow());
		cell =row.getCell((int)cellReference.getCol());
		if(cell==null)
			cell = row.createCell((int)cellReference.getCol()); 
		cell.setCellValue("( "+saleDetail.getMyUser().getFullName()+" )");
		
			HSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
			} 
			 
			try {
				fileOut = new FileOutputStream(filePath+"QT_"+id+".xls");
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
			}
			
			//String inputFile="/Users/imake/Desktop/JobServices.xls";
			
			// connect to an OpenOffice.org instance running on port 8100
			OpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
			try {
				connection.connect();
			} catch (ConnectException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String filename="QT_"+id+".pdf";
			if(type.equals("pdf")){
				DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
				converter.convert(new File(filePath+"QT_"+id+".xls"), new File(outputFile));
				 
				// close the connection
				connection.disconnect();
				 response.setContentType("application/pdf");
			}else
			{
				 filename="QT_"+id+".xls";
			}
		//	  ByteArrayOutputStream bOutput = new ByteArrayOutputStream();
			// convert
			
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
		    if(!type.equals("pdf")){
		    	 String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
		    	  response.setHeader("Content-disposition", disposition);
		    }
		    	// String disposition = "attachment; filename=\"" + dispositionFileName + "\"";
		   // String disposition = "attachment; inline=\"" + dispositionFileName + "\"";
		    
			 //response.setHeader("Content-disposition", disposition);
			 
			// Document document = new Document();
			 ServletOutputStream servletOutputStream=null;
				try {
					servletOutputStream = response.getOutputStream();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				  if(type.equals("pdf")){
					  InputStream buf=null;
						try {
							buf = new BufferedInputStream(new FileInputStream(outputFile));
						} catch (FileNotFoundException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
					      int readBytes = 0;

					      //read from the file; write to the ServletOutputStream
					      try {
							while ((readBytes = buf.read()) != -1)
								  servletOutputStream.write(readBytes);
						} catch (IOException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}finally{
							try {
								buf.close();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
				    }else{ // xls
				    	try {
							wb.write(servletOutputStream);
						
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} 
				    }
				
			 
					    try {
							servletOutputStream.flush();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					       try {
							servletOutputStream.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} 
		} finally {
			if (fileIn != null)
				try {
					fileIn.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (fileOut != null)
				try {
					fileOut.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}//String outputFile="/Users/imake/Desktop/"+id+".pdf";
			  Path path = Paths.get(filePath,"QT_"+id+".pdf");
			  Path path2 = Paths.get(filePath,"QT_"+id+".xls");
			try {
				Files.deleteIfExists(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				Files.deleteIfExists(path2);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
					      
	}
   /* @RequestMapping(value={"/deletefile/doc/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    @ResponseBody
    public  String deletefile(HttpServletRequest request, Model model,@PathVariable String id)
    {
    	MissDoc missDoc =new MissDoc();
    	missDoc.setMdId(Long.valueOf(id));
    	 missExamService.deleteMissDoc(missDoc); 
    	 return "";
    }*/
    private void createDirectoryIfNeeded(String directoryName)
  	 {
  	   File theDir = new File(directoryName);

  	   // if the directory does not exist, create it
  	   if (!theDir.exists())
  	   {
  		   //boolean cancreate = theDir.mkdir();
  		   theDir.mkdir();
  	   }
  	  
  	 }
      private String genToken(){
  		StringBuffer sb = new StringBuffer();
  	    for (int i = 36; i > 0; i -= 12) {
  	      int n = Math.min(12, Math.abs(i));
  	      sb.append(org.apache.commons.lang3.StringUtils.leftPad(Long.toString(Math.round(Math.random() * Math.pow(36, n)), 36), n, '0'));
  	    }
  	    return sb.toString();
   }
}
