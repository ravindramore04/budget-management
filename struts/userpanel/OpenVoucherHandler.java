package struts.userpanel;

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

public class OpenVoucherHandler extends org.apache.struts.action.Action
{
    private static final String Success = "success";
    public static final String GLOBAL_FORWARD_failure = "failure";
    private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");
            ErrorHandler eh = new ErrorHandler();
            try{
                CommonLogic cl = new CommonLogic();
                CVDal cvdal = new CVDal(DBnm);
                CVDal cvdalBn = new CVDal(DBnm);
                HashMap hmFinal = new HashMap();
                Vector vec = new Vector();
				Vector vec1 = new Vector();
				DynaActionForm daf = (DynaActionForm)form;
				String operation=(String)daf.get("operation");
				sop("Form Details >>>>>>>>>>>>>>>" + daf.getMap().entrySet());
				sop("Operation >>>>>>>>>>>>>" + operation);

				vec.clear();
				HashMap hmAll = new HashMap();
        		HashMap hmt= new HashMap();
/*				cvdal.setSQL("openHeadExpanse", vec);
				vec2 = (Vector)cvdal.executeQuery();
				if(vec2!=null && vec2.size()>0){
					HashMap hmmt = (HashMap)vec2.elementAt(0);
					hmt.put("exp",(String)hmmt.get("exp"));
				}
				request.setAttribute("expense", hmt);*/

                String strId = (String)daf.get("id");
                int nOpr = Integer.parseInt((String)daf.get("opr"));
                switch(nOpr){
                    case 1:
                        //add new
                    case 2:
                        //update
                        vec.clear();
                        vec.addElement(strId);
                        if("view".equals(operation)){
                            cvdal.setSQL("openVoucherDetailsWithVoucherId", vec);
                        }else{
                            cvdal.setSQL("openVoucherDetailsWithBudgetNoteId", vec);

                            cvdalBn.setSQL("getTotalVoucherAmoutForBudgetNote",vec);

                            vec1 = (Vector)cvdalBn.executeQuery();
                            if(vec1!=null && vec1.size()>0){
                               HashMap noteAmount = (HashMap)vec1.elementAt(0);
                                String budgetNoteVoucherAmount=(String)noteAmount.get("BudgetNoteVoucherAmount");
                                request.setAttribute("budgetNoteVoucherAmount", budgetNoteVoucherAmount);
                            }

                        }
                        vec1.clear();
                        vec1 = (Vector)cvdal.executeQuery();
                        if(vec1!=null && vec1.size()>0){
                            hmFinal = (HashMap)vec1.elementAt(0);
                        }



                        FORWARD_final = "budgetvoucher";
                        break;
                    case 5:
                        //print
                        vec.clear();
                        vec.addElement(strId);
                        cvdal.setSQL("GET_VOUCHER_DETAILS_FOR_PRINT", vec);
                        vec1 = (Vector)cvdal.executeQuery();
                        if(vec1!=null && vec1.size()>0){
                            hmFinal = (HashMap)vec1.elementAt(0);
                        }
                        FORWARD_final = Success;
                        break;

                }


                request.setAttribute("data", hmFinal);

            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("147420");
				String nxtpg = "AllVoucher.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","147420");
				hmErr.put("Source","OpenVoucherHandler");
				hmErr.put("err",err);
				hmErr.put("nxtpg",nxtpg);
				request.setAttribute("err",hmErr);
				request.setAttribute("eDetail",e);
                FORWARD_final = GLOBAL_FORWARD_failure;
            }

            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println(msg);
	}
}
