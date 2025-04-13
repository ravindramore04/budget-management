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

import java.util.HashMap;
import struts.common.CVDal;
import struts.common.CommonLogic;
import struts.common.ErrorHandler;
import java.util.*;
import java.sql.*;

public class SaveVoucherHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
			ErrorHandler eh = new ErrorHandler();
			HttpSession session = request.getSession(true);
		try{

			int itr=Integer.parseInt((String)session.getAttribute("itr"));
			 if(itr>0){
			session.setAttribute("itr","0");


			CommonLogic cl = new CommonLogic();


			HashMap hmUser = (HashMap)session.getAttribute("user");
			String DBnm = (String)hmUser.get("DBnm");
			String strUserId = (String)hmUser.get("UId");
			String strToday = (String)cl.getToday();
			Vector vec=new Vector();
			Vector vector=new Vector();
			Vector vec1=new Vector();
			CVDal cvdal = new CVDal(DBnm);
			boolean bHead=false;
			boolean bNetAmount=false;
			boolean bTdsAmount=false;

			DynaActionForm daf = (DynaActionForm)form;
			sop("--daf----"+daf);

            String strId= (String)daf.get("txtId");


            sop("-------------strId--------------&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&++++++++++++++++++++##############@@@@@@@@@@------------------------"+strId);
            String strDate= (String)daf.get("txtDt");
            String strVoucherNo= (String)daf.get("txtNo");
            String strHeadId= (String)daf.get("txtHeadId");
            String strdblAmount= (String)daf.get("txtAmt");
            String strdblTds= (String)daf.get("txtTds");

            String strType= (String)daf.get("txtType");

			String strTDS= (String)daf.get("txtTDS");
			String strPONo= (String)daf.get("txtsession");
			sop("-------strPONo-----------"+strPONo);
            String strToAcc= (String)daf.get("txtAcc");
            String strbMode= (String)daf.get("txtMode");
            String strBank= (String)daf.get("txtBank");
            String strReceiverNm= (String)daf.get("txtReceiver");
            String strChequeNo= (String)daf.get("txtChqno");
            String strInsertBy=strUserId;
            String strInsertOn=strToday;
            double dbBalance=0;
			String netAmount="";
			String TDSAmount="";
			String HeadId="";
			int srCvouNO=1;
			if(strdblTds==null || strdblTds.equals("null"))
				strdblTds="0";

            dbBalance=Double.parseDouble(strdblAmount)+Double.parseDouble(strdblTds);


           if(strbMode.equals("2"))
              strVoucherNo=strChequeNo;


           if(strId != null && strId.length()>0){
				vec.clear();
				vec.addElement(strId);
				cvdal.setSQL("openVoucherId",vec);
				vector=(Vector)cvdal.executeQuery();
				if(vector!=null && vector.size()>0){
					HashMap hm=(HashMap)vector.elementAt(0);
					HeadId=(String)hm.get("HeadId");
					netAmount=(String)hm.get("dblAmount");
					TDSAmount=(String)hm.get("dblTds");

					if(!HeadId.equals(strHeadId))
						bHead=true;

					if(!(netAmount.equals(strdblAmount)) || (TDSAmount.equals(strdblTds)))
						bNetAmount=true;

				}

		   }

           Vector Vouno= new Vector();
           Vouno.clear();
           Vouno.addElement(strHeadId);
           int VouNo=1;
           cvdal.setSQL("SelectVouno",Vouno);
           Vouno.clear();
           Vouno =(Vector)cvdal.executeQuery();
           if(Vouno != null && Vouno.size()!=0)
           {
			 HashMap Vou=(HashMap)Vouno.elementAt(0);
			 String incrVou=(String)Vou.get("LastId");
			 if(incrVou != null){
				 VouNo=Integer.parseInt(incrVou);
				 VouNo++;
				 }
			   }
         //insert code for the voucher no of cheque type//
           if(strbMode.equals("2")){
			 Vouno.clear();
			 Vouno.addElement(strbMode);
			 cvdal.setSQL("SelectVounoforCheque",Vouno);
            Vouno.clear();
           Vouno =(Vector)cvdal.executeQuery();
           if(Vouno != null && Vouno.size()!=0)
           {
			 HashMap VouChq=(HashMap)Vouno.elementAt(0);
			 String incrVouChq=(String)VouChq.get("LastId");
			 if(incrVouChq != null){
				 srCvouNO=Integer.parseInt(incrVouChq);
				 srCvouNO++;
				 }
			   }

			   }


         ////************************************////
			vec.clear();

            if(strId == null || strId.length()==0){
				//insert record
				int iNewId = 100001;
				cvdal.setSQL("lastVoucherID",vec);
				vec1 = (Vector)cvdal.executeQuery();

			   if(vec1 != null && vec1.size()!=0){
					HashMap hm = (HashMap)vec1.elementAt(0);
					String strTemp = (String)hm.get("LastId");
					if(strTemp != null){
						iNewId = Integer.parseInt(strTemp);
						iNewId++;
					}
				}
				vec.clear();
				vec1.clear();
				vec.addElement(""+iNewId);
				vec1.addElement(""+iNewId);

			}

			vec.addElement(strVoucherNo);
			vec.addElement(strDate);
			vec.addElement(strHeadId);
			vec.addElement(strdblAmount);
			vec.addElement(strdblTds);
			vec.addElement(strType);
			vec.addElement(strToAcc);
			vec.addElement(strbMode);
			vec.addElement(strBank);
			vec.addElement(strReceiverNm);
			vec.addElement(strInsertBy);
			vec.addElement(strInsertOn);
			vec.addElement(strUserId);
			vec.addElement(strToday);
			vec.addElement(strTDS);
			vec.addElement(strPONo);
			vec.addElement(""+VouNo);
			vec.addElement(""+srCvouNO);

			vec1.addElement(strChequeNo);
			vec1.addElement(strPONo);

			if(strId == null || strId.length()==0){
				cvdal.setSQL("insertintoVoucher",vec);
				int irow=cvdal.executeUpdate();


			  if(strbMode.equals("2")){
				cvdal.setSQL("insertintoCheque",vec1);
				int irow1=cvdal.executeUpdate();
			}


			}else{
				vec.addElement(strId);
				sop(""+vec);
				sop("----------------------------------------------------");
				cvdal.setSQL("updateintoVoucher",vec);
				int irow=cvdal.executeUpdate();

				 if(strbMode.equals("2")){
					vec1.addElement(strId);
					cvdal.setSQL("updateintoCheque",vec1);
					int irow1=cvdal.executeUpdate();
				}
			}


		/*	if(strId == null || strId.length()==0){
				cvdal.setSQL("insertintoVoucher",vec);
				int irow=cvdal.executeUpdate();



			if(strbMode.equals("2")){
				cvdal.setSQL("insertintoCheque",vec1);
				int irow1=cvdal.executeUpdate();
				}
			}*/

			sop("---check -------strPONo ----------"+strPONo);


			if(strId == null || strId.length()==0 && strPONo== null || strPONo.equals("----Select----")){
				vec.clear();
				vec.addElement(""+dbBalance);
				vec.addElement(strHeadId);
				cvdal.setSQL("minusHeadBalance",vec);
				int irow2=cvdal.executeUpdate();


			}else{
			   if(bHead){
					vec.clear();
					vec.addElement(""+dbBalance);
					vec.addElement(strHeadId);
					cvdal.setSQL("minusHeadBalance",vec);
					int row=cvdal.executeUpdate();

					vec.clear();
					vec.addElement(""+dbBalance);
					vec.addElement(HeadId);
					cvdal.setSQL("updateHeadBalance",vec);
					int row1=cvdal.executeUpdate();
			    }else{

					vec.clear();
					vec.addElement(""+dbBalance);
					vec.addElement(strHeadId);
					vec.addElement(strPONo);
					cvdal.setSQL("updatePOBalance",vec);
					int row1=cvdal.executeUpdate();

					//double Amountnet = Double.parseDouble(netAmount);
					sop("sunil---OKKKKKKK-");
					//double AmountTds = Double.parseDouble(TDSAmount);

					//double dblAmount = Amountnet + AmountTds;
					//double newAmount = dblAmount - dbBalance;
					//vec.clear();
					//vec.addElement(""+newAmount);
					//vec.addElement(HeadId);
					//cvdal.setSQL("updateHeadBalance",vec);
					//int irow2=cvdal.executeUpdate();

					}
		     }

			FORWARD_final = Success;
			}else
			FORWARD_final = Success;





		}catch(Exception e){
			e.printStackTrace();
			String err = eh.getError("138620");
			String nxtpg = "ValidatedLogin.do";
			HashMap hmErr = new HashMap();
			hmErr.put("no","138620");
			hmErr.put("Source","SaveVoucherHandler");
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
