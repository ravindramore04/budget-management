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

public class POviewReportHandler extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	private static final String Success_all = "success_all";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");
            ErrorHandler eh = new ErrorHandler();
            HashMap hmFinal=new HashMap();
            HashMap hmAmt=new HashMap();
            HashMap hmVoc=new HashMap();
            HashMap hmVoc1=new HashMap();
            HashMap hmFinal1=new HashMap();
            HashMap hmFinal2=new HashMap();
            String strId="";
            Vector vec1=new Vector();
			Vector vec = new Vector();
            try
            {
                    int nNum_Per_Page = 10;
                    CommonLogic cl = new CommonLogic();
                    CVDal cvdal = new CVDal(DBnm);
					vec.clear();
                    DynaActionForm daf = (DynaActionForm)form;
                    strId=(String)daf.get("id");
                    //String txtBGid=(String)daf.get("txtBGid");
                    String gid=(String)daf.get("txtBudgroupId");

                    String txtPOID=(String)request.getParameter("txtPOID");
                    sop("--txtPOID---"+txtPOID);
            		if(!(strId.equals("0")))
                    {
						sop("inside The if>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		                vec.clear();
        	            vec.addElement(strId);
        	            cvdal.setSQL("openAmount", vec);
        	            vec1 = (Vector)cvdal.executeQuery();
        	            if(vec1!=null && vec1.size()>0)
        	            {
							 for(int j=0;j<vec1.size();j++)
							 {
								 HashMap hm=(HashMap)vec1.elementAt(j);
								 hmAmt.put(""+j,hm);
							 }
        	                 hmFinal.put("AlloAmont",hmAmt);
						}
                        vec.clear();
                        vec.addElement(strId);

                        cvdal.setSQL("openVouchseForPO", vec);
                        vec1 = (Vector)cvdal.executeQuery();
                        if(vec1!=null && vec1.size()>0)
                        {
							for(int i=0;i<vec1.size();i++)
							{
								HashMap hmVou=(HashMap)vec1.elementAt(i);
								hmVoc.put(""+i,hmVou);
							}
							hmFinal1.put("voucher",hmVoc);
                        }
                        vec.clear();
						vec.addElement(strId);
						cvdal.setSQL("openBalance", vec);
                        vec1 = (Vector)cvdal.executeQuery();
                        if(vec1!=null && vec1.size()>0)
                        {
							HashMap hmbal=(HashMap)vec1.elementAt(0);
							hmFinal.put("bal",hmbal);
						}
                        vec.clear();
                        vec1.clear();
                        vec.addElement(strId);
                        cvdal.setSQL("openHead", vec);
                        vec1 = (Vector)cvdal.executeQuery();
                        if(vec1!=null && vec1.size()>0)
                        {
							HashMap hmVou=(HashMap)vec1.elementAt(0);
							hmFinal2.put("0",hmVou);
                        }
						request.setAttribute("Amount",hmFinal);
                    	request.setAttribute("Voucher",hmFinal1);
						request.setAttribute("MyHead",hmFinal2);
                    	FORWARD_final = Success;
                    }
                    else
                    {
						/*** case for all head ***/
						sop("inside The else>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						//String TDate=(String)daf.get("TDate");
						String fyy=(String)daf.get("FYY");
						String fmm=(String)daf.get("FMM");
						String fdd=(String)daf.get("FDD");
						String tyy=(String)daf.get("TYY");
						String tmm=(String)daf.get("TMM");
						String tdd=(String)daf.get("TDD");
						String FDate=fyy.trim()+"-"+fmm.trim()+"-"+fdd.trim();
						String TDate=tyy.trim()+"-"+tmm.trim()+"-"+tdd.trim();


						String FDateInd=fdd.trim()+"-"+fmm.trim()+"-"+fyy.trim();
						String TDateInd=tdd.trim()+"-"+tmm.trim()+"-"+tyy.trim();

						sop("==============================");
						sop(FDate);
						sop(TDate);
						sop("==============================");
						sop(FDateInd);
						sop(TDateInd);

						vec.clear();
						vec.addElement(gid);
                    	cvdal.setSQL("ViewAllAllocwithbgid", vec);
                    	vec1 = (Vector)cvdal.executeQuery();
						if(vec1!=null && vec1.size()>0)
						{
							for(int indx=0;indx<vec1.size();indx++)
							{
								HashMap hmt = (HashMap)vec1.elementAt(indx);
								hmFinal.put(""+indx,hmt);
							}
						}

                    	vec.clear();

						vec.addElement(FDate);
						vec.addElement(TDate);
						vec.addElement(gid);
						cvdal.setSQL("ViewAllVouchwithgid", vec);
						vec1.clear();
                    	vec1 = (Vector)cvdal.executeQuery();

						if(vec1!=null && vec1.size()>0)
						{
							for(int indx=0;indx<vec1.size();indx++)
							{
								HashMap hmt1 = (HashMap)vec1.elementAt(indx);
								hmFinal1.put(""+indx,hmt1);
							}
						}
						request.setAttribute("FDATEi",FDateInd);
						request.setAttribute("TDATEi",TDateInd);

						request.setAttribute("FDATE",FDate);
						request.setAttribute("TDATE",TDate);

						request.setAttribute("Alloc",hmFinal);
						request.setAttribute("Vouch",hmFinal1);
                    	FORWARD_final = Success_all;
					}
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
