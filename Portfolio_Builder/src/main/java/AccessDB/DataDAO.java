package AccessDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DataDAO {
	private DataSource        dataFactory;
	private Connection        conn;
	private PreparedStatement pstmt;
	private ResultSet         rs;
	
	private List<DataDTO> wholeAssets = new ArrayList<DataDTO>();
	int listSize;
	
	
	// ----------------------------------------
	// 0. DB와의 연결통로 생성
	// ----------------------------------------
	public DataDAO() {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) env.lookup("jdbc/mysql");
		} catch(Exception e) {
			e.printStackTrace();
		}
	} // public DataDAO()

	// ----------------------------------------
	// 1. 선택 가능한 종목 전체 가져오기
	// ----------------------------------------
	public ArrayList<String> ListEmAll() {
		
		ArrayList<String> info = new ArrayList<String>();
		String list="";
		String numberOfAssets="";
		
		try {
			conn = dataFactory.getConnection();

			String query = "SELECT * FROM assets ";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCountry(rs.getString("country"));
				dto.setName(rs.getString("name"));
				dto.setCode_ticker(rs.getString("code_ticker"));
				wholeAssets.add(dto);
			}
			
			list="<tbody>";
			listSize=wholeAssets.size();
			for(int i=0; i<listSize; i++) {
				list += "<tr><td>";
				list += "<input type=\"checkbox\" name=\"TL_checkbox\" ";
				list += "id=\""+wholeAssets.get(i).code_ticker+"\" onclick=\"getCheckboxValue(event)\" /> ";
				list += "<span id=\"list-no"+(i+1)+"\" name=\""+wholeAssets.get(i).name+"\"> ";
				list += wholeAssets.get(i).code_ticker+"</span>";
				list += "</td></tr>";
			}
			list+="</tbody>";
			numberOfAssets=Integer.toString(listSize);
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		info.add(numberOfAssets);
		info.add(list);

		return info;

	} // public void ListEmAll()
	
	// ----------------------------------------
	// 2. 동일 가중방식 구현
	// ----------------------------------------	
	public String EqualWeightIndex(String forQuery) {
		List<DataDTO> statsForTable = new ArrayList<DataDTO>();
		String tableComponent="";
		
		try {
			conn = dataFactory.getConnection();
			
			String query
			= "SELECT stats.code_ticker , "
			+ "       assets.name , "
			+ "		  stats.Annual_AVG , "
			+ "       ( 1/(SELECT COUNT(code_ticker) FROM stats WHERE code_ticker IN ("+forQuery+")) ) AS proportion "
			+ "FROM stats, assets "
			+ "WHERE stats.code_ticker=assets.code_ticker "
			+ "      AND stats.code_ticker IN ("+forQuery+"); ";
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCode_ticker(rs.getString("code_ticker"));
				dto.setName(rs.getString("name"));
				dto.setAvg_yield(rs.getFloat("Annual_AVG"));
				dto.setProportion(rs.getFloat("proportion"));
				statsForTable.add(dto);
			}
			
			for(int i=0; i<statsForTable.size(); i++) {
				tableComponent += "<tr>";
				tableComponent += "<td id='No'>"+(i+1)+"</td>";
				tableComponent += "<td id='CodeTicker'>"+statsForTable.get(i).code_ticker+"</td>";
				tableComponent += "<td id='NameOfStock'>"+statsForTable.get(i).name+"</td>";
				tableComponent += "<td id='YieldRate'>"+statsForTable.get(i).avg_yield+"%</td>";
				tableComponent += "<td id='Porportion'>"+statsForTable.get(i).proportion+"%</td>";
				tableComponent += "</tr>";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return tableComponent;
	} // public String EqualWeightIndex()
	
	// ----------------------------------------
	// 3. 시가총액 가중방식 구현
	// ----------------------------------------	
	public String CapitalizationWeightIndex(String forQuery) {
		List<DataDTO> statsForTable = new ArrayList<DataDTO>();
		String tableComponent="";
		
		try {
			conn = dataFactory.getConnection();
			
			String query 
			= "SELECT stats.code_ticker, "
			+ "       assets.name, "
			+ "       stats.Annual_AVG, "
			+ "       (Market_Cap/(SELECT SUM(Market_Cap) FROM stats WHERE stats.code_ticker IN ("+forQuery+"))) AS proportion "
			+ "FROM stats, assets "
			+ "WHERE stats.code_ticker=assets.code_ticker "
			+ "      AND stats.code_ticker "
			+ "      IN ("+forQuery+") "
			+ "ORDER BY proportion DESC; ";
			
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCode_ticker(rs.getString("code_ticker"));
				dto.setName(rs.getString("name"));
				dto.setAvg_yield(rs.getFloat("Annual_AVG"));
				dto.setProportion(rs.getFloat("proportion"));
				statsForTable.add(dto);
			}
			
			for(int i=0; i<statsForTable.size(); i++) {
				tableComponent += "<tr>";
				tableComponent += "<td id='No'>"+(i+1)+"</td>";
				tableComponent += "<td id='CodeTicker'>"+statsForTable.get(i).code_ticker+"</td>";
				tableComponent += "<td id='NameOfStock'>"+statsForTable.get(i).name+"</td>";
				tableComponent += "<td id='YieldRate'>"+statsForTable.get(i).avg_yield+"%</td>";
				tableComponent += "<td id='Porportion'>"+statsForTable.get(i).proportion+"%</td>";
				tableComponent += "</tr>";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return tableComponent;
	} // public String CapitalizationWeightIndex()
	
	// ----------------------------------------------------------------------------------
	// 4. SiHoonChris 가중방식 구현 - PrepareForSHCWI, ExecuteSHCWI, SiHoonChrisWeightIndex
	// ----------------------------------------------------------------------------------
	private void PrepareForSHCWI(String forQuery) {   // SiHoonChris 가중방식을 사용하기 위한 View를 생성한다.		
		try {
			conn = dataFactory.getConnection();
			
			String query
			= "CREATE VIEW temp_portfolio AS "
			+ "SELECT stats.code_ticker, assets.name, stats.Adj_Annual_AVG, "
			+ "		  IF( "
			+ "         ( "
			+ "			  ( "
			+ "			    ( (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) "
			+ "				   + ( (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) "
			+ "					     - (SELECT STDEV FROM stats WHERE stats.code_ticker=assets.code_ticker AND stats.code_ticker IN ("+forQuery+")) "
			+ "					 ) "
			+ "			    ) / (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) "
			+ "			  ) "
			+ "			  * ( 1 / (SELECT COUNT(code_ticker) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) ) "
			+ "		    ) >= 0 , ( "
			+ "                  ( "
			+ "			           ( "
			+ "			             ( (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) "
			+ "						    + ( (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) "
			+ "					              - (SELECT STDEV FROM stats WHERE stats.code_ticker=assets.code_ticker AND stats.code_ticker IN ("+forQuery+")) "
			+ "					          ) "
			+ "						 ) / (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) "
			+ "					   ) * ( 1 / (SELECT COUNT(code_ticker) FROM stats WHERE stats.code_ticker IN ("+forQuery+")) ) "
			+ "					 ) "
			+ "				     ) , 0 "
			+ "           ) AS forCalcProp "
			+ "FROM stats, assets "
			+ "WHERE stats.code_ticker=assets.code_ticker "
			+ "AND stats.code_ticker "
			+ "IN ("+forQuery+") "
			+ "ORDER BY forCalcProp DESC; ";
			
			pstmt=conn.prepareStatement(query);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	} // public void PrepareForSHCWI()

	private String ExecuteSHCWI() {   // SiHoonChris 가중방식 실행 결과를 저장한다
		List<DataDTO> statsForTable = new ArrayList<DataDTO>();
		String tableComp="";
		
		try {
			conn = dataFactory.getConnection();
			
			String query
			="SELECT code_ticker, name, Adj_Annual_AVG, forCalcProp, "
			+"       (forCalcProp * 1/(SELECT SUM(forCalcProp) from temp_portfolio)) AS proportion "
			+"FROM temp_portfolio; ";
			
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCode_ticker(rs.getString("code_ticker"));
				dto.setName(rs.getString("name"));
				dto.setAvg_yield(rs.getFloat("Adj_Annual_AVG"));
				dto.setProportion(rs.getFloat("proportion"));
				statsForTable.add(dto);
			}
			
			for(int i=0; i<statsForTable.size(); i++) {
				tableComp += "<tr>";
				tableComp += "<td id='No'>"+(i+1)+"</td>";
				tableComp += "<td id='CodeTicker'>"+statsForTable.get(i).code_ticker+"</td>";
				tableComp += "<td id='NameOfStock'>"+statsForTable.get(i).name+"</td>";
				tableComp += "<td id='YieldRate'>"+statsForTable.get(i).avg_yield+"%</td>";
				tableComp += "<td id='Porportion'>"+statsForTable.get(i).proportion+"%</td>";
				tableComp += "</tr>";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return tableComp;
	} // public String ExecuteSHCWI()
	
	public String SiHoonChrisWeightIndex(String forQuery) {  // SiHoonChris 가중방식 실행, 결과 저장, View 삭제
		PrepareForSHCWI(forQuery);
		String tableComponent = ExecuteSHCWI();
		
		try {
			conn = dataFactory.getConnection();
			
			String query
			="DROP VIEW temp_portfolio; ";
			
			pstmt=conn.prepareStatement(query);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return tableComponent;
	} // public String SiHoonChrisWeightIndex()
	
	
} // END - public class DataDAO{}