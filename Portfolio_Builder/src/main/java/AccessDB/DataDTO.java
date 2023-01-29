package AccessDB;

public class DataDTO {
	String country, name, code_ticker, avg_yield, proportion;
	public DataDTO() {}

	public String getCountry()                       {return country;}
	public void   setCountry(String country)         {this.country = country;}
	public String getName()                          {return name;}
	public void   setName(String name)               {this.name = name;}
	public String getCode_ticker()                   {return code_ticker;}
	public void   setCode_ticker(String code_ticker) {this.code_ticker = code_ticker;}
	public String getAvg_yield()                     {return avg_yield;}
	public void   setAvg_yield(float avg_yield)      {this.avg_yield =String.format("%.2f", (avg_yield-1)*100);}
	public String getProportion()                    {return proportion;}
	public void   setProportion(float proportion)    {this.proportion = String.format("%.2f", (proportion*100));}

	@Override
	public String toString() {return "DataDTO [국가=" + country + ", 종목명=" + name + ", 종목번호/티커=" + code_ticker + "]";}
	
} // END - public class DataDTO{}
