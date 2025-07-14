package struts.adminpanel;

import login.SessionUtils;
import struts.adminpanel.beans.VoucherReportRow;
import struts.adminpanel.utils.DateUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.action.DynaActionForm;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.HashMap;
import struts.common.CVDal;
import struts.common.CommonLogic;
import struts.common.ErrorHandler;
import java.util.*;
import java.sql.*;

public class viewReportHeadHandler extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	private static final String Print = "print";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");
            ErrorHandler eh = new ErrorHandler();
			Vector vec = new Vector();
			Vector vec1 = new Vector();
            try
            {
				CVDal cvdal = new CVDal(DBnm);
				vec.clear();
				DynaActionForm daf = (DynaActionForm)form;
				sop("Daf   >>"+daf.getMap().entrySet());
				String fromDate = (String)daf.get("fromDate");
				String toDate = (String)daf.get("toDate");
				String chkCash = (String)daf.get("rd");
				String headId = (String)daf.get("txtBGid");
				String strDepartmentId=(String)daf.get("strDepartmentId");
				String operation=(String)daf.get("opr");

                String payMethod=chkCash;
				if("3".equals(chkCash)){
					payMethod="1,2";
				}

				//vec.addElement(DateUtils.getFormattedCurrentDate());
				//vec.addElement(DateUtils.getFormattedCurrentDate());
				vec.addElement(fromDate);
				vec.addElement(toDate);

				if (!SessionUtils.isAccountUser(session)) {
					strDepartmentId=SessionUtils.getDepartmentId(session);
					sop("Department ID>>"+strDepartmentId);
				}

					if("0".equals(strDepartmentId) && "0".equals(headId)){
						vec.addElement(payMethod);
						cvdal.setSQL("ALL_VOUCHER_REPORT_PAY_METHOD", vec);
					}else if("0".equals(strDepartmentId) && !"0".equals(headId)){
						vec.addElement(headId);
						vec.addElement(payMethod);
						cvdal.setSQL("ALL_VOUCHER_REPORT_BY_HEAD_PAY_METHOD", vec);
					}else if(!"0".equals(strDepartmentId) && "0".equals(headId)) {
						vec.addElement(strDepartmentId);
						vec.addElement(payMethod);
						cvdal.setSQL("ALL_VOUCHER_REPORT_BY_ALL_HEAD_DEPT_PAY_METHOD", vec);
					}else{
						vec.addElement(strDepartmentId);
						vec.addElement(headId);
						vec.addElement(payMethod);
						cvdal.setSQL("ALL_VOUCHER_REPORT_BY_DEPT_AND_HEAD", vec);
					}

				vec1 = (Vector) cvdal.executeQuery();

				List<VoucherReportRow> createVoucherReportRows = createVoucherReportRows(vec1);

				sop("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH" + createVoucherReportRows);

				request.setAttribute("ReportDetails", createVoucherReportRows);

				request.setAttribute("toDate",toDate);
				request.setAttribute("fromDate",fromDate);
				request.setAttribute("chkCash",chkCash);
				request.setAttribute("headId",headId);
				request.setAttribute("strDepartmentId",strDepartmentId);

				FORWARD_final = Success;
				if("2".equals(operation))
					FORWARD_final = Print;

            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138530");
				String nxtpg = "ValidatedLogin.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138530");
				hmErr.put("Source","AllHeadHandler");
				hmErr.put("err",err);
				hmErr.put("nxtpg",nxtpg);
				request.setAttribute("err",hmErr);
				request.setAttribute("eDetail",e);
                FORWARD_final = GLOBAL_FORWARD_failure;
            }
            sop("forward value is--> "+FORWARD_final);
            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	private static List<VoucherReportRow> createVoucherReportRows(Vector vec1){
		List<VoucherReportRow> voucherReportRows = new ArrayList<VoucherReportRow>();

		if (vec1.size() > 0){
			for (int i=0; i<vec1.size(); i++){
				HashMap<String, String> map = (HashMap<String, String>) vec1.get(i);
				voucherReportRows.add(new VoucherReportRow((String)map.get("voucher_id"),
						(String)map.get("voucher_date"),
						(String)map.get("VOUCHER_AMOUNT"),
						(String)map.get("receiver_name"),
						(String)map.get("strDepartmentNm"),
						(String)map.get("strName")
				));
			}
		}


		return voucherReportRows;

	}

	public void sop(String msg){
		System.out.println(msg);
	}
}
