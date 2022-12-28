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
	
	public DataDAO() {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) env.lookup("jdbc/mysql");
		} catch(Exception e) {
			e.printStackTrace();
		}
	} // END - public DataDAO()
	
	public List<DataDTO> ListEmAll() {
		
		List<DataDTO> listOfAssets = new ArrayList<DataDTO>();
				
		try {
			conn = dataFactory.getConnection();
			
			String query = "SELECT * FROM assets ";
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCountry("country");
				dto.setName("name");
				dto.setCode_ticker(rs.getString("code_ticker"));
				
				listOfAssets.add(dto);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return listOfAssets;
	} // END - public void ListEmAll()
	
	
} // END - public class DataDAO{}