package struts.adminpanel;
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
import struts.common.ErrorHandler;
import struts.common.CVDal;
import java.util.*;
import java.sql.*;


public class ChoosePODateHandler extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final =GLOBAL_FORWARD_failure;

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
		HttpSession session=request.getSession(true);
		ErrorHandler eh=(ErrorHandler)session.getAttribute("errorobject");
		try{
			/*CVDal cvdal= new CVDal("schlactual");
			HashMap hmUser=(HashMap)session.getAttribute("currentuser");
			String strBranchId=(String)hmUser.get("strBranchId");
			HashMap hmFinal = new HashMap();
			Vector vec = new Vector();
			vec.addElement(strBranchId);
			cvdal.setSQL("actual.openallcoursesforbranch",vec);
			Vector vector = (Vector)cvdal.executeQuery();
			if(vector != null && vector.size()!=0) {
				for(int indx=0;indx<vector.size();indx++){
					HashMap hm = (HashMap)vector.elementAt(indx);
					hmFinal.put(""+indx,hm);
				}
		    }
			request.setAttribute("data",hmFinal);*/

			FORWARD_final=Success;

		}catch(Exception e){
			e.printStackTrace();
			FORWARD_final = GLOBAL_FORWARD_failure;
		}

		sop("Before returning success*** "+FORWARD_final);
		return (mapping.findForward(FORWARD_final));

	}

	public void sop(String msg)	{

		//System.out.println(msg);

	}
}

