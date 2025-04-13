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

public class SaveBudGroupHeadHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;
	public String DBnm="";

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
                        DBnm = (String)hmUser.get("DBnm");

                        String strUserId = (String)hmUser.get("UId");

                        CommonLogic cl = new CommonLogic();
                        String strToday = (String)cl.getToday();
                        CVDal cvdal = new CVDal(DBnm);
                        HashMap hmFinal = new HashMap();
                        Vector vec = new Vector();
                        boolean bDuplicate = false;
                        DynaActionForm daf = (DynaActionForm)form;

                       	String strId=(String)daf.get("txtId");
                        String strName=(String)daf.get("txtName");
                        String strHeadOfDeptNm=(String)daf.get("strHeadOfDeptNm");

						HashMap hData = new HashMap();


					  if(strId == null || strId.length()==0){
							//new record
							//test for duplication
							vec.addElement(strName);
							cvdal.setSQL("checkDepartment",vec);
							Vector vec12=(Vector)cvdal.executeQuery();
							if(vec12 != null && vec12.size()!=0)
									bDuplicate=true;
							else
									bDuplicate=false;
						}else{
							//update record
							//test for update name
							vec.clear();
							vec.addElement(strId);
							cvdal.setSQL("openDepartmentWithId",vec);
							Vector vec12=(Vector)cvdal.executeQuery();
							if(vec12 != null && vec12.size()!=0){
								HashMap hmt = (HashMap)vec12.elementAt(0);
								if(hmt!=null && hmt.size()>0){
									String strNm = (String)hmt.get("strDepartmentNm");
									if(strNm.equals(strName)){
										//not update do nothing
									}else{
										//updated
										//test for duplication
										vec.clear();
										vec.addElement(strName);
										cvdal.setSQL("checkDepartment",vec);
										vec12=(Vector)cvdal.executeQuery();
										if(vec12 != null && vec12.size()!=0){
											bDuplicate=true;
										}else{
											bDuplicate=false;
										}
									}
								}else{
									//Error
								}
							}else{
								//Error
							}
						}

						if(bDuplicate){
							String err = eh.getError("147530");
							String nxtpg = "AllHead.do";
							HashMap hmErr = new HashMap();
							hmErr.put("no","147530");
							hmErr.put("Source","SaveHeadHandler");
							hmErr.put("err",err);
							hmErr.put("nxtpg",nxtpg);
							request.setAttribute("err",hmErr);
							//request.setAttribute("eDetail",e);
							FORWARD_final = GLOBAL_FORWARD_failure;
						}else{
                       vec.clear();
                        if(strId == null || strId.length()==0){
                            //insert record
                            int iNewId = 100001;
                            vec.clear();
                            cvdal.setSQL("lastDepartmentID",vec);
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

                        vec.addElement(strName);
						vec.addElement(strHeadOfDeptNm);
							vec.addElement("");
							vec.addElement("");
							vec.addElement("");
							vec.addElement("");




                        if(strId == null || strId.length()==0){
                            //insert
                            cvdal.setSQL("insertDepartment",vec);
                        }else{
                            //update record
                            vec.addElement(strId);
                            cvdal.setSQL("updateDepartment",vec);
                        }
                        int row_num=cvdal.executeUpdate();
                        if(row_num>0){
                        	if(strId == null || strId.length()==0){
								//make entry to the head current balance
								String strTemp = (String)vec.elementAt(0);
								vec.clear();
								vec.addElement(strTemp);
								vec.addElement("0");
								//cvdal.setSQL("insertHeadBalance",vec);
								//row_num=cvdal.executeUpdate();
							}
                            FORWARD_final = Success;
                        }else{
							String err = eh.getError("138620");
							String nxtpg = "AllHead.do";
							HashMap hmErr = new HashMap();
							hmErr.put("no","138620");
							hmErr.put("Source","SaveHeadHandler");
							hmErr.put("err",err);
							hmErr.put("nxtpg",nxtpg);
							request.setAttribute("err",hmErr);
							//request.setAttribute("eDetail",e);
                            FORWARD_final = GLOBAL_FORWARD_failure;
					   }
                    }
                    }else{
                        FORWARD_final = Success;
                    }
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138620");
				String nxtpg = "AllHead.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138620");
				hmErr.put("Source","SaveHeadHandler");
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
		CVDal cvdal = new CVDal(DBnm);

		Vector vec = new Vector();
		cvdal.setSQL("acode",vec);
		Vector vec1 = (Vector)cvdal.executeQuery();
		String strTemp="";
	   if(vec1 != null && vec1.size()!=0){
			HashMap hm = (HashMap)vec1.elementAt(0);
			strTemp = (String)hm.get("code");
			sop("max from budgethead "+strTemp);
			if(strTemp == null){
				strTemp ="E1";
			}else{
				//String cd=strTemp.substring(1,strTemp.length());
				sop("substring"+"cd"+"---"+strTemp);
				//int icd=Integer.parseInt(cd);
				int icd=Integer.parseInt(strTemp);
				icd++;
				strTemp="E"+icd;
			}
		}

		sop("auto code"+strTemp);
		return strTemp;
	}
}
