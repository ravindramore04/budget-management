package struts.setting;

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

public class SaveBrnUserHandler extends org.apache.struts.action.Action
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
                        String strUserId = (String)hmUser.get("login");
                        CommonLogic cl = new CommonLogic();
                        String strToday = (String)cl.getToday();
                        CVDal cvdal = new CVDal("setting");
                        HashMap hmFinal = new HashMap();
                        Vector vec = new Vector();
                        boolean bDuplicate = false;
                        String userNm="";
                        String strBranchId="";

                         HashMap hmBranch= (HashMap)session.getAttribute("branch");
											if(hmBranch != null && hmBranch.size()>0){
											    strBranchId= (String)hmBranch.get("BranchId");
											}



                        DynaActionForm daf = (DynaActionForm)form;
                        sop("-->"+daf);
                        String strId=(String)daf.get("txtId");
                        String strUserName=(String)daf.get("txtNm");
                        String strGroup=(String)daf.get("group");
                        String strPassword=(String)daf.get("txtpwd");
                        String strInsertBy=(String)daf.get("txtInsertBy");
                        String strInsertDt=(String)daf.get("txtInsertOn");


						if(strId == null || strId.length()==0){
							//new record
							//test for duplication
							vec.addElement(strUserName);
							cvdal.setSQL("checkbranchUserDuplication",vec);
							Vector vec12=(Vector)cvdal.executeQuery();
							vec.clear();
							if(vec12 != null && vec12.size()!=0)
									bDuplicate=true;
							else
							        bDuplicate=false;
						}else{
							//update record
							//test for update name
							vec.clear();
							vec.addElement(strId);
							cvdal.setSQL("openBrnUserWithId",vec);
							Vector vec12=(Vector)cvdal.executeQuery();
							vec.clear();
							if(vec12 != null && vec12.size()!=0){
								HashMap hmt = (HashMap)vec12.elementAt(0);
								if(hmt!=null && hmt.size()>0){
									userNm = (String)hmt.get("strUserLogin");
									if(userNm.equals(strUserName)){
										//not update do nothing
									}else{
										//updated
										//test for duplication
										vec.clear();
										vec.addElement(strUserName);
										cvdal.setSQL("checkbranchUserDuplication",vec);
										vec.clear();
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
							String nxtpg = "BrnUser.do";
							HashMap hmErr = new HashMap();
							hmErr.put("no","147530");
							hmErr.put("Source","SaveBrnUserHandler");
							hmErr.put("err",err);
							hmErr.put("nxtpg",nxtpg);
							request.setAttribute("err",hmErr);
					//		request.setAttribute("eDetail",e);
							FORWARD_final = GLOBAL_FORWARD_failure;
						}else{
						 vec.clear();
							if(strId == null || strId.length()==0){
								//insert record
								int iNewId = 1000000001;
								vec.clear();
								cvdal.setSQL("lastBrnUserId",vec);
								Vector vec1 = (Vector)cvdal.executeQuery();
								if(vec1 != null && vec1.size()!=0){
									HashMap hm = (HashMap)vec1.elementAt(0);
									String strTemp = (String)hm.get("LastId");
									if(strTemp != null){
										iNewId = Integer.parseInt(strTemp);
										iNewId++;
									}
								}
								strInsertBy=strUserId;
								strInsertDt=strToday;
								vec.addElement(""+iNewId);
							}

							vec.addElement(strUserName);
							vec.addElement(cl.encryptValue(strPassword));
							vec.addElement(strGroup);
							vec.addElement(strBranchId);
							vec.addElement(strInsertBy);
							vec.addElement(strInsertDt);
							vec.addElement(strUserId);
							vec.addElement(strToday);
							if(strId == null || strId.length()==0){
								//insert
								cvdal.setSQL("insertBrnUser",vec);
							}else{
								//update record
								vec.addElement(strId);
								cvdal.setSQL("updateBrnUser",vec);
							}
							int row_num=cvdal.executeUpdate();
							if(row_num>0)
								FORWARD_final = Success;
							else{
								String err = eh.getError("138620");
								String nxtpg = "BrnUser.do";
								HashMap hmErr = new HashMap();
								hmErr.put("no","138620");
								hmErr.put("Source","SaveBrnUserHandler");
								hmErr.put("err",err);
								hmErr.put("nxtpg",nxtpg);
								request.setAttribute("err",hmErr);
					  		//    request.setAttribute("eDetail",e);
								FORWARD_final = GLOBAL_FORWARD_failure;
						     }
						   }
					   }else{
							FORWARD_final = Success;
				   }

            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138620");
				String nxtpg = "BrnUser.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138620");
				hmErr.put("Source","SaveBrnUserHandler");
				hmErr.put("err",err);
				hmErr.put("nxtpg",nxtpg);
				request.setAttribute("err",hmErr);
				request.setAttribute("eDetail",e);
                FORWARD_final = GLOBAL_FORWARD_failure;
            }
			 sop("forward before returning ----->--->"+FORWARD_final);
            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println(msg);
	}
}

