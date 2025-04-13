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

public class viewBudgetNoteHandler extends org.apache.struts.action.Action
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
                    CVDal cvdal = new CVDal(DBnm);
                    DynaActionForm daf = (DynaActionForm)form;
					HashMap hmFinal=new HashMap();
					String strId="";
					Vector vec = new Vector();
                    strId=(String)daf.get("id");
					vec.clear();
					vec.addElement(strId);
					cvdal.setSQL("openHeadWithId", vec);
					Vector vec1 = (Vector)cvdal.executeQuery();
					if(vec1!=null && vec1.size()>0){
						hmFinal =(HashMap)vec1.elementAt(0);
						cvdal.setSQL("ViewAllocForHeadId", vec);
						vec1 = (Vector)cvdal.executeQuery();
						if(vec1!=null && vec1.size()>0){
							HashMap hmmt =(HashMap)vec1.elementAt(0);
							hmFinal.put("BSUM",(String)hmmt.get("BSUM"));
						}

						cvdal.setSQL("ViewVouchAndPOWithoutDateForHeadId", vec);
						vec1 = (Vector)cvdal.executeQuery();
						if(vec1!=null && vec1.size()>0){
							HashMap hmmt =(HashMap)vec1.elementAt(0);
							hmFinal.put("VSUM",(String)hmmt.get("VSUM"));
							hmFinal.put("TSUM",(String)hmmt.get("TSUM"));
							String Headid=(String)hmmt.get("HeadId");



							vec.clear();
							vec.addElement(Headid);
							cvdal.setSQL("AmtForPO",vec);
							vec =(Vector)cvdal.executeQuery();

							HashMap HMTT=new HashMap();
							sop("-------vec-------Ravi----------"+vec);
							if(vec!=null && vec.size()>0 )
							{
								//for(int ii=0; ii<vec.size();ii++)
								//{
								HMTT =(HashMap)vec.elementAt(0);
								sop("=---------HMTT------ravi------------------"+HMTT);
								hmFinal.put("rr",HMTT);

								//}

							}else{
									hmFinal.put("rr",HMTT);
								}



							//hmFinal.put("POSUM",(String)hmmt.get("POSUM"));
						}
					}

                    request.setAttribute("Head",hmFinal);
                   	FORWARD_final = Success;

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

	public void sop(String msg){
		System.out.println(msg);
	}
}
