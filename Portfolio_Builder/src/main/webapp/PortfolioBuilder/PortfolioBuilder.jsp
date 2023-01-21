<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="AccessDB.DataServlet" %>
<%@ page import="java.util.ArrayList" %>
<%
DataServlet srv = new DataServlet();
ArrayList<String> listOfAssets = srv.ShowAll();
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
			.BR {grid-area: d;}
			
			#canvas {border: 1px black solid;}
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
 			<canvas width="600px" height="414px" class="BR" id='canvas'></canvas>
  		</div>
<!-- BR 파트 -->
		<!-- <script src="PortfolioBuilder.js"></script> -->
		<script>
			// TL-1) 종목명 보여주기
			let total_num = document.getElementById("Total").innerHTML;
			total_num = total_num.substring(6);
					
			for(var i=1 ; i < parseInt(total_num,10) ; i++){
				let id="list-no"+i;
				let asset = document.getElementById(id);
				asset.addEventListener("mouseover", assetMouseOver);
				asset.addEventListener("mouseout", assetMouseOut);
			}
	
			function assetMouseOver(){ // 종목 코드/티커에 마우스 올리면 풀네임 보여줌
				document.getElementById("full-name").innerHTML
				= document.getElementById(event.srcElement.id).getAttribute("name");
			}
			function assetMouseOut(){ // 마우스가 나가면 기본 문자열 보여줌
				document.getElementById("full-name").innerHTML="종목명 상세";
			}
	
			// TL-2~5) 종목 선택 관련 작업 (버튼 실행)
			let checkedValue_add = [];    // 선택한 종목들을 checkedValue_add에 담고, add_assets()가 실행되면 selectedAssets로 옮김
			let checkedValue_remove = []; // 선택한 종목들을 checkedValue_remove에 담고, remove_assets()가 실행되면 selectedAssets로 옮김
			let selectedAssets=[];  // 종목 선택에 대한 종합적인 결과를 출력하는 배열
			const map = new Map();  // 4-1)에서 사용 : key는 종목명, value는 그 종목의 위치(배열 안)
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
					assetName += 'onclick="remove_in_array(event)" /> ';
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
					assetName += 'onclick="remove_in_array(event)" /> ';
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
				
				AssetsAndMethod.method="post";
				AssetsAndMethod.action="/result";
				AssetsAndMethod.submit();
			}
			
			
			// BR) 원차트(도넛차트) 만들기
			const canvas = document.getElementById('canvas');
			const ctx    = canvas.getContext('2d');
			var   width  = canvas.clientWidth;
			var   height = canvas.clientHeight;
			var   value  = [42.13 , 23.28 , 34.59];
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
					console.log(0, degree);
				}
				else {
					ctx.arc(width/2, height/2, radius, (Math.PI/180)*degree, (Math.PI/180)*(degree+item), false);
					console.log(degree, degree+item);
					degree = degree + item;
				}
				ctx.closePath();
				ctx.stroke();
				ctx.restore();
			}
		</script>
	</body>
</html>