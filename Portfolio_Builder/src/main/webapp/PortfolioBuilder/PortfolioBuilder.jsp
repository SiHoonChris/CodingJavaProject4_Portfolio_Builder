<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<!-- https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Box_Alignment_in_CSS_Grid_Layout -->

<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width" initial-scale="1.0">
		<title>Build your Portfolio!</title>
		<style>
			.container {
				display: grid;
  				grid-template-columns: repeat(2, 50%);
  				grid-template-rows: repeat(2, 50%);
  				height: 690px;
  				width: 1000px;
  				gap: 10px;
  				grid-template-areas:
    				"a b"
    				"c d";
    			margin: 0 auto;
			}
			
			
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
			.TL .select   {grid-area: a; border: 1px solid black;}
			.TL .selected {grid-area: b; border: 1px solid black;}
			.TL .display  {grid-area: d; border: 1px solid black;}
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
			.TL .button .add    {grid-area: a; border: 1px solid black;}
			.TL .button .remove {grid-area: b; border: 1px solid black;}
			.TL .button .reset  {grid-area: c; border: 1px solid black;}
			
			
			.TR {
  				grid-area: b;
			}
			#table {
				border: 1px solid black;
				height: 92%;
			}
			.time {float: right;}
			
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
			.BL .select   {grid-area: a; border: 1px solid black;}
			.BL .selected {grid-area: b; border: 1px solid black;}
			.BL .button   {grid-area: c; border: 1px solid black;}
			
			.BR {
  				grid-area: d;
  				border: 1px solid black;
			}
			
			button {
				height:  100%;
				width:   100%;
			}
		</style>
	</head>
	<body>
		<div class="container">
		
			<div id="stock" class="TL">
				<div class="select" align="center">
					<input type="text" placeholder="티커 또는 종목코드 검색"/>
					<!-- 따로 확인 버튼 없이, 입력된 결과에 해당하는 내용만 박스에 남김. 만약 없으면 찾는 결과가 없다고 출력 -->
					<!-- 체크박스 적용 -->
				</div>
				<div class="selected">종목 리스트(티커/코드)</div>
				<div class="display">
					<h3>iShares 20+ Treasury Bond</h3>
					<!-- div(class="select") 내의 종목명에 마우스 올리면 div(class="display")에 종목 풀네임 출력 -->
					<!-- Full-name이 길어서 칸 밖으로 나가면 애니메이션 효과 적용, 전광판처럼 우에서 좌로 이동 -->
				</div>
				<div class="button">
					<div class="add">
						<button>추가</button>
					</div>
					<div class="remove">
						<button>제거</button>
					</div>
					<div class="reset">
						<button>초기화</button>
						<!-- 초기화 버튼 클릭 시 alert 창 띄우기 : 재확인 -->
					</div>
				</div>
			</div>
			
  			<div class="TR">
  				<div id="table">표 : No. Ticker/Code 종목명 수익률 비중</div>
  				<span class="date">(업데이트 : 2022.12)</span>
  				<span class="time">(X.XXXXsec.)</span>
  			</div>
  			<div id="method" class="BL">
  				<div class="select">포트폴리오 구성 방법</div>
  				<!-- 라디오버튼 적용 -->>
  				<div class="selected">선택된 포트폴리오 설명</div>
  				<div class="button">
  					<button>실행</button>
  				</div>
  			</div>
  			<div id="chart" class="BR">
  				도넛모양 차트
  			</div>
  		</div>
	</body>
</html>