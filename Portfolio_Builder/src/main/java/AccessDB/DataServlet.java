package AccessDB;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// DB Connection 점검
@WebServlet("/tester")
public class DataServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}

	// 버튼 클릭에 따른 실행 상황 정의(SQL 관련 작업)
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		DataDAO dao = new DataDAO();
		List<DataDTO> list = dao.ListEmAll();
		String country, name, code_ticker;
		
		out.print("<html>");
			out.print("<body>");
				out.print("<table>");
				
				for(int i=0; i<list.size(); i++) {
					DataDTO showList = (DataDTO) list.get(i);
					code_ticker = showList.getCode_ticker();
					out.print("<tr>");
						out.print("<td>");
							out.print("<input type=\"checkbox\"/> "+code_ticker);
						out.print("</td>");
					out.print("</tr>");
				}
				
				out.print("</table>");
			out.print("</body>");
		out.print("</html>");
	} // END - protected void doHandle(request, response) throws Exceptions
	
	
//  < 아래의 코드를 JSP 파일에 삽입해야 함 >
//	response.setContentType("text/html;charset=UTF-8");
//	request.setCharacterEncoding("UTF-8");
//	PrintWriter out = response.getWriter();
//	
//	DataDAO dao = new DataDAO();
//	List<DataDTO> list = dao.ListEmAll();
//	String country, name, code_ticker;
//			
//	for(int i=0; i<list.size(); i++) {
//		DataDTO showList = (DataDTO) list.get(i);
//		code_ticker = showList.getCode_ticker();
//		out.print("<tr>");
//			out.print("<td>");
//				out.print("<input type=\"checkbox\"/> "+code_ticker);
//			out.print("</td>");
//		out.print("</tr>");
//	}
	
} //END - public class DataServlet{}