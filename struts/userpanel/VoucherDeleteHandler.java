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
import java.util.Enumeration;

import java.util.HashMap;
import struts.common.CVDal;
import struts.common.CommonLogic;
import struts.common.ErrorHandler;
import java.util.*;
import java.sql.*;

public class VoucherDeleteHandler extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            ErrorHandler eh = new ErrorHandler();
            HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");
            CVDal cvdal = new CVDal(DBnm);
		    DynaActionForm daf = (DynaActionForm)form;
	    	try
	    	{

				sop("I am in Vocucher Delete"+daf.getMap().entrySet());

                String voucher_id=(String)daf.get("id");

				Vector vec = new Vector();
				vec.addElement(voucher_id);
				cvdal.setSQL("VoucherDelete",vec);
				int i=cvdal.executeUpdate();


			/*	int No_Of_Row=0;
            	Enumeration en = request.getParameterNames();
	            while(en.hasMoreElements())
	            {
	            	sop("----------------------------------- After While");
	            	String ParamName =(String)en.nextElement();
	            	sop("Parameter -------->   "+ ParamName);
	            	if(ParamName.length()>2)
	            	{
		            	if(ParamName.substring(0,3).equals("chk"))
		            	{
			            		String ParamValues[] = request.getParameterValues(ParamName);
								Vector vec = new Vector();
								vec.addElement(ParamValues[0]);
								cvdal.setSQL("VoucherDelete",vec);
								int i=cvdal.executeUpdate();
								No_Of_Row =No_Of_Row+i;
						}
					}
	            }
	            if(No_Of_Row>0)*/


	            		FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("148621");
				String nxtpg = "AllVoucher.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","148621");
				hmErr.put("Source","VoucherDeleteHandler");
				hmErr.put("err",err);
				hmErr.put("nxtpg",nxtpg);
				request.setAttribute("err",hmErr);
				request.setAttribute("eDetail",e);
                FORWARD_final = GLOBAL_FORWARD_failure;
            }
            sop("forward value is--> "+FORWARD_final);
            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println(msg);
	}
}
