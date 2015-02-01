package th.co.imake.syndome.agent;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import jcifs.smb.SmbFile;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;

import th.co.imake.syndome.domain.ArMas;

public class ExpressAgent {
	static Logger logger = Logger.getLogger(ExpressAgent.class.getName());
	private static String DB_SCHEMA = "";
	private static String DB_JDBC_URL = "";
	private static String DB_JDBC_DRIVER_CLASS_NAME = "";
	private static String DB_USERNAME = "";
	private static String DB_PASSWORD = "";
	private static String[] COLUMNS={"CUSCOD","CUSTYP","PRENAM","CUSNAM","ADDR01","ADDR02","ADDR03","ZIPCOD","TELNUM","CONTACT", // 9
									   "CUSNAM2","TAXID","ORGNUM","TAXTYP","TAXRAT","TAXGRP","TAXCOND","SHIPTO","SLMCOD","AREACOD","PAYTRM", // 20
									   "PAYCOND","PAYER","TABPR","DISC","BALANCE","CHQRCV","CRLINE","LASIVC","ACCNUM","REMARK", // 30
									   "DLVBY","TRACKSAL","CREBY","CREDAT","USERID","CHGDAT","STATUS","INACTDAT"}; // 38
	  
/*	CUSCOD	CUSTYP	PRENAM	CUSNAM	ADDR01	ADDR02	ADDR03	ZIPCOD	TELNUM	CONTACT	CUSNAM2	TAXID	ORGNUM(class java.lang.Integer)	TAXTYP	TAXRAT	TAXGRP	TAXCOND	SHIPTO	SLMCOD	AREACOD	PAYTRM	
	PAYCOND	PAYER	TABPR	DISC	BALANCE	CHQRCV	CRLINE	LASIVC	ACCNUM	REMARK	DLVBY	TRACKSAL	CREBY
	CREDAT	USERID	CHGDAT	STATUS	INACTDAT*/	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 logger.info("############################################# Express Agent Start #############################################");
		ExpressAgent agent = new ExpressAgent();
		Properties prop = new Properties();
		//Map map = null;
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
		String url = "smb://192.168.10.1/WinXP/ExpressI/SYN2556/ARMAS.DBF";
    	//NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(null, null, null);
    	//SmbFile dir = new SmbFile(url, auth);
    	SmbFile dir=null;
		try {
			dir = new SmbFile(url);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
			fileOuputStream = new FileOutputStream("/opt/Agent/Express/DBF/ARMAS.DBF");
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
		}
		//String fileName="/usr/local/data/Work/PROJECT/IMakeDev/SynDome/Data/140107/DBF";
	    String fileName="/opt/Agent/Express/DBF";
		List<ArMas> arMasList = agent.getDataExpress(fileName);
		logger.info("size=" + arMasList.size());
		 agent.synExpress(arMasList);
		long end = System.currentTimeMillis();
	//	logger.info("used time=" + ((end - start) / 1000d));
		logger.info("Express used time=" + ((end - start) / 1000d));
		 logger.info("############################################# Express Agent End #############################################");
	}

	public List<ArMas> getDataExpress(String fileName) {
		List<ArMas> arMasList = new ArrayList<ArMas>();
		try {
			Class.forName("jstels.jdbc.dbf.DBFDriver2");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Connection conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:jstels:dbf:"
					+ fileName);
			// create a Statement object to execute the query with
			Statement stmt = conn.createStatement();
			int offset = 1000;
			ResultSet rs = null;
			int index = 0;
			int i = 0;
			// for (int i = 0; i <= 12; i++) {
			while (true) {
				int index_inner = 0;
				rs = stmt.executeQuery("SELECT * FROM ARMAS limit 1000 offset "
						+ (i * offset));
				i++;
				/*logger.info(rs.getMetaData().getColumnCount());
				for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
					System.out.print(rs.getMetaData().getColumnName(j) + "\t");
				}*/
				// INT = 20 ,  Double = 25,26,27 , Timestamp = 28 34 36
			 
				//CUSCOD 1 java.lang.String
				//CUSTYP 2
				//PRENAM 3
				//CUSNAM 4
				//ADDR01 5
				//ADDR02 6
				//ADDR03 7
				//ZIPCOD 8
				//TELNUM 9
				//CONTACT 10  java.lang.String
				//CUSNAM2 11
				//TAXID 12
				//TAXTYP 13
				//TAXRAT 14
				//TAXGRP 15
				//TAXCOND 16
				//SHIPTO 17
				//SLMCOD 18  java.lang.String
				//AREACOD 19  java.lang.String
				//PAYTRM 20  java.lang.Integer
				//PAYCOND 21  java.lang.String
				//PAYER 22
				//TABPR  23  java.lang.String
				//DISC  24
				//BALANCE 25  java.lang.Double
				//CHQRCV  26   java.lang.Double
				//CRLINE  27   java.lang.Double
				//LASIVC  28  java.sql.Timestamp
				//ACCNUM  29  java.lang.String
				//REMARK  30
				//DLVBY   31
				//TRACKSAL  32
				//CREBY  33  java.lang.String
				//CREDAT  34  java.sql.Timestamp
				//USERID  35  java.lang.String
				//CHGDAT  36  java.sql.Timestamp
				//STATUS  37
				//INACTDAT	38
				 
				
				//System.exit(1);
				while (rs.next()) {
					/*
					 * rowObjects x[1]->EM06990XXX CUSCOD rowObjects x[2]->00
					 * CUSTYP rowObjects x[3]->บริษัท PRENAM rowObjects
					 * x[4]->แพนอาร์ต คอมพิวเตอร์ จำกัด CUSNAM rowObjects
					 * x[5]->22/1 ซอยเทอดไท 63/1 ถนนเทอดไท ADDR01 rowObjects
					 * x[6]->แขวงบางหว้า เขตภาษีเจริญ กรุงเทพฯ 10160 ADDR02
					 * rowObjects x[7]->กรุงเทพฯ ADDR03 rowObjects x[8]->10160
					 * ZIPCOD rowObjects
					 * x[9]->8689677F8689677ซ.วัชรพลโอภาส13-17จ่ายศ2,4โอนTFB
					 * TELNUM rowObjects x[10]->ฝ่ายบัญชี/การเงิน CONTACT
					 * rowObjects x[18]->1438 SLMCOD rowObjects x[19]->01
					 * AREACOD rowObjects x[21]->เครดิต 30 วัน PAYCOND
					 * rowObjects x[23]->1 TABPR rowObjects x[29]->11-4001
					 * ACCNUM rowObjects x[35]->NONGLUK USERID CUSNAM2 TAXID
					 * TAXTYP TAXRAT TAXGRP TAXCOND SHIPTO PAYTRM PAYER DISC
					 * BALANCE CHQRCV CRLINE LASIVC REMARK DLVBY TRACKSAL CREBY
					 * CREDAT CHGDAT STATUS INACTDAT
					 */
					ArMas arMas = new ArMas();
					Object[] objectArrays = new Object[rs.getMetaData()
							.getColumnCount()];
					 
					for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
						// 20=java.lang.Integer , 25=java.lang.Double , 26=
						// java.lang.Double , 27=java.lang.Double
						// 28=java.sql.Timestamp , 36 java.sql.Timestamp
						// 33=java.sql.Timestamp , 34=java.sql.Timestamp
					 	/*if(rs.getObject(j)!=null)
						 logger.info("class x[" + j + "]->"+	rs.getMetaData().getColumnName(j) + "-->" + rs.getObject(j).getClass().toString()); 
						*/try {
							objectArrays[j - 1] = rs.getObject(j) != null ? getEncode(rs
									.getObject(j).toString()) : null;
							arMas.setObjectArrays(objectArrays);
							/*
							 * 
							 * class x[1]->class java.lang.String class
							 * x[2]->class java.lang.String class x[4]->class
							 * java.lang.String class x[5]->class
							 * java.lang.String class x[6]->class
							 * java.lang.String class x[9]->class
							 * java.lang.String class x[10]->class
							 * java.lang.String class x[12]->class
							 * java.lang.String class x[18]->class
							 * java.lang.String class x[19]->class
							 * java.lang.String class x[20]->class
							 * java.lang.Integer class x[21]->class
							 * java.lang.String class x[23]->class
							 * java.lang.String class x[25]->class
							 * java.lang.Double class x[26]->class
							 * java.lang.Double class x[27]->class
							 * java.lang.Double class x[28]->class
							 * java.sql.Timestamp class x[29]->class
							 * java.lang.String class x[33]->class
							 * java.lang.String class x[34]->class
							 * java.sql.Timestamp class x[35]->class
							 * java.lang.String class x[36]->class
							 * java.sql.Timestamp
							 */
							/*
							 * if (rs.getObject(j) != null ){ //if
							 * (rs.getObject(j) != null && j!=20 && j!=25 &&
							 * j!=26 && j!=27 && j!=28 && j!=36&& j!=33 &&
							 * j!=34){ //&&
							 * rs.getObject(j).getClass().toString() //
							 * .equals("class java.lang.String")) {
							 * logger.info("class x[" + j + "]->" +
							 * rs.getObject(j).toString());
							 * 
							 * }
							 */
						} catch (Exception e) {
							e.printStackTrace();
						}
					}

					index++;
					index_inner++;
					//logger.info("-------------------------");
					arMasList.add(arMas);
					 // if(index_inner ==1) break;
					 
				}
				if (index_inner != 1000) {
					break;
				}
			}
			//logger.info(index);
			// close the objects
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return arMasList;
	}

	public void synExpress( List<ArMas> arMasList) {

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
		int column_size=COLUMNS.length;
		if (con != null) {
			try {
				for (ArMas arMas : arMasList) {
					Object[] objectArrays=arMas.getObjectArrays();
					query.setLength(0); 
					query.append(" SELECT count(*) as COUNT FROM " + DB_SCHEMA+ ".BPM_ARMAS where CUSCOD='"+objectArrays[0]+"'");
					pst1 = con.prepareStatement(query.toString());
					rs = pst1.executeQuery();
					  while (rs.next()) {
				            int count = rs.getInt("COUNT");
				            query.setLength(0);
				            if(count>0){//update 
				            	query.append("UPDATE  "+ DB_SCHEMA+ ".BPM_ARMAS SET ");
				            	
				            	for (int i = 1; i < column_size; i++) {
				            		//PAYTRM 20  java.lang.Integer 
			        				//BALANCE 25  java.lang.Double
			        				//CHQRCV  26   java.lang.Double
			        				//CRLINE  27   java.lang.Double
				            		/*if(i==3){
				            			query.append(COLUMNS[i]+"="+(objectArrays[i]!=null?("?"):"null")+"");
				            		}else{*/
				            		/*if(i==27)
				            			logger.info(objectArrays[i].getClass());*/
				            		//else{
				            			//if(i!=19 && i!=24 && i!=25 && i!=26 ) 
				            		   if(i!=20 && i!=25 && i!=26 && i!=27 )
				            				query.append(COLUMNS[i]+"="+(objectArrays[i]!=null?("'"+objectArrays[i]+"'"):"null")+"");
				            			else
				            				query.append(COLUMNS[i]+"="+(objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+""); 
				            		//}
				            		if(column_size!=(i+1))
				            			query.append(",");
				            		//}
								}
				            	query.append(" WHERE CUSCOD='"+objectArrays[0]+"'"); 
				            	}else{//insert
				            	query.append("  INSERT INTO  "+ DB_SCHEMA+ ".BPM_ARMAS ( ");
				            	for (int i = 0; i < column_size; i++) { 
				            		query.append(COLUMNS[i]);
				            		if(column_size!=(i+1))
				            			query.append(",");
				            	}
				            	query.append(")VALUES(");
				            	for (int i = 0; i < column_size; i++) { 
				            		/*if(i==3){
				            			query.append("?");
				            		}else{*/
				            			//if(i!=19 && i!=24 && i!=25 && i!=26 )
				            		   if(i!=20 && i!=25 && i!=26 && i!=27 )
				            				query.append((objectArrays[i]!=null?("'"+objectArrays[i]+"'"):"null")+"");
				            			else
				            				query.append((objectArrays[i]!=null?(""+objectArrays[i]+""):"null")+""); 
				            		//}
				            		if(column_size!=(i+1))
				            			query.append(",");
								}
				            	query.append(")"); 
				            }
				            pst1 = con.prepareStatement(query.toString());
				           // pst1.setString(1, (objectArrays[3]!=null?(""+objectArrays[3]+""):"null"));
				          //  logger.info("index["+index+"]->"+query.toString());
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
	 
}
