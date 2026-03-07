package struts.adminpanel;

import login.SessionUtils;
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

public class viewReportHandler extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	private static final String Success_all = "success_all";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
		HttpSession session = request.getSession(true);
		ErrorHandler eh = new ErrorHandler();
		try{
			DynaActionForm daf = (DynaActionForm)form;
			sop("DAF>>>>>>>" + daf.getMap().entrySet());
			String code=(String)daf.get("opr");

			request.setAttribute("data", getGroupWiseData("1",session));
			request.setAttribute("data1", getGroupWiseData("0",session));
			HashMap hmPage = new HashMap();
			request.setAttribute("page", hmPage);
			if(code.equals("2")){
				FORWARD_final = Success;
			}else {
				FORWARD_final = Success_all;
			}
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138530");
				String nxtpg = "viewRpt.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138530");
				hmErr.put("Source","viewReportHandler");
				hmErr.put("err",err);
				hmErr.put("nxtpg",nxtpg);
				request.setAttribute("err",hmErr);
				request.setAttribute("eDetail",e);
                FORWARD_final = GLOBAL_FORWARD_failure;
            }
            sop("forward value is--> "+FORWARD_final);
            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public HashMap getGroupWiseData(String grpId,HttpSession session){
		HashMap My = (HashMap)session.getAttribute("user");
		String DBnm = (String)My.get("DBnm");
		CVDal cvdal = new CVDal(DBnm);

		HashMap hmFinalData = new HashMap();
		Vector vec = new Vector();
		Vector vec1 = new Vector();
		Vector bugGrp = new Vector();
		vec.addElement(grpId);
		cvdal.setSQL("getAllGroupId", vec);
		bugGrp = cvdal.executeQueryGetList();

		sop("Group Id List >>>> " + bugGrp);

		if (bugGrp != null && bugGrp.size() > 0) {

			for (int indx1 = 0; indx1 < bugGrp.size(); indx1++) {

				String budGrpId = (String) bugGrp.elementAt(indx1);

				Vector grp = new Vector();
				grp.addElement(budGrpId);

				if (SessionUtils.isAccountUser(session)) {
					cvdal.setSQL("getAllHeadGroupWiseBallance", grp);
				}
				else {
					grp.addElement(SessionUtils.getDepartmentId(session));
					cvdal.setSQL("getAllHeadGroupWiseBallanceDept", grp);
				}

				HashMap hmFinal = new HashMap();

				vec1 = (Vector) cvdal.executeQuery();

				if (vec1 != null && vec1.size() > 0) {

					for (int indx = 0; indx < vec1.size(); indx++) {

						HashMap hmt = (HashMap) vec1.elementAt(indx);
						hmFinal.put("" + indx, hmt);

					}
				}

				hmFinalData.put(budGrpId, hmFinal);
			}
		}


		return 	hmFinalData;
	}


	public void sop(String msg){
		System.out.println(msg);
	}
}
