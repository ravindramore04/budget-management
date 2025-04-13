public class test
{
	public static void main(String args[])
	{

		double alloc=0; double exp=0;double MyBal=0;
		alloc+=Double.parseDouble( "99000000.1");
		exp+=(Double.parseDouble( "990000004.2" )+Double.parseDouble("990000005.3"));
		MyBal-=(Double.parseDouble( "990000006.4" )+Double.parseDouble("990000006.5"));
		DecimalFormat d = new DecimalFormat("#.##");
		System.out.println(d.format(alloc));
		System.out.println(d.format(exp));
		System.out.println(d.format(MyBal));
	}
}