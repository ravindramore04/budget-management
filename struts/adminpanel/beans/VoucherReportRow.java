package struts.adminpanel.beans;

/**
 * Created by morer on 11-05-2025.
 */
public class VoucherReportRow {
    private String voucherNumebr;
    private String coucherDate;
    private String voucherAmount;
    private String receiverName;
    private String departmentName;
    private String headName;

    public String getVoucherNumebr() {
        return voucherNumebr;
    }

    public String getCoucherDate() {
        return coucherDate;
    }

    public String getVoucherAmount() {
        return voucherAmount;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public String getHeadName() {
        return headName;
    }

    public VoucherReportRow(String voucherNumebr, String coucherDate, String voucherAmount, String receiverName, String departmentName, String headName) {
        this.voucherNumebr = voucherNumebr;
        this.coucherDate = coucherDate;
        this.voucherAmount = voucherAmount;
        this.receiverName = receiverName;
        this.departmentName = departmentName;
        this.headName = headName;
    }

    @Override
    public String toString() {
        return "VoucherReportRow{" +
                "voucherNumebr='" + voucherNumebr + '\'' +
                ", coucherDate='" + coucherDate + '\'' +
                ", voucherAmount='" + voucherAmount + '\'' +
                ", receiverName='" + receiverName + '\'' +
                ", departmentName='" + departmentName + '\'' +
                ", headName='" + headName + '\'' +
                '}';
    }
}
