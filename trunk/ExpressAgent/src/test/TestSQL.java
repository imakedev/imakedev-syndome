package test;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.*;

import org.apache.commons.io.IOUtils;

import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbFile;

public class TestSQL {

  public static void main(String[] args) {
    try {
    	String url = "smb://192.168.10.1/WinXP/ExpressI/SYN2556/ARMAS.DBF";
    	//NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(null, null, null);
    	//SmbFile dir = new SmbFile(url, auth);
    	SmbFile dir = new SmbFile(url);
    	// System.out.println(dir.getInputStream());
    	 byte[] bytes = IOUtils.toByteArray(dir.getInputStream());
    	System.out.println(bytes.length);
    	 FileOutputStream fileOuputStream = 
                 new FileOutputStream("/tmp/DBF/ARMAS.DBF"); 
	    fileOuputStream.write(bytes);
	    fileOuputStream.close();
    	// System.out.println(dir.getInputStream());
    	/* for (SmbFile f : dir.listFiles())
    	{
    	    System.out.println(f.getName());
    	} */ 
    	//java.util.Properties props = new java.util.Properties();
    	 
    	//props.put("extension", ".DFB");       	// file extension is .db
    	//props.put("charset", "CP874");      // file encoding is "ISO-8859-2"
    	 
    	//Connection conn = DriverManager.getConnection("jdbc:jstels:dbf:c:/dbffiles", props);
      // load the driver into memory
      Class.forName("jstels.jdbc.dbf.DBFDriver2");

      // create a connection. The first command line parameter is assumed to
      // be the directory in which the .dbf files are held
      //jdbc:jstels:dbf:cache://smb://your_server/your_share/your_folder
     //  Connection conn = DriverManager.getConnection("jdbc:jstels:dbf:" + "/usr/local/data/Work/PROJECT/IMakeDev/SynDome/Data/DBF");
      Connection conn = DriverManager.getConnection("jdbc:jstels:dbf:" + "/tmp/DBF");
      // \\192.168.10.1\WinXP\ExpressI\SYN2556
      //Connection conn = DriverManager.getConnection("jdbc:jstels:dbf://smb://192.168.10.1/WinXP/Expressl/SYN2556");
      // create a Statement object to execute the query with
      Statement stmt = conn.createStatement();

      // execute a query
      int offset=1000;
      ResultSet rs =null;
      int index=0;
      int i=0;
    //  for (int i = 0; i <= 12; i++) {
	  while(true){
	  int index_inner=0;
      rs =stmt.executeQuery("SELECT * FROM ARMAS limit 1000 offset "+(i*offset));
      i++;
		/*"SELECT  prod.descr AS \"Product\", regs.regionname AS \"Region\", " +
		"minprice, stdprice, FORMATDATETIME(startdate, \'dd " +
		"MMMMM yyyy\' ) AS \"Start Date\", FORMATDATETIME(enddate, \'dd MMMMM yyyy\') " +
		"AS \"End Date\" FROM \"prices.dbf\" ps JOIN \"regions.dbf\" regs ON " +
		"ps.regionid = regs.id JOIN \"products.dbf\" prod ON prod.prodid = ps.prodid " +
		"\nORDER BY \"Product\"");*/

      // read the data and put it to the console
     
      System.out.println(rs.getMetaData().getColumnCount());
      for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
       System.out.print(rs.getMetaData().getColumnName(j) + "\t"); 
      }
     System.exit(1);

      while (rs.next()) {
        for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
        	if(rs.getObject(j)!=null && rs.getObject(j).getClass().toString().equals("class java.lang.String")){
        		//System.out.println(rs.getObject(j).getClass().toString());
        		String s = (String) rs.getObject(j);
        		 byte[] test= s.getBytes("ISO-8859-1");
	   			 String xx=new String(test,"windows-874");
	        	  System.out.println( "rowObjects original["+j+"]->"+s);
	        	  byte[] utf8 =s.getBytes("CP1252");
	        	 // String xx=new String(utf8,"UTF-8");
	        	  String xx2=new String(utf8,"Windows-874");
	        	 // String xx3=new String(utf8,"Windows-1252");
	        	 // byte[] utf8Again = xx2.getBytes("UTF-8");
	        	//  String ii=new String(utf8Again, "Windows-874");
	        	 // System.out.println(new String(ii.getBytes("tis-620"), "utf-8"));
	        	  System.out.println( "rowObjects x["+j+"]->"+xx);
	        	  System.out.println( "rowObjects x["+j+"]->"+xx2);
	        	 // System.out.println( "rowObjects x["+j+"]->"+xx3);
	        	 // System.out.println( "rowObjects x["+j+"]->"+new String(xx.getBytes("Cp838")));
  	   			System.out.println(xx);
        	}
        
        	  //if(rs.getObject(j).getClass().toString())
        	  /*String s = (String) rs.getObject(j);
        	  byte[] test= s.getBytes("ISO-8859-1");
	   			 String xx=new String(test,"windows-874");
	   			System.out.print(xx + "\t");*/
           //System.out.print(rs.getObject(j) + "\t");
        	
        }
        
        index++;
        index_inner++;
        System.out.println("-------------------------");
       } 
       if(index_inner!=1000){
    	  break;
       }
      }
      System.out.println(index);
      // close the objects
      rs.close();
      stmt.close();
      conn.close();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}
