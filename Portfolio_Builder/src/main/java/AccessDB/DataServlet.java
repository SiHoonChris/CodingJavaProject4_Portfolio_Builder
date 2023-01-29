package AccessDB;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/result")
public class DataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public String ShowAll() { // DB내 전체 종목 정보(JSP)
		DataDAO dao = new DataDAO();
		String AllAssets = dao.ListEmAll();
		
		return AllAssets;
	} // public String ShowAll()
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String Method = request.getParameter("Method");
		String Assets = request.getParameter("Assets");
		
		if(Method.equals("ewi")) {
			DataDAO dao = new DataDAO();
			String html_txt = dao.EqualWeightIndex(Assets);
			request.setAttribute("html_txt", html_txt);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/PortfolioBuilder/PortfolioBuilder.jsp");
			dispatcher.forward(request, response);
		}
		else if(Method.equals("cwi")) {
			DataDAO dao = new DataDAO();
			String html_txt = dao.CapitalizationWeightIndex(Assets);
			request.setAttribute("html_txt", html_txt);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/PortfolioBuilder/PortfolioBuilder.jsp");
			dispatcher.forward(request, response);
		}
		else if(Method.equals("shcwi")) {
			DataDAO dao = new DataDAO();
			String html_txt = dao.SiHoonChrisWeightIndex(Assets);
			request.setAttribute("html_txt", html_txt);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/PortfolioBuilder/PortfolioBuilder.jsp");
			dispatcher.forward(request, response);
		}
	} // protected void doHandle()
	
} // END - public class DataServlet{}