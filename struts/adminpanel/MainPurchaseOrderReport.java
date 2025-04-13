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


public class MainPurchaseOrderReport extends org.apache.struts.action.Action
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
			DynaActionForm daf = (DynaActionForm)form;
		//	sop("hmUser-------------->>"+daf);
			HashMap hmUser = (HashMap)session.getAttribute("user");
			//sop("hmUser-------------->>"+hmUser);
			String DBnm = (String)hmUser.get("DBnm");
			String con = request.getParameter("con");
			String Non = request.getParameter("Non");

			CVDal cvdal= new CVDal(DBnm);
			HashMap hmFinal = new HashMap();
			HashMap hm = new HashMap();
			Vector vec = new Vector();

			if(Non==null ){
			Non="0";
			vec.clear();
			vec.addElement(con);

			cvdal.setSQL("getPOCon",vec);
			Vector vec2 = (Vector)cvdal.executeQuery();
			sop("@@@-----vec2---for consumable--@@@"+vec2);
				if(vec2!=null && vec2.size()!=0){
					HashMap hmStd = new HashMap();
					for(int indx=0;indx<vec2.size();indx++){
						HashMap hmt=(HashMap)vec2.elementAt(indx);
						hmStd.put(""+indx,hmt);
					}
					hm.put("std",hmStd);
				}
				request.setAttribute("data1",hm);

				}else	if(con==null ){
					con="0";
					vec.clear();
					vec.addElement(Non);

					cvdal.setSQL("getPONonCon",vec);
					Vector vec2 = (Vector)cvdal.executeQuery();
					sop("@@@-----vec2 for NonConsumable-----@@@"+vec2);
						if(vec2!=null && vec2.size()!=0){
							HashMap hmStd = new HashMap();
							for(int indx=0;indx<vec2.size();indx++){
								HashMap hmt=(HashMap)vec2.elementAt(indx);
								hmStd.put(""+indx,hmt);
							}
							hm.put("std",hmStd);
						}
						request.setAttribute("data2",hm);
			}else{
				vec.clear();
				vec.addElement(con);
				vec.addElement(Non);

				cvdal.setSQL("getPO",vec);
				Vector vec2 = (Vector)cvdal.executeQuery();
				sop("@@@-----vec2-----@@@"+vec2);
					if(vec2!=null && vec2.size()!=0){
						HashMap hmStd = new HashMap();
						for(int indx=0;indx<vec2.size();indx++){
							HashMap hmt=(HashMap)vec2.elementAt(indx);
							hmStd.put(""+indx,hmt);
						}
						hm.put("std",hmStd);
					}

				}

			request.setAttribute("data",hm);
			FORWARD_final=Success;
		}catch(Exception e){
			e.printStackTrace();
			FORWARD_final = GLOBAL_FORWARD_failure;
		}
		sop("Before returning success*** "+FORWARD_final);
		return (mapping.findForward(FORWARD_final));
	}

	public void sop(String msg)	{
		System.out.println(msg);
	}
}

