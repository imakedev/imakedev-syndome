package th.co.aoe.imake.pst.backoffice.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import th.co.aoe.imake.pst.backoffice.service.PSTService;

@Controller
@RequestMapping(value = { "/report" })
public class ReportController {
	@Autowired
	private PSTService pstService;
	private static SimpleDateFormat format = new SimpleDateFormat("MMM_yyyy");

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
	private static final String SCHEMA = bundle.getString("schema");

	@RequestMapping(value = { "/init" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String eptNormReport(Model model) {
		// return "exam/template/empty";
		return "backoffice/template/empty";
	}

	@RequestMapping(value = { "/page/{pagename}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String page(Model model, @PathVariable String pagename) {
		return "backoffice/template/" + pagename;
	}

	// @SuppressWarnings({ "deprecation", "unchecked" })
	@RequestMapping(value = { "/export_report1" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		String time_from = request.getParameter("from");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();

		// src=src+"?from="+time_from_array+"&to="+time_to_array;

		// String time_to=request.getParameter("to");
		// String[] time_from_array=time_from.split("_");
		// String[] time_to_array=time_to.split("_");
		String from_sql = year + "-" + month + "-" + day_from + " 00:00:00";
		String to_sql = year + "-" + month + "-" + day_to + " 23:59:59";
		// 2013-05-01 00:00:00
		StringBuffer query = new StringBuffer();
		StringBuffer query_inner = new StringBuffer();
		StringBuffer query_inner_sum = new StringBuffer();
		query.append(" SELECT status.pes_id,status.pes_name FROM " + SCHEMA
				+ ".PST_EMPLOYEE_STATUS status order by status.pes_id");
		// String query1=

		HSSFWorkbook wb = new HSSFWorkbook();
		// HSSFSheet sheet =
		// wb.createSheet(time_from_array[0]+"/"+" ถึง "+time_to+"สรุปบันทึกการขาด ลา มาสาย พนง.");
		// / HSSFSheet sheet =
		// wb.createSheet(time_from_array[0]+"-"+time_from_array[1]+"-"+time_from_array[2]+" ถึง "+time_to_array[0]+"-"+time_to_array[1]+"-"+time_to_array[2]);
		HSSFSheet sheet = wb.createSheet("ค่าแรงพนักงานรายวัน");

		// HSSFRow row = sheet.createRow(0);
		// HSSFCellStyle style = wb.createCellStyle();
		String[] label = { "รหัสประจำตัว", "เบอร์รถ", "ชื่อ-สกุล", "ตำแหน่ง",
				"ค่าแรง/วัน" };
		int indexRow = 2;
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle2 = wb.createCellStyle();
		HSSFCellStyle cellStyle3 = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
				.getIndex());
		cellStyle.setWrapText(true);

		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);

		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				2, // first column (0-based)
				10 // last column (0-based)
		));
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(2);
		// cell = row.createCell(2);
		// cell.setCellValue("ค่าแรงพนักงานรายวัน  ประจำเดือน _____________________");
		cell.setCellValue("ค่าแรงพนักงานรายวัน  ประจำเดือน "
				+ dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);
		cell = row.createCell(10);
		cell.setCellStyle(cellStyle);
		row = sheet.createRow(indexRow);
		int index = 0;
		// Header 5
		/*
		 * HSSFRow row = sheet.createRow(indexRow); HSSFCell cell =
		 * row.createCell(0); int index=0; รหัสประจำตัว เบอร์รถ
		 */
		for (int i = 0; i < label.length; i++) {
			cell = row.createCell(index++);
			cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle);
		}

		/*
		 * cell = row.createCell(index++); cell.setCellValue("ชื่อ-สกุล");
		 * cell.setCellStyle(cellStyle); cell = row.createCell(index++);
		 * cell.setCellValue("ตำแหน่ง"); cell.setCellStyle(cellStyle);
		 */
		List<Object[]> status = pstService.searchObject(query.toString());
		int status_size = status.size();
		for (Object[] objects : status) {
			cell = row.createCell(index++);
			cell.setCellValue((String) objects[1]);
			cell.setCellStyle(cellStyle);
			query_inner
					.append("   (select count(*) FROM "
							+ SCHEMA
							+ ".PST_EMPLOYEE_WORK_MAPPING mapping"
							+ "    where mapping.pe_id=emp.pe_id and mapping.pes_id in("
							+ (Integer) objects[0] + ")"
							+ "   and mapping.pewm_date_time between '"
							+ from_sql + "' and '" + to_sql + "' ) as work_"
							+ (Integer) objects[0] + " , ");
			query_inner_sum
					.append(" ,  (select  (pst_status.pes_wage_rate*(count(*))) FROM "
							+ SCHEMA
							+ ".PST_EMPLOYEE_WORK_MAPPING mapping"
							+ "   left join  "
							+ SCHEMA
							+ ".PST_EMPLOYEE_STATUS pst_status on (mapping.pes_id=pst_status.pes_id) "
							+ " where mapping.pe_id=emp.pe_id and mapping.pes_id in("
							+ (Integer) objects[0]
							+ ")"
							+ "   and mapping.pewm_date_time between '"
							+ from_sql
							+ "' and '"
							+ to_sql
							+ "' ) as work_sum_" + (Integer) objects[0] + "  ");
		}
		cell = row.createCell(index++);
		cell.setCellValue("วันทำงานสะสม");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(index++);
		cell.setCellValue("ค่าแรง(บาท)");
		cell.setCellStyle(cellStyle);
		indexRow++;

		for (int i = 0; i < index; i++) {
			if (i == 2 || i == 3)
				sheet.setColumnWidth(i, (short) ((50 * 8) / ((double) 1 / 20)));
			else
				sheet.setColumnWidth(i, (short) ((20 * 8) / ((double) 1 / 20)));
		}
		query.setLength(0);
		query.append(" SELECT status.pes_id,status.pes_name FROM " + SCHEMA
				+ ".PST_EMPLOYEE_STATUS status where status.pes_wage_rate>0");

		List<Object[]> work_days = pstService.searchObject(query.toString());
		StringBuffer status_in = new StringBuffer();
		int work_days_size = work_days.size();
		for (int i = 0; i < work_days_size; i++) {
			if (i != (work_days_size - 1))
				status_in.append((Integer) work_days.get(i)[0] + ",");
			else
				status_in.append((Integer) work_days.get(i)[0] + "");
		}
		query_inner.append("   (select count(*) FROM " + SCHEMA
				+ ".PST_EMPLOYEE_WORK_MAPPING mapping"
				+ "    where mapping.pe_id=emp.pe_id and mapping.pes_id in("
				+ status_in + ")" + "   and mapping.pewm_date_time between '"
				+ from_sql + "' and '" + to_sql + "' ) as work_all , ");
		query.setLength(0);
		query.append("SELECT "
				+ query_inner.toString()
				+ " "
				+ " emp.pe_uid, pump.prp_no, emp.pe_first_name,emp.pe_last_name,pos.pp_name,emp.pe_wage,IFNULL(title.PT_NAME,'') "
				+ query_inner_sum.toString() + " from " + SCHEMA
				+ ".PST_EMPLOYEE emp left join  " + SCHEMA
				+ ".PST_POSITION pos" + " on emp.pp_id=pos.pp_id left join  "
				+ SCHEMA + ".PST_ROAD_PUMP pump"
				+ " on emp.prp_id=pump.prp_id  " + " left join " + SCHEMA
				+ ".PST_TITLE title on emp.PT_ID=title.PT_ID ");

		/*
		 * SELECT (select count(*) FROM PST_DB2.PST_EMPLOYEE_WORK_MAPPING
		 * mapping where mapping.pe_id=emp.pe_id and mapping.pes_id in(1,2) and
		 * mapping.pewm_date_time between '2013-05-01 00:00:00' and '2013-05-31
		 * 00:00:00' ) as work_normal, (select count(*) FROM
		 * PST_DB2.PST_EMPLOYEE_WORK_MAPPING mapping where
		 * mapping.pe_id=emp.pe_id and mapping.pes_id in(2) and
		 * mapping.pewm_date_time between '2013-05-01 00:00:00' and '2013-05-31
		 * 00:00:00' ) as work_special, (select count(*) FROM
		 * PST_DB2.PST_EMPLOYEE_WORK_MAPPING mapping where
		 * mapping.pe_id=emp.pe_id and mapping.pes_id in(3,4,5,6) and
		 * mapping.pewm_date_time between '2013-05-01 00:00:00' and '2013-05-31
		 * 00:00:00' ) as work_leave , emp.* from PST_DB2.PST_EMPLOYEE emp
		 */
		List<Object[]> emps = pstService.searchObject(query.toString());
		int rowIndex = 1;
		int emps_size = emps.size();
		for (int i = 0; i < emps_size; i++) {
			// for(status_size)
			row = sheet.createRow(indexRow);
			indexRow++;
			index = 0;
			cell = row.createCell(index++);
			cell.setCellValue((String) emps.get(i)[status_size + 1]);
			cell.setCellStyle(cellStyle3);

			cell = row.createCell(index++);
			cell.setCellValue((String) emps.get(i)[status_size + 2]);
			cell.setCellStyle(cellStyle3);

			cell = row.createCell(index++);
			cell.setCellValue((rowIndex++) + ". "
					+ (String) emps.get(i)[status_size + 7] + " "
					+ (String) emps.get(i)[status_size + 3] + " "
					+ (String) emps.get(i)[status_size + 4]);
			cell.setCellStyle(cellStyle3);

			cell = row.createCell(index++);
			cell.setCellValue((String) emps.get(i)[status_size + 5]);
			cell.setCellStyle(cellStyle3);

			cell = row.createCell(index++);
			cell.setCellValue(((java.math.BigDecimal) emps.get(i)[status_size + 6])
					.intValue());
			cell.setCellStyle(cellStyle3);
			int sum = 0;
			for (int j = 0; j < status_size; j++) {
				cell = row.createCell(index++);
				// cell.setCellValue((java.math.BigInteger)emps.get(i)[j]+"");
				cell.setCellValue(((java.math.BigInteger) emps.get(i)[j])
						.intValue());
				if (emps.get(i)[j + status_size + 8] != null)
					sum = sum
							+ ((java.math.BigInteger) emps.get(i)[j
									+ status_size + 8]).intValue();
				cell.setCellStyle(cellStyle3);
			}
			cell = row.createCell(index++);
			cell.setCellValue((java.math.BigInteger) emps.get(i)[status_size]
					+ "");
			cell.setCellStyle(cellStyle3);

			sum = sum
					* ((java.math.BigDecimal) emps.get(i)[status_size + 6])
							.intValue();
			cell = row.createCell(index++);
			cell.setCellValue(sum);
			cell.setCellStyle(cellStyle3);
		}
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "ค่าแรง.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/export_report2" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export2(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		String time_from = request.getParameter("from");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		// src=src+"?from="+time_from_array+"&to="+time_to_array;

		// String time_to=request.getParameter("to");
		// String[] time_from_array=time_from.split("_");
		// String[] time_to_array=time_to.split("_");
		String from_sql = year + "-" + month + "-" + day_from + " 00:00:00";
		String to_sql = year + "-" + month + "-" + day_to + " 23:59:59";
		// 2013-05-01 00:00:00
		StringBuffer query = new StringBuffer();
		StringBuffer query_inner = new StringBuffer();
		// StringBuffer query_inner_sum=new StringBuffer();
		query.append(" SELECT pump.prp_id,pump.prp_no FROM " + SCHEMA
				+ ".PST_ROAD_PUMP pump order by pump.prp_no");
		// String query1=

		HSSFWorkbook wb = new HSSFWorkbook();
		// HSSFSheet sheet =
		// wb.createSheet(time_from_array[0]+"/"+" ถึง "+time_to+"สรุปบันทึกการขาด ลา มาสาย พนง.");
		// / HSSFSheet sheet =
		// wb.createSheet(time_from_array[0]+"-"+time_from_array[1]+"-"+time_from_array[2]+" ถึง "+time_to_array[0]+"-"+time_to_array[1]+"-"+time_to_array[2]);
		HSSFSheet sheet = wb.createSheet("ค่าคิวพนักงานรายวัน");

		// HSSFRow row = sheet.createRow(0);
		// HSSFCellStyle style = wb.createCellStyle();
		String[] label = { "รหัสประจำตัว", "ชื่อ-สกุล" };
		int indexRow = 2;
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

		cellStyle.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
				.getIndex());
		cellStyle.setWrapText(true);

		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);
		cellStyle3.setDataFormat(dataFormat.getFormat("#,##0.##"));
		// cellStyle3.setDataFormat(dataFormat.getFormat("#,##0.00"));

		cellStyle4.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setWrapText(true);
		cellStyle4.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle4.setFillPattern(CellStyle.SOLID_FOREGROUND);

		cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.##"));
		// cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.00"));
		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				2, // first column (0-based)
				10 // last column (0-based)
		));
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(2);
		// cell = row.createCell(2);
		// cell.setCellValue("ค่าแรงพนักงานรายวัน  ประจำเดือน _____________________");
		cell.setCellValue("ค่าคิวพนักงานรายวัน  ประจำเดือน "
				+ dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);
		cell = row.createCell(10);
		cell.setCellStyle(cellStyle);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
		row = sheet.createRow(indexRow);
		int index = 0;
		for (int i = 0; i < label.length; i++) {
			cell = row.createCell(index++);
			cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle);
		}
		List<Object[]> status = pstService.searchObject(query.toString());
		int status_size = status.size();
		for (Object[] objects : status) {
			cell = row.createCell(index++);
			cell.setCellValue((String) objects[1]);
			cell.setCellStyle(cellStyle);
			query_inner
					.append(" , IFNULL((SELECT sum(j_emp.pje_amount) FROM "
							+ SCHEMA
							+ ".PST_JOB_EMPLOYEE j_emp left join "
							+ " "
							+ SCHEMA
							+ ".PST_JOB job on j_emp.pj_id=job.pj_id where j_emp.pe_id=emp.pe_id  "
							+ "and job.pj_created_time between '" + from_sql
							+ "' and '" + to_sql + "' and j_emp.prp_id="
							+ (Integer) objects[0] + "),0) " + " as pst_"
							+ (Integer) objects[0] + " ");
		}
		query_inner
				.append(" , (SELECT sum(j_emp.pje_amount) FROM "
						+ SCHEMA
						+ ".PST_JOB_EMPLOYEE j_emp left join "
						+ " "
						+ SCHEMA
						+ ".PST_JOB job on j_emp.pj_id=job.pj_id where j_emp.pe_id=emp.pe_id "
						+ " and job.pj_created_time between '" + from_sql
						+ "' and '" + to_sql + "' ) as pst_sum");
		cell = row.createCell(index++);
		cell.setCellValue("รวม (บาท)");
		cell.setCellStyle(cellStyle);
		indexRow++;

		for (int i = 0; i < index; i++) {
			if (i == 1)
				sheet.setColumnWidth(i, (short) ((50 * 8) / ((double) 1 / 20)));
			else
				sheet.setColumnWidth(i, (short) ((20 * 8) / ((double) 1 / 20)));
		}
		//
		query.setLength(0);
		query.append("SELECT emp.pe_uid,emp.pe_first_name,emp.pe_last_name ,IFNULL(title.PT_NAME ,'') "
				+ query_inner.toString()
				+ " "
				+ " FROM "
				+ SCHEMA
				+ ".PST_EMPLOYEE emp "
				+ " left join  "
				+ SCHEMA
				+ ".PST_TITLE title  on emp.PT_ID=title.PT_ID "
				+ " order by emp.pe_uid  ");
		// System.out.println("sql 1->"+query.toString());
		List<Object[]> emps = pstService.searchObject(query.toString());
		int rowIndex = 1;
		int emps_size = emps.size();
		for (int i = 0; i < emps_size; i++) {
			// for(status_size)
			row = sheet.createRow(indexRow);
			indexRow++;
			index = 0;
			cell = row.createCell(index++);
			cell.setCellValue((String) emps.get(i)[0]);
			cell.setCellStyle(cellStyle3);

			cell = row.createCell(index++);
			cell.setCellValue((rowIndex++) + ". " + (String) emps.get(i)[3]
					+ " " + (String) emps.get(i)[1] + " "
					+ (String) emps.get(i)[2]);
			cell.setCellStyle(cellStyle3);
			for (int j = 0; j < status_size; j++) {
				cell = row.createCell(index++);
				cell.setCellValue(((java.math.BigDecimal) emps.get(i)[j + 4])
						.doubleValue());
				cell.setCellStyle(cellStyle3);
			}
			cell = row.createCell(index++);
			if (emps.get(i) != null && emps.get(i)[status_size + 4] != null)
				cell.setCellValue(((java.math.BigDecimal) emps.get(i)[status_size + 4])
						.doubleValue());
			else
				cell.setCellValue(0);
			cell.setCellStyle(cellStyle4);
		}
		query.setLength(0);
		query.append("	SELECT (SELECT IFNULL(sum(j_emp.pje_amount),0) FROM "
				+ SCHEMA
				+ ".PST_JOB_EMPLOYEE j_emp left join "
				+ " "
				+ SCHEMA
				+ ".PST_JOB job on j_emp.pj_id=job.pj_id where j_emp.prp_id=pump.prp_id and "
				+ " job.pj_created_time between '" + from_sql + "' and '"
				+ to_sql + "' ) as pst_1,pump.prp_no " + " FROM " + SCHEMA
				+ ".PST_ROAD_PUMP  pump order by pump.prp_no " + " ");
		emps = pstService.searchObject(query.toString());
		// int rowIndex=1;
		row = sheet.createRow(indexRow);
		indexRow++;
		emps_size = emps.size();
		index = 1;
		cellStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		cell = row.createCell(index++);
		cell.setCellValue("รวม (บาท)");
		cell.setCellStyle(cellStyle);
		for (int i = 0; i < emps_size; i++) {
			cell = row.createCell(index++);
			cell.setCellValue(((java.math.BigDecimal) emps.get(i)[0])
					.doubleValue());
			cell.setCellStyle(cellStyle4);
		}
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "ค่าคิว.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/export_report3" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export3(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		String time_from = request.getParameter("from");
		String prpId = request.getParameter("prpId");

		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		String from_sql = year + "-" + month + "-" + day_from + " 00:00:00";
		String to_sql = year + "-" + month + "-" + day_to + " 23:59:59";
		StringBuffer query = new StringBuffer();
		/*
		 * StringBuffer query_inner=new StringBuffer(); StringBuffer
		 * query_inner_sum=new StringBuffer();
		 */
		query.append("SELECT prp_id , prp_no FROM " + SCHEMA
				+ ".PST_ROAD_PUMP where prp_id=" + prpId);
		List<Object[]> road_pump = pstService.searchObject(query.toString());
		String prpNo = "";
		int road_pump_size = road_pump.size();
		for (int i = 0; i < road_pump_size; i++)
			prpNo = road_pump.get(i)[1] != null ? (String) road_pump.get(i)[1]
					: "";

		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("เบอร์รถ " + prpNo);
		DataFormat dataFormat = wb.createDataFormat();
		String[] label = { "วันที่", "ชื่อลูกค้า", "หน่วยงาน", "ปูนที่ใช้",
				"จำนวน(คิว)", "ต่อท่อ(เมตร)", "สาเหตุการ Break Down",
				"จำนวนปูน Spoil" };
		int indexRow = 2;
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle2 = wb.createCellStyle();
		HSSFCellStyle cellStyle3 = wb.createCellStyle();
		HSSFCellStyle cellStyle_text = wb.createCellStyle();
		HSSFCellStyle cellStyle_number = wb.createCellStyle();

		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
				.getIndex());
		cellStyle.setWrapText(true);

		cellStyle_text.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle_text.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_text.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_text.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_text.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_text.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_text.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
				.getIndex());
		cellStyle_text.setWrapText(true);

		cellStyle_number.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle_number.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_number.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_number.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_number.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_number.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_number.setFillBackgroundColor(new HSSFColor.GREY_25_PERCENT()
				.getIndex());
		cellStyle_number.setWrapText(true);
		cellStyle_number.setDataFormat(dataFormat.getFormat("#,##0.##"));
		// cellStyle_number.setDataFormat(dataFormat.getFormat("#,##0.00"));

		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);

		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				1, // first column (0-based)
				6 // last column (0-based)
		));
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(1);
		cell.setCellValue("รายงานการออกงานประจำวัน ของรถเบอร์ " + prpNo
				+ " ของเดือน " + dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);
		cell = row.createCell(6);
		cell.setCellStyle(cellStyle);
		row = sheet.createRow(indexRow++);
		int index = 0;
		// Header 5
		/*
		 * HSSFRow row = sheet.createRow(indexRow); HSSFCell cell =
		 * row.createCell(0); int index=0; รหัสประจำตัว เบอร์รถ
		 */
		for (int i = 0; i < label.length; i++) {
			cell = row.createCell(index++);
			cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle);
		}

		/*
		 * cell = row.createCell(index++); cell.setCellValue("ชื่อ-สกุล");
		 * cell.setCellStyle(cellStyle); cell = row.createCell(index++);
		 * cell.setCellValue("ตำแหน่ง"); cell.setCellStyle(cellStyle);
		 */
		query.setLength(0);
		query.append("SELECT "
				+
				// " job.pj_created_time," +
				"IFNULL(DATE_FORMAT(job.pj_created_time,'%d'),''),"
				+ " job.pj_customer_name,	job.pj_customer_department,"
				+ " 	concrete.pconcrete_name, 	"
				+
				// "job.pj_cubic_amount," +
				"j_work.pjw_cubic_amount,j_work.pjw_tube , "
				+ "b_down.pbd_name,j_work.pjw_concrete_spoil "
				+ " FROM "
				+ SCHEMA
				+ ".PST_JOB_WORK j_work 	 left join "
				+ SCHEMA
				+ ".PST_JOB job on j_work.pj_id=job.pj_id"
				+ " 	 left join "
				+ SCHEMA
				+ ".PST_CONCRETE concrete on job.pconcrete_id=concrete.pconcrete_id"
				+ "	 left join " + SCHEMA
				+ ".PST_BREAK_DOWN b_down on j_work.pbd_id=b_down.pbd_id"
				//+ "  	where j_work.prp_id=" + prpId + ""
				+ "  	where job.prp_id=" + prpId + ""
				+ " and job.pj_created_time between '" + from_sql + "' and '"
				+ to_sql + "' " + " order by job.pj_created_time");
		List<Object[]> status = pstService.searchObject(query.toString());
		// int status_size=status.size();
		if (status != null)
			for (Object[] objects : status) {
				row = sheet.createRow(indexRow++);
				// indexRow++;
				// index=0;
				for (int i = 0; i < label.length; i++) {
					cell = row.createCell(i);
					if (i == 4 || i == 5) {
						cell.setCellValue(objects[i] != null ? ((java.math.BigDecimal) objects[i])
								.doubleValue() : 0d);
						cell.setCellStyle(cellStyle_number);
					} else {
						cell.setCellValue(objects[i] != null ? (String) objects[i]
								: "");
						cell.setCellStyle(cellStyle_text);
					}
					if (i == 0)
						cell.setCellStyle(cellStyle);
					if (i == 7) {
						cell.setCellValue(objects[i] != null ? Double
								.parseDouble((String) objects[i]) : 0d);
						cell.setCellStyle(cellStyle_number);
					}
				}
			}

		indexRow++;

		for (int i = 0; i < index; i++) {
			if (i == 1 || i == 2 || i == 6)
				sheet.setColumnWidth(i, (short) ((50 * 8) / ((double) 1 / 20)));
			else
				sheet.setColumnWidth(i, (short) ((20 * 8) / ((double) 1 / 20)));
		}

		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "รายงานการออกงานประจำวันของรถเบอร์ " + prpNo + ".xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/export_report4" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export4(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		String time_from = request.getParameter("from");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		String from_sql = year + "-" + month + "-" + day_from + " 00:00:00";
		String to_sql = year + "-" + month + "-" + day_to + " 23:59:59";
		StringBuffer query = new StringBuffer();
		StringBuffer query_inner = new StringBuffer();
		StringBuffer query_sum = new StringBuffer();
		StringBuffer query_sum_all = new StringBuffer();
		query.append(" SELECT pump.prp_id,pump.prp_no FROM " + SCHEMA
				+ ".PST_ROAD_PUMP pump order by pump.prp_no");
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("Break Down");

		String[] label = { "สาเหตุการ Break Down", "รวม" };
		int indexRow = 2;
		DataFormat dataFormat = wb.createDataFormat();
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic = wb.createCellStyle();
		HSSFCellStyle cellStyle2 = wb.createCellStyle();
		HSSFCellStyle cellStyle3 = wb.createCellStyle();
		HSSFCellStyle cellStyle4 = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle_topic.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle_topic.setFillPattern(CellStyle.SOLID_FOREGROUND);

		/*
		 * cellStyle.setFillBackgroundColor(new
		 * HSSFColor.GREY_25_PERCENT().getIndex()); cellStyle.setWrapText(true);
		 */

		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);
		cellStyle3.setDataFormat(dataFormat.getFormat("#,##0.##"));

		cellStyle4.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setWrapText(true);
		cellStyle4.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle4.setFillPattern(CellStyle.SOLID_FOREGROUND);

		cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.##"));
		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				0, // first column (0-based)
				10 // last column (0-based)
		));
		HSSFRow row = sheet.createRow(0);
		row.setHeight((short) 400);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("สถิติการ Break Down ประจำเดือน "
				+ dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);

		cell = row.createCell(10);
		cell.setCellStyle(cellStyle);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);

		row = sheet.createRow(indexRow++);
		int index = 0;
		for (int i = 0; i < label.length; i++) {
			cell = row.createCell(index++);
			cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle_topic);
		}
		List<Object[]> status = pstService.searchObject(query.toString());
		int status_size = status.size();
		query_sum.append(" SELECT r_pump.prp_no ,");
		query_sum
				.append("(SELECT count(*) FROM "
						+ SCHEMA
						+ ".PST_JOB_WORK j_work  left join "
						+ " "
						+ SCHEMA
						+ ".PST_JOB p_job on ( j_work.pj_id =p_job.pj_id )"
						//+ "  where j_work.prp_id=r_pump.prp_id   and p_job.pj_created_time between '"
						+ "  where p_job.prp_id=r_pump.prp_id   and p_job.pj_created_time between '"
						+ from_sql + "' and '" + to_sql + "' "
						+ " and j_work.pbd_id is not null)as break_down_1 "
						+ " FROM " + SCHEMA
						+ ".PST_ROAD_PUMP r_pump order by r_pump.prp_no "
						+ "  ");
		query_sum_all.append(" SELECT count(*) FROM " + SCHEMA
				+ ".PST_JOB_WORK j_work left join " + " " + SCHEMA
				+ ".PST_JOB p_job on ( j_work.pj_id =p_job.pj_id ) where"
				+ " p_job.pj_created_time between '" + from_sql + "' and '"
				+ to_sql + "' and  j_work.pbd_id is not null ");
		query_inner.append("SELECT b_down.pbd_name, ");
		query_inner
				.append(" ( SELECT  count(*) FROM "
						+ SCHEMA
						+ ".PST_JOB_WORK j_work  left join "
						+ " "
						+ SCHEMA
						+ ".PST_JOB p_job on ( j_work.pj_id =p_job.pj_id ) "
						+ "   left join "
						+ SCHEMA
					//	+ ".PST_ROAD_PUMP r_pump on  j_work.prp_id=r_pump.prp_id  "
					+ ".PST_ROAD_PUMP r_pump on  p_job.prp_id=r_pump.prp_id  "
						+ " where j_work.pbd_id=b_down.pbd_id  and  j_work.pbd_id is not null and p_job.pj_created_time "
						+ " between '" + from_sql + "' and '" + to_sql + "'"
						+ " ) break_down_sum ");
		for (Object[] objects : status) {
			cell = row.createCell(index++);
			cell.setCellValue((String) objects[1]);
			cell.setCellStyle(cellStyle_topic);
			query_inner.append(" ,(SELECT count(*) FROM " + SCHEMA
					+ ".PST_JOB_WORK j_work  left join " + "  " + SCHEMA
					+ ".PST_JOB p_job on ( j_work.pj_id =p_job.pj_id )"
					+ " left join " + SCHEMA
				//	+ ".PST_ROAD_PUMP r_pump on  j_work.prp_id=r_pump.prp_id"
				+ ".PST_ROAD_PUMP r_pump on  p_job.prp_id=r_pump.prp_id"
					+ "  where j_work.pbd_id=b_down.pbd_id and r_pump.prp_id="
					+ (Integer) objects[0] + " "
					+ " and p_job.pj_created_time between '" + from_sql
					+ "' and '" + to_sql + "' ) as break_down_"
					+ (Integer) objects[0] + " " + "");
		}
		query_inner.append("  FROM " + SCHEMA + ".PST_BREAK_DOWN b_down ");

		for (int i = 0; i < index; i++) {
			if (i == 0)
				sheet.setColumnWidth(i, (short) ((50 * 8) / ((double) 1 / 20)));
			else
				sheet.setColumnWidth(i, (short) ((20 * 8) / ((double) 1 / 20)));
		}

		query.setLength(0);
		query.append(query_inner.toString());
		cellStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		List<Object[]> emps = pstService.searchObject(query.toString());

		if (emps != null && emps.size() > 0) {
			int emps_size = emps.size();
			for (int i = 0; i < emps_size; i++) {
				// for(status_size)
				row = sheet.createRow(indexRow);
				indexRow++;
				index = 0;
				cell = row.createCell(index++);
				cell.setCellValue((String) emps.get(i)[0]);
				cell.setCellStyle(cellStyle3);

				cell = row.createCell(index++);
				cell.setCellValue(((java.math.BigInteger) emps.get(i)[1])
						.doubleValue());
				cell.setCellStyle(cellStyle);
				for (int j = 0; j < status_size; j++) {
					cell = row.createCell(index++);
					cell.setCellValue(((java.math.BigInteger) emps.get(i)[j + 2])
							.doubleValue());
					cell.setCellStyle(cellStyle3);
				}
			}
		}
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "สถิติการเบรคดาวน์.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/export_report5" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export5(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		/*
		 * 
		 * select (SELECT count(j_work.prp_id) FROM PST_DB.PST_JOB_WORK j_work
		 * left join PST_DB.PST_JOB job on (j_work.pj_id=job.pj_id and
		 * j_work.prp_id =job.prp_id ) where j_work.prp_id= r_pump.prp_id and
		 * job.pj_created_time between '2013-03-02 00:00:00' and '2013-03-02
		 * 23:59:59' )as count_pump,(SELECT sum(j_work.pjw_cubic_amount) FROM
		 * PST_DB.PST_JOB_WORK j_work left join PST_DB.PST_JOB job on
		 * (j_work.pj_id=job.pj_id and j_work.prp_id =job.prp_id ) where
		 * j_work.prp_id= r_pump.prp_id and job.pj_created_time between
		 * '2013-03-02 00:00:00' and '2013-03-02 23:59:59' )as amount ,(SELECT
		 * sum(j_work.pjw_cubic_amount) FROM PST_DB.PST_JOB_WORK j_work left
		 * join PST_DB.PST_JOB job on (j_work.pj_id=job.pj_id and j_work.prp_id
		 * =job.prp_id ) where j_work.prp_id= r_pump.prp_id and
		 * job.pj_created_time between '2013-03-01 00:00:00' and '2013-03-31
		 * 23:59:59' )as amount_all_y ,(SELECT sum(j_work.pjw_cubic_amount) FROM
		 * PST_DB.PST_JOB_WORK j_work left join PST_DB.PST_JOB job on
		 * (j_work.pj_id=job.pj_id and j_work.prp_id =job.prp_id ) where
		 * job.pj_created_time between '2013-03-02 00:00:00' and '2013-03-02
		 * 23:59:59' )as amount_all_x,r_pump.prp_id ,(select '2013-03-01' as
		 * day_pump) from PST_DB.PST_ROAD_PUMP r_pump order by r_pump.prp_id
		 */
		String time_from = request.getParameter("from");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		/*
		 * String from_sql=year+"-"+month+"-"+day_from+" 00:00:00"; String
		 * to_sql=year+"-"+month+"-"+day_to+" 23:59:59";
		 */
		StringBuffer query = new StringBuffer();
		query.append(" SELECT pump.prp_id,pump.prp_no FROM " + SCHEMA
				+ ".PST_ROAD_PUMP pump order by pump.prp_no");
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("คิวคอนกรีต");

		// String[] label={"สาเหตุการ Break Down","รวม"};
		int indexRow = 2;
		DataFormat dataFormat = wb.createDataFormat();
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic = wb.createCellStyle();
		HSSFCellStyle cellStyle2 = wb.createCellStyle();
		HSSFCellStyle cellStyle3 = wb.createCellStyle();
		HSSFCellStyle cellStyle4 = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle_topic.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle_topic.setFillPattern(CellStyle.SOLID_FOREGROUND);

		/*
		 * cellStyle.setFillBackgroundColor(new
		 * HSSFColor.GREY_25_PERCENT().getIndex()); cellStyle.setWrapText(true);
		 */

		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);
		cellStyle3.setDataFormat(dataFormat.getFormat("#,##0.##"));

		cellStyle4.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setWrapText(true);
		cellStyle4.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle4.setFillPattern(CellStyle.SOLID_FOREGROUND);

		// cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.##"));
		cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.00"));

		List<Object[]> status = pstService.searchObject(query.toString());
		int status_size = status.size();
		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				0, // first column (0-based)
				status_size + 1 // last column (0-based)
		));
		HSSFRow row = sheet.createRow(0);
		row.setHeight((short) 400);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("รายงานสรุปคิวคอนกรีต ประจำเดือน "
				+ dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);

		cell = row.createCell(status_size + 1);
		cell.setCellStyle(cellStyle);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);

		row = sheet.createRow(1);
		cell = row.createCell(0);
		cell.setCellValue("วันที่");
		cell.setCellStyle(cellStyle_topic);

		cell = row.createCell(1);
		cell.setCellValue("เบอร์รถ");
		cell.setCellStyle(cellStyle_topic);

		cell = row.createCell(status_size);
		cell.setCellStyle(cellStyle_topic);

		cell = row.createCell(status_size + 1);
		cell.setCellValue("ยอดรวม");
		cell.setCellStyle(cellStyle_topic);
		// row = sheet.createRow(2);

		row = sheet.createRow(indexRow++);
		sheet.addMergedRegion(new CellRangeAddress(1, // first row (0-based)
				2, // last row (0-based)
				0, // first column (0-based)
				0 // last column (0-based)
		));
		sheet.addMergedRegion(new CellRangeAddress(1, // first row (0-based)
				1, // last row (0-based)
				1, // first column (0-based)
				status_size // last column (0-based)
		));
		sheet.addMergedRegion(new CellRangeAddress(1, // first row (0-based)
				2, // last row (0-based)
				status_size + 1, // first column (0-based)
				status_size + 1 // last column (0-based)
		));
		int index = 1;

		for (int i = 0; i < status_size; i++) {
			cell = row.createCell(index++);
			cell.setCellValue((String) status.get(i)[1]);
			// cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle_topic);
		}
		query.setLength(0);
		double[] sum_y_array = new double[status_size];
		for (int i = day_from; i <= day_to; i++) {
			query.setLength(0);
			//query.append(" select (SELECT count(j_work.prp_id) FROM "
			query.append(" select (SELECT count(job.prp_id) FROM "
					+ SCHEMA
					+ ".PST_JOB_WORK j_work "
					+ " left join "
					+ SCHEMA
					//+ ".PST_JOB job on (j_work.pj_id=job.pj_id and j_work.prp_id =job.prp_id ) "
					+ ".PST_JOB job on (j_work.pj_id=job.pj_id ) "
					//+ " where	j_work.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ " where	job.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 00:00:00'"
					+ "  and '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 23:59:59')as count_pump,"
					+ " (SELECT sum(j_work.pjw_cubic_amount) FROM "
					+ SCHEMA
					+ ".PST_JOB_WORK j_work "
					+ " left join "
					+ SCHEMA
					//+ ".PST_JOB job on (j_work.pj_id=job.pj_id and j_work.prp_id =job.prp_id ) "
					+ ".PST_JOB job on (j_work.pj_id=job.pj_id  ) "
					//+ " where	j_work.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ " where	job.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 00:00:00'"
					+ "  and '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 23:59:59')as amount ,"
					+ " (SELECT sum(j_work.pjw_cubic_amount) FROM "
					+ SCHEMA
					+ ".PST_JOB_WORK j_work "
					+ " left join "
					+ SCHEMA
					//+ ".PST_JOB job on (j_work.pj_id=job.pj_id and j_work.prp_id =job.prp_id )"
					+ ".PST_JOB job on (j_work.pj_id=job.pj_id)"
//					+ " where j_work.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ " where job.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ day_from
					+ " 00:00:00'"
					+ "  and '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ day_to
					+ " 23:59:59')as amount_all_y ,"
					+ " (SELECT sum(j_work.pjw_cubic_amount) FROM "
					+ SCHEMA
					+ ".PST_JOB_WORK j_work "
					+ " left join "
					+ SCHEMA
					//+ ".PST_JOB job on (j_work.pj_id=job.pj_id and j_work.prp_id =job.prp_id ) "
					+ ".PST_JOB job on (j_work.pj_id=job.pj_id ) "
					+ " where job.pj_created_time between '" + year + "-"
					+ month + "-" + i + " 00:00:00' and '" + year + "-" + month
					+ "-" + i + " 23:59:59'	)as amount_all_x,"
					+ "r_pump.prp_id "
					+ // ,(select '2013-03-01' as day_pump) " +
					" from " + SCHEMA
					+ ".PST_ROAD_PUMP r_pump	order by r_pump.prp_no ");
			List<Object[]> emps = pstService.searchObject(query.toString());

			// System.out.println("sql->"+query.toString());
			int emps_size = emps.size();
			row = sheet.createRow(indexRow);
			indexRow++;
			index = 1;
			cell = row.createCell(0);
			cell.setCellValue(i);
			cell.setCellStyle(cellStyle_topic);
			double sum_x = 0;
			double sum_y = 0;
			for (int j = 0; j < emps_size; j++) {
				sum_y = 0;
				cell = row.createCell(index++);
				if (emps.get(j)[1] != null)
					cell.setCellValue(((java.math.BigDecimal) emps.get(j)[1])
							.doubleValue());
				else
					cell.setCellValue(0);
				// cellStyle4
				// if(((java.math.BigInteger)emps.get(j)[0]).intValue()>1){
				if (emps.get(j)[1] != null
						&& ((java.math.BigDecimal) emps.get(j)[1])
								.doubleValue() > 1) {
					cell.setCellStyle(cellStyle4);
				} else
					cell.setCellStyle(cellStyle3);
				if (emps.get(j)[3] != null)
					sum_x = ((java.math.BigDecimal) emps.get(j)[3])
							.doubleValue();

				if (emps.get(j)[2] != null)
					sum_y = ((java.math.BigDecimal) emps.get(j)[2])
							.doubleValue();
				// cell.setCellStyle(cellStyle3);

				sum_y_array[j] = sum_y;

			}
			cell = row.createCell(emps_size + 1);
			cell.setCellValue(sum_x);
			cell.setCellStyle(cellStyle4);

		}
		row = sheet.createRow(indexRow);
		indexRow++;
		cell = row.createCell(0);
		cell.setCellValue("รวม");
		cell.setCellStyle(cellStyle4);
		index = 1;
		double sum_all = 0;
		for (int j = 0; j < sum_y_array.length; j++) {
			cell = row.createCell(index++);
			cell.setCellValue(sum_y_array[j]);
			sum_all = sum_all + sum_y_array[j];
			cell.setCellStyle(cellStyle4);
		}
		cell = row.createCell(index++);
		cell.setCellValue(sum_all);
		cell.setCellStyle(cellStyle4);
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "รายงานสรุปคิวคอนกรีตประจำเดือน.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/export_report6" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export6(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {

		/*
		 * 
		 * SELECT road_pump.prp_no, title.pt_name ,emp.pe_first_name
		 * ,emp.pe_last_name,position.pp_name, (select
		 * count(*)*job1.pj_feedback_score from PST_DB.PST_JOB_EMPLOYEE
		 * job_emp_inner left join PST_DB.PST_JOB as job1 on
		 * job_emp_inner.pj_id=job1.pj_id where job_emp_inner.pe_id=emp.pe_id
		 * and job1.pj_created_time='2013-07-01 00:00:00') as day1, (select
		 * count(*)*job1.pj_feedback_score from PST_DB.PST_JOB_EMPLOYEE
		 * job_emp_inner left join PST_DB.PST_JOB as job1 on
		 * job_emp_inner.pj_id=job1.pj_id where job_emp_inner.pe_id=emp.pe_id
		 * and job1.pj_created_time='2013-07-02 00:00:00') as day2, (select
		 * count(*)*job1.pj_feedback_score from PST_DB.PST_JOB_EMPLOYEE
		 * job_emp_inner left join PST_DB.PST_JOB as job1 on
		 * job_emp_inner.pj_id=job1.pj_id where job_emp_inner.pe_id=emp.pe_id
		 * and job1.pj_created_time='2013-07-03 00:00:00') as day3, (select
		 * count(*)*job1.pj_feedback_score from PST_DB.PST_JOB_EMPLOYEE
		 * job_emp_inner left join PST_DB.PST_JOB as job1 on
		 * job_emp_inner.pj_id=job1.pj_id where job_emp_inner.pe_id=emp.pe_id
		 * and job1.pj_created_time='2013-07-04 00:00:00') as day4, ( select
		 * sum(job_inner.pj_cubic_amount) FROM PST_DB.PST_JOB job_inner where
		 * job_inner.pj_id=job_emp.pj_id) as sum_amount FROM
		 * PST_DB.PST_JOB_EMPLOYEE job_emp left join PST_DB.PST_EMPLOYEE emp on
		 * job_emp.pe_id = emp.pe_id left join PST_DB.PST_ROAD_PUMP road_pump on
		 * emp.prp_id=road_pump.prp_id left join PST_DB.PST_TITLE title on
		 * emp.pt_id=title.pt_id left join PST_DB.PST_POSITION position on
		 * emp.pp_id=position.pp_id group by emp.pe_id
		 */
		String time_from = request.getParameter("from");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		String from_sql = year + "-" + month + "-" + day_from + " 00:00:00";
		String to_sql = year + "-" + month + "-" + day_to + " 23:59:59";
		StringBuffer query = new StringBuffer();
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("เงินประเมิณ");
		String[] label = { "เบอร์ปั๊ม", "ชื่อ - สกุล", "ตำแหน่ง" };
		int label_size = label.length;
		int indexRow = 0;
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic_center = wb.createCellStyle();
		HSSFCellStyle cellStyle_left = wb.createCellStyle();
		HSSFCellStyle cellStyle_right = wb.createCellStyle();
		HSSFCellStyle cellStyle_right_sum = wb.createCellStyle();
		HSSFCellStyle cellStyle_center = wb.createCellStyle();

		/*
		 * HSSFCellStyle cellStyle_text = wb.createCellStyle(); HSSFCellStyle
		 * cellStyle_number = wb.createCellStyle();
		 */
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		// cellStyle.setFillBackgroundColor(new
		// HSSFColor.GREY_25_PERCENT().getIndex()); CORAL, AQUA
		cellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		cellStyle.setWrapText(true);

		cellStyle_topic_center.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle_topic_center
				.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic_center.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_center.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_center.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_center.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_center
				.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
						.getIndex());
		cellStyle_topic_center.setFillPattern(CellStyle.SOLID_FOREGROUND);
		cellStyle_topic_center.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle_topic_center.setFont(font);

		cellStyle_left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle_left.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_left.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_left.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_left.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_left.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_left.setWrapText(true);

		cellStyle_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle_right.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_right.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_right.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_right.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_right.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_right.setWrapText(true);

		cellStyle_right_sum.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle_right_sum.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_right_sum.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_right_sum.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_right_sum.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_right_sum.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_right_sum.setWrapText(true);
		DataFormat dataFormat = wb.createDataFormat();
		cellStyle_right_sum.setDataFormat(dataFormat.getFormat("#,##0.00"));

		cellStyle_center.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle_center.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_center.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_center.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_center.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_center.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_center.setWrapText(true);

		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(1);

		/*
		 * String[] obj_inner_array ={"10", "10", "", "10", "","10", "10", "",
		 * "10", "","10", "10", "", "10", "","10", "10", "", "10", "","10",
		 * "10", "", "10", "","10", "10", "", "10", ""}; int
		 * days=obj_inner_array.length;
		 */

		row = sheet.createRow(indexRow++);
		int index = 0;

		for (int i = 0; i < label.length; i++) {
			cell = row.createCell(index++);
			cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle);
		}
		cell = row.createCell(label_size);
		cell.setCellValue("ผลประเมินการบริการปั๊มคอนกรีต เดือน "
				+ dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle_topic_center);
		cell = row.createCell(label_size + (day_to - 1));
		cell.setCellStyle(cellStyle);
		CellRangeAddress region1 = new CellRangeAddress(0, // first row
															// (0-based)
				0, // last row (0-based)
				label_size, // first column (0-based)
				label_size + (day_to - 1) // last column (0-based)
		);
		sheet.addMergedRegion(region1);
		/*
		 * P-0007 นายจันทา บัวใหญ่ พนักงานขับรถ P-0007 นายสาคร สุวรรณเวียง
		 * พนักงานควบคุมปั๊ม
		 */

		// String[] obj_array ={"รถร่วม/ล/ซายน์", "นาย สุวรรณวิทย์ สารรัตน์",
		// "พนักงานควบคุมปั๊มคอนกรีต"};
		// P-0007 รถร่วม/ล/ซายน์
		String[] extend_label = { "วัน", "คะแนนเฉลี่ย", "ยอดคิว",
				"ผลประเมิน(บาท)" };
		// int size=obj_array.length;
		query.append("SELECT road_pump.prp_no, title.pt_name ,emp.pe_first_name"
				+ " ,emp.pe_last_name,position.pp_name,");
		for (int i = day_from; i <= day_to; i++) {
			// query.append("(select count(*)*job1.pj_feedback_score from "+SCHEMA+".PST_JOB_EMPLOYEE job_emp_inner "
			// +
			query.append("(select sum(job1.pj_feedback_score) from "
					+ SCHEMA
					+ ".PST_JOB_EMPLOYEE job_emp_inner "
					+ " left join "
					+ SCHEMA
					+ ".PST_JOB as job1 on job_emp_inner.pj_id=job1.pj_id"
					+ " where job_emp_inner.pe_id=emp.pe_id and job1.pj_created_time='"
					+ year + "-" + month + "-" + i + " 00:00:00') as day" + i
					+ ",");
		}
		// sum(job_inner.pj_cubic_amount)
		/*
		 * query.append("( select  sum(job_work_iner.pjw_cubic_amount)  FROM "+
		 * SCHEMA+".PST_JOB job_inner " + " left join "+SCHEMA+
		 * ".PST_JOB_WORK job_work_iner on job_inner.pj_id=job_work_iner.pj_id  "
		 * + " where  job_inner.pj_id=job_emp.pj_id) as sum_amount " +
		 */
		query.append("( select  sum(job_work_iner.pjw_cubic_amount)  FROM "
				+ SCHEMA
				+ ".PST_JOB job_inner "
				+ " left join "
				+ SCHEMA
				+ ".PST_JOB_WORK job_work_iner on job_inner.pj_id=job_work_iner.pj_id  "
				+ " left join   "
				+ SCHEMA
				+ ".PST_JOB_EMPLOYEE job_emp_x on job_inner.pj_id=job_emp_x.pj_id "
				+ " where  job_emp_x.pe_id=job_emp.pe_id "
				+ " and   job_inner.pj_created_time between '"
				+ from_sql
				+ "' and '"
				+ to_sql
				+ "' ) as sum_amount "
				+ " FROM "
				+ SCHEMA
				+ ".PST_JOB_EMPLOYEE job_emp left join"
				+ " "
				+ SCHEMA
				+ ".PST_JOB job_outer  on job_emp.pj_id=job_outer.pj_id left join"
				+ " " + SCHEMA
				+ ".PST_EMPLOYEE emp on job_emp.pe_id = emp.pe_id "
				+ " left join " + SCHEMA
				+ ".PST_ROAD_PUMP road_pump on emp.prp_id=road_pump.prp_id"
				+ " left join " + SCHEMA
				+ ".PST_TITLE title on emp.pt_id=title.pt_id" + " left join "
				+ SCHEMA + ".PST_POSITION position on emp.pp_id=position.pp_id"
				+ " where job_outer.pj_created_time between '" + from_sql
				+ "' and '" + to_sql + "' " + " group by emp.pe_id ");
		// System.out.println("sql->"+query.toString());
		List<Object[]> emps = pstService.searchObject(query.toString());
		// System.out.println("emps->"+emps);
		// int emps_size=emps.size();

		int extend_size = label_size + day_to;
		for (int i = 0; i < extend_label.length; i++) {
			cell = row.createCell(extend_size + i);
			cell.setCellStyle(cellStyle);
			cell.setCellValue(extend_label[i]);
		}

		row = sheet.createRow(indexRow++);
		for (int i = 0; i < day_to; i++) {
			cell = row.createCell(label_size + i);
			cell.setCellStyle(cellStyle);
			cell.setCellValue(i + 1);
		}
		for (int i = 0; i < label.length; i++) {
			sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
					1, // last row (0-based)
					i, // first column (0-based)
					i // last column (0-based)
			));
		}
		for (int i = 0; i < extend_label.length; i++) {
			sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
					1, // last row (0-based)
					extend_size + i, // first column (0-based)
					extend_size + i // last column (0-based)
			));
		}

		CellReference cellRef = null;
		String beginCount = "";
		String endCount = "";
		// int start_col=3;
		if (emps != null)
			for (Object[] objects : emps) {
				row = sheet.createRow(indexRow++);
				cell = row.createCell(0);
				cell.setCellValue(objects[0] != null ? (String) objects[0] : "");
				cell.setCellStyle(cellStyle_left);

				cell = row.createCell(1);
				String title = objects[1] != null ? (String) objects[1] : "";
				String name = objects[2] != null ? (String) objects[2] : "";
				String fname = objects[3] != null ? (String) objects[3] : "";
				cell.setCellValue(title + name + " " + fname);
				cell.setCellStyle(cellStyle_left);

				cell = row.createCell(2);
				cell.setCellValue(objects[4] != null ? (String) objects[4] : "");
				cell.setCellStyle(cellStyle_left);

				for (int i = 0; i < day_to; i++) {
					cell = row.createCell(label_size + i);
					if (i == 0) {
						cellRef = new CellReference(row.getRowNum(),
								cell.getColumnIndex());
						beginCount = cellRef.formatAsString().replaceAll("\\$",
								"");
					}
					if (i == day_to - 1) {
						cellRef = new CellReference(row.getRowNum(),
								cell.getColumnIndex());
						endCount = cellRef.formatAsString().replaceAll("\\$",
								"");
					}
					if (objects[label_size + 2 + i] != null)
						cell.setCellValue(((java.math.BigDecimal) objects[label_size
								+ 2 + i]).doubleValue());
					cell.setCellStyle(cellStyle_center);
				}
				int extend_index = 0;
				cell = row.createCell(day_to + label_size + extend_index++);
				cell.setCellFormula("COUNT(" + beginCount + ":" + endCount
						+ ",\">0\")");
				cell.setCellStyle(cellStyle_right);
				sheet.setColumnWidth(cell.getColumnIndex(),
						(short) ((6 * 8) / ((double) 1 / 20)));
				cellRef = new CellReference(row.getRowNum(),
						cell.getColumnIndex());
				String days_ref = cellRef.formatAsString()
						.replaceAll("\\$", "");
				cell = row.createCell(day_to + label_size + extend_index++);
				cell.setCellFormula("ROUND(SUM(" + beginCount + ":" + endCount
						+ ")/" + days_ref + ",2)");
				cell.setCellStyle(cellStyle_right);

				cell = row.createCell(day_to + label_size + extend_index++);
				if (objects[label_size + 2 + day_to] != null)
					cell.setCellValue(((java.math.BigDecimal) objects[label_size
							+ 2 + day_to]).doubleValue());
				cell.setCellStyle(cellStyle_right_sum);

				cell = row.createCell(day_to + label_size + extend_index++);
				sheet.setColumnWidth(cell.getColumnIndex(),
						(short) ((20 * 8) / ((double) 1 / 20)));
				cell.setCellStyle(cellStyle_right);
			}

		indexRow++;

		for (int i = 0; i < label.length; i++) {
			if (i != 0) {
				sheet.setColumnWidth(i, (short) ((30 * 8) / ((double) 1 / 20)));
			}

		}
		for (int i = 0; i < day_to; i++) {
			sheet.setColumnWidth(3 + i, (short) ((6 * 8) / ((double) 1 / 20)));
		}
		sheet.createFreezePane(3, 2);

		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "เงินประเมิณ.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/export_report7" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export7(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		String time_from = request.getParameter("from");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		StringBuffer query = new StringBuffer();
		query.append(" SELECT pump.prp_id,pump.prp_no FROM " + SCHEMA
				+ ".PST_ROAD_PUMP pump order by pump.prp_no");
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("คิวคอนกรีต");

		int indexRow = 2;
		DataFormat dataFormat = wb.createDataFormat();
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic = wb.createCellStyle();
		HSSFCellStyle cellStyle2 = wb.createCellStyle();
		HSSFCellStyle cellStyle3 = wb.createCellStyle();
		HSSFCellStyle cellStyle4 = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle_topic.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle_topic.setFillPattern(CellStyle.SOLID_FOREGROUND);

		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);
		cellStyle3.setDataFormat(dataFormat.getFormat("#,##0.##"));

		cellStyle4.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setWrapText(true);
		cellStyle4.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle4.setFillPattern(CellStyle.SOLID_FOREGROUND);

		// cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.##"));
		cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.00"));

		List<Object[]> status = pstService.searchObject(query.toString());
		int status_size = status.size();
		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				0, // first column (0-based)
				status_size + 1 // last column (0-based)
		));
		HSSFRow row = sheet.createRow(0);
		row.setHeight((short) 400);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("รายงานสรุปคะแนนประเมิณ ประจำเดือน "
				+ dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);

		cell = row.createCell(status_size + 1);
		cell.setCellStyle(cellStyle);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);

		row = sheet.createRow(1);
		cell = row.createCell(0);
		cell.setCellValue("วันที่");
		cell.setCellStyle(cellStyle_topic);

		cell = row.createCell(1);
		cell.setCellValue("เบอร์รถ");
		cell.setCellStyle(cellStyle_topic);

		cell = row.createCell(status_size);
		cell.setCellStyle(cellStyle_topic);

		cell = row.createCell(status_size + 1);
		cell.setCellValue("ยอดรวม");
		cell.setCellStyle(cellStyle_topic);
		// row = sheet.createRow(2);

		row = sheet.createRow(indexRow++);
		sheet.addMergedRegion(new CellRangeAddress(1, // first row (0-based)
				2, // last row (0-based)
				0, // first column (0-based)
				0 // last column (0-based)
		));
		sheet.addMergedRegion(new CellRangeAddress(1, // first row (0-based)
				1, // last row (0-based)
				1, // first column (0-based)
				status_size // last column (0-based)
		));
		sheet.addMergedRegion(new CellRangeAddress(1, // first row (0-based)
				2, // last row (0-based)
				status_size + 1, // first column (0-based)
				status_size + 1 // last column (0-based)
		));
		int index = 1;

		for (int i = 0; i < status_size; i++) {
			cell = row.createCell(index++);
			cell.setCellValue((String) status.get(i)[1]);
			// cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle_topic);
		}
		query.setLength(0);
		double[] sum_y_array = new double[status_size];
		for (int i = day_from; i <= day_to; i++) {
			query.setLength(0);
			query.append(" select (SELECT count(job.prp_id) FROM "
					+ SCHEMA
					+ ".PST_JOB job "
					+ " where	job.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 00:00:00'"
					+ "  and '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 23:59:59')as count_pump,"
					+ " (SELECT sum(job.pj_feedback_score)FROM "
					+ SCHEMA
					+ ".PST_JOB job "
					+ " where	job.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 00:00:00'"
					+ "  and '"
					+ year
					+ "-"
					+ month
					+ "-"
					+ i
					+ " 23:59:59')as amount ,"
					+ " (SELECT sum(job.pj_feedback_score) FROM "
					+ SCHEMA
					+ ".PST_JOB job "
					+ " where job.prp_id=  r_pump.prp_id and job.pj_created_time between '"
					+ year + "-" + month + "-" + day_from + " 00:00:00'"
					+ "  and '" + year + "-" + month + "-" + day_to
					+ " 23:59:59')as amount_all_y ,"
					+ " (SELECT sum(job.pj_feedback_score) FROM " + SCHEMA
					+ ".PST_JOB job " + " where job.pj_created_time between '"
					+ year + "-" + month + "-" + i + " 00:00:00' and '" + year
					+ "-" + month + "-" + i + " 23:59:59'	)as amount_all_x,"
					+ "r_pump.prp_id "
					+ // ,(select '2013-03-01' as day_pump) " +
					" from " + SCHEMA
					+ ".PST_ROAD_PUMP r_pump	order by r_pump.prp_no ");
			List<Object[]> emps = pstService.searchObject(query.toString());

			System.out.println("sql->" + query.toString());
			int emps_size = emps.size();
			row = sheet.createRow(indexRow);
			indexRow++;
			index = 1;
			cell = row.createCell(0);
			cell.setCellValue(i);
			cell.setCellStyle(cellStyle_topic);
			double sum_x = 0;
			double sum_y = 0;
			for (int j = 0; j < emps_size; j++) {
				sum_y = 0;
				cell = row.createCell(index++);
				if (emps.get(j)[1] != null)
					cell.setCellValue(((java.math.BigDecimal) emps.get(j)[1])
							.doubleValue());
				else
					cell.setCellValue(0);
				// cellStyle4
				// if(((java.math.BigInteger)emps.get(j)[0]).intValue()>1){
				if (emps.get(j)[1] != null
						&& ((java.math.BigDecimal) emps.get(j)[1])
								.doubleValue() > 1) {
					cell.setCellStyle(cellStyle4);
				} else
					cell.setCellStyle(cellStyle3);
				if (emps.get(j)[3] != null)
					sum_x = ((java.math.BigDecimal) emps.get(j)[3])
							.doubleValue();

				if (emps.get(j)[2] != null)
					sum_y = ((java.math.BigDecimal) emps.get(j)[2])
							.doubleValue();
				// cell.setCellStyle(cellStyle3);

				sum_y_array[j] = sum_y;

			}
			cell = row.createCell(emps_size + 1);
			cell.setCellValue(sum_x);
			cell.setCellStyle(cellStyle4);

		}
		row = sheet.createRow(indexRow);
		indexRow++;
		cell = row.createCell(0);
		cell.setCellValue("รวม");
		cell.setCellStyle(cellStyle4);
		index = 1;
		double sum_all = 0;
		for (int j = 0; j < sum_y_array.length; j++) {
			cell = row.createCell(index++);
			cell.setCellValue(sum_y_array[j]);
			sum_all = sum_all + sum_y_array[j];
			cell.setCellStyle(cellStyle4);
		}
		cell = row.createCell(index++);
		cell.setCellValue(sum_all);
		cell.setCellStyle(cellStyle4);
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "รายงานสรุปคะแนนประเมิณประจำเดือน.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/export_report8" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export8(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		/*
		 * SELECT cost.PC_ID ,cost.pc_uid , (SELECT sum(j_pay_1.pjp_amount) FROM
		 * PST_JOB_PAY j_pay_1 left join PST_JOB job_1 on
		 * j_pay_1.pj_id=job_1.pj_id left join PST_COSTS cost_1 on
		 * j_pay_1.pc_id=cost_1.pc_id where job_1.prp_id=job.prp_id and
		 * cost_1.pc_id=cost.pc_id and job_1.pj_created_time between '2013-8-1
		 * 00:00:00' and '2013-8-1 23:59:59' ) as pjp_amount_1, (SELECT
		 * sum(j_pay_1.pjp_amount) FROM PST_JOB_PAY j_pay_1 left join PST_JOB
		 * job_1 on j_pay_1.pj_id=job_1.pj_id left join PST_COSTS cost_1 on
		 * j_pay_1.pc_id=cost_1.pc_id where job_1.prp_id=job.prp_id and
		 * cost_1.pc_id=cost.pc_id and job_1.pj_created_time between '2013-8-2
		 * 00:00:00' and '2013-8-2 23:59:59' ) as pjp_amount_2, (SELECT
		 * sum(j_pay_1.pjp_amount) FROM PST_JOB_PAY j_pay_1 left join PST_JOB
		 * job_1 on j_pay_1.pj_id=job_1.pj_id left join PST_COSTS cost_1 on
		 * j_pay_1.pc_id=cost_1.pc_id where job_1.prp_id=job.prp_id and
		 * cost_1.pc_id=cost.pc_id and job_1.pj_created_time between '2013-8-8
		 * 00:00:00' and '2013-8-8 23:59:59' ) as pjp_amount_20 --
		 * j_pay.*,cost.* FROM PST_JOB_PAY j_pay left join PST_JOB job on
		 * j_pay.pj_id=job.pj_id left join PST_COSTS cost on
		 * j_pay.pc_id=cost.pc_id where job.prp_id=3 and job.pj_created_time
		 * between '2013-8-1 00:00:00' and '2013-8-31 23:59:59' group by
		 * cost.pc_id order by cost.pc_uid
		 */
		String time_from = request.getParameter("from");
		String prpId = request.getParameter("prpId");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		StringBuffer query = new StringBuffer();
		query.append("SELECT prp_id , prp_no FROM " + SCHEMA
				+ ".PST_ROAD_PUMP where prp_id=" + prpId);
		List<Object[]> road_pump = pstService.searchObject(query.toString());
		String prpNo = "";
		int road_pump_size = road_pump.size();
		for (int i = 0; i < road_pump_size; i++)
			prpNo = road_pump.get(i)[1] != null ? (String) road_pump.get(i)[1]
					: "";

		query.setLength(0);
		// query.append(" SELECT pump.prp_id,pump.prp_no FROM "+SCHEMA+".PST_ROAD_PUMP pump order by pump.prp_no");
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("สรุปยอดรหัสการจ่าย");

		int indexRow = 2;
		DataFormat dataFormat = wb.createDataFormat();
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic = wb.createCellStyle();
		HSSFCellStyle cellStyle2 = wb.createCellStyle();
		HSSFCellStyle cellStyle3 = wb.createCellStyle();
		HSSFCellStyle cellStyle4 = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle_topic.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderTop(HSSFCellStyle.BORDER_THIN);

		cellStyle_topic.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle_topic.setFillPattern(CellStyle.SOLID_FOREGROUND);

		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);
		cellStyle3.setDataFormat(dataFormat.getFormat("#,##0.##"));

		cellStyle4.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setWrapText(true);
		cellStyle4.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle4.setFillPattern(CellStyle.SOLID_FOREGROUND);

		// cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.##"));
		cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.00"));

		// List<Object[]> status=pstService.searchObject(query.toString());
		// int status_size=status.size();
		/*
		 * sheet.addMergedRegion(new CellRangeAddress( 0, //first row (0-based)
		 * 0, //last row (0-based) 0, //first column (0-based) status_size+1
		 * //last column (0-based) ));
		 */
		HSSFRow row = sheet.createRow(0);
		row.setHeight((short) 400);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("รายงานสรุปยอดรหัสการจ่ายของ เบอร์ปั๊ม " + prpNo
				+ " ประจำเดือน " + dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);

		cell = row.createCell(day_to);
		cell.setCellStyle(cellStyle);

		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);

		row = sheet.createRow(1);
		cell = row.createCell(0);
		cell.setCellValue("รหัส/วันที่");
		cell.setCellStyle(cellStyle_topic);
		sheet.setColumnWidth(0, (short) ((20 * 8) / ((double) 1 / 20)));

		for (int i = day_from; i <= day_to; i++) {
			cell = row.createCell(i);
			cell.setCellValue(i);
			cell.setCellStyle(cellStyle_topic);
		}
		/*
		 * cell = row.createCell(1); cell.setCellValue("เบอร์รถ");
		 * cell.setCellStyle(cellStyle_topic);
		 * 
		 * cell = row.createCell(status_size);
		 * cell.setCellStyle(cellStyle_topic);
		 * 
		 * cell = row.createCell(status_size+1); cell.setCellValue("ยอดรวม");
		 * cell.setCellStyle(cellStyle_topic);
		 */
		// row = sheet.createRow(2);

		// row = sheet.createRow(indexRow++);

		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				0, // first column (0-based)
				31 // last column (0-based)
		));
		/*
		 * sheet.addMergedRegion(new CellRangeAddress( 1, //first row (0-based)
		 * 1, //last row (0-based) 1, //first column (0-based) status_size
		 * //last column (0-based) )); sheet.addMergedRegion(new
		 * CellRangeAddress( 1, //first row (0-based) 2, //last row (0-based)
		 * status_size+1, //first column (0-based) status_size+1 //last column
		 * (0-based) ));
		 */
		// int index=1;

		/*
		 * for(int i=0;i<status_size;i++){ cell = row.createCell(index++);
		 * cell.setCellValue((String)status.get(i)[1]);
		 * //cell.setCellValue(label[i]); cell.setCellStyle(cellStyle_topic); }
		 */
		query.setLength(0);
		query.append(" SELECT cost.pc_amount ,cost.pc_uid ");

		for (int i = day_from; i <= day_to; i++) {
			// query.setLength(0);
			query.append(", (SELECT sum(j_pay_1.pjp_amount) FROM  "
					+ SCHEMA
					+ ".PST_JOB_PAY j_pay_1 left join "
					+ SCHEMA
					+ ".PST_JOB job_1"
					+ " on j_pay_1.pj_id=job_1.pj_id left join "
					+ SCHEMA
					+ ".PST_COSTS cost_1"
					+ " on j_pay_1.pc_id=cost_1.pc_id"
					+ "	 where job_1.prp_id=job.prp_id and cost_1.pc_id=cost.pc_id"
					+ "	 and job_1.pj_created_time" + " between '" + year + "-"
					+ month + "-" + i + " 00:00:00'" + "  and '" + year + "-"
					+ month + "-" + i + " 23:59:59' ) as pjp_amount_" + i);
		}
		query.append(" FROM  " + SCHEMA + ".PST_JOB_PAY j_pay left join "
				+ SCHEMA + ".PST_JOB job"
				+ " on j_pay.pj_id=job.pj_id left join " + SCHEMA
				+ ".PST_COSTS cost"
				+ " on j_pay.pc_id=cost.pc_id  where job.prp_id=" + prpId
				+ " and job.pj_created_time " + " between '" + year + "-"
				+ month + "-" + day_from + " 00:00:00'" + "  and '" + year
				+ "-" + month + "-" + day_to + " 23:59:59' "
				+ " group by cost.pc_id order by cost.pc_uid");

		List<Object[]> emps = pstService.searchObject(query.toString());
		if (emps != null && emps.size() > 0) {
			int emps_size = emps.size();
			double[][] sum_y_array = new double[emps_size][day_to];
			double pc_amount = 0;
			CellReference cellRef = null;
			String beginCount = "";
			String endCount = "";
			for (int j = 0; j < emps_size; j++) {
				row = sheet.createRow(indexRow++);
				cell = row.createCell(0);
				cell.setCellValue(emps.get(j)[1] != null ? (String) emps.get(j)[1]
						: "");
				pc_amount = emps.get(j)[0] != null ? ((java.math.BigDecimal) emps
						.get(j)[0]).doubleValue() : 0d;
				cell.setCellStyle(cellStyle_topic);
				for (int k = day_from; k <= day_to; k++) {
					cell = row.createCell(k);
					if (emps.get(j)[k + 1] != null
							&& ((java.math.BigDecimal) emps.get(j)[k + 1])
									.doubleValue() > 0) {
						cell.setCellStyle(cellStyle4);
						cell.setCellValue(((java.math.BigDecimal) emps.get(j)[k + 1])
								.doubleValue());
						sum_y_array[j][k - 1] = ((java.math.BigDecimal) emps
								.get(j)[k + 1]).doubleValue() * pc_amount;
						// sum_per_day=sum_per_day+((java.math.BigDecimal)emps.get(j)[k+1]).doubleValue();
					} else {
						cell.setCellStyle(cellStyle3);
						sum_y_array[j][k - 1] = 0d;
					}
				}
			}
			row = sheet.createRow(indexRow++);
			cell = row.createCell(0);
			cell.setCellValue("รวมเงิน(ต่อวัน)");
			cell.setCellStyle(cellStyle4);
			double[] sum_y = new double[day_to];
			double sum_y_all = 0d;

			for (int i = 0; i < day_to; i++) {
				double sum_y2 = 0;
				for (int j = 0; j < emps_size; j++) {
					sum_y2 = sum_y2 + sum_y_array[j][i];
					sum_y_all = sum_y_all + sum_y_array[j][i];
				}
				sum_y[i] = sum_y2;
			}
			for (int j = 0; j < sum_y.length; j++) {
				cell = row.createCell(j + 1);
				cell.setCellValue(sum_y[j]);
				cell.setCellStyle(cellStyle4);
				if (j == 0) {
					cellRef = new CellReference(row.getRowNum(),
							cell.getColumnIndex());
					beginCount = cellRef.formatAsString().replaceAll("\\$", "");
				}
				if (j == sum_y.length - 1) {
					cellRef = new CellReference(row.getRowNum(),
							cell.getColumnIndex());
					endCount = cellRef.formatAsString().replaceAll("\\$", "");
				}
			}
			row = sheet.createRow(indexRow++);
			cell = row.createCell(0);
			cell.setCellValue("เงินรวม(เดือน)");
			cell.setCellStyle(cellStyle4);

			cell = row.createCell(1);
			cell.setCellStyle(cellStyle4);
			cell.setCellFormula("SUM(" + beginCount + ":" + endCount + ")");
		}
		sheet.createFreezePane(1, 2);
		// =SUM(B11:AF11)
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "รายงานสรุปยอดรหัสการจ่ายประจำเดือน.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = { "/export_report9" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public void export9(HttpServletRequest request,
			HttpServletResponse response, Model model,
			SecurityContextHolderAwareRequestWrapper srequest) {
		/*
		 SELECT cost.pc_uid  ,cost.pc_name,cost.pc_amount,cost.pc_unit
, (SELECT sum(j_pay_1.pjp_amount) FROM
		   PST_JOB_PAY j_pay_1 left join PST_JOB job_1 on
		   j_pay_1.pj_id=job_1.pj_id left join PST_COSTS cost_1 on
		   j_pay_1.pc_id=cost_1.pc_id where job_1.prp_id=job.prp_id and
		   cost_1.pc_id=cost.pc_id and job_1.pj_created_time between '2013-8-1
		   00:00:00' and '2013-8-31 23:59:59' ) as pjp_amount_all
, (SELECT sum(j_pay_1.pjp_amount*cost_1.pc_amount) FROM
		   PST_JOB_PAY j_pay_1 left join PST_JOB job_1 on
		   j_pay_1.pj_id=job_1.pj_id left join PST_COSTS cost_1 on
		   j_pay_1.pc_id=cost_1.pc_id where job_1.prp_id=job.prp_id and
		   cost_1.pc_id=cost.pc_id and job_1.pj_created_time between '2013-8-1
		   00:00:00' and '2013-8-31 23:59:59' ) as pjp_amount_sum_all 
		   FROM PST_JOB_PAY j_pay left join PST_JOB job on
		   j_pay.pj_id=job.pj_id left join PST_COSTS cost on
		   j_pay.pc_id=cost.pc_id where job.prp_id=3 and job.pj_created_time
		   between '2013-8-1 00:00:00' and '2013-8-31 23:59:59' group by
		   cost.pc_id order by cost.pc_uid
		 */
		String time_from = request.getParameter("from");
		String prpId = request.getParameter("prpId");
		Date d = null;
		try {
			d = format.parse(time_from);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DateTime dt = new DateTime(d);
		int day_from = dt.getDayOfMonth();
		int month = dt.getMonthOfYear();
		int year = dt.getYear();

		int day_to = dt.dayOfMonth().getMaximumValue();
		StringBuffer query = new StringBuffer();
		query.append("SELECT prp_id , prp_no FROM " + SCHEMA
				+ ".PST_ROAD_PUMP where prp_id=" + prpId);
		List<Object[]> road_pump = pstService.searchObject(query.toString());
		String prpNo = "";
		int road_pump_size = road_pump.size();
		for (int i = 0; i < road_pump_size; i++)
			prpNo = road_pump.get(i)[1] != null ? (String) road_pump.get(i)[1]
					: "";

		query.setLength(0);
		// query.append(" SELECT pump.prp_id,pump.prp_no FROM "+SCHEMA+".PST_ROAD_PUMP pump order by pump.prp_no");
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("สรุปค่าคิวรถออกงานประจำเดือน");

		int indexRow = 2;
		DataFormat dataFormat = wb.createDataFormat();
		HSSFCellStyle cellStyle = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic_left = wb.createCellStyle();
		HSSFCellStyle cellStyle_topic_right = wb.createCellStyle();
		
		HSSFCellStyle cellStyle_left = wb.createCellStyle();
		HSSFCellStyle cellStyle_right = wb.createCellStyle();
		HSSFCellStyle cellStyle2 = wb.createCellStyle();
		HSSFCellStyle cellStyle3 = wb.createCellStyle();
		HSSFCellStyle cellStyle4 = wb.createCellStyle();
		HSSFCellStyle cellStyle_number_00 = wb.createCellStyle();
		
		 cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
 
		cellStyle_topic.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle_topic.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle_topic.setFillPattern(CellStyle.SOLID_FOREGROUND);

		cellStyle_topic_left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle_topic_left.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic_left.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_left.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_left.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_left.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_left.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle_topic_left.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		cellStyle_topic_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle_topic_right.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_topic_right.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_right.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_right.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_right.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_topic_right.setFillForegroundColor(IndexedColors.GREY_25_PERCENT
				.getIndex());
		cellStyle_topic_right.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		cellStyle_left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle_left.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_left.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_left.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_left.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_left.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		cellStyle_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle_right.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_right.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_right.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_right.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_right.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_NONE);
		cellStyle2.setWrapText(true);

		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 13);
		cellStyle2.setFont(font);

		cellStyle3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle3.setWrapText(true);
		cellStyle3.setDataFormat(dataFormat.getFormat("#,##0.##"));
		
		cellStyle_number_00.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle_number_00.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle_number_00.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle_number_00.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_number_00.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_number_00.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_number_00.setWrapText(true);
		cellStyle_number_00.setDataFormat(dataFormat.getFormat("#,##0.00"));

		cellStyle4.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle4.setWrapText(true);
		cellStyle4.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		cellStyle4.setFillPattern(CellStyle.SOLID_FOREGROUND);

		// cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.##"));
		cellStyle4.setDataFormat(dataFormat.getFormat("#,##0.00"));

		// List<Object[]> status=pstService.searchObject(query.toString());
		// int status_size=status.size();
		/*
		 * sheet.addMergedRegion(new CellRangeAddress( 0, //first row (0-based)
		 * 0, //last row (0-based) 0, //first column (0-based) status_size+1
		 * //last column (0-based) ));
		 */
		String[] label = { "รหัสการจ่าย", "คำอธิบาย", "จำนวนเงิน/หน่วย","หน่วย","จำนวน","จำนวนเงินรวม","หมายเหตุ"};
		int label_size = label.length;
		
		HSSFRow row = sheet.createRow(0);
		row.setHeight((short) 400);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("รายงานสรุปค่าคิวรถ " + prpNo
				+ " ประจำเดือน " + dt.monthOfYear().getAsText(locale) + " "
				+ dt.year().getAsText());
		cell.setCellStyle(cellStyle2);

		cell = row.createCell(label_size-1);
		cell.setCellStyle(cellStyle2);

		cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);

		
		row = sheet.createRow(1);
		
		for (int i = 0; i < label_size; i++) {
			cell = row.createCell(i);
			cell.setCellValue(label[i]);
			cell.setCellStyle(cellStyle_topic);
			if (i == 1)
				sheet.setColumnWidth(i, (short) ((100 * 8) / ((double) 1 / 20)));
			else if(i==6)
				sheet.setColumnWidth(i, (short) ((50 * 8) / ((double) 1 / 20)));
			else if(i == 3 || i == 5)
				sheet.setColumnWidth(i, (short) ((30 * 8) / ((double) 1 / 20)));
			else
				sheet.setColumnWidth(i, (short) ((20 * 8) / ((double) 1 / 20)));
		}
		  
		/*
		 * cell = row.createCell(1); cell.setCellValue("เบอร์รถ");
		 * cell.setCellStyle(cellStyle_topic);
		 * 
		 * cell = row.createCell(status_size);
		 * cell.setCellStyle(cellStyle_topic);
		 * 
		 * cell = row.createCell(status_size+1); cell.setCellValue("ยอดรวม");
		 * cell.setCellStyle(cellStyle_topic);
		 */
		// row = sheet.createRow(2);

		// row = sheet.createRow(indexRow++);

		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				0, // last row (0-based)
				0, // first column (0-based)
				6 // last column (0-based)
		));
		 
		query.setLength(0);
		query.append(" SELECT cost.pc_uid  ,cost.pc_name,cost.pc_amount,cost.pc_unit" +
				" , (SELECT sum(j_pay_1.pjp_amount) FROM  " + SCHEMA + ".PST_JOB_PAY j_pay_1 left join " + SCHEMA + ".PST_JOB job_1 on" +
				"  j_pay_1.pj_id=job_1.pj_id left join " + SCHEMA + ".PST_COSTS cost_1 on  j_pay_1.pc_id=cost_1.pc_id where job_1.prp_id=job.prp_id and" +
				"  cost_1.pc_id=cost.pc_id and job_1.pj_created_time between '" + year + "-"+ month + "-" + day_from + " 00:00:00' and '" + year + "-"+ month + "-" + day_to + " 23:59:59' ) as pjp_amount_all" +
				", (SELECT sum(j_pay_1.pjp_amount*cost_1.pc_amount) FROM  " + SCHEMA + ".PST_JOB_PAY j_pay_1 left join " + SCHEMA + ".PST_JOB job_1 on" +
				"  j_pay_1.pj_id=job_1.pj_id left join " + SCHEMA + ".PST_COSTS cost_1 on j_pay_1.pc_id=cost_1.pc_id where job_1.prp_id=job.prp_id and" +
				"  cost_1.pc_id=cost.pc_id and job_1.pj_created_time between '" + year + "-"+ month + "-" + day_from + " 00:00:00' and '" + year + "-"+ month + "-" + day_to + " 23:59:59' ) as pjp_amount_sum_all" +
				" FROM " + SCHEMA + ".PST_JOB_PAY j_pay left join " + SCHEMA + ".PST_JOB job on j_pay.pj_id=job.pj_id left join " + SCHEMA + ".PST_COSTS cost on  " +
				" j_pay.pc_id=cost.pc_id where job.prp_id=" + prpId +" and job.pj_created_time" +
				"  between '" + year + "-"+ month + "-" + day_from + " 00:00:00' and '" + year + "-"+ month + "-" + day_to + " 23:59:59' group by cost.pc_id order by cost.pc_uid ");

	 
		List<Object[]> emps = pstService.searchObject(query.toString());
		if (emps != null && emps.size() > 0) {
			int emps_size = emps.size();
			 
			for (int j = 0; j < emps_size; j++) {
				row = sheet.createRow(indexRow++);
				for (int i = 0; i < label_size-1; i++) {
					cell = row.createCell(i);
					if(i==2 || i==4|| i==5){
						if (emps.get(j)[i] != null
								&& ((java.math.BigDecimal) emps.get(j)[i])
										.doubleValue() > 0) {
							cell.setCellValue(((java.math.BigDecimal) emps.get(j)[i])
									.doubleValue());
						}else
							cell.setCellValue(0);
					}else{
						cell.setCellValue(emps.get(j)[i] != null ? (String) emps.get(j)[i]
								: "");
					} 
					if(i==5)
						cell.setCellStyle(cellStyle_number_00);
					else if(i==1)
						cell.setCellStyle(cellStyle_left);
					else if(i==2 || i==4)
						cell.setCellStyle(cellStyle3);
					else
						cell.setCellStyle(cellStyle);
				}
				 
			}
			/*row = sheet.createRow(indexRow++);
			cell = row.createCell(0);
			cell.setCellValue("รวมเงิน(ต่อวัน)");
			cell.setCellStyle(cellStyle4);
			double[] sum_y = new double[day_to];
			double sum_y_all = 0d;*/

			/*for (int i = 0; i < day_to; i++) {
				double sum_y2 = 0;
				for (int j = 0; j < emps_size; j++) {
					sum_y2 = sum_y2 + sum_y_array[j][i];
					sum_y_all = sum_y_all + sum_y_array[j][i];
				}
				sum_y[i] = sum_y2;
			}*/
			/*for (int j = 0; j < sum_y.length; j++) {
				cell = row.createCell(j + 1);
				cell.setCellValue(sum_y[j]);
				cell.setCellStyle(cellStyle4);
				if (j == 0) {
					cellRef = new CellReference(row.getRowNum(),
							cell.getColumnIndex());
					beginCount = cellRef.formatAsString().replaceAll("\\$", "");
				}
				if (j == sum_y.length - 1) {
					cellRef = new CellReference(row.getRowNum(),
							cell.getColumnIndex());
					endCount = cellRef.formatAsString().replaceAll("\\$", "");
				}
			}*/
			row = sheet.createRow(indexRow++);
			cell = row.createCell(0);
			cell.setCellValue("เงินรวมเงินรวมสุทธิ");
			cell.setCellStyle(cellStyle_topic_right);
			cell = row.createCell(4); 
			cell.setCellStyle(cellStyle_topic_right);

			cell = row.createCell(5);
			cell.setCellStyle(cellStyle4);
			cell.setCellFormula("SUM(F3:F" + (emps_size+2) + ")");
			cell = row.createCell(6);
			cell.setCellValue("บาท");
			cell.setCellStyle(cellStyle_topic_left); 
			
			sheet.addMergedRegion(new CellRangeAddress(emps_size+2, // first row (0-based)
					emps_size+2, // last row (0-based)
					0, // first column (0-based)
					label_size-3 // last column (0-based)
			));
		}
		//sheet.createFreezePane(1, 2);
		// =SUM(B11:AF11)
		response.setHeader("Content-Type",
				"application/octet-stream; charset=UTF-8");
		String filename = "รายงานสรุปค่าคิวรถออกงานประจำเดือน.xls";
		if (filename.length() > 0) {
			String userAgent = request.getHeader("user-agent");
			boolean isInternetExplorer = (userAgent.indexOf("MSIE") > -1);
			byte[] fileNameBytes = null;
			try {
				fileNameBytes = filename
						.getBytes((isInternetExplorer) ? ("windows-1250")
								: ("utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String dispositionFileName = "";
			for (byte b : fileNameBytes)
				dispositionFileName += (char) (b & 0xff);

			String disposition = "attachment; filename=\""
					+ dispositionFileName + "\"";
			response.setHeader("Content-disposition", disposition);
		}
		// response.setHeader("Content-disposition",
		// "attachment; filename=Report.xls");
		ServletOutputStream servletOutputStream = null;
		try {
			servletOutputStream = response.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			wb.write(servletOutputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			servletOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
