package th.co.imake.syndome.agent;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
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
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import th.co.imake.syndome.domain.Stock;
public class ERPAgent {
	static Logger logger = Logger.getLogger(ERPAgent.class.getName());
	private static String DB_SCHEMA = "";
	private static String DB_JDBC_URL = "";
	private static String DB_JDBC_DRIVER_CLASS_NAME = "";
	private static String DB_USERNAME = "";
	private static String DB_PASSWORD = "";	 
	public static String[] COLUMNS_NAME={"IMA_ItemID","IMA_ItemName","LocQty","UnitMeasure","ProdFam","Classification","LeadTimeCode","ItemTypeCode","AcctValAmt"};
	public static int[] COLUMNS={0,1,3,4,7,8,14,15,5};
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
		//try {
			//prop.load(new FileInputStream("/opt/Agent/config.properties"));

			/*DB_SCHEMA = prop.getProperty("DB_SCHEMA","http://203.150.20.37/imake/rest/numbering/");
			DB_JDBC_URL = prop.getProperty("DB_JDBC_URL","jdbc:mysql://localhost:3306/BLUECODE_DB");
			DB_JDBC_DRIVER_CLASS_NAME = prop.getProperty("DB_JDBC_DRIVER_CLASS_NAME", "com.mysql.jdbc.Driver");
			DB_USERNAME = prop.getProperty("DB_USERNAME", "root");
			DB_PASSWORD = prop.getProperty("DB_PASSWORD", "");*/
			
			DB_SCHEMA = prop.getProperty("DB_SCHEMA","SYNDOME_BPM_DB");
			DB_JDBC_URL = prop.getProperty("DB_JDBC_URL","jdbc:mysql://192.168.10.250:3306/SYNDOME_BPM_DB?characterEncoding=UTF-8");
			DB_JDBC_DRIVER_CLASS_NAME = prop.getProperty("DB_JDBC_DRIVER_CLASS_NAME", "com.mysql.jdbc.Driver");
			DB_USERNAME = prop.getProperty("DB_USERNAME", "root");
			DB_PASSWORD = prop.getProperty("DB_PASSWORD", "syndome_db");
			
		/*} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}*/
		boolean isXLSX=false;
		try {
		     //Map<String,Stock>  stockMap=agent.getERP(new FileInputStream("/home/syndome/stock.xls"), isXLSX);
		    Map<String,Stock>  stockMap=agent.getERP(new FileInputStream("/Users/Ruethair/Desktop/stock1/stock.xls"), isXLSX);
			logger.info("stockMap.size()->"+stockMap.size());
			agent.synStock(stockMap);
			long end = System.currentTimeMillis();
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
				
				 logger.info(myWorkBook);

				Sheet sheet1 = myWorkBook.getSheetAt(0);
				Cell cell=null;
				int columns_size=COLUMNS.length; 

				for (Row row : sheet1) {
					rowNum = row.getRowNum();
					if (rowNum > 0) { 
						
						cell=row.getCell(0);//get IMA_ItemID
						cell.setCellType(Cell.CELL_TYPE_STRING);
						String ima_itemID=cell.getStringCellValue().trim();
						if(ima_itemID.length()==0)
							break;
						Stock stockRead=new Stock();
						cell=row.getCell(4);

						cell=row.getCell(3);

						Double locQty_read=0d;
						cell.setCellType(Cell.CELL_TYPE_STRING);
						if(cell.getStringCellValue().trim().length()>0){
							locQty_read=(new Double(myFormatter.parse(cell.getStringCellValue().trim()).doubleValue()));
						} 
						
						String key=ima_itemID;
						System.out.println("ima_itemID --> "+ima_itemID);
						Object[] objectArrays=new Object[columns_size]; 
						//logger.info(key);
						for (int i = 0; i < columns_size; i++) {
							int index=COLUMNS[i];
							//logger.info("index="+index);
							cell=row.getCell(index);
							
							if(i==2 || i==8 ){
								Double doubleValue=0d;
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(cell.getStringCellValue().trim().length()>0){
									doubleValue=(new Double(myFormatter.parse(cell.getStringCellValue().trim()).doubleValue()));
								}
								objectArrays[i]=doubleValue;
							}else{
								//cell.setCellType(Cell.CELL_TYPE_STRING);
								objectArrays[i]=cell.getStringCellValue().trim();
							}

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
			StringBuffer query = new StringBuffer();

			ResultSet rs = null;
			PreparedStatement pst1 = null;
			int index=0;
			int column_size=COLUMNS_NAME.length;
			if (con != null) {
				try {
					for (Map.Entry<String, Stock> entry : stockMap.entrySet()) {
				        String key = entry.getKey();
				        Stock stock = entry.getValue();
	
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

					            		if(i==2 || i==8 )//LocQty, AcctValAmt
					            			query.append(COLUMNS_NAME[i]+"="+(objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+""); 
				            			else
				            				query.append(COLUMNS_NAME[i]+"="+(objectArrays[i]!=null?("'"+getEncode(objectArrays[i].toString())+"'"):"null")+"");
	
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
					            		
					            		if(i==2 || i==8 ) 
					            			query.append((objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+"");
					            		else
					            			query.append((objectArrays[i]!=null?("'"+getEncode(objectArrays[i].toString())+"'"):"null")+"");

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
					          logger.info("count->"+count);
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
			 byte[] encoded = null;
			try {
				//new String(request.getParameter("txtName").getBytes("ISO8859_1"), "UTF-8");
				encoded = fromStr.getBytes("ISO-8859-1");
				//encoded=fromStr.getBytes("CP1252");
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
			fromStr=fromStr.replaceAll("\\\\", "\\\\\\\\");
			fromStr=fromStr.replaceAll("'","\\\\'"); 
			
		   return fromStr ;
			//return  fromStr;
		}
}
