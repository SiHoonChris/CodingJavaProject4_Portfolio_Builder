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
	} // END - public DataDAO()

	// ----------------------------------------
	// 1. 선택 가능한 종목 전체 가져오기
	// ----------------------------------------
	public String ListEmAll() {
		
		String list="";
		
		try {
			conn = dataFactory.getConnection();

			String query = "SELECT country, name, code_ticker FROM assets ";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCountry(rs.getString("country"));
				dto.setName(rs.getString("name"));
				dto.setCode_ticker(rs.getString("code_ticker"));
				wholeAssets.add(dto);
			}
			
			listSize=wholeAssets.size();
			for(int i=0; i<listSize; i++) {
				list += "<tr><td>";
				list += "<input type=\"checkbox\" ";
				list += "name=\""+wholeAssets.get(i).code_ticker+"\" /> ";
				list += "<span id=\"list-no"+(i+1)+"\" name=\""+wholeAssets.get(i).name+"\"> ";
				list += wholeAssets.get(i).code_ticker+"</span>";
				list += "</td></tr>";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return list;

	} // END - public void ListEmAll()
	
	// ----------------------------------------
	// 2. 그 다음
	// ----------------------------------------	
	
	
} // END - public class DataDAO{}