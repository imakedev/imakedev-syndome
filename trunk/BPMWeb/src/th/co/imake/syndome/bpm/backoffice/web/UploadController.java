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
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.backoffice.xstream.IMakeFile;

import com.google.gson.Gson;
@Controller
public class UploadController {	
	//private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	//private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	private static Logger logger = Logger.getRootLogger();
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
						  createDirectoryIfNeeded(path);
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
		Gson gson=new Gson();
		//gson.toJson(imkeFile );
		System.out.println(hotLink);
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
			
			String query="SELECT so.BSO_DELIVERY_LOCATION," +
					" so.BSO_DELIVERY_ADDR1, " +
					/*" concat(\"แขวง/ตำบล \",so.BSO_DELIVERY_ADDR2), " +
					" concat(\"เขต/อำเภอ \",so.BSO_DELIVERY_ADDR3), " +
					" concat(\"จ. \",so.BSO_DELIVERY_PROVINCE)," +*/
					"  so.BSO_DELIVERY_ADDR2, " +
					"  so.BSO_DELIVERY_ADDR3, " +
					"  so.BSO_DELIVERY_PROVINCE," +
					" so.BSO_DELIVERY_ZIPCODE," +
					//" concat(\"      \",so.BSO_DELIVERY_TEL_FAX ), " +
					" so.BSO_DELIVERY_TEL_FAX , " +
					" so.BSO_RFE_NO , "+ 
					"concat(\"Tel \\: \",so.BSO_DELIVERY_TEL_FAX,\" \",so.BSO_DELIVERY_CONTACT) ,"+
					" IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'') as d1 ," +
					" IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i'),'') as d2 ," +
					" IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%d/%m/%Y'),'') as d3 ," +
					" IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%H:%i'),'') as d4 "+
				    " FROM "+schema+".BPM_SALE_ORDER so  " +
					" WHERE so.BSO_ID="+id;
			
			List<Object[]> sale_order = synDomeBPMService.searchObject(query);
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
				String[] date_array={"G","G","K","K"};
				String[] date_value={BSO_CREATED_DATE,BSO_CREATED_DATE_TIME,BSO_DELIVERY_DUE_DATE,BSO_DELIVERY_DUE_DATE_TIME};
				int[] index_date={16,17,16,17};
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
			 query="SELECT item.amount," +
			 		" item.weight," +
			 		" product.ima_itemname" +
			 		" FROM SYNDOME_BPM_DB.BPM_SALE_PRODUCT_ITEM item " +
					" left join "+schema+".BPM_PRODUCT product on item.ima_itemid=product.ima_itemid "+ 
					" WHERE item.BSO_ID="+id;
			
			List<Object[]> product_item = synDomeBPMService.searchObject(query);
			int product_item_size = product_item.size();
			int index=8;
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
			
			List<Object[]> status = synDomeBPMService.searchObject(query);
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
			
			List<Object[]> status = synDomeBPMService.searchObject(query);
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
