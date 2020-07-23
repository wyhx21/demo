package org.layz.engine.common.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.mysql.jdbc.StringUtils;

/**
 * 导出excelUtil类
 * 
 * @author 80002406
 *
 */
public class ExcelUtil {
	private static final String YYYY_MM_DD = "yyyy-MM-dd";

	/**
	 * 
	 * 导出excel2007 方法
	 * 
	 * @param fileName
	 *            导出文件名
	 * @param title
	 * 			  工作表明称
	 * @param headers
	 *            列名
	 * @param dataSource
	 *            数据源
	 * @param methodNames
	 *            对象属性get方法名
	 * @param HttpServletResponse
	 * @return
	 * @throws IOException
	 */
	public static void export(String fileName, String title, String[] headers, List<?> dataSource,
			String[] methodNames, HttpServletResponse response) throws IOException {
		// 声明一个工作薄
		//XSSFWorkbook  workbook = new XSSFWorkbook();
		Workbook  workbook = new HSSFWorkbook ();
		// 生成一个表格
		Sheet sheet=workbook.createSheet(title);
		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth((short) 15);
	
		CellStyle style = workbook.createCellStyle();
		// 设置这些样式
		CellStyle style2 = getStyle(workbook, sheet, style);
		// 设置注释作者，当鼠标移动到单元格上是可以在状态栏中看到该内容.
		// 产生表格标题行
		Row row = sheet.createRow(0);
		for (short i = 0; i < headers.length; i++) {
			Cell cell = row.createCell(i);
			cell.setCellStyle(style);
			cell.setCellValue(headers[i]);
		}
		int rowNumber = 1;
		if (dataSource != null) {
			for (Object tempObj : dataSource) {
				// 创建行
				row = sheet.createRow(rowNumber);
				// 得到传入对象的所有方法
				getParam(methodNames, style2, row, tempObj);
				rowNumber++;
			}
		}
		// 返回给浏览器一个下载命令
		String filePath = fileName + ".xls";
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename=" + new String(URLEncoder.encode(filePath,"utf-8").getBytes()));
		OutputStream ouputStream = response.getOutputStream();
		workbook.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
	}

	private static void getParam(String[] methodNames,CellStyle style, Row row, Object tempObj) {
		Method[] methods = tempObj.getClass().getMethods();
		String methodName = null;
		Object objValue = null;
		int cellNumber = 0;
		// 循环与列头对应的列
		for (String tempMethod : methodNames) {
			for (int i = 0; i < methods.length; i++) {
				methodName = methods[i].getName();
				try {
					// 匹配当前要那值的列
					if (tempMethod.equals(methodName)) {
						objValue = methods[i].invoke(tempObj);
						// 创建列
						Cell cellTemp = row.createCell(cellNumber);
						cellTemp.setCellStyle(style);
						if (null != objValue && objValue instanceof Date) {
							cellTemp.setCellValue(getSytemTime(YYYY_MM_DD, (Date) objValue));
						} else {
							if (null != objValue) {// 如果值为null就设置一个空字符
								cellTemp.setCellValue(objValue.toString());
							} else {
								cellTemp.setCellValue("");
							}
						}
						cellNumber++;
					}

				} catch (Exception e) {
					destroy(e);
					throw new NullPointerException(e.getMessage());
				} 

			}

		}
	}

	private static CellStyle getStyle(Workbook workbook, Sheet sheet, CellStyle style) {
		style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setAlignment(HorizontalAlignment.CENTER);
		// 生成一个字体
		Font font = workbook.createFont();
		font.setColor(HSSFColor.VIOLET.index);
		font.setFontHeightInPoints((short) 12);
		font.setBold(true);
		// 把字体应用到当前的样式
		style.setFont(font);
		// 生成并设置另一个样式
		CellStyle style2 = workbook.createCellStyle();
		// //设置前景色
		style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		// //设置填充模式
		style2.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style2.setBorderBottom(BorderStyle.THIN);
		style2.setBorderLeft(BorderStyle.THIN);
		style2.setBorderRight(BorderStyle.THIN);
		style2.setBorderTop(BorderStyle.THIN);
		style2.setAlignment(HorizontalAlignment.CENTER);
		style2.setVerticalAlignment(VerticalAlignment.CENTER);
		// 生成另一个字体
		Font font2 = workbook.createFont();
		// 字体为粗体
		font2.setBold(true);
		// 把字体应用到当前的样式
		style2.setFont(font2);
		// 声明一个画图的顶级管理器
//		Drawing patriarch = sheet.createDrawingPatriarch();
		// 定义注释的大小和位置,详见文档
//		Comment comment = patriarch.createCellComment(new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
//		// 设置注释内容
//		comment.setString(new HSSFRichTextString("导出时间为:" + getSytemTime(YYYY_MM_DD, new Date())));
		return style2;
	}

	/**
	 * 日期格式化
	 * 
	 * @param format
	 * @return
	 */
	public static String getSytemTime(String format, Date date) {
		java.text.DateFormat formatd = new java.text.SimpleDateFormat(format);
		return formatd.format(date);
	}
	
	/**
	 * 日期格式化
	 * 
	 * @param format
	 * @return
	 */
	public static String getSytemTime(String format) {
		java.text.DateFormat formatd = new java.text.SimpleDateFormat(format);
		return formatd.format(new Date());
	}
	
	private static boolean destroy(Exception e) {
		return e == null ? true : false;
	}
	
	/**
	 * 获得上传的Excel内容返回一个集合
	 * @param inputStream
	 * @return
	 * @throws IOException
	 */
	public static Map<String,Object> getExcelData(InputStream inputStream) throws IOException {
		 List<Map<String,String>> list=new ArrayList<>();
		 String msg="";
		 Map<String,Object> map=new HashMap<>();
		 Workbook work = null;
		try {
			work = WorkbookFactory.create(inputStream);
		} catch (EncryptedDocumentException e) {
			throw new IOException("解析Excel失败");
		} catch (InvalidFormatException e) {
			throw new IOException("解析Excel失败");
		}
		Sheet sheet = null;
		//for (int i = 0; i < work.getNumberOfSheets(); i++) { //获取一个sheet
		for (int i = 0; i <1; i++) {
			sheet = work.getSheetAt(i);
			if (sheet == null) {
				continue;
			}
			// 遍历当前sheet中的所有行
			msg=getRowData(list, sheet);
		}
		inputStream.close();
		map.put("msg", msg);
		map.put("dataList", list);
		return map;

	}

	private static String getRowData(List<Map<String, String>> list, Sheet sheet) {
		Row row;
		Cell cell;
		StringBuilder sb=new StringBuilder("");
		for (int j = 2; j <= sheet.getLastRowNum(); j++) {
			row = sheet.getRow(j);
			if (row == null || row.getFirstCellNum() == j) {
				continue;
			}
			if(row.getLastCellNum()-row.getFirstCellNum()==1){
				break;
			}
			// 遍历所有的列
			Map<String,String> map=new HashMap<>();
			for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
				cell = row.getCell(y);
				String text = "";
				if (cell == null) {
					String msg="第【"+(j+1)+"】行"+getCellValue(sheet.getRow(0).getCell(y))+"为空;";
					sb.append(msg);
					text=null; 
				}else{
					text=String.valueOf(getCellValue(cell));
					if(StringUtils.isNullOrEmpty(text)){
						String htEndDate=getCellValue(sheet.getRow(0).getCell(y))+"";
						if(!StringUtils.isNullOrEmpty(text) && "合同终止日期".equals(htEndDate)){
							String msg="第【"+(j+1)+"】行"+getCellValue(sheet.getRow(0).getCell(y))+"为空;";
							sb.append(msg);
						}
					}
				}
				map.put(sheet.getRow(1).getCell(y).getStringCellValue(),text);
			}
			list.add(map);
		}
		return sb.toString();
	}

	
	/**
	 * 描述：对表格中数值进行格式化
	 * 
	 * @param cell
	 * @return
	 */
	private static Object getCellValue(Cell cell) {
		Object value = null;
		DecimalFormat df = new DecimalFormat("0"); // 格式化number String字符
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd"); // 日期格式化
		DecimalFormat df2 = new DecimalFormat("0.00"); // 格式化数字
		CellType cellTypeEnum = cell.getCellTypeEnum();
		if(cellTypeEnum.equals(CellType.STRING)){
			value = cell.getRichStringCellValue().getString();
		} else if(cellTypeEnum.equals(CellType.NUMERIC)) {
			if ("General".equals(cell.getCellStyle().getDataFormatString())) {
				value = df.format(cell.getNumericCellValue());
			} else if ("m/d/yy".equals(cell.getCellStyle().getDataFormatString())) {
				value = sdf.format(cell.getDateCellValue());
			} else {
				value = df2.format(cell.getNumericCellValue());
			}
		} else if(cellTypeEnum.equals(CellType.BOOLEAN)) {
			value = cell.getBooleanCellValue();
		} else if(cellTypeEnum.equals(CellType.BLANK)) {
			value = "";
		}
		return value;
	}

	public static  Integer getMaxDay(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		Date parse = null;
		try {
			parse = sdf.parse(date);
		} catch (ParseException e) {
			throw new RuntimeException("日期转换异常");
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
		date=sf.format(parse);
		String[] split = date.split("-");
		Calendar cal = Calendar.getInstance();
		// 设置年份
		cal.set(Calendar.YEAR, Integer.valueOf(split[0]));
		// 设置月份
		cal.set(Calendar.MONTH, Integer.valueOf(split[1]) - 1);
		// 获取某月最大天数
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		// 设置日历中月份的最大天数
		cal.set(Calendar.DAY_OF_MONTH, lastDay);
		// 格式化日期
		SimpleDateFormat sdft = new SimpleDateFormat(YYYY_MM_DD);
		String lastDayOfMonth = sdft.format(cal.getTime());
		return Integer.valueOf(lastDayOfMonth.split("-")[2]);
	}
}
