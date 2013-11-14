package th.co.aoe.imake.pst.backoffice.service.impl;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;

public class FileRead {
	public static void main(String args[])
	  {
	  try{
	  // Open the file that is the first 
	  // command line parameter
	  FileInputStream fstream = new FileInputStream("/usr/local/data/BACK_UP/Work/Server/apache-tomcat-7.0.27/aoe3.txt");
	  // Get the object of DataInputStream
	  DataInputStream in = new DataInputStream(fstream);
	  BufferedReader br = new BufferedReader(new InputStreamReader(in));
	  //String strLine;
	  //Read File Line By Line
	//  String x="";
      handleCharacters(br);
	 /* StringBuffer buString=new StringBuffer();
	  while ((strLine = br.readLine()) != null)   {
	  // Print the content on the console
	 
	  buString.append(strLine);
	  x=x+strLine;
	  }*/
	  //Close the input stream
	 
	  in.close();
	    }catch (Exception e){//Catch exception if any
	     e.printStackTrace();
	  }
	  }

    private static void handleCharacters(BufferedReader reader)
            {
    	try{
        int r;
        StringBuffer buString =new StringBuffer(); 
    
        while ((r = reader.read()) != -1) {
            char ch = (char) r;
            byte bValue = (byte)ch;
         
            if(bValue==11){
            	//ch="้";
            	/*ch=11;
            	byte[] bV=new byte[1];            	
            	bV[0]=bValue;
            	String sss=new String(bV);
            	char[] chars = sss.toCharArray();
                */
            	 
                buString.append("้");
            }else if(bValue==18){ 
            	 buString.append("็");
            }else if(bValue==10 && ch!='ช' && ch!='\n'){ 
           	 buString.append("่");
            	
            }else{
            	 buString.append(ch);
            } 
        } 
      
    	}catch (Exception e) {
			// TODO: handle exception
    		e.printStackTrace();
		}
    }
}
