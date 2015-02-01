package th.co.imake.syndome.agent;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import th.co.imake.syndome.domain.Stock;
public class ERPAgent {
	static Logger logger = Logger.getLogger(ERPAgent.class.getName());
	private static String DB_SCHEMA = "";
	private static String DB_JDBC_URL = "";
	private static String DB_JDBC_DRIVER_CLASS_NAME = "";
	private static String DB_USERNAME = "";
	private static String DB_PASSWORD = "";	 
//	public static String[] COLUMNS_NAME={"IMA_ItemID","IMA_ItemName","LocQty","LocationName","AcctValAmt","StdCostAmt","AvgCostAmt","LastCostAmt"};
	public static String[] COLUMNS_NAME={"IMA_ItemID","IMA_ItemName","LocQty","LocationName","AcctValAmt"
		,"UnitMeasure","ProdFam","Classification","LeadTimeCode","ItemTypeCode"};
	 

	//public static int[] COLUMNS={0,1,2,4,11,12,13,14};
	public static int[] COLUMNS={1,2,3,15,9
							,20,18,10,5,11}; 
	public static NumberFormat format = NumberFormat.getNumberInstance();
	public static  DecimalFormat myFormatter = new DecimalFormat("#,###,###,##0.00");
	static{
		format.setGroupingUsed(true);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 logger.info("############################################# ERP Agent Start #############################################");
		ERPAgent agent =new ERPAgent();
		Properties prop = new Properties();
		long start = System.currentTimeMillis();
		try {
			prop.load(new FileInputStream(
					"/opt/Agent/config.properties"));

			DB_SCHEMA = prop.getProperty("DB_SCHEMA",
					"http://203.150.20.37/imake/rest/numbering/");
			DB_JDBC_URL = prop.getProperty("DB_JDBC_URL",
					"jdbc:mysql://localhost:3306/BLUECODE_DB");
			DB_JDBC_DRIVER_CLASS_NAME = prop.getProperty(
					"DB_JDBC_DRIVER_CLASS_NAME", "com.mysql.jdbc.Driver");
			DB_USERNAME = prop.getProperty("DB_USERNAME", "root");
			DB_PASSWORD = prop.getProperty("DB_PASSWORD", "");

		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		boolean isXLSX=false;
		try {
		// Map<String,Stock>  stockMap=agent.getERP(new FileInputStream("/usr/local/data/Work/PROJECT/IMakeDev/SynDome/Data/ERP/stock value as of 10_30_2013.xlscal.xls"), isXLSX);
			
		/*	String url = "smb://192.168.10.2/Canter-Data/stock/stock.xls";
			SmbFile dir=null;
			try {
				dir = new SmbFile(url);
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 
			try {
				System.out.println(dir.exists());
			} catch (SmbException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	    	// logger.info(dir.getInputStream());
	    	 byte[] bytes=null;
			try {
				bytes = IOUtils.toByteArray(dir.getInputStream());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			logger.info("file size="+bytes.length);
	    	 FileOutputStream fileOuputStream=null;
			try {
				fileOuputStream = new FileOutputStream("/home/syndome/stock.xls");
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		    try {
				fileOuputStream.write(bytes);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    try {
				fileOuputStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
		     Map<String,Stock>  stockMap=agent.getERP(new FileInputStream("/home/syndome/stock.xls"), isXLSX);
		    //Map<String,Stock>  stockMap=agent.getERP(new FileInputStream("/Users/imake/Desktop/stock.xls"), isXLSX);
			logger.info("stockMap.size()->"+stockMap.size());
	       agent.synStock(stockMap);
	       long end = System.currentTimeMillis();
	   	//	logger.info("used time=" + ((end - start) / 1000d));
	   		logger.info("ERP used time=" + ((end - start) / 1000d));
	   	 logger.info("############################################# ERP Agent END #############################################");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	 private Map<String,Stock> getERP(InputStream in, boolean isXLSX) {
			
		 Map<String,Stock> stockMap =new HashMap<String,Stock> ();
		 int columnIndex = 0;
			int rowNum = 0;
			try { 
				Workbook myWorkBook = null;
				if (isXLSX) {
					myWorkBook = new XSSFWorkbook(in);
				} else {
					POIFSFileSystem myFileSystem = new POIFSFileSystem(in); 
					myWorkBook = new HSSFWorkbook(myFileSystem);
				}
				
				// logger.info(myWorkBook);

				Sheet sheet1 = myWorkBook.getSheetAt(0);
				// String [] columns={"A","B","C","D","E"};
				int[] types = { 1, 1, 0, 1 };

				CellReference cellRef = null;
				/*int columnIndex = 0;
				int rowNum = 0;*/
				int end_col=4;
				Cell cell=null;
				int columns_size=COLUMNS.length; 
				int index_row=0;
				for (Row row : sheet1) {
					index_row++;
					//for (Cell cell : row) {
						//columnIndex = cell.getColumnIndex();
						rowNum = row.getRowNum();
						//System.out.println("rowNum->"+rowNum);
						if (rowNum > 1) { 
							// [IMA_ItemID],[IMA_ItemName],[LocQty],[LocationName],[AcctValAmt],[StdCostAmt],[AvgCostAmt],[LastCostAmt]
							//  0,1,2,4,11,12,13,14
							// key==>[IMA_ItemID]_[LocQty]
							// number=2,11,12,13,14 
							cell=row.getCell(1);
							String ima_itemID=cell.getStringCellValue().trim();
							if(ima_itemID.length()==0)
								break;
							Stock stockRead=new Stock();
							cell=row.getCell(4);
							//String locationName=cell.getStringCellValue().trim(); 
							
							//cell=row.getCell(2);
							cell=row.getCell(3);
							//Double locQty_read=(new Double(format.format(cell.getNumericCellValue())));
						//	myFormatter.parse(cell.getStringCellValue().trim()).doubleValue();
							Double locQty_read=0d;
							if(cell.getStringCellValue().trim().length()>0){
								locQty_read=(new Double(myFormatter.parse(cell.getStringCellValue().trim()).doubleValue()));
							} 
							
							/*logger.info("locQty_read 1=>"+locQty_read);
							logger.info("locQty_read 2=>"+cell.getNumericCellValue());
							logger.info("locQty_read 3=>"+format.format(cell.getNumericCellValue()));
							cell=row.getCell(14);
							logger.info("locQty_read 4=>"+format.format(cell.getNumericCellValue()));*/
							//String key=ima_itemID+"_"+locationName;
							String key=ima_itemID;
							Object[] objectArrays=new Object[columns_size]; 
							//logger.info(key);
							for (int i = 0; i < columns_size; i++) {
								int index=COLUMNS[i];
								//logger.info("index="+index);
								cell=row.getCell(index);
								/*
								 * public static int[] COLUMNS={1,2,3,15,9
							,20,18,10,5,11};
								 */
								//System.out.println("cell.getStringCellValue().trim()->"+cell.getStringCellValue().trim());
							//	objectArrays[i]=cell.getStringCellValue().trim();
								if(i==2 || i==4 ){
									//logger.info(cell.getStringCellValue().trim());
									// objectArrays[i]=cell.getStringCellValue().trim();
									Double doubleVaue=0d;
									if(cell.getStringCellValue().trim().length()>0){
										doubleVaue=(new Double(myFormatter.parse(cell.getStringCellValue().trim()).doubleValue()));
									}
									objectArrays[i]=doubleVaue;
								}else{
									objectArrays[i]=cell.getStringCellValue().trim();
								}
								/*if(index!=2 && index!=11 && index!=12 &&index!=13 &&index!=14 ){
									//logger.info(cell.getStringCellValue().trim());
									objectArrays[i]=cell.getStringCellValue().trim();
								}else{
									objectArrays[i]=cell.getNumericCellValue();
								}*/
							}
							stockRead.setObjectArrays(objectArrays);
							if(!stockMap.containsKey(key)){
								stockMap.put(key, stockRead);
							}else{
								Stock stock=stockMap.get(key);
								 java.lang.Double locQty =(java.lang.Double)stock.getObjectArrays()[2];
								 locQty=locQty+locQty_read; 
								stock.getObjectArrays()[2]=locQty;
							}
							 
				          }
				}
				//logger.info("index_row"+index_row);
				//logger.info(stockMap.get("01110").getObjectArrays()[2]);
				/*Iterator<Row> rowIterator = sheet.iterator();
				while(rowIterator.hasNext()) { */
				/*if(sheet1.getRow(0).getCell(end_col-1)!=null && sheet1.getRow(0).getCell(end_col-1).getStringCellValue().length()>0
						&& ( sheet1.getRow(0).getCell(end_col)==null ||  ( sheet1.getRow(0).getCell(end_col)!=null && sheet1.getRow(0).getCell(end_col).getStringCellValue().length()==0))  ){
				for (Row row : sheet1) {
					//for (Cell cell : row) {
					for (int j=0;j<end_col;j++) {
						cell=row.getCell(j);
						if(cell==null)
							break;
						columnIndex = cell.getColumnIndex();
						rowNum = row.getRowNum();
						if (rowNum > 0) {
							cellRef = new CellReference(rowNum, columnIndex);
							cellRef.
							// check type
							if (types[columnIndex] == 6 && cell.getCellType() == 0) { // ok

							} else if (types[columnIndex] == cell.getCellType()) { // ok

							} else { // not ok
								data.add(cellRef.formatAsString());
							}
 
						}
					}
				}*/
				  
			} catch (Exception e) {
				System.out.println("columnIndex->"+columnIndex);
				System.out.println("rowNum-->"+rowNum);
				e.printStackTrace();
			} finally {
				if (in != null)
					try {
						in.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			} 
			
			return stockMap;
		}
		public void synStock(Map<String,Stock> stockMap) {
			 
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
			int column_size=COLUMNS_NAME.length;
			if (con != null) {
				try {
					for (Map.Entry<String, Stock> entry : stockMap.entrySet()) {
				        String key = entry.getKey();
				        Stock stock = entry.getValue();
				        // use key and value
				    
					//for (ArMas arMas : arMasList) {
						Object[] objectArrays=stock.getObjectArrays();
						query.setLength(0); 
						query.append(" SELECT count(*) as COUNT FROM " + DB_SCHEMA+ ".BPM_PRODUCT where IMA_ItemID='"+objectArrays[0]+"'");
						pst1 = con.prepareStatement(query.toString());
						rs = pst1.executeQuery();
						  while (rs.next()) {
					            int count = rs.getInt("COUNT");
					            query.setLength(0);
					            if(count>0){//update 
					            	query.append("UPDATE  "+ DB_SCHEMA+ ".BPM_PRODUCT SET ");
					            	
					            	for (int i = 1; i < column_size; i++) {
					            		//PAYTRM 20  java.lang.Integer 
				        				//BALANCE 25  java.lang.Double
				        				//CHQRCV  26   java.lang.Double
				        				//CRLINE  27   java.lang.Double
					            		/*if(i==3){
					            			query.append(COLUMNS[i]+"="+(objectArrays[i]!=null?("?"):"null")+"");
					            		}else{*/ 
					            		
					            	/*	public static String[] COLUMNS_NAME={"IMA_ItemID","IMA_ItemName","LocQty","LocationName","AcctValAmt"
					            			,"UnitMeasure","ProdFam","Classification","LeadTimeCode","ItemTypeCode"}; 
					            		public static int[] COLUMNS={1,2,3,15,9
					            								,20,18,10,5,11}; */
					            		if(i==2 || i==4 )
					            			query.append(COLUMNS_NAME[i]+"="+(objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+""); 
				            			else
				            				query.append(COLUMNS_NAME[i]+"="+(objectArrays[i]!=null?("'"+getEncode(objectArrays[i].toString())+"'"):"null")+"");
					            			/*if(i!=2 && i!=4 && i!=5 && i!=6  && i!=7)
					            				query.append(COLUMNS_NAME[i]+"="+(objectArrays[i]!=null?("'"+getEncode(objectArrays[i].toString())+"'"):"null")+"");
					            			else
					            				query.append(COLUMNS_NAME[i]+"="+(objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+""); */
					            		//}
					            		if(column_size!=(i+1))
					            			query.append(",");
									}
					            	query.append(" WHERE IMA_ItemID='"+objectArrays[0]+"'"); 
					            	}else{//insert
					            	query.append("  INSERT INTO  "+ DB_SCHEMA+ ".BPM_PRODUCT ( ");
					            	for (int i = 0; i < column_size; i++) { 
					            		query.append(COLUMNS_NAME[i]);
					            		if(column_size!=(i+1))
					            			query.append(",");
					            	}
					            	query.append(")VALUES(");
					            	for (int i = 0; i < column_size; i++) { 
					            		/*if(i==3){
					            			query.append("?");
					            		}else{*/
					            		if(i==2 || i==4 ) 
					            			query.append((objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+"");
					            		else
					            			query.append((objectArrays[i]!=null?("'"+getEncode(objectArrays[i].toString())+"'"):"null")+"");
					            			/*if(i!=2 && i!=4 && i!=5 && i!=6  && i!=7)
					            				query.append((objectArrays[i]!=null?("'"+getEncode(objectArrays[i].toString())+"'"):"null")+"");
					            			else
					            				query.append((objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+""); */
					            		//}
					            		if(column_size!=(i+1))
					            			query.append(",");
									}
					            	query.append(")"); 
					            }
					            pst1 = con.prepareStatement(query.toString());
					           // pst1.setString(1, (objectArrays[3]!=null?(""+objectArrays[3]+""):"null"));
					            //logger.info("index["+index+"]->"+query.toString());
					           // System.out.println(query.toString());
					            pst1.executeUpdate();
					          // logger.info("count->"+count);
					            if(index%3000==0){/*
					            	try {
										Thread.sleep(3000);
									} catch (InterruptedException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
					            */}
					            index++;
					        }
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
		private String getEncode(String fromStr) {
			/* byte[] encoded = null;
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
			}*/
			fromStr=fromStr.replaceAll("\\\\", "\\\\\\\\");
			fromStr=fromStr.replaceAll("'","\\\\'"); 
			
		   return fromStr ;
			//return  fromStr;
		}
}
