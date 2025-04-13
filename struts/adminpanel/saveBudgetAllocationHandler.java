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

public class saveBudgetAllocationHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            ErrorHandler eh = new ErrorHandler();
            try{
                    int nItr = Integer.parseInt((String)session.getAttribute("itr"));
                    if(nItr>0){
                        session.setAttribute("itr", "0");
                        HashMap hmUser = (HashMap)session.getAttribute("user");
                        String DBnm = (String)hmUser.get("DBnm");

                        String strUserId = (String)hmUser.get("UId");

                        CommonLogic cl = new CommonLogic();
                        String strToday = (String)cl.getToday();
                        CVDal cvdal = new CVDal(DBnm);
                        HashMap hmFinal = new HashMap();
                        Vector vec = new Vector();
                        boolean bDuplicate = false;
                        boolean bAmount=false;
                        boolean bHead=false;

                        Vector vector=new Vector();
                        DynaActionForm daf = (DynaActionForm)form;

                       	String strId=(String)daf.get("txtId");
                        String strHeadId=(String)daf.get("Head");
                        String strAmount=(String)daf.get("txtAmount");
                        sop("strAmount==============="+strAmount);
						String strDate=(String)daf.get("txtDate");
						String strRemark=(String)daf.get("txtRemark");
						String InsertBy=strUserId;
						String InsertOn=strToday;
						String HeadId="";
						String Amount="";


						HashMap hData = new HashMap();
						cvdal = new CVDal(DBnm);
					 	if(strId != null && strId.length()>0){
							vec.clear();
							vec.addElement(strId);
							cvdal.setSQL("openAllocationWithId",vec);
							vector=(Vector)cvdal.executeQuery();
							if(vector!=null && vector.size()>0){
								HashMap hm=(HashMap)vector.elementAt(0);
								HeadId=(String)hm.get("HeadId");
								Amount=(String)hm.get("dblAmount");
								if(!HeadId.equals(strHeadId))
									bHead=true;

								if(!strAmount.equals(Amount))
									bAmount=true;
						    }
				       }
						vec.clear();
						cvdal = new CVDal(DBnm);
					    if(strId == null || strId.length()==0){
                            //insert record
                            int iNewId = 100001;
                            cvdal.setSQL("lastAllocationID",vec);
                            Vector vec1 = (Vector)cvdal.executeQuery();

                           if(vec1 != null && vec1.size()!=0){
                                HashMap hm = (HashMap)vec1.elementAt(0);
                                String strTemp = (String)hm.get("LastId");
                                if(strTemp != null){
                                    iNewId = Integer.parseInt(strTemp);
                                    iNewId++;
                                }
                            }
                            vec.addElement(""+iNewId);
                        }

						vec.addElement(strHeadId);
						vec.addElement(strDate);
						vec.addElement(strAmount);
						vec.addElement(strRemark);
						vec.addElement(InsertBy);
						vec.addElement(InsertOn);
						vec.addElement(strUserId);
						vec.addElement(strToday);

						cvdal = new CVDal(DBnm);
						if(strId == null || strId.length()==0){
							cvdal.setSQL("insertintobudgetallocation",vec);
							int irow=cvdal.executeUpdate();

						}else{
							vec.addElement(strId);
							cvdal.setSQL("updateintobudgetallocation",vec);
							int irow=cvdal.executeUpdate();
						}

						sop("before test-->"+strId);
						 cvdal = new CVDal(DBnm);
						 if(strId == null || strId.length()==0){
							 sop("inside if-->"+strId);
							vec.clear();
							vec.addElement(strAmount);
							vec.addElement(strHeadId);
							cvdal.setSQL("updateHeadBalance",vec);
							int irow1=cvdal.executeUpdate();
						 }else{
							 if(bHead){
								vec.clear();
								vec.addElement(Amount);
								vec.addElement(HeadId);
								cvdal.setSQL("minusHeadBalance",vec);
								int irow1=cvdal.executeUpdate();

								vec.clear();
								vec.addElement(strAmount);
								vec.addElement(strHeadId);
								cvdal.setSQL("updateHeadBalance",vec);
								irow1=cvdal.executeUpdate();
							 }else if(bAmount){
								 sop("inside else if-->"+strId);
								double dblAmount= Double.parseDouble(strAmount);
								double lAmount= Double.parseDouble(Amount);
								/*double dblAmount=(Double.valueOf(strAmount)).doubleValue();
								double lAmount=(Double.valueOf(Amount)).doubleValue();*/
								double newAmount = dblAmount-lAmount;
								vec.clear();
								vec.addElement(""+newAmount);
								vec.addElement(HeadId);
								cvdal.setSQL("updateHeadBalance",vec);
								int irow2=cvdal.executeUpdate();
							 }
						 }
						FORWARD_final = Success;
                    }else{
                        FORWARD_final = Success;
                    }
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138620");
				String nxtpg = "AllBudgetAllocation.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138620");
				hmErr.put("Source","saveBudgetAllocationHandler");
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

	public String newAccountNumber(){
		/*CVDal cvdal = new CVDal("budget");
		Vector vec = new Vector();
		*/
		return "E0001";
	}
}
