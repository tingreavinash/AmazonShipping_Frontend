package com.avinash.amazonshipping.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import com.avinash.amazonshipping.model.Order;

@Service
public class FileHandler {

	public void createFile(List<Order> orderList, String filepath) throws IOException {
		System.out.println("--------Inside createFile");
		// Create blank workbook
		XSSFWorkbook workbook = new XSSFWorkbook();

		// Create a blank sheet
		XSSFSheet spreadsheet = workbook.createSheet("Barcode");

		// Create row object
		XSSFRow row;

		// This data needs to be written (Object[])
		Map<Integer, Object[]> orderinfo = new TreeMap<Integer, Object[]>();
		
		orderinfo.put(1,
				new Object[] { "Sr No.", "Barcode", "Tracking ID", "Name", "Address", "Pin", "Weight", "Amount" });
		int rownum = 2;
		int srno = 1;
		for (Order o : orderList) {
			
			if (!o.isOrder_cancelled()) {
				orderinfo.put(rownum, new Object[] { srno, "", o.getTracking_id(), o.getRecipient_name(),
						o.getShip_city(), o.getShip_postal_code(), "", "" });
				rownum++;
				srno++;
			}
		}

		// Iterate over data and write to sheet
		Set<Integer> keyid = orderinfo.keySet();
		int rowid = 0;

		for (int key : keyid) {
			row = spreadsheet.createRow(rowid++);
			Object[] objectArr = orderinfo.get(key);
			int cellid = 0;

			for (Object obj : objectArr) {
				Cell cell = row.createCell(cellid++);
				if(obj.getClass() == Integer.class) {
					cell.setCellValue((int)obj );					
				}else if(obj.getClass() == Long.class) {
					cell.setCellValue((long)obj );
				}else {
					cell.setCellValue((String) obj);					
				}

			}
		}
		// Write the workbook in file system
		FileOutputStream out = new FileOutputStream(new File(filepath));

		workbook.write(out);
		out.close();
		workbook.close();
		System.out.println("Writesheet.xlsx written successfully");
	}
}
