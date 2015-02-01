package test;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import th.co.imake.syndome.domain.Stock;

public class PoiTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		PoiTest agent=new PoiTest();
		  try {
			Map<String,Stock>  stockMap=agent.getERP(new FileInputStream("/Users/imake/Desktop/ARMAS.DBF"), false);
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
				int columns_size=0;//COLUMNS.length; 
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
							 
							
							/*logger.info("locQty_read 1=>"+locQty_read);
							logger.info("locQty_read 2=>"+cell.getNumericCellValue());
							logger.info("locQty_read 3=>"+format.format(cell.getNumericCellValue()));
							cell=row.getCell(14);
							logger.info("locQty_read 4=>"+format.format(cell.getNumericCellValue()));*/
							//String key=ima_itemID+"_"+locationName;
							String key=ima_itemID;
							Object[] objectArrays=new Object[columns_size]; 
							//logger.info(key);
						 
							 
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
}
