<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>VINNS MEDIA ACADEMY</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
	.chart-bar, .chart-grade {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.chart-bar {
		flex-direction: column;
	}
	.chart-grade div {
		margin-left: 4vw;
		display: flex;
		justify-content: space-around;
		align-items: center;
	}
	.chart-grade div span {
		color: #454545;
	}
	/* 범례 커스텀 */
	.chartjs-legend ol, .chartjs-legend ul {
		list-style: none;
		margin: 0;
		padding: 0;
		text-align: right;
	}
	.chartjs-legend li {
		cursor: pointer;
		display: inline-table;
		margin: 10px 4px;
	}
	.chartjs-legend li span.bar {
		position: relative;
		padding: 0px 10px;
		margin: 5px;
		
		color: white;
	}
	.chartjs-legend li span.line {
		position: relative;
		padding: 0px 10px;
		margin: 5px;
		border-radius: 100px;
		color: white;
	}
	.chartjs-legend li div.line {
		float:left;
		height:2px;
		background:#000;
		font-size:0;
		line-height:0;
		width:25px;
		padding: 1px 0px;
		border-radius: 100px;
		margin: 9px 5px;
		
	}
	
	
</style>

</head>
<body>
	<!-- 전체 감싸는 것 -->
	<div class='container-fluid'>
		<nav class="navbar navbar-light bg-light">
			<a class="navbar-brand" href="/">
				<img src="http://vinnsmedia.com/assets/image/vinns_logo_h42.png" alt="">
			</a>
			<span class="navbar-text">
				Academy
			</span>
		</nav>

		<!-- 차트 -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">학년 / 트랙별 평균점수</h6>
			</div>
			<div class="card-body">
				<div class="chart-bar" >
					<div id="chartLegend" class="chartjs-legend"></div>
					<canvas id="avgChart" style="height:60vh; width:90vw;"></canvas>
				</div>
				<div class="chart-grade">
					<div style="height:5vh; width:90vw;">
						<span>10학년</span>
						<span>11학년</span>
						<span>12학년</span>
					</div>
				</div>
			</div>
		</div>
		<!-- 목록 전체 -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">학년별 학생 목록</h6>			
			</div>
			<!-- 목록 만들기-->
			<div class="card-body">
				<ul class="nav nav-tabs">
					<li class="nav-item">
						<a class="nav-link active" href="10">10학년</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="11">11학년</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="12">12학년</a>
					</li>
				</ul>
				<br/>
				<div class="tab-content">
					<div class="table-responsive">
						<table id="studentTable" class="table table-bordered" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>No</th>
									<th>Name</th>
									<th>Gender</th>
									<th>Level</th>
									<th>Track</th>
									<th colspan=2>Lecture / Score</th>
									<th colspan=2>Lecture / Score</th>
									<th colspan=2>Lecture / Score</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
						<!-- 페이징 -->
						<div>
							<ul class="pagination justify-content-center">
								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- jquery 최신 js -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script>
	var defaultLevel = 10;
	var defaultPage = 1;
	
	
	
	paintingChart();
	paintingList(defaultLevel, defaultPage);
	// 화면 사이즈 변경 시 막대 그래프 너비가 늘어나서 이쁘지 않아 다시 불러오기로 함.
	// 차트를 다시 그릴 경우 범례는 그대로임. 
	// 새로고침을 할 경우 밑의 학생목록이 초기화가 됨.
	/* $(window).resize(function(){
		
	}); */
	
	// 차트 그리기
	function paintingChart() {
		$.ajax({
			type: "GET",
			url: "/chart",
			dataType: "json"
		}).done(function(result){
			// result.totalAvgList = 학년 별, 트랙 별 평균 점수
			// result.ANP = Alice & Parker의 학년별 track 1 점수
			var ctx = document.getElementById('avgChart');
			
			window.theChart = new Chart(ctx, {
				type: 'bar',
				data: {
					labels: ['4', '3', '2', '1', 
						'4', '3', '2', '1',
						'4', '3', '2', '1'],
					datasets: [{
						label: 'Alice',
						data: [NaN, NaN, NaN, result.ANP[0].scores[0].value, NaN, NaN, NaN, result.ANP[0].scores[1].value, NaN, NaN, NaN, result.ANP[0].scores[2].value],
						backgroundColor: 'rgba(153, 102, 255, 0.8)',
						borderColor: 'rgba(153, 102, 255, 1)',
						fill: false,
						type: 'line',
						spanGaps: true,
					}, {
						label: 'Parker',
						data: [NaN, NaN, NaN, result.ANP[1].scores[0].value, NaN, NaN, NaN, result.ANP[1].scores[1].value, NaN, NaN, NaN, result.ANP[1].scores[2].value],
						backgroundColor: 'rgba(255, 159, 64, 0.8)',
						borderColor: 'rgba(255, 159, 64, 1)',
						fill: false,
						type: 'line',
						spanGaps: true,
					}, {
						label: 'track',
						type: 'bar',
						data: [result.totalAvgList[0].avg, 
							result.totalAvgList[1].avg, 
							result.totalAvgList[2].avg, 
							result.totalAvgList[3].avg, 
							result.totalAvgList[4].avg, 
							result.totalAvgList[5].avg, 
							result.totalAvgList[6].avg, 
							result.totalAvgList[7].avg, 
							result.totalAvgList[8].avg, 
							result.totalAvgList[9].avg, 
							result.totalAvgList[10].avg, 
							result.totalAvgList[11].avg, 
						],
						backgroundColor: [
							'rgba(255, 99, 132, 0.8)',
							'rgba(54, 162, 235, 0.8)',
							'rgba(255, 206, 86, 0.8)',
							'rgba(75, 192, 192, 0.8)',
							'rgba(255, 99, 132, 0.8)',
							'rgba(54, 162, 235, 0.8)',
							'rgba(255, 206, 86, 0.8)',
							'rgba(75, 192, 192, 0.8)',
							'rgba(255, 99, 132, 0.8)',
							'rgba(54, 162, 235, 0.8)',
							'rgba(255, 206, 86, 0.8)',
							'rgba(75, 192, 192, 0.8)',
						],
						borderColor: [
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
						],
						borderWidth: 1,
						maxBarThickness: 50,
					}]
				},
				options: {
					legend: false,
					legendCallback: function(chart){
						return drawCustomLegend(chart);
					},
					responsive: false,
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true
							}
						}]
					},
				}
			});
			$("#chartLegend").html(window.theChart.generateLegend());
			
			// 커스텀 범례
			function drawCustomLegend(chart){
				var text=[];
				text.push('<ul class="'+chart.id+'-legend">');
				if(chart.config.type == 'bar'){
					var barIndex = chart.data.datasets.length;
					for(var i=0; i<chart.data.datasets.length;i++){
						
						if(chart.data.datasets[i].type == 'line' == false){
							barIndex = i;
							break;
						}
					}
					
					for (i=barIndex; i<chart.data.datasets.length; i++) {
						if(!(chart.data.datasets[i].hideLegend) && chart.data.datasets[i].label){
								text.push('<li datasetIndex="'+i+'"><span class="bar" style="background-color: '+chart.data.datasets[i].backgroundColor[0]+'"></span>');
								text.push('<span>'+chart.data.datasets[i].label+'</span>');
								text.push('</li>');
						}
					}
					for (i=0;i<barIndex;i++){
						if(!(chart.data.datasets[i].hideLegend) && chart.data.datasets[i].label){
							text.push('<li datasetIndex="'+i+'"><span class="line" style="background: '+chart.data.datasets[i].borderColor+'"></span>');
							text.push('<span>'+chart.data.datasets[i].label+'</span>');
							text.push('</li>');
						}
					}
				}else if(chart.config.type == 'line'){
					for(i=0;i<chart.data.datasets.length;i++){
						if(!(chart.data.datasets[i].hideLegend) && chart.data.dataset[i].label){
							text.push('<li datasetIndex="'+i+'"><span class="line" style="background-color: '+chart.data.datasets[i].borderColor+'"></span>');
							text.push('<span>'+chart.data.datasets[i].label+'</span>');
							text.push('</li>');
						}
					}
				}
				text.push('</ul>');
				return text.join("");
			}
			// 기존 범례 기능 추가
			$("#chartLegend li").click(function(){
				updateDataset(event, $(this).attr("datasetIndex"), "theChart");
				if($(this).css("text-decoration").indexOf("line-through")<0){
					$(this).css("text-decoration", "line-through");
				}else {
					$(this).css("text-decoration", "none");
				}
			});
			
			// update 함수
			function updateDataset(e, datasetIndex, chartId){
				var index = datasetIndex;
				var ci = e.view[chartId];
				var meta = ci.getDatasetMeta(index);
				var scaleList = ci.options.scales["yAxes"];
				
				meta.hidden = meta.hidden === null? !ci.data.datasets[index].hidden : null;
				ci.update();
			}
		}).fail(function(xhr, status, errorThrown){
			console.log(errorThrown+" / "+status);
		});
	} 
	// 리스트 그리기
	function paintingList(level, page){
		$.ajax({
			type: "GET",
			url: "/"+level+"/"+page,
			dataType: "json"
		}).done(function(data){
			// data.students = 학년 별 학생 리스트
			// data.pageMaker = 페이징 처리
			var html = "";
			$(data.students).each(function(){
				html += "<tr>";
				html += "	<td>";
				html += this.seq;
				html += "	</td>";
				html += "	<td>";
				html += this.name;
				html += "	</td>";
				html += "	<td>";
				html += this.gender;
				html += "	</td>";
				html += "	<td>";
				html += this.level;
				html += "	</td>";
				html += "	<td>";
				html += this.track;
				html += "	</td>";
				if(this.scores == null || this.scores.length == 0) {
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
				}else if(this.scores.length == 1){
					html += "	<td>";
					html += this.scores[0].title;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[0].score;
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
				}else if(this.scores.length == 2) {
					html += "	<td>";
					html += this.scores[0].title;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[0].score;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[1].title;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[1].score;
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
					html += "	<td>";
					html += " -- ";
					html += "	</td>";
				}else if(this.scores.length == 3) {
					html += "	<td>";
					html += this.scores[0].title;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[0].score;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[1].title;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[1].score;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[2].title;
					html += "	</td>";
					html += "	<td>";
					html += this.scores[2].score;
					html += "	</td>";
				}
				html += "</tr>";
			});
			$("#studentTable tbody").html(html);
			makePage(data.pageMaker, level);
		}).fail(function(xhr, status, errorThrown){
			console.log(errorThrown+" / "+status);
		});
	}
	// 페이지 만들기
	function makePage(pm, level){
		var html = "";
		var isPrev = pm.prev ? '' : 'disabled';
		var isNext = pm.next ? '' : 'disabled';
		
		html += "<li class='page-item "+isPrev+"'>";
		html += "	<a class='page-link' href='"+(pm.startPage-1)+"'>&laquo;</a>";
		html += "</li>";
		for(var i=pm.startPage;i<=pm.endPage;i++){
			var current = pm.cri.page == i? 'active' : '';
			html += "<li class='page-item "+current+"'>";
			if(current == 'active'){
				html += "	<span class='page-link'>"+i+"</span>";
			}else {
				html += "	<a class='page-link' href='"+i+"'>"+i+"</a>";	
			}
			html += "</li>";
		}
		html += "<li class='page-item "+isNext+"'>";
		html += "	<a class='page-link' href='"+(pm.endPage+1)+"'>&raquo;</a>";
		html += "</li>";
		$(".pagination").html(html);
	}
	
	// 페이지 클릭 시
	$(".pagination").on("click", "li a", function(e){
		e.preventDefault();
		var page = $(this).attr("href");
		var level = $(".nav-tabs .nav-item .active").attr("href");
		paintingList(level, page);
	});
	
	// 학년별로 보기
	$(".nav-tabs .nav-item .nav-link").on("click", function(e){
		e.preventDefault();
		if($(this).hasClass('active')){
			return;
		}else {
			var level = $(this).attr("href");
			
			// 다른 녀석 active 효과 지우기
			$(".nav-tabs .nav-item").children().removeClass('active');
			// 그녀석 active 효과 주기
			$(this).addClass("active");
			paintingList(level, defaultPage);
		}
	});
</script>
</html>