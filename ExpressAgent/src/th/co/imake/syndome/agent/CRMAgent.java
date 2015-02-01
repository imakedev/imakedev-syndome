package th.co.imake.syndome.agent;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;

import th.co.imake.syndome.domain.BpmArma;
import th.co.imake.syndome.domain.ProdRegistration;

public class CRMAgent {
	static Logger logger = Logger.getLogger(CRMAgent.class.getName());
	private static String DB_SCHEMA = "";
	private static String DB_JDBC_URL = "";
	private static String DB_JDBC_DRIVER_CLASS_NAME = "";
	private static String DB_USERNAME = "";
	private static String DB_PASSWORD = "";
	private static String DB_SCHEMA_CRM = "";
	private static String DB_JDBC_URL_CRM = "";
	private static String DB_JDBC_DRIVER_CLASS_NAME_CRM = "";
	private static String DB_USERNAME_CRM = "";
	private static String DB_PASSWORD_CRM = "";
	private static String[] COLUMNS={"CUSCOD","CUSTYP","PRENAM","CUSNAM","ADDR01","ADDR02","ADDR03","ZIPCOD","TELNUM","CONTACT", // 9
									   "CUSNAM2","TAXID","ORGNUM","TAXTYP","TAXRAT","TAXGRP","TAXCOND","SHIPTO","SLMCOD","AREACOD","PAYTRM", // 20
									   "PAYCOND","PAYER","TABPR","DISC","BALANCE","CHQRCV","CRLINE","LASIVC","ACCNUM","REMARK", // 30
									   "DLVBY","TRACKSAL","CREBY","CREDAT","USERID","CHGDAT","STATUS","INACTDAT"}; // 38
	  public static void main(String[] args) {

			// TODO Auto-generated method stub
			 logger.info("############################################# CRMAgent Agent Start #############################################");
			 CRMAgent agent = new CRMAgent();
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
				
				DB_SCHEMA_CRM = prop.getProperty("DB_SCHEMA_CRM",
						"");
				DB_JDBC_URL_CRM = prop.getProperty("DB_JDBC_URL_CRM",
						"");
				DB_JDBC_DRIVER_CLASS_NAME_CRM = prop.getProperty(
						"DB_JDBC_DRIVER_CLASS_NAME_CRM", "com.mysql.jdbc.Driver");
				DB_USERNAME_CRM = prop.getProperty("DB_USERNAME_CRM", "root");
				DB_PASSWORD_CRM = prop.getProperty("DB_PASSWORD_CRM", "");

			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			 
			/*System.out.println("DB_SCHEMA->"+DB_SCHEMA);
			System.out.println("DB_JDBC_URL->"+DB_JDBC_URL);
			System.out.println("DB_USERNAME->"+DB_USERNAME);
			System.out.println("DB_PASSWORD->"+DB_PASSWORD);
			
			System.out.println("DB_SCHEMA_CRM->"+DB_SCHEMA_CRM);
			System.out.println("DB_JDBC_URL_CRM->"+DB_JDBC_URL_CRM);
			System.out.println("DB_USERNAME_CRM->"+DB_USERNAME_CRM);
			System.out.println("DB_PASSWORD_CRM->"+DB_PASSWORD_CRM);*/
			//String fileName="/usr/local/data/Work/PROJECT/IMakeDev/SynDome/Data/140107/DBF";
		   // String fileName="/opt/Agent/Express/DBF";
			List<BpmArma> arMasList = agent.getDataExpress( );
			logger.info("size=" + arMasList.size());
			//System.out.println("size="+arMasList.size());
			 agent.synExpress(arMasList);
			 List<ProdRegistration> prodRegistrationList= agent.getProduct();
			 logger.info("size="+prodRegistrationList.size());
			 agent.synProductRegistration(prodRegistrationList);
			long end = System.currentTimeMillis();
		//	logger.info("used time=" + ((end - start) / 1000d));
			logger.info("Express used time=" + ((end - start) / 1000d));
			 logger.info("############################################# Express Agent End #############################################");
		
	}
	  public List<ProdRegistration> getProduct(){ 

List<ProdRegistration> prodRegistrationList = new ArrayList<ProdRegistration>();
 
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
 
try { 
	// create a Statement object to execute the query with
	Statement stmt = con.createStatement();
	int offset = 1000;
	ResultSet rs = null;
	int index = 0;
	int i = 0;
	// for (int i = 0; i <= 12; i++) {
	while (true) {
		int index_inner = 0;
		rs = stmt.executeQuery(" SELECT   TRIM(concat( ifnull(armas.prenam,''),' ',ifnull(armas.cusnam,''))) as c1, "+
				" so.CUSCOD as c2  "+
				" ,mapping.IMA_ItemID as c3  "+
				" ,product.IMA_ItemName  as c4   "+
				" ,mapping.SERIAL as c5   , "+
				" IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%d/%m/%Y'),'') as c6 ,"+ 
				" so.BSO_IS_WARRANTY as c7,so.BSO_WARRANTY as c8, "+
				" CASE   "+
				" WHEN (so.BSO_IS_DELIVERY='1' and so.BSO_IS_WARRANTY='1')    "+
				" THEN    "+
				" IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'')  "+
				" WHEN (so.BSO_IS_DELIVERY_INSTALLATION='1' and so.BSO_IS_WARRANTY='1' )    "+
				" THEN    "+
				" IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'')  "+
				" WHEN (select so.BSO_IS_INSTALLATION='1' and so.BSO_IS_WARRANTY='1' )    "+
				" THEN    "+ 
				" IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'') "+ 
				" WHEN (select so.BSO_IS_NO_DELIVERY='1'  and so.BSO_IS_WARRANTY='1' ) "+   
				" THEN    "+
				" IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%d/%m/%Y'),'') "+ 
				"  "+
				" ELSE "+ 
				"  '' "+
				" END as c9  , "+  
				" CASE    "+
				" WHEN (select so.BSO_IS_DELIVERY='1' and so.BSO_IS_WARRANTY='1') "+   
				"  THEN    "+
				" IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_DELIVERY_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'') "+  
				" WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')    "+
				"  THEN    "+
				" IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_INSTALLATION_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'') "+  
				" WHEN (select so.BSO_IS_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')    "+
				"  THEN    "+
				" IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_INSTALLATION_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'') "+  
				" WHEN (select so.BSO_IS_NO_DELIVERY='1' and so.BSO_IS_WARRANTY='1')    "+
				" THEN    "+
				" IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_CREATED_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'') "+  
				" ELSE   "+
				"  ''   "+
				" END as c10, "+  
				"  "+
				" so.BSO_TYPE_NO  as c11,ifnull(armas.CONTACT,'') as c12 "+
				" FROM "+DB_SCHEMA+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping "+ 
			//	" left join "+DB_SCHEMA+".BPM_SALE_PRODUCT_ITEM item on mapping.BSO_ID=item.BSO_ID "+
		 "  left join "+DB_SCHEMA+".BPM_SALE_ORDER so on mapping.bso_id =so.bso_id "+
		 "  left join "+DB_SCHEMA+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
		 " left join "+DB_SCHEMA+".BPM_PRODUCT product  on mapping.IMA_ItemID=product.IMA_ItemID "+
		 " where   is_serial ='1'  limit 1000 offset  "
				+ (i * offset));
		i++;
		 
		while (rs.next()) {
		//	  System.out.println("cuscod="+rs);
			ProdRegistration prod = new ProdRegistration();
		/*	Object[] objectArrays = new Object[rs.getMetaData()
					.getColumnCount()]; */
			String accountCode=rs.getString(2); 
			String serialNo=rs.getString(5);  
			String accountName=rs.getString(1); 
			String contactName=rs.getString(12);  
			String model=rs.getString(4);  
			String productItem=rs.getString(3);  
			String registrationDate=rs.getString(6);    
			String salesOrderNo=rs.getString(11);    
			String warrEndDate=rs.getString(10);  
			String warrStartDate=rs.getString(9); 
			String warrantyPeriod=rs.getString(8); 
			String warrantyType=rs.getString(7);   
			prod.setAccountCode(accountCode); 
			prod.setSerialNo (serialNo);  
			prod.setAccountName(accountName); 
			prod.setContactName(contactName);  
			prod.setModel(model);  
			prod.setProductItem(productItem);  
			prod.setRegistrationDate(registrationDate);    
			prod.setSalesOrderNo(salesOrderNo);    
			prod.setWarrEndDate(warrEndDate);  
			prod.setWarrStartDate(warrStartDate); 
			prod.setWarrantyPeriod(warrantyPeriod); 
			prod.setWarrantyType(warrantyType);
				/*for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
				 try {
					objectArrays[j - 1] = rs.getObject(j) != null ? getEncode(rs
							.getObject(j).toString()) : null;
					arMas.setObjectArrays(objectArrays);
					 
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			 */
			index++;
			index_inner++;
			//logger.info("-------------------------");
			prodRegistrationList.add(prod);
			 // if(index_inner ==1) break;
			 
		}
		//System.out.println("index_inner->"+index_inner);
		if (index_inner != 1000) {
			break;
		}
	}
	//logger.info(index);
	// close the objects
	rs.close();
	stmt.close();
	con.close();
} catch (Exception e) {
	e.printStackTrace();
}

return prodRegistrationList;

	  }
	  public List<BpmArma> getDataExpress() {
			List<BpmArma> arMasList = new ArrayList<BpmArma>();
			 
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
			 
			try { 
				// create a Statement object to execute the query with
				Statement stmt = con.createStatement();
				int offset = 1000;
				ResultSet rs = null;
				int index = 0;
				int i = 0;
				// for (int i = 0; i <= 12; i++) {
				while (true) {
					int index_inner = 0;
					rs = stmt.executeQuery("SELECT CUSCOD, "+ // 1
							" TRIM(concat( ifnull(prenam,''),' ',ifnull(cusnam,''))) as c2,"+
							" ifnull(telnum,'') as c3 ,"+
							" ifnull(creby,'') as c4, "+
							" ifnull(CONTACT,'') as c5, "+
						    " TRIM(concat( ifnull(ADDR01,''),' ',ifnull(ADDR02,''),' ',ifnull(ADDR03,''),' ',ifnull(zipcod,''))) as c6 , "+
							" ifnull(status,'') as c7  "+
							  	"  FROM "+DB_SCHEMA+".BPM_ARMAS limit 1000 offset "
							+ (i * offset));
					i++;
					 
					while (rs.next()) {
					//	  System.out.println("cuscod="+rs);
						BpmArma arMas = new BpmArma();
					/*	Object[] objectArrays = new Object[rs.getMetaData()
								.getColumnCount()]; */
						
						    String cuscod=rs.getString(1);
						   // System.out.println("cuscod="+cuscod);
							String name=rs.getString(2);
							String assignedUserName=rs.getString(4);
							String phoneOffice=rs.getString(3);
							String status=rs.getString(7);
							
							// contact
							String contact_first_name=rs.getString(5);
							String contact_phone_mobile=rs.getString(3);
							
							// accountAddress
							String accountAddress=rs.getString(6);
							String accountAddress_contact_name=rs.getString(5);
							String accountAddress_contact_phone=rs.getString(3);
							
							arMas.setCuscod(cuscod);
							arMas.setName(name);
							arMas.setAssignedUserName(assignedUserName);
							arMas.setPhoneOffice(phoneOffice);
							arMas.setStatus(status);
							arMas.setContact_first_name(contact_first_name);
							arMas.setContact_phone_mobile(contact_phone_mobile);
							arMas.setAccountAddress(accountAddress);
							arMas.setAccountAddress_contact_name(accountAddress_contact_name);
							arMas.setAccountAddress_contact_phone(accountAddress_contact_phone);
							/*for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
							 try {
								objectArrays[j - 1] = rs.getObject(j) != null ? getEncode(rs
										.getObject(j).toString()) : null;
								arMas.setObjectArrays(objectArrays);
								 
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						 */
						index++;
						index_inner++;
						//logger.info("-------------------------");
						arMasList.add(arMas);
						 // if(index_inner ==1) break;
						 
					}
					//System.out.println("index_inner->"+index_inner);
					if (index_inner != 1000) {
						break;
					}
				}
				//logger.info(index);
				// close the objects
				rs.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			return arMasList;
		}

		public void synExpress( List<BpmArma> arMasList) { 
			Connection con = null;
			try {
				Class.forName(DB_JDBC_DRIVER_CLASS_NAME_CRM).newInstance();
			} catch (Exception ex) {
				ex.printStackTrace();
			}

			try {
				//System.out.println(DB_JDBC_URL_CRM+","+DB_USERNAME_CRM+","+DB_PASSWORD_CRM);
				con = DriverManager.getConnection(DB_JDBC_URL_CRM, DB_USERNAME_CRM,
						DB_PASSWORD_CRM);
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
				//try {
					for (BpmArma arMas : arMasList) {
						/*String cuscod=getEncode(arMas.getCuscod());
						String name=getEncode(arMas.getName());
						String assigned_user_name=getEncode(arMas.getAssignedUserName());
						String phone_office=getEncode(arMas.getPhoneOffice());
						String status=getEncode(arMas.getStatus());*/
						 // account
						String cuscod=(arMas.getCuscod());
						String name= getEncode(arMas.getName());
						String assigned_user_name= getEncode(arMas.getAssignedUserName());
						String phone_office= (arMas.getPhoneOffice());
						String status= (arMas.getStatus()); 
						  
						// contact
						String contact_first_name= getEncode(arMas.getContact_first_name());
						String contact_phone_mobile= getEncode(arMas.getContact_phone_mobile());
						
						// accountAddress
						String accountAddress= getEncode(arMas.getAccountAddress());
						String accountAddress_contact_name= getEncode(arMas.getAccountAddress_contact_name());
						String accountAddress_contact_phone= getEncode(arMas.getAccountAddress_contact_phone());
						
						//setAccountValue
						query.setLength(0); 
						query.append(" SELECT count(*) as COUNT FROM " + DB_SCHEMA_CRM+ ".ACCOUNT where account_code='"+cuscod+"'");
						// System.out.println(query.toString());
						try{
						pst1 = con.prepareStatement(query.toString());
						rs = pst1.executeQuery();
						  while (rs.next()) {
					            int count = rs.getInt("COUNT");
					            query.setLength(0);
					            if(count>0){//update  
					            	query.append("UPDATE  "+ DB_SCHEMA_CRM+ ".ACCOUNT SET ");
					            	query.append("name_en ='"+ name+ "' , ");
					            	query.append("name_th ='"+name+ "' , ");
					            	query.append("assigned_user_name ='"+ assigned_user_name+ "' , ");
					            	query.append("phone_office ='"+ phone_office+ "' , ");
					            	query.append("status ='"+ ((status.equals("A"))?"Active":"")+"' ");  
					            	query.append(" WHERE account_code='"+cuscod+"'"); 
					            	}else{//insert
					            	query.append("  INSERT INTO  "+ DB_SCHEMA_CRM+ ".ACCOUNT ( ");
					            	query.append("account_code,name_en ,name_th,assigned_user_name,phone_office,status ) VALUES ( ");  
					            	query.append("'"+cuscod+"' , ");
					            	query.append("'"+name+ "' , ");
					            	query.append("'"+name+ "' , ");
					            	query.append("'"+ assigned_user_name+ "' , ");
					            	query.append("'"+ phone_office+ "' , ");
					            	query.append("'"+ ((status.equals("A"))?"Active":"")+"' ) ");
					            }
					            //System.out.println(query.toString());
					            pst1 = con.prepareStatement(query.toString()); 
					            pst1.executeUpdate();
					          
					           
					        }
						}  catch (SQLException e) {
							e.printStackTrace();
						}
						 
						//setContact 
						query.setLength(0); 
						query.append(" SELECT count(*) as COUNT FROM " + DB_SCHEMA_CRM+ ".CONTACT where contact_code='"+cuscod+"'");
						// System.out.println(query.toString());
						try{
						pst1 = con.prepareStatement(query.toString());
						rs = pst1.executeQuery();
						  while (rs.next()) {
					            int count = rs.getInt("COUNT");
					            query.setLength(0);
					            if(count>0){//update  
					            	query.append("UPDATE  "+ DB_SCHEMA_CRM+ ".CONTACT SET ");
					            	query.append("first_name ='"+ contact_first_name+ "' , ");
					            	query.append("phone_mobile ='"+contact_phone_mobile+ "'  "); 
					            	query.append(" WHERE contact_code='"+cuscod+"'"); 
					            	}else{//insert
					            	query.append("  INSERT INTO  "+ DB_SCHEMA_CRM+ ".CONTACT ( ");
					            	query.append("contact_code,first_name ,phone_mobile ) VALUES ( ");  
					            	query.append("'"+cuscod+"' , ");
					            	query.append("'"+contact_first_name+ "' , ");
					            	query.append("'"+contact_phone_mobile+ "' ) "); 
					            }
					            //System.out.println(query.toString());
					            pst1 = con.prepareStatement(query.toString()); 
					            pst1.executeUpdate();
					          
					           
					        }
						}  catch (SQLException e) {
							e.printStackTrace();
						}
						
						//setAccountAddress
						 
						query.setLength(0); 
						query.append(" SELECT count(*) as COUNT FROM " + DB_SCHEMA_CRM+ ".ACCOUNT_ADDRESS where address_code='"+cuscod+"'");
						// System.out.println(query.toString());
						try{
						pst1 = con.prepareStatement(query.toString());
						rs = pst1.executeQuery();
						  while (rs.next()) {
					            int count = rs.getInt("COUNT");
					            query.setLength(0);
					            if(count>0){//update  
					            	query.append("UPDATE  "+ DB_SCHEMA_CRM+ ".ACCOUNT_ADDRESS SET "); 
					            	query.append("account_name ='"+ name+ "' , ");
					            	query.append("primary_address ='"+ accountAddress+ "' , ");
					            	query.append("contact_name ='"+accountAddress_contact_name+ "' , "); 
					            	query.append("contact_phone ='"+accountAddress_contact_phone+ "'  "); 
					            	query.append(" WHERE address_code='"+cuscod+"'"); 
					            	}else{//insert
					            	query.append("  INSERT INTO  "+ DB_SCHEMA_CRM+ ".ACCOUNT_ADDRESS ( ");
					            	query.append("address_code,account_name ,primary_address,contact_name ,contact_phone) VALUES ( ");  
					            	query.append("'"+cuscod+"' , ");
					            	query.append("'"+name+ "' , ");
					            	query.append("'"+accountAddress+ "' , "); 
					            	query.append("'"+accountAddress_contact_name+ "'  ,"); 
					            	query.append("'"+accountAddress_contact_phone+ "')  "); 
					            }
					            //System.out.println(query.toString());
					            pst1 = con.prepareStatement(query.toString()); 
					            pst1.executeUpdate();
					          
					           
					        }
					      
						}  catch (SQLException e) {
							e.printStackTrace();
						}  
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
			/*	} catch (SQLException e) {
					e.printStackTrace();
				}*/
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
		public void synProductRegistration( List<ProdRegistration> prodRegistrationList) { 
			Connection con = null;
			try {
				Class.forName(DB_JDBC_DRIVER_CLASS_NAME_CRM).newInstance();
			} catch (Exception ex) {
				ex.printStackTrace();
			}

			try {
				con = DriverManager.getConnection(DB_JDBC_URL_CRM, DB_USERNAME_CRM,
						DB_PASSWORD_CRM);
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
				//try {
					for (ProdRegistration prod : prodRegistrationList) {
						/*String cuscod=getEncode(arMas.getCuscod());
						String name=getEncode(arMas.getName());
						String assigned_user_name=getEncode(arMas.getAssignedUserName());
						String phone_office=getEncode(arMas.getPhoneOffice());
						String status=getEncode(arMas.getStatus());*/
						 // account 
						String serialNo= getEncode(prod.getSerialNo());
						String accountCode=(prod.getAccountCode());
						
						String accountName=prod.getAccountName(); 
						String contactName=prod.getContactName();
						String model=prod.getModel();
						String productItem=prod.getProductItem(); 
						String registrationDate=prod.getRegistrationDate();  
						String salesOrderNo=prod.getSalesOrderNo();    
						String warrEndDate=prod.getWarrEndDate(); 
						String warrStartDate=prod.getWarrStartDate();
						String warrantyPeriod=prod.getWarrantyPeriod();
						String warrantyType=prod.getWarrantyType();  
						/*prod.setAccountCode(accountCode); 
						prod.setSerialNo (serialNo);  
						prod.setAccountName(accountName); 
						prod.setContactName(contactName);  
						prod.setModel(model);  
						prod.setProductItem(productItem);  
						prod.setRegistrationDate(registrationDate);    
						prod.setSalesOrderNo(salesOrderNo);    
						prod.setWarrEndDate(warrEndDate);  
						prod.setWarrStartDate(warrStartDate); 
						prod.setWarrantyPeriod(warrantyPeriod); 
						prod.setWarrantyType(warrantyType);*/ 
 
						 
					
						//setAccountValue
						query.setLength(0); 
						query.append(" SELECT count(*) as COUNT FROM " + DB_SCHEMA_CRM+ ".PROD_REGISTRATION where account_code='"+accountCode+"' "
								+ "and serial_no='"+serialNo+"'");
						// System.out.println(query.toString());
						try{
						pst1 = con.prepareStatement(query.toString());
						rs = pst1.executeQuery();
						  while (rs.next()) {
					            int count = rs.getInt("COUNT");
					            query.setLength(0);
					            if(count>0){//update  
					            	query.append("UPDATE  "+ DB_SCHEMA_CRM+ ".PROD_REGISTRATION SET ");
					            	query.append("account_name ='"+ accountName+ "' , ");
					            	query.append("contact_name ='"+contactName+ "' , ");
					            	query.append("model ='"+ model+ "' , ");
					            	query.append("product_item ='"+ productItem+ "' , ");
					            	if(registrationDate.length()>0){
					            		String[] registrationDates=registrationDate.split("/");
					            		query.append("registration_date ='"+ registrationDates[2]+ "-"+registrationDates[1]+"-"+registrationDates[0]+" 00:00:00' , ");
					            	} 
					            	query.append("sales_order_no ='"+ salesOrderNo+ "' , ");
					            	if(warrEndDate.length()>0){
					            		String[] warrEndDates=warrEndDate.split("/");
					            		query.append("warr_end_date ='"+ warrEndDates[2]+ "-"+warrEndDates[1]+"-"+warrEndDates[0]+" 00:00:00' , ");
					            	}
					            	if(warrStartDate.length()>0){
					            		String[] warrStartDates=warrStartDate.split("/");
					            		query.append("warr_start_date ='"+ warrStartDates[2]+ "-"+warrStartDates[1]+"-"+warrStartDates[0]+" 00:00:00' , ");
					            	} 
					            	query.append("warranty_period ='"+ warrantyPeriod+ "' , ");
					            	query.append("warranty_type ='"+ warrantyType+ "'  ");
					            	query.append(" WHERE account_code='"+accountCode+"' and serial_no='"+serialNo+"'");
					            	}else{//insert
					            	query.append("  INSERT INTO  "+ DB_SCHEMA_CRM+ ".PROD_REGISTRATION ( ");
					            	query.append("account_code,serial_no ,account_name,contact_name,model,product_item,registration_date,sales_order_no,"
					            			+ "warr_end_date,warr_start_date ,warranty_period,warranty_type) VALUES ( ");  
					            	query.append("'"+accountCode+"' , ");
					            	query.append("'"+serialNo+ "' , ");
					            	query.append("'"+accountName+ "' , ");
					            	query.append("'"+ contactName+ "' , ");
					            	query.append("'"+ model+ "' , ");
					            	query.append("'"+ productItem+ "' , ");
					            	if(registrationDate.length()>0){
					            		String[] registrationDates=registrationDate.split("/");
					            		query.append("'"+ registrationDates[2]+ "-"+registrationDates[1]+"-"+registrationDates[0]+" 00:00:00' , ");
					            	}  
					            	query.append("'"+ salesOrderNo+ "' , ");
					            
					            	if(warrEndDate.length()>0){
					            		String[] warrEndDates=warrEndDate.split("/");
					            		query.append("'"+ warrEndDates[2]+ "-"+warrEndDates[1]+"-"+warrEndDates[0]+" 00:00:00' , ");
					            	}else{
					            		query.append("null , ");
					            	}
					            	if(warrStartDate.length()>0){
					            		String[] warrStartDates=warrStartDate.split("/");
					            		query.append("'"+ warrStartDates[2]+ "-"+warrStartDates[1]+"-"+warrStartDates[0]+" 00:00:00' , ");
					            	} else{
					            		query.append("null , ");
					            	}
					            	query.append("'"+ warrantyPeriod+ "' , ");
					            	query.append("'"+ warrantyType+ "' )  "); 
					            }
					            //System.out.println(query.toString());
					            pst1 = con.prepareStatement(query.toString()); 
					            pst1.executeUpdate();
					          
					           
					        }
						}  catch (SQLException e) {
							e.printStackTrace();
						}
						
						 
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
			/*	} catch (SQLException e) {
					e.printStackTrace();
				}*/
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
				// encoded=fromStr.getBytes("CP1252");
				encoded=fromStr.getBytes("utf-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String returnStr=null;
			try {
				//returnStr = new String(encoded, "windows-874");
				returnStr = new String(encoded, "utf-8");
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
