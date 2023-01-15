<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="AccessDB.DataServlet" %>
<%@ page import="java.util.ArrayList" %>
<%
DataServlet srv = new DataServlet(); 
ArrayList<String> listOfAssets = srv.ShowAll();
int range = srv.range;
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width" initial-scale="1.0">
		<title>Build your Portfolio!</title>
		<link rel="stylesheet" type='text/css' href='PortfolioBuilder.css'>
	</head>
	<body>
		<div class="container">
<!-- TL 파트 -->
			<div id="stock" class="TL">
				<div class="select" align="center">
					<div class="type">		
						<p>
							<input type="text" placeholder="종목명 검색"/>
							<span title="전체 종목 수" id="Total">&nbsp;<%=listOfAssets.get(0) %></span>
						</p>
					</div>
					<div class="scroll">
						<table>
							<%=listOfAssets.get(1) %>
						</table>
					</div>
				</div>
				<div class="selected" align="center">
					<div class="type">
						<p>
							<input type="text" placeholder="종목명 검색"/>
							<span id="number_selec" title="선택한 종목 수">&nbsp;(0)</span>
						</p>
					</div>
					<div class="scroll">
						<table id="selected">
						</table>
					</div>				
				</div>
				<div class="display">
					<h3 id="full-name">종목명 상세</h3>
				</div>
				<div class="button">
					<div id="add">
						<button type="button" onclick="add_assets()">추가</button>
					</div>
					<div id="remove">
						<button type="button" onclick="remove_assets()">제거</button>
					</div>
					<div id="reset">
						<button type="button" onclick="reset_assets()">초기화</button>
					</div>
				</div>
			</div>
<!-- TL 파트 -->
<!-- TR 파트 -->
  			<div class="TR">
  				<div id="table">
  					<table id="result_table">
  						<thead>
  							<tr>
  								<th>No.</th>
  								<th>코드/티커</th>
  								<th>종목명</th>
  								<th>수익률</th>
  								<th>투자 비중</th>
  							</tr>
  						</thead>
  						<tbody>
  							<tr>
  								<td>ex)1</td>
  								<td>ex)AAPL</td>
  								<td>ex)Apple Inc.</td>
  								<td>ex)1.2048</td>
  								<td>ex)0.1328</td>
  							</tr>
  						</tbody>
  					</table>
  				</div>
  				<span class="date">(업데이트 : 2022.12)</span>
  				<span class="time">(X.XXXXsec.)</span>
  			</div>
<!-- TR 파트 -->
<!-- BL 파트 -->
  			<div id="method" class="BL">
  				<div class="select">
  					<div class="title"><b>&nbsp;포트폴리오 가중 방식</b></div>
  					<div class="scroll" align="center">
  						<table>
  							<tr>
  								<td>
  									<input type="radio" id="ewi" name="Method" value="ewi" onclick="select_method(event)"/>동일 가중방식
  								</td>
  								<td>
  									<input type="radio" id="cwi" name="Method" value="cwi" onclick="select_method(event)"/>시가총액 가중방식
  								</td>
  								<td>
  									<input type="radio" id="shcwi" name="Method" value="shcwi" onclick="select_method(event)"/>SiHoonChris 가중방식
  								</td>
  							</tr>
  						</table>
  					</div>
  				</div>
  				<div class="selected">
  					<div id="p_method">[이름]</div>
  					<br/>
  					<div id="p_expl">[설명]</div>
  				</div>
  				<div class="button">
  					<button>실행</button>
  				</div>
  			</div>
<!-- BL 파트 -->
<!-- BR 파트 -->
 			<div id="chart" class="BR">
  				도넛모양 차트
  			</div>
  		</div>
<!-- BR 파트 -->
		<script src="PortfolioBuilder.js"></script>
	</body>
</html>