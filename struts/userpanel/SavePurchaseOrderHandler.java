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

public class SavePurchaseOrderHandler extends org.apache.struts.action.Action
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
			int Itr= Integer.parseInt((String)session.getAttribute("itr"));
			if(Itr==1){
				CommonLogic cl = new CommonLogic();
				session.setAttribute("itr","0")	;

				HashMap hmUser = (HashMap)session.getAttribute("user");
				String DBnm = (String)hmUser.get("DBnm");
				String strUserId = (String)hmUser.get("UId");
				String strToday = (String)cl.getToday();
				Vector vec=new Vector();
				CVDal cvdal = new CVDal(DBnm);
				boolean bHead=false;
				boolean bNetAmount=false;
				boolean bTdsAmount=false;
				int iit=0;

				DynaActionForm daf = (DynaActionForm)form;

				String strId= request.getParameter("POId");
				String OldheadId= request.getParameter("OldheadId");
				String OAmmount= request.getParameter("OAmmount");
				sop("strId---------->"+strId);
				String strDate= (String)daf.get("txtDt");
				String strPONo= (String)daf.get("txtNo");
				String strBudgId= (String)daf.get("txtHeadId");
				String strPartyNm= (String)daf.get("txtPartyNm");
				String strAmount= (String)daf.get("txtAmt");
				String Non = request.getParameter("Non");
				String Con = request.getParameter("Con");
				double dbBalance=0;
				int NewId=10000;

				if(strId != null && strId.length()>0){
					Vector UPDT =new Vector();
					UPDT.addElement(strPONo);
					UPDT.addElement(strBudgId);
					UPDT.addElement(strDate);
					UPDT.addElement(Con);
					UPDT.addElement(Non);
					UPDT.addElement(strPartyNm);
					UPDT.addElement(strAmount);
					UPDT.addElement(strId);
					cvdal.setSQL("UpdatePODetails",UPDT);
					int Row = cvdal.executeUpdate();
					vec.clear();
					vec.addElement(OAmmount);
					vec.addElement(OldheadId);
					cvdal.setSQL("updateHeadBalance",vec);
					int irow2=cvdal.executeUpdate();
					vec.clear();
					vec.addElement(strAmount);
					vec.addElement(strBudgId);
					cvdal.setSQL("minusHeadBalance",vec);
					int row=cvdal.executeUpdate();
				}else{
					Vector My = new Vector();
					cvdal.setSQL("MAxPOId",My);
					Vector vec11=(Vector)cvdal.executeQuery();
					if(vec11!= null && vec11.size()>0){
						HashMap Myy= (HashMap) vec11.elementAt(0);
						String LastId= (String)Myy.get("LastId");
						if(LastId != null)
						{
							sop("---------"+LastId);
							NewId=Integer.parseInt(LastId);
							NewId++;
						}
					}
					Vector UPDT =new Vector();
					UPDT.addElement(strPONo);
					UPDT.addElement(""+NewId);
					UPDT.addElement(strBudgId);
					UPDT.addElement(strDate);
					UPDT.addElement(Con);
					UPDT.addElement(Non);
					UPDT.addElement(strPartyNm);
					UPDT.addElement(strAmount);
					cvdal.setSQL("insertintoPO",UPDT);
					int Row = cvdal.executeUpdate();
					vec.clear();
					vec.addElement(strAmount);
					vec.addElement(strBudgId);
					cvdal.setSQL("minusHeadBalance",vec);
					int row1=cvdal.executeUpdate();
				}
			}
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
