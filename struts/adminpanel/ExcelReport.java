package struts.adminpanel;

import login.SessionUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

import struts.adminpanel.excel.BudgetAllocationState;

/**
 * Created by morer on 11-05-2025.
 */
public class ExcelReport extends org.apache.struts.action.Action {

    private static final String Success = "success";
    public static final String GLOBAL_FORWARD_failure = "failure";
    private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
                                 HttpServletResponse response) throws RuntimeException, Exception {
        HttpSession session = request.getSession(true);
        HashMap My = (HashMap) session.getAttribute("user");
        String DBnm = (String) My.get("DBnm");
        struts.common.ErrorHandler eh = new struts.common.ErrorHandler();
        Vector vec = new Vector();
        Vector vec1 = new Vector();
        try {
            struts.common.CVDal cvdal = new struts.common.CVDal(DBnm);
            vec.clear();
            if(SessionUtils.isAccountORStoreUser(session)) {
                cvdal.setSQL("get_All_Allocation_Status_Report", vec);
            }else {
                vec.addElement(SessionUtils.getDepartmentId(session));
                cvdal.setSQL("get_All_Allocation_Status_Report_Department", vec);
            }

            vec1 = (Vector) cvdal.executeQuery();

            //createAllAllocationReportFile(vec1, request);
              createAllAllocationReport(vec1, request);

            FORWARD_final = Success;

        } catch (Exception e) {
            e.printStackTrace();
            FORWARD_final = GLOBAL_FORWARD_failure;
        }

        sop("Before returning success*** " + FORWARD_final);
        return (mapping.findForward(FORWARD_final));

    }

    public void sop(String msg) {

        System.out.println(msg);

    }


    private void createAllAllocationReport(Vector vec1, HttpServletRequest request) {

        Map<String, BudgetAllocationState> budgetAllocationStateMap = new HashMap<String, BudgetAllocationState>();

        String excelFileName = getReportFullPath(request);
        String fileName = new File(excelFileName).getName();
        request.setAttribute("downloadLink",request.getContextPath() + "/reports/"+fileName);



        SortedSet<String> sortedHeads = new TreeSet<String>();
        SortedSet<String> sortedDepartments = new TreeSet<String>();


        if (vec1.size() > 0) {
            for (int i = 0; i < vec1.size(); i++) {
                HashMap<String, String> map = (HashMap<String, String>) vec1.get(i);
                String headName = map.get("HEAD_NAME");
                String departmentName = map.get("DEPARTMENT_NAME");

                sortedHeads.add(headName);
                sortedDepartments.add(departmentName);

                BudgetAllocationState budgetAllocationState = new BudgetAllocationState(
                        headName,
                        departmentName,
                        map.get("ALLOCATED_AMOUNT"),
                        map.get("RESERVED_AMOUNT"),
                        map.get("UTILISED_AMOUNT"),
                        map.get("REMAINING_AMOUNT")

                );

                budgetAllocationStateMap.put(budgetAllocationState.getHeadDepartmentKey(), budgetAllocationState);
            }
        }

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("Sheet1");
        int rowIndex = 0;
        int cellIndex = 0;
        HSSFCellStyle CS_BOLD_GREEN = createCellStyle(workbook);


        HSSFRow titleRow = sheet.createRow(rowIndex++);

// Create bold centered style for the title
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        HSSFFont titleFont = workbook.createFont();
        titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        titleFont.setFontHeightInPoints((short) 14);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

// Set foreground (not background) color — this is the visible background in Excel
        titleStyle.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);

// Set title in first cell
        HSSFCell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("Utilization Report for All Heads");
        titleCell.setCellStyle(titleStyle);

// Merge first row across multiple columns (adjust 0 to N based on column count, example here: 5)
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));

        HSSFRow row = sheet.createRow(rowIndex++);
        System.out.print("Head,");
        HSSFCell cell = row.createCell(cellIndex++);
        cell.setCellValue("Head V / Department ->");
        cell.setCellStyle(CS_BOLD_GREEN);
        HSSFCellStyle numericStyle = workbook.createCellStyle();
        numericStyle.setDataFormat(workbook.createDataFormat().getFormat("#,##0.00"));


        for (String department : sortedDepartments) {
            System.out.print(department + ", " + department + ",");
            cell = row.createCell(cellIndex++);
            cell.setCellValue(department + " - Allocated");
            cell.setCellStyle(CS_BOLD_GREEN);

            cell = row.createCell(cellIndex++);
            cell.setCellValue(department + " - Utilised");
            cell.setCellStyle(CS_BOLD_GREEN);
        }
        System.out.print("\n");

        System.out.print(",");
        for (String department : sortedDepartments) {
            System.out.print("Allocated Amount" + ", " + "Reserved Amount" + ","+ "Utilised Amount" + ","+ "Remaining Amount" + ",");
        }
        System.out.print("\n");

        for (String head : sortedHeads) {
            row = sheet.createRow(rowIndex++);
            cellIndex = 0;
            System.out.print(head + ", ");
            row.createCell(cellIndex++).setCellValue(head);

            for (String department : sortedDepartments) {
                BudgetAllocationState budgetAllocationState = budgetAllocationStateMap.get(head + "-I_AM_MAK-" + department);

                if (null == budgetAllocationState) {
                    System.out.print(0 + "," + 0 + "," + 0 + "," + 0 + ",");
                    row.createCell(cellIndex++).setCellValue(Double.parseDouble("0.00"));
                    row.createCell(cellIndex++).setCellValue(Double.parseDouble("0.00"));

                } else {
                    System.out.print(budgetAllocationState.getAllocatedAmount() + "," + budgetAllocationState.getReservedAmount() + "," + budgetAllocationState.getUtilisedAmount() + "," + budgetAllocationState.getRemainingAmount() + ",");
                    HSSFCell cell1 = row.createCell(cellIndex++);
                    cell1.setCellValue(Double.parseDouble(budgetAllocationState.getAllocatedAmount()));
                    cell1.setCellStyle(numericStyle);

                    HSSFCell cell2 = row.createCell(cellIndex++);
                    cell2.setCellValue(Double.parseDouble(budgetAllocationState.getReservedAmount()) + Double.parseDouble(budgetAllocationState.getUtilisedAmount()));
                    cell2.setCellStyle(numericStyle);

                }
            }
            System.out.print("\n");
        }

        for (int i = 0; i < ( (sortedDepartments.size()*4 ) + 1); i++) {
            sheet.autoSizeColumn(i);
        }

        FileOutputStream out = null;
        try {
            out = new FileOutputStream(excelFileName);
            workbook.write(out);
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    private void createAllAllocationReportFile(Vector vec1, HttpServletRequest request) {

        Map<String, BudgetAllocationState> budgetAllocationStateMap = new HashMap<String, BudgetAllocationState>();

        String excelFileName = getReportFullPath(request);
        String fileName = new File(excelFileName).getName();
        request.setAttribute("downloadLink",request.getContextPath() + "/reports/"+fileName);



        SortedSet<String> sortedHeads = new TreeSet<String>();
        SortedSet<String> sortedDepartments = new TreeSet<String>();


        if (vec1.size() > 0) {
            for (int i = 0; i < vec1.size(); i++) {
                HashMap<String, String> map = (HashMap<String, String>) vec1.get(i);
                String headName = map.get("HEAD_NAME");
                String departmentName = map.get("DEPARTMENT_NAME");

                sortedHeads.add(headName);
                sortedDepartments.add(departmentName);

                BudgetAllocationState budgetAllocationState = new BudgetAllocationState(
                        headName,
                        departmentName,
                        map.get("ALLOCATED_AMOUNT"),
                        map.get("RESERVED_AMOUNT"),
                        map.get("UTILISED_AMOUNT"),
                        map.get("REMAINING_AMOUNT")

                );

                budgetAllocationStateMap.put(budgetAllocationState.getHeadDepartmentKey(), budgetAllocationState);
            }
        }

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("Sheet1");
        int rowIndex = 0;
        int cellIndex = 0;
        HSSFCellStyle CS_BOLD_GREEN = createCellStyle(workbook);


        HSSFRow titleRow = sheet.createRow(rowIndex++);

// Create bold centered style for the title
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        HSSFFont titleFont = workbook.createFont();
        titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        titleFont.setFontHeightInPoints((short) 14);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

// Set foreground (not background) color — this is the visible background in Excel
        titleStyle.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);

// Set title in first cell
        HSSFCell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("Utilization Report for All Heads");
        titleCell.setCellStyle(titleStyle);

// Merge first row across multiple columns (adjust 0 to N based on column count, example here: 5)
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));

        HSSFRow row = sheet.createRow(rowIndex++);
        System.out.print("Head,");
        HSSFCell cell = row.createCell(cellIndex++);
        cell.setCellValue("Head V / Department ->");
        cell.setCellStyle(CS_BOLD_GREEN);
        HSSFCellStyle numericStyle = workbook.createCellStyle();
        numericStyle.setDataFormat(workbook.createDataFormat().getFormat("#,##0.00"));


        for (String department : sortedDepartments) {
            System.out.print(department + ", " + department + ",");
            cell = row.createCell(cellIndex++);
            cell.setCellValue(department + " - Allocated");
            cell.setCellStyle(CS_BOLD_GREEN);

            cell = row.createCell(cellIndex++);
            cell.setCellValue(department + " - Reserved");
            cell.setCellStyle(CS_BOLD_GREEN);

            cell = row.createCell(cellIndex++);
            cell.setCellValue(department + " - Utilised");
            cell.setCellStyle(CS_BOLD_GREEN);

            cell = row.createCell(cellIndex++);
            cell.setCellValue(department + " - Remaining");
            cell.setCellStyle(CS_BOLD_GREEN);
        }
        System.out.print("\n");

        System.out.print(",");
        for (String department : sortedDepartments) {
            System.out.print("Allocated Amount" + ", " + "Reserved Amount" + ","+ "Utilised Amount" + ","+ "Remaining Amount" + ",");
        }
        System.out.print("\n");

        for (String head : sortedHeads) {
            row = sheet.createRow(rowIndex++);
            cellIndex = 0;
            System.out.print(head + ", ");
            row.createCell(cellIndex++).setCellValue(head);

            for (String department : sortedDepartments) {
                BudgetAllocationState budgetAllocationState = budgetAllocationStateMap.get(head + "-I_AM_MAK-" + department);

                if (null == budgetAllocationState) {
                    System.out.print(0 + "," + 0 + "," + 0 + "," + 0 + ",");
                    row.createCell(cellIndex++).setCellValue(Double.parseDouble("0.00"));
                    row.createCell(cellIndex++).setCellValue(Double.parseDouble("0.00"));
                    row.createCell(cellIndex++).setCellValue(Double.parseDouble("0.00"));
                    row.createCell(cellIndex++).setCellValue(Double.parseDouble("0.00"));

                } else {
                    System.out.print(budgetAllocationState.getAllocatedAmount() + "," + budgetAllocationState.getReservedAmount() + "," + budgetAllocationState.getUtilisedAmount() + "," + budgetAllocationState.getRemainingAmount() + ",");
                    HSSFCell cell1 = row.createCell(cellIndex++);
                    cell1.setCellValue(Double.parseDouble(budgetAllocationState.getAllocatedAmount()));
                    cell1.setCellStyle(numericStyle);

                    HSSFCell cell2 = row.createCell(cellIndex++);
                    cell2.setCellValue(Double.parseDouble(budgetAllocationState.getReservedAmount()));
                    cell2.setCellStyle(numericStyle);

                    HSSFCell cell3 = row.createCell(cellIndex++);
                    cell3.setCellValue(Double.parseDouble(budgetAllocationState.getUtilisedAmount()));
                    cell3.setCellStyle(numericStyle);

                    HSSFCell cell4 = row.createCell(cellIndex++);
                    cell4.setCellValue(Double.parseDouble(budgetAllocationState.getRemainingAmount()));
                    cell4.setCellStyle(numericStyle);
                }
            }
            System.out.print("\n");
        }

        for (int i = 0; i < ( (sortedDepartments.size()*4 ) + 1); i++) {
            sheet.autoSizeColumn(i);
        }

        FileOutputStream out = null;
        try {
            out = new FileOutputStream(excelFileName);
            workbook.write(out);
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



    private String getReportFullPath_Old(HttpServletRequest request){
        String appPath = request.getSession().getServletContext().getRealPath("/");
        String reportsPath = appPath + File.separator + "reports";

        // Step 2: Create reports directory if it doesn't exist
        File reportsDir = new File(reportsPath);
        if (!reportsDir.exists()) {
            reportsDir.mkdirs();
        }

        // Step 3: Define the output CSV file path  request.getContextPath() + "/reports/allocation_report.xls"
        //String filePath =  request.getContextPath() + "/reports/"+"AlllocationUtilization_"+struts.adminpanel.utils.DateUtils.getCurrentTimestamp()+".xls";
        //String filePath =   request.getContextPath() + "/reports/allocation_report.xls";
        String filePath = reportsPath + File.separator + "allocation_report.xls";
        return filePath;

    }

    private String getReportFullPath(HttpServletRequest request) {
        // Step 1: Get the application path
        String appPath = request.getSession().getServletContext().getRealPath("/");
        String reportsPath = appPath + File.separator + "reports";

        // Step 2: Create reports directory if it doesn't exist
        File reportsDir = new File(reportsPath);
        if (!reportsDir.exists()) {
            reportsDir.mkdirs();
        }

        // Step 3: Generate timestamp for the filename
        String timestamp = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss").format(new Date());

        // Step 4: Define the output file path with datetime in filename
        String filePath = reportsPath + File.separator + "allocation_report_" + timestamp + ".xls";

        return filePath;
    }

    private HSSFCellStyle createCellStyle(HSSFWorkbook workbook){
        // Create bold font
        HSSFFont boldFont = workbook.createFont();
        boldFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

        // Create cell style with bold font and background color
        HSSFCellStyle style = workbook.createCellStyle();
        style.setFont(boldFont);
        style.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

        return style;
    }
}
