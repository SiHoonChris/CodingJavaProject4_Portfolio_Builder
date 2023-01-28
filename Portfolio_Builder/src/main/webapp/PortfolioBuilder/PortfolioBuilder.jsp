<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="AccessDB.DataServlet" %>
<%@ page import="java.util.ArrayList" %>
<%
DataServlet srv = new DataServlet();
String listOfAssets = srv.ShowAll();
String html = (String)request.getAttribute("html_txt");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Build your Portfolio!</title>
		<!-- <link rel="stylesheet" type='text/css' href='PortfolioBuilder.css'> -->
		<style>
		/* 전체 ----------------------------------------------------------------- */
			.container {
				display: grid;
 				grid-template-columns: repeat(2, 50%);
 				grid-template-rows: repeat(2, 50%);
 				height: 828px;
 				width: 1200px;
 				gap: 10px;
 				grid-template-areas:
  		 			"a b"
   					"c d";
   				margin: 0 auto;
			}
		
			button {
				height:  100%;
				width:   100%;
			}
			.scroll {
				overflow-y: scroll;
				font-size: 20px;
			}
		/* 전체 ----------------------------------------------------------------- */
	
		/* (Top-Left) 종목 선택, 포트폴리오 편입 -------------------------------------- */	
			.TL {
		 		grid-area: a;
		 
		 		display: grid;
		 		grid-template-columns: repeat(5, 20%);
		 		grid-template-rows: repeat(5, 20%);
		 		height: 100%;
		 		width: 100%;
		 		gap: 1px;
		 		grid-template-areas:
		   			"a a d d d"
		   			"a a c b b"
		   			"a a c b b"
		   			"a a c b b"
		   			"a a c b b";
		   		
		   		margin-bottom: 2px;
			}
			.TL p {
				margin-top: 7.5px;
				margin-bottom: 0px;
			}
			.TL .select   {
				grid-area: a;
				border: 1px solid black;
					
				display: grid;
		 		grid-template-columns: repeat(1, 100%);
		 		grid-template-rows: repeat(10, 10%);
		 		height: 100%;
		 		width: 100%;
		 		gap: 0;
		 		grid-template-areas:
		   			"a"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
			}
			.TL .select .type   {grid-area: a;}
			.TL .select .type p {float:left; padding-left:15px;}
			.TL .select .scroll {grid-area: b;}
			
			.TL .selected {
				grid-area: b;
				border: 1px solid black;
					
				display: grid;
		 		grid-template-columns: repeat(1, 100%);
		 		grid-template-rows: repeat(8, 12.5%);
		 		height: 100%;
		 		width: 100%;
		 		gap: 0;
		 		grid-template-areas:
		   			"a"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
		   			"b"
			}
			.TL .selected .type   {grid-area: a;}
			.TL .selected .type p {float:left; padding-left:15px;}
			
			.TL .selected .scroll {grid-area: b;}
				
			.TL .display  {grid-area: d; border: 1px solid black; padding-left:10px;}
			.TL .button   {
				grid-area: c;
					
				display: grid;
				grid-template-columns: repeat(1, 100%);
		 		grid-template-rows: repeat(3, 33.1%);
		 		height: 100%;
		 		width: 100%;
				gap: 1px;
				grid-template-areas:
					"a"
					"b"
					"c";
				}
			.TL .button #add    {grid-area: a;}
			.TL .button #remove {grid-area: b;}
			.TL .button #reset  {grid-area: c;}
			
			.TL table input {margin-right: 10px;}
		/* (Top-Left) 종목 선택, 포트폴리오 편입 -------------------------------------- */	
			
		/* (Top-Right) 선택된 종목에 대하여 표 생성 ------------------------------------ */		
			.TR {
				grid-area: b;
				height: 92%;
			}
		 	#table  {
				border: 1px solid black;
		
				display:grid;
		 		grid-template-columns: repeat(1, 100%);
		 		grid-template-rows: repeat(12, 8.33%);
		 		height: 100%;
		 		width: 100%;
		 		gap: 0;
		 		grid-template-areas:
		 			"a"
		 			"b"
		 		 	"b"
		 			"b"
		 		 	"b"
		 			"b"
		 		 	"b"
		 			"b"
		 			"b"
		 			"b"
		 		 	"b"
		 		 	"b"
			}	
			.TR #table #portfolio_table_head {grid-area:a;}
			.TR #table #portfolio_table_head table {
				width:  580px;
				height: 30px;
				border-collapse: collapse;}
			.TR #table #portfolio_table_head th {
				border-right: 1px solid;
				border-bottom: 1px solid;
				background-color: #b3f4ea;
			}
			
			.TR #table #portfolio_table_rows {grid-area:b;}
			.TR #table #portfolio_table_rows table {
				width:  580px;
				height: 30px;
				border-collapse: collapse;}
			.TR #table #portfolio_table_rows td {
				border-right: 1px solid;
				border-top: 1px solid;
				border-bottom: 1px solid;
				text-align:center;
				font-size: 15px;
			}
			
			.TR #table #No          {width:10%;}
			.TR #table #CodeTicker  {width:28%;}
			.TR #table #NameOfStock {width:36%;}
			.TR #table #YieldRate   {width:14%;}
			.TR #table #Porportion  {width:12%;}
			
		
			.time {float: right;}
		/* (Top-Right) 선택된 종목에 대하여 표 생성 ------------------------------------ */
			
		/* (Bottom-Left) 포트폴리오 구성 방법 선택 ------------------------------------- */	
			.BL {
		 		grid-area: c;
		 		display: grid;
		 		grid-template-columns: repeat(5, 20%);
		 		grid-template-rows: repeat(3, 33.33%);
		 		height: 100%;
		 		width: 100%;
		 		gap: 1px;
		 		grid-template-areas:
		   		"a a a a a"
		   		"b b b b c"
		   		"b b b b c";
		   		
		   		margin-top: 8px;
			}
			.BL .select   {
				grid-area: a;
				border: 1px solid black;
					
		 		display: grid;
		 		grid-template-columns: repeat(2, 50%);
		 		grid-template-rows: repeat(5, 20%);
		 		height: 100%;
		 		width: 100%;
		 		gap: 0px;
		 		grid-template-areas:
		   			"a a"
		   			"b b"
		   			"b b"
		   			"b b"
		   			"b b";
			}
			.BL .select .title {grid-area:a;}
			.BL .select .scroll {grid-area:b;}
			.BL .selected {grid-area: b; border: 1px solid black;}
			.BL .button   {grid-area: c;}
		/* (Bottom-Left) 포트폴리오 구성 방법 선택 ------------------------------------- */
			
		/* (Bottom-Right) 포트폴리오 구성 비중 원차트 ----------------------------------- */
			.BR {grid-area: d; padding:0; border: 1px black solid;}
		/* (Bottom-Right) 포트폴리오 구성 비중 원차트 ----------------------------------- */
		</style>
	</head>
	<body>
		<div class="container">
<!-- TL 파트 -->
			<form name="AssetsAndMethod">
			<div id="stock" class="TL">
				<div class="select" align="center">
					<div class="type">
						<p>
							<input id="search_1" type="text" placeholder="종목명 검색"/>
							<span title="전체 종목 수" id="Total"></span>
						</p>
					</div>
					<div class="scroll">
						<table id="showUp_all">
							<%=listOfAssets %>
						</table>
					</div>
				</div>
				<div class="selected" align="center">
					<div class="type">
						<p>
							<input id="search_2" type="text" placeholder="종목명 검색"/>
							<span id="number_selec" title="선택한 종목 수">&nbsp;(0)</span>
						</p>
					</div>
					<div class="scroll">
						<table id="selected">
						</table>
					</div>
					<input type="hidden" id="nameOfAssets" name="Assets" value="empty"/>				
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
  					<button type="submit" onclick="fn_sendDatas(event)">실행</button>
  				</div>
  			</div>
  			</form>
<!-- BL 파트 -->
<!-- TR 파트 -->
  			<div class="TR">
  				<div id="table">
  					<div id="portfolio_table_head">
	  					<table>
	  						<thead>
	  							<tr>
	  								<th id="No">No.</th>
	  								<th id="CodeTicker">코드/티커</th>
	  								<th id="NameOfStock">종목명</th>
	  								<th id="YieldRate">수익률</th>
	  								<th id="Porportion">비중</th>
	  							</tr>
	  						</thead>
	  					</table>
  					</div>
  					<div id="portfolio_table_rows" class="scroll">
	  					<table>
	  						<tbody>
	  							<%=html %>
	  						</tbody>
	  					</table>
  					</div>
  				</div>
  				<span class="date">(자료 업데이트 : 2022.12)</span>
  				<span class="time">(X.XXXXsec.)</span>
  			</div>
<!-- TR 파트 -->
<!-- BR 파트 -->
			<div class="BR">
 				<canvas width="600px" height="414px" id='canvas'></canvas>
			</div>
  		</div>
<!-- BR 파트 -->
		<!-- <script src="PortfolioBuilder.js"></script> -->
		<script>
			// TL-1) 종목명 보여주기
			let asset = document.getElementsByName("in_list");
			var tNum  = asset.length;
			document.getElementById("Total").innerHTML = tNum;  // 종목 수 보여주기
			
			for(var i=0; i<tNum; i++){
				asset[i].addEventListener("mouseover", function(){ // 종목 코드/티커에 마우스 올리면 풀네임 보여줌
					document.getElementById("full-name").innerHTML
					= document.getElementById(event.srcElement.id).getAttribute("id");
				});
				asset[i].addEventListener("mouseout", function(){ // 마우스가 나가면 기본 문자열 보여줌
					document.getElementById("full-name").innerHTML = "종목명 상세";
				});
			}
	
			// TL-2~5) 종목 선택 관련 작업 (버튼 실행)
			let checkedValue_add = [];    // 선택한 종목들을 checkedValue_add에 담고, add_assets()가 실행되면 selectedAssets로 옮김
			let checkedValue_remove = []; // 선택한 종목들을 checkedValue_remove에 담고, remove_assets()가 실행되면 selectedAssets로 옮김
			let selectedAssets=[];  // 종목 선택에 대한 종합적인 결과를 출력하는 배열
			//const map = new Map();  // 4-1)에서 사용 : key는 종목명, value는 그 종목의 위치(배열 안)
			let assetName="";
					
			// TL-2) 버튼 공통 적용
			function aft_buttonClicked() {
				// 포트폴리오 안에 담긴 종목 수 표시
				document.getElementById("number_selec").innerHTML = "&nbsp;("+selectedAssets.length+")";
				// 버튼 실행 후 전체 체크박스에 체크 해제
				const checkedBox = document.getElementsByName("TL_checkbox");
				for(var i=0; i<checkedBox.length; i++){
					if(checkedBox[i].checked==true) checkedBox[i].checked=false;
				}
				checkedValue_add=[];
				checkedValue_remove=[];
			}
				
			// TL-3-1) 추가 : 체크된 항목들을 checkedValue배열에 담기
			function getCheckboxValue(event) {				
				if(event.target.checked==true) {
					let name = event.target.id;
					checkedValue_add.push(name);
					console.log(checkedValue_add);
				}
				else if(event.target.checked==false) {
					let index = checkedValue_add.indexOf(event.target.id);
					checkedValue_add.splice(index, 1);
					console.log(checkedValue_add);
				}
			}
			// TL-3-2) 추가 : 선택된 종목들 포트폴리오에 추가()
			function add_assets() {
				selectedAssets = selectedAssets.concat(checkedValue_add);
				selectedAssets = [...new Set(selectedAssets)];
				checkedValue_add=[];
				
				assetName="<tbody>";
				for(var i=0; i<selectedAssets.length; i++){
					assetName += '<tr><td>';
					assetName += '<input type="checkbox" name="composition" value="'+selectedAssets[i]+'" ';
					assetName += 'onclick="remove_in_array(event)" />';
					assetName += selectedAssets[i];
					assetName += '</td></tr>';
				}
				assetName += "</tbody>";
				document.getElementById("selected").innerHTML = assetName;
				
				aft_buttonClicked();
			}
	
			// TL-4-1) 제거 : selectedAssets 배열에서 선택된 항목 제거
			function remove_in_array(event) {
				if(event.target.checked==true) {
					let name = event.target.value;
					checkedValue_remove.push(name);
					console.log(checkedValue_remove);
				}
				else if(event.target.checked==false) {
					let index = checkedValue_remove.indexOf(event.target.value);
					checkedValue_remove.splice(index, 1);
					console.log(checkedValue_remove);
				}
			}
			// TL-4-2) 제거 : 포트폴리오 내의 선택된 종목만 제거
			function remove_assets() {
				for(var i=0; i<checkedValue_remove.length; i++){
					for(var j=0; j<selectedAssets.length; j++){
						if(checkedValue_remove[i]==selectedAssets[j]){
							selectedAssets.splice(j, 1);
						}	
					}
				}
				checkedValue_remove=[];
	
				assetName="<tbody>";
				for(var i=0; i<selectedAssets.length; i++){
					assetName += '<tr><td>';
					assetName += '<input type="checkbox" name="composition" value="'+selectedAssets[i]+'" ';
					assetName += 'onclick="remove_in_array(event)" />';
					assetName += selectedAssets[i];
					assetName += '</td></tr>';
				}
				assetName += "</tbody>";
				document.getElementById("selected").innerHTML = assetName;
				
				aft_buttonClicked();
			}
	
			// TL-5) 초기화 : 포트폴리오 안에 추가된 전체 종목 삭제
			function reset_assets() {
				if(confirm("선택된 종목 전체가 삭제됩니다.")) {
					selectedAssets=[];
					
					assetName = "<tbody></tbody>";
					document.getElementById("selected").innerHTML = assetName;
					
					aft_buttonClicked();
				}
			}
			
			// TL-6) 종목 검색 구현
			var       input = document.querySelector('#search_1');			
			var  innerTable = document.querySelector('#showUp_all');
			const assetList = document.getElementsByName("in_list");
			const resultList = new Map();  // 전체 종목에 대한 정보 저장
			for(var i=0; i<assetList.length; i++) {
				resultList.set(i, {name : assetList[i].id, ticker : assetList[i].innerHTML});	
			}
			
			input.addEventListener("keyup", function(event){  // 별도의 확인 버튼 없이, 입력된 문자열을 포함하는 내용을 자동으로 <table>형태로 표시
				var html_string = "";
				var  noData = true;  // 찾는 데이터가 있는지 없는지 판단(한 개라도 있으면 false)
				var keyword = input.value.toUpperCase(); // 미국주식의 경우, 대소문자 구분 없이 검색 가능하게 코드 작성
				console.log(keyword);
				
				if(keyword=="" || keyword.length == 0) {  // 입력된 검색어가 없다면, 처음 상태로 돌아온다
					for(var i=0; i<resultList.size; i++){
						html_string += "<tr><td>";
						html_string += "<input type=\"checkbox\" name=\"TL_checkbox\" ";
						html_string += "id=\""+resultList.get(i).ticker+"\" onclick=\"getCheckboxValue(event)\" />";
						html_string += "<span id=\""+resultList.get(i).name+"\" name=\"in_list\">";
						html_string += resultList.get(i).ticker+"</span>";
						html_string += "</td></tr>";			
					}
				}
				else {  
					for(var i=0; i<resultList.size; i++){
						if((resultList.get(i).name).toUpperCase().indexOf(keyword)==0) { // 검색어와 일치하는 데이터만으로 테이블을 구성한다.
							noData=false;
							html_string += "<tr><td>";
							html_string += "<input type=\"checkbox\" name=\"TL_checkbox\" ";
							html_string += "id=\""+resultList.get(i).ticker+"\" onclick=\"getCheckboxValue(event)\" />";
							html_string += "<span id=\""+resultList.get(i).name+"\" name=\"in_list\">";
							html_string += resultList.get(i).ticker+"</span>";
							html_string += "</td></tr>";
						}
					} // for반복문이 끝날 때까지, 조건에 해당하는 데이터가 한 개라도 있으면 noData는 false 
					
					if(noData==true){ // 만약 없으면 찾는 결과가 없다("No Data")고 출력
						html_string += "<tr><td>";
						html_string += "No Data";
						html_string += "</td></tr>";
					}
					
				}
				
				innerTable.innerHTML = html_string;
				document.getElementById("Total").innerHTML = document.getElementsByName("in_list").length;  // 검색된 결과에 따라 종목수 변경
			});
			
			
			// BL-1) 포트폴리오 가중 방식에 대한 설명을 보여준다
			let method = document.querySelector("#p_method");
			let expl   = document.querySelector("#p_expl");
				
			function select_method(event) {
				let title;
				let explanation;
	
				switch(event.target.id) {
				case 'ewi':
					title="동일 가중방식";
					explanation = "모든 구성 종목에 동일한 비중으로 투자한다. 중소형주의 주가변화가 상대적으로 높게 반영된다.";
					break;
				case 'cwi':
					title="시가총액 가중방식";
					explanation = "시가총액에 비례하여 구성 종목의 투자 비중을 설정한다. 대형주의 주가변화가 상대적으로 높게 반영된다.";
					break;
				case 'shcwi':
					title="SiHoonChris 가중방식";
					explanation = "SiHoonChris가 Ray Dalio의 Risk-Parity Portfolio 전략에서 파생시킨 가중방식으로, ";
					explanation +="특정 기간 동안의 연간 수익률이 가지는 표준편차를 기준으로 투자비중을 설정하는 방식이다. ";
					explanation +="표준편차가 낮을수록 높은 투자비중을 갖게 되며, 기대수익률은 기간 동안의 연평균 수익률에서 ";
					explanation +="표준편차의 크기에 비례하는 수익률을 감하여 계산한다.";
				}
				method.textContent = title;
				expl.textContent   = explanation;
			}
	
			// BL-2) 실행 버튼 구현
			function fn_sendDatas(event){
				let html_string="";
				for(var i=0; i<selectedAssets.length; i++ ){
					if(i==selectedAssets.length-1) {html_string += "'"+selectedAssets[i]+"'";}
					else {html_string += "'"+selectedAssets[i]+"', "};
				}
				document.getElementById("nameOfAssets").value = html_string;
	
				let AssetsAndMethod = document.AssetsAndMethod;
				let Method = AssetsAndMethod.Method.value;
				let Assets = AssetsAndMethod.Assets.value;
				
				if(Assets.length < 1) {
					alert("적어도 1종목 이상 선택하세요");
					return false;
				}
				else if(Method.length < 1) {
					alert("가중방식을 선택하세요");
					return false;
				}
				else {
					AssetsAndMethod.method="post";
					AssetsAndMethod.action="/result";
					AssetsAndMethod.submit();
				}
			}
			
			
			// BR) 원차트(도넛차트) 만들기
			var prop_array = document.getElementsByName('Proportion');
			var name_array = document.getElementsByName('CodeTicker');
			const canvas = document.getElementById('canvas');
			const ctx    = canvas.getContext('2d');
			var   width  = canvas.clientWidth;
			var   height = canvas.clientHeight;
			var   value  = [];
			function getDatasForChart() { // 문자열=>숫자열 (42.13% => 42.13)
				for(var i=0; i<prop_array.length; i++){		
					value.push( parseFloat(prop_array[i].innerHTML.substr(0, (prop_array[i].innerHTML.length-1))) ); 
				}
			}
			getDatasForChart();
			var   degree = 360;
			var   radius = 150; // 반지름
			
			// sum : 총 합계
			var sum = value.reduce((a, b) => a+b);
			// conv_array : 비율(개별 데이터/데이터 총합)들이 담긴 배열
			var conv_array = value.slice().map((data) => {
				var rate = data / sum;
				var myDegree = degree * rate;
				return myDegree;
			});
			
			degree = 0; // 360 => 0으로 초기화 
			var event_array = value.slice().map(arg=>[]);
			for(var i=0; i<conv_array.length; i++) {
				var item = conv_array[i];
				ctx.save();
				ctx.beginPath();
				ctx.moveTo(width/2, height/2);
				if(i==0){
					// arc : 호(원)를 그리는 함수(라디안 사용, 1도 × π/180 = 0.01745라디안)
					// ctx.arc(x좌표, y좌표, 반지름(radius), 시작각(startAngle), 끝각(endAngle), counterClockwise)
					ctx.arc(width/2, height/2, radius, (Math.PI/180)*0, (Math.PI/180)*item, false);
					degree = item;
					event_array[i]=[0, degree];
				}
				else {
					ctx.arc(width/2, height/2, radius, (Math.PI/180)*degree, (Math.PI/180)*(degree+item), false);
					event_array[i]=[degree, degree+item];
					degree = degree + item;
				}
				ctx.closePath();
				ctx.stroke();
				ctx.restore();
			}
			
			var drawed = false;
			canvas.addEventListener("mousemove", function(event){
				// clientX,Y(브라우저(웹 페이지)의 크기를 기준으로 위치 계산) vs. screenX,Y(화면(모니터)의 크기를 기준으로 위치 계산)
				// offsetTop, offsetLeft
				// => offsetTop is the number of pixels from the top of the closest relatively positioned parent element(margin을 포함한 영역을 기준으로 함)
				var x1 = event.clientX-canvas.offsetLeft;
				var y1 = event.clientY-canvas.offsetTop;
				var inn = isInsideArc(x1, y1);
				console.log(inn);
				if(inn.index>-1){
					drawed=true;
					hoverCanvas(inn.index);
					makeText(inn.index);
				}
				else {
					if(drawed){
						hoverCanvas(-1);
						makeText(-1);
					}
					drawed=false;
				}
			});
			
			function isInsideArc(x1, y1){  // 이벤트 위치 파악 함수
				var result1 = false; // 원의 중심점 기준, 반지름 내부에 들어왔는지 확인
				var result2 = false;
				var index = -1;
				var circle_len = radius;
				var x = width/2 - x1;
				var y = height/2 - y1;
				var my_len = Math.sqrt(Math.abs(x*x)+Math.abs(y*y));
				
				if(circle_len >= my_len) {result1 = true;}
				
				var rad = Math.atan2(y,x); // 아크탄젠트(이벤트 발생 지점의 (중심점 기준)방향 확인) 활용, 라디안으로 계산됨
				rad = (rad*180)/Math.PI; // 라디안 => 각 , 음수가 나옴
				rad += 180;
				
				if(result1){                          // 반지름(원 범위) 안에 있으면서
					event_array.forEach((arr, idx)=>{ // 각도 범위 안에 있는지 확인
						if(rad>=arr[0] && rad<=arr[1]){
							result2 = true;
							index = idx; // 0부터 시작
						}
					});
				}
				
				return {x:x, y:y, my_len:my_len, result1:result1, result2:result2, index:index, degree:rad};
			}
			
			function hoverCanvas(index) {  // 마우스 동작에 따라 차트가 다시 그려짐(앞에서 처음 원형차트 만들 때 했던 과정 반복)
				ctx.clearRect(0,0,width,height);  // canvas 안의 내용물 지우기
				for (var i=0; i<conv_array.length; i++) {
					var item = conv_array[i];
					ctx.save();
					ctx.beginPath();
					var innRadius = radius;
					ctx.moveTo(width/2, height/2);
					
					if(index == i) {  // 대상이면 색칠 및 크기 조정
						ctx.lineWidth = 3;
						ctx.strokeStyle = 'blue';
						innRadius = radius*1.1;
					}
					if(i == 0) {
						ctx.arc(width/2, height/2, innRadius, (Math.PI/180)*0, (Math.PI/180)*item, false);
						degree = item; // 초기화
					}
					else {
						ctx.arc(width/2, height/2, innRadius, (Math.PI/180)*degree, (Math.PI/180)*(degree+item), false);
						degree = degree + item;
					}
					
					ctx.closePath();
					ctx.stroke();
					ctx.restore();
				}
			}
			
			function degreeToRadian(degree) { // 도 => 라디안
				return degree*(Math.PI/180);
			}
			
			function makeText(index) {				
				event_array.forEach((itm, idx) => {
					var half = (itm[1]-itm[0])/2;
					var degr = itm[0]+half;
					var xx = Math.cos(degreeToRadian(degr)) * radius * 0.7 + width/2;
					var yy = Math.sin(degreeToRadian(degr)) * radius * 0.7 + height/2;
					
					var txt; // 마우스 위치에 따라 다른 값 출력
					var minus = ctx.measureText(txt).width/2; // 텍스트 절반 길이
					ctx.save();
					
					if(index==idx) {
						ctx.font = "normal bold 22px serif";
						ctx.fillStyle='blue';
						txt=prop_array[idx].innerHTML;
					}
					else {
						ctx.font = "normal 18px";
						txt=name_array[idx].innerHTML;
					}
					ctx.fillText(txt, xx-minus, yy);
					ctx.restore();
				});
			}
			
			makeText(-1);
		</script>
	</body>
</html>