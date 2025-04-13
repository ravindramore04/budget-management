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

public class DelVouHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
			ErrorHandler eh = new ErrorHandler();
			HttpSession session = request.getSession(true);
			HashMap My = (HashMap)session.getAttribute("user");
			sop("inside delete voucher"+My);

		try{

		//	HttpSession session = request.getSession(true);
			//HashMap hmUser = (HashMap)session.getAttribute("user");
			CommonLogic cl = new CommonLogic();
			String strUserId = (String)My.get("UId");
			String strToday = (String)cl.getToday();
			String DBnm = (String)My.get("DBnm");
			sop("DBnm==========>111111111111111111111111111111111"+DBnm);
			CVDal cvdal = new CVDal(DBnm);
			sop("cvdal==========>2222222222222222222222"+cvdal);

			Vector vec=new Vector();

			DynaActionForm daf = (DynaActionForm)form;

            String strId= (String)daf.get("txtId");
			vec.addElement(strId);

			sop("b4 setsql");
			cvdal.setSQL("FindFromVoucher",vec);
			Vector vec1 = (Vector)cvdal.executeQuery();
			sop("vec1000000000000000000000000000000000000000000000"+vec1);
			HashMap hmt = new HashMap();
			if(vec1!=null && vec1.size()>0)
			{
					hmt = (HashMap)vec1.elementAt(0);
			}
/*			sop("----------------------------");
			sop("----------------------------");
			sop("HashMap Size -->"+hmt.size());
			sop("Voucher Id --> "+strId);
			sop("----------------------------");
			sop((String)hmt.get("voucherId"));
			sop((String)hmt.get("HeadId"));
			sop((String)hmt.get("dblAmount"));
			sop((String)hmt.get("dblTds"));
*/
			String Amount =(String)hmt.get("dblAmount");
			String TDS = (String)hmt.get("dblTds");
			double Tot =Double.parseDouble(Amount)+Double.parseDouble(TDS);
/*			sop("Total-->"+Tot);
			sop("----------------------------");
			sop("----------------------------");
*/
			vec.clear();
			vec.addElement(""+Tot);
			vec.addElement((String)hmt.get("HeadId"));
			cvdal.setSQL("updateHeadBalance",vec);
			int irow0=cvdal.executeUpdate();

			vec.clear();
			vec.addElement(strId);
			cvdal.setSQL("DeleteFromVoucher",vec);
			int irow=cvdal.executeUpdate();
			cvdal.setSQL("DeleteFromCheque",vec);
			int irow1=cvdal.executeUpdate();


			FORWARD_final = Success;
		}catch(Exception e){
			e.printStackTrace();
			String err = eh.getError("138530");
			String nxtpg = "CnlVoucher.do";
			HashMap hmErr = new HashMap();
			hmErr.put("no","138530");
			hmErr.put("Source","DelVouHandler");
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
