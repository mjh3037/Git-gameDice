<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
.content{
	padding: 10px;
}
</style>
<%@ include file="/WEB-INF/views/adminView.jsp" %>
<title>product Enrollment</title>
</head>
<body>
	<div class="content">
		<h2>product name</h2>
		
		<div class="pnameTxt">
			<input type="text" class="pname" size="50" placeholder="product name">
		</div>
		<h2>company select</h2>
		
		<div class="companySelect">
			<select class="companyCode">
				<c:forEach var="list" items="${companyList}">
					<option value="${list.companyCode}">${list.cname}</option>
				</c:forEach>
			</select>
		</div>
		
		<h2>flatform</h2>
		
		<div class="flatformSelect">
			<input type="checkbox" name="flatform" value="windows">windows
			<input type="checkbox" name="flatform" value="mac">mac
			<input type="checkbox" name="flatform" value="linux">linux
		</div>
		
		<h2>price</h2>
		
		<div class="priceTxt"> <input type="text" class="price" placeholder="write price"></div>
		
		<h2>content</h2>
		
		<div class="contentTxt"><textarea rows="15" cols="75" class="content1" placeholder="write content"></textarea></div>
		
		<h2>aboutGame</h2>
		
		<div class="aboutGameTxt"><textarea rows="10" cols="75" class="aboutGame" placeholder="write about"></textarea></div>
		
		<h2>systemRequirements</h2>
		
		<span class="systemMinRequirementsTxt"><textarea rows="25" cols="50" class="systemMinRequirements" placeholder="write systemMinRequirements"></textarea></span>
		<span class="systemMaxRequirementsTxt"><textarea rows="25" cols="50" class="systemMaxRequirements" placeholder="write systemMaxRequirements"></textarea></span>
		
		<h2>ReleasedDate</h2>
		<div class="Date">
			
			<select class="confirmationCheck">
				<option value="Coming Soon">출시일 미정</option>
				<option value="Confirmation">출시일 확정</option>
			</select>
			<div class="calenderDiv">
				<input type="text" id="calender">
			</div>
		</div>
		
		<div>
			<input type="button" class="btnInsert" value="Enter">
		</div>
	</div>
</body>

<script>
$( ".calenderDiv" ).hide();

$(".confirmationCheck").on("change",function(){
	console.log("1");
	var select = $(this).val();
	if(select == "Confirmation"){
		$( ".calenderDiv" ).show();
	}else{
		$( ".calenderDiv" ).hide();
	}
});




 $('.btnInsert').on("click",function(){
	 var pname= $('.pname').val();
	 var companyCode= $('.companyCode option:selected').val();
	 var price= $('.price').val();
	 var content= $('.content1').val();
	 var aboutGame= $('.aboutGame').val();
	 var systemMin= $('.systemMinRequirements').val();
	 var systemMax= $('.systemMaxRequirements').val();
	 var total= 20;
	 var flatForm= "";
	 var confirmationCheck = $("#calender").val();

	 if(confirmationCheck == ""){
		 confirmationCheck = "none";
	 }
	 
	 
	 $("input[name=flatform]:checked").each(function() {
		 flatForm += $(this).val();
		 flatForm += ", ";
		});
	
	$.ajax({
		type: "POST",
		url: "/product/insert",
		data: {"pname":pname, "companyCode": companyCode, "flatForm": flatForm, "price": price, "content": content, "aboutGame": aboutGame, "systemMinRequirements": systemMin, "systemMaxRequirements": systemMax, "totalArcheive": total, "confirmationCheck": confirmationCheck},
		success: function(){
			alert("success");
		}
	});
 });


 
 
 $(function() { 
		 $( "#calender" ).datepicker({ 
			 showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다. 
			 buttonImage: "/application/db/jquery/images/calendar.gif", // 버튼 이미지 
			 buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다. 
			 changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다. 
			 changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다. 
			 minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.prev 아이콘의 툴팁.
			 nextText: '다음 달', // next 아이콘의 툴팁. prevText: '이전 달', // 
			 numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
			 stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
			 yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가. 
			 showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
			 currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널 
			 closeText: '닫기', // 닫기 버튼 패널 
			 dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식. 
			 showAnim: "slide", //애니메이션을 적용한다. 
			 showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
			 dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식. 
			 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월의 한글 형식. 
// 			 yearRange: "2010:2013" //연도 범위
		 }); 
	 });


</script>
</html>