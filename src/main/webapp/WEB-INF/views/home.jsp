<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>빈스미디어 아카데미</title>
</head>
<body>
	<!-- 전체 감싸는 것 -->
	<div>
		<!-- 차트 -->
		<div>
			<canvas id="avgChart" width="400" height="400"></canvas>
		</div>
	</div>
</body>
<!-- jquery 최신 js -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script>
	var level = 10;
	
	paintingChart();
	paintingList(level);
	
	// 차트 그리기
	function paintingChart() {
		$.ajax({
			type: "GET",
			url: "/chart",
			dataType: "json"
		}).done(function(result){
			console.log(result);
			// result.totalAvgList = 학년 별, 트랙 별 평균 점수
			// result.ANP = Alice & Parker의 학년별 track 1 점수
			var ctx = document.getElementById('avgChart');
			var avgChart = new Chart(ctx, {
				type: 'bar',
				data: {
					labels: ['4', '3', '2', '1'],
					datasets: [
						{
							
						},
						{
							
						},
						{
							
						},
						{
							
						}
					],
					datasets: [{
						label: '#1',
						data: [12, 19, 3, 5, 2, 3],
						backgroundColor: [
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)',
							'rgba(255, 206, 86, 0.2)',
							'rgba(75, 192, 192, 0.2)',
							
						],
						borderColor: [
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							
						],
						borderWidth: 1
					}],
				},
				options: {
					responsive: false,
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true
							}
						}]
					},
				} 
			})
		}).fail(function(xhr, status, errorThrown){
			console.log(errorThrown+" / "+status);
		});
	} 
	// 리스트 그리기
	function paintingList(level){
		$.ajax({
			type: "GET",
			url: "/"+level,
			dataType: "json"
		}).done(function(students){
			console.log(students);
			// students = 학년 별 학생 리스트
		}).fail(function(xhr, status, errorThrown){
			console.log(errorThrown+" / "+status);
		});
	}
</script>
</html>