package struts.adminpanel;

import login.SessionUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import java.io.*;
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
       // request.setAttribute("downloadLink", excelFileName);
        request.setAttribute("downloadLink",request.getContextPath() + "/reports/allocation_report.xls");



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
        HSSFRow row = sheet.createRow(rowIndex++);

        HSSFCellStyle CS_BOLD_GREEN = createCellStyle(workbook);

        System.out.print("Head,");
        HSSFCell cell =  row.createCell(cellIndex++);
        cell.setCellValue("Head /Department ->");
        cell.setCellStyle(CS_BOLD_GREEN);



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
            System.out.print("Allocated Amount" + ", " + "Utilised Amount" + ",");
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
                    System.out.print(0 + "," + 0 + ",");
                    row.createCell(cellIndex++).setCellValue("0.00");
                    row.createCell(cellIndex++).setCellValue("0.00");

                } else {
                    System.out.print(budgetAllocationState.getAllocatedAmount() + "," + budgetAllocationState.getUtilisedAmount() + ",");
                    row.createCell(cellIndex++).setCellValue(budgetAllocationState.getAllocatedAmount());
                    row.createCell(cellIndex++).setCellValue(budgetAllocationState.getUtilisedAmount());
                }
            }
            System.out.print("\n");
        }

        for (int i = 0; i < ( (sortedDepartments.size()*2 ) + 1); i++) {
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
        SortedSet<String> sortedHeads = new TreeSet<String>();
        SortedSet<String> sortedDepartments = new TreeSet<String>();

        // Populate data from vector
        if (vec1.size() > 0) {
            for (int i = 0; i < vec1.size(); i++) {
                HashMap map = (HashMap) vec1.get(i);
                String headName = (String) map.get("HEAD_NAME");
                String departmentName = (String) map.get("DEPARTMENT_NAME");

                sortedHeads.add(headName);
                sortedDepartments.add(departmentName);

                BudgetAllocationState budgetAllocationState = new BudgetAllocationState(
                        headName,
                        departmentName,
                        (String) map.get("ALLOCATED_AMOUNT"),
                        (String) map.get("RESERVED_AMOUNT"),
                        (String) map.get("UTILISED_AMOUNT"),
                        (String) map.get("REMAINING_AMOUNT")
                );

                budgetAllocationStateMap.put(budgetAllocationState.getHeadDepartmentKey(), budgetAllocationState);
            }
        }


        String filePath =getReportFullPath(request);


       // String filePath = getReportFullPath(request);
        System.out.print("File Path >>>>" + filePath);

        PrintWriter writer = null;
        try {
            writer = new PrintWriter(new FileWriter(filePath));

            // Header row 1
            writer.print("Head,");
            for (String department : sortedDepartments) {
                writer.print(department + " - Allocated,");
                writer.print(department + " - Utilised,");
            }
            writer.print("\n");

            // Data rows
            for (String head : sortedHeads) {
                writer.print(head + ",");
                for (String department : sortedDepartments) {
                    String key = head + "-I_AM_MAK-" + department;
                    BudgetAllocationState state = budgetAllocationStateMap.get(key);
                    if (state == null) {
                        writer.print("0,0,");
                    } else {
                        writer.print(state.getAllocatedAmount() + "," + state.getUtilisedAmount() + ",");
                    }
                }
                writer.print("\n");
            }

            writer.flush();
            //response.setContentType("application/vnd.ms-excel");
            //response.setHeader("Content-Disposition", "attachment; filename=\"allocation_report.xls\"");
            System.out.println("CSV report generated: allocation_report.xls");
            request.setAttribute("downloadLink",request.getContextPath() + "/reports/allocation_report.xls");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) writer.close();
        }
    }



    private String getReportFullPath(HttpServletRequest request){
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
