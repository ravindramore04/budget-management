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

public class SaveVoucherHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
			ErrorHandler eh = new ErrorHandler();
			HttpSession session = request.getSession(true);
		try{

			int itr=Integer.parseInt((String)session.getAttribute("itr"));
			 if(itr>0){
			session.setAttribute("itr","0");


			CommonLogic cl = new CommonLogic();


			HashMap hmUser = (HashMap)session.getAttribute("user");
			String DBnm = (String)hmUser.get("DBnm");
			String strUserId = (String)hmUser.get("UId");
			String strToday = (String)cl.getToday();
			Vector vec=new Vector();
			Vector vector=new Vector();
			Vector vec1=new Vector();
			CVDal cvdal = new CVDal(DBnm);
			boolean bHead=false;
			boolean bNetAmount=false;
			boolean bTdsAmount=false;

			DynaActionForm daf = (DynaActionForm)form;
			sop("--daf->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>---"+daf.getMap().entrySet());

            String strId= (String)daf.get("txtId");
            sop("-------------strId--------------&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&++++++++++++++++++++##############@@@@@@@@@@------------------------"+strId);
            String strDate= (String)daf.get("txtDt");
            String strVoucherNo= (String)daf.get("txtNo");
            String HeadId= (String)daf.get("HeadId");
			String strDepartmentId =(String)daf.get("strDepartmentId");
            String strdblAmount= (String)daf.get("txtAmt");
            String strdblTds= (String)daf.get("txtTds");
            String strType= (String)daf.get("txtType");
			String strTDS= (String)daf.get("txtTDS");
            String strToAcc= (String)daf.get("txtAcc");
            String strbMode= (String)daf.get("txtMode");
            String strBank= (String)daf.get("txtBank");
            String strReceiverNm= (String)daf.get("txtReceiver");
            String strChequeNo= (String)daf.get("txtChqno");
            String strInsertBy=strUserId;
            String strInsertOn=strToday;
            double dbBalance=0;
			String netAmount="";
			String TDSAmount="";
			int srCvouNO=1;
			if(strdblTds==null || strdblTds.equals("null"))
				strdblTds="0";

            dbBalance=Double.parseDouble(strdblAmount)+Double.parseDouble(strdblTds);

           /*if(strId != null && strId.length()>0){
				vec.clear();
				vec.addElement(strId);
				cvdal.setSQL("openVoucherId",vec);
				vector=(Vector)cvdal.executeQuery();
				if(vector!=null && vector.size()>0){
					HashMap hm=(HashMap)vector.elementAt(0);
					HeadId=(String)hm.get("HeadId");
					netAmount=(String)hm.get("dblAmount");
					TDSAmount=(String)hm.get("dblTds");
		   }*/

         ////************************************////
			vec.clear();
			String voucher_id = cvdal.getMaxId("voucher_details_MAX_ID");
			String voucher_number = cvdal.getMaxId("voucher_number_MAX_ID");
			String budget_note_id=(String)daf.get("budget_note_id");

			     vec.add(voucher_id);
			     vec.add(voucher_number);
			     vec.add(budget_note_id);
				 vec.add(strDate);
				 vec.add(strdblAmount);
				 vec.add(strdblTds);
				 vec.add(strType);
				 vec.add(strbMode);
				 vec.add(strBank);
				 vec.add(strChequeNo);
				 vec.add(strReceiverNm);
				 vec.add(strToAcc);
				 vec.add("1011");
				 vec.add(strUserId);
				 vec.add(strInsertOn);
				 vec.add(strInsertBy);
				 vec.add(strInsertOn);
				 vec.add(strVoucherNo);

				 if(strId == null || strId.length()==0){
				cvdal.setSQL("insertintoBudgetVoucher",vec);
				int irow=cvdal.executeUpdate();
			}else{
				vec.addElement(strId);
					 cvdal.setSQL("updateintoVoucher",vec);
				int irow=cvdal.executeUpdate();
			}

				vec.clear();
				 vec.addElement(""+dbBalance);
				vec.addElement(""+dbBalance);
				vec.addElement(HeadId);
				vec.addElement(strDepartmentId);
				cvdal.setSQL("adjustAllocatedAndReservedAmount",vec);
				int irow2=cvdal.executeUpdate();

			   if(bHead){
					vec.clear();
					vec.addElement(""+dbBalance);
					vec.addElement(HeadId);
					cvdal.setSQL("minusHeadBalance",vec);
					int row=cvdal.executeUpdate();

					vec.clear();
					vec.addElement(""+dbBalance);
					vec.addElement(HeadId);
					cvdal.setSQL("updateHeadBalance",vec);
					int row1=cvdal.executeUpdate();
			    }

			FORWARD_final = Success;
			}else
			FORWARD_final = Success;





		}catch(Exception e){
			e.printStackTrace();
			String err = eh.getError("138620");
			String nxtpg = "ValidatedLogin.do";
			HashMap hmErr = new HashMap();
			hmErr.put("no","138620");
			hmErr.put("Source","SaveVoucherHandler");
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
