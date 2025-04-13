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
import struts.common.CVDal;
import struts.common.CommonLogic;
import struts.common.ErrorHandler;
import java.util.*;
import java.sql.*;

public class showBudgetAllocationHandler extends org.apache.struts.action.Action
{
    private static final String Success = "success";
    public static final String GLOBAL_FORWARD_failure = "failure";
    public static final String Delete = "delete";
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
                HashMap hmHead = new HashMap();
                HashMap hmFinal = new HashMap();
                Vector vec = new Vector();
                String HeadId="";
				String Amount="";

                DynaActionForm daf = (DynaActionForm)form;
                String strId = (String)daf.get("id");

				String strAllocId[]=request.getParameterValues("txtAllocId");

               	int nOpr = Integer.parseInt((String)daf.get("opr"));

                vec.clear();
				cvdal.setSQL("openAllHead", vec);
				Vector vec2 = (Vector)cvdal.executeQuery();
				if(vec2!=null && vec2.size()>0){
					for(int i=0;i<vec2.size();i++){
					 HashMap hm=(HashMap)vec2.elementAt(i);
					 hmHead.put(""+i,hm);
			       }
				}


                //sop("sunil----"+nOpr);
                switch(nOpr){
                    case 1:
                        //add new
                        FORWARD_final = Success;
                        break;
                    case 2:
                        //update
                        vec.clear();
                        vec.addElement(strId);
                        cvdal.setSQL("openAllocationWithId", vec);
                        Vector vec21 = (Vector)cvdal.executeQuery();
                        if(vec21!=null && vec21.size()>0){
                            hmFinal = (HashMap)vec21.elementAt(0);
                        }
                        FORWARD_final = Success;
                        break;
                    case 3:
                        //delete

                       for(int indx=0;indx<strAllocId.length;indx++){
							vec.clear();
							vec.addElement(strAllocId[indx]);
							cvdal.setSQL("openAllocationWithId",vec);
							Vector vec1=(Vector)cvdal.executeQuery();
							if(vec1!=null && vec1.size()>0){
							 HashMap hmt=(HashMap)vec1.elementAt(0);
							 HeadId=(String)hmt.get("HeadId");
							 Amount=(String)hmt.get("dblAmount");
							}

							vec.clear();
							vec.addElement(strAllocId[indx]);
							cvdal.setSQL("deleteFromAllocation",vec);
							int row=cvdal.executeUpdate();

							vec.clear();
							vec.addElement(Amount);
							vec.addElement(HeadId);
							cvdal.setSQL("minusHeadBalance",vec);
							int row1=cvdal.executeUpdate();
						}
                        FORWARD_final = Delete;
                        break;
                 }

                request.setAttribute("data", hmFinal);
                request.setAttribute("head", hmHead);
                request.setAttribute("HeadId", HeadId);
				sop("milin jain request---> "+request);
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("147420");
				String nxtpg = "AllBudgetAllocation.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","147420");
				hmErr.put("Source","showBudgetAllocationHandler");
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
