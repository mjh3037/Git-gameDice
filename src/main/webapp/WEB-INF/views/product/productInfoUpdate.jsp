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

<%@ include file="/WEB-INF/views/adminView.jsp" %>
<title>Add Info</title>
<style>

.arrow_bg{
	display:inline-block;
	width: 50px;
	height: 25px;
	float:left;
	background: green;
	margin-top: 100px;
	padding-left: 20px;
	border: 1px solid black;
}
.addItems{
	background: rgb(34,193,195);
	background: linear-gradient(0deg, rgba(34,193,195,1) 0%, rgba(53,253,45,0.30885857761073177) 100%);
}
.items{
	background: rgb(34,193,195);
	background: linear-gradient(0deg, rgba(34,193,195,1) 0%, rgba(53,253,45,0.30885857761073177) 100%);
}
.a{text-decoration: none;}

.includeItems{
	width:400px;
	height: 250px;
	float: left;	
	overflow: hidden;
	border: 1px solid gray;
}
.selectedItems{
	width:400px;
	height: 250px;
	float: right;	
	overflow: hidden;
	border: 1px solid gray;
}
.items_bg{
	display: inline-block;
	border: 1px solid gray;
	margin: 0 auto;
	margin: 5px;
}

.important_content_bg{
background: rgb(34,193,195);
background: linear-gradient(0deg, rgba(34,193,195,1) 0%, rgba(45,228,253,0.6674019949776786) 100%);
}
.content{
	widht:100%;
	heigt: 1500px;
}
.includeFile_List_bg{
	width: 50%;
	margin: 0 auto;
	display: inline-block;
	height: 100%;
	background: grey;
	padding: 25px;
}
</style>
</head>
<body>
	<h1>IncludeProduct Add Page</h1>
	
	<div class="content">
		<div class="content_bg">
			<div class="includeFile_List_bg">
				<div class="includeFile_List">
				
					<div class="important_content_bg">
					
						<div class="companySelect">
							<h2>Select Add Product</h2>
							<select class="productCode">
									<option value="none">none</option>
								<c:forEach var="list" items="${productList}">
									<option value="${list.pcode}">${list.pname}</option>
								</c:forEach>
							</select>
						</div>
						<div class="pakageType_bg">
							<h2>pakageType</h2>
							<select class="pakageType">
								<option value="none" selected>none</option>
								<option value="collection">collection</option>
								<option value="DLC">DLC</option>
							</select>
						</div>
						<div class="includeItems_bg">
							<h2>Items (Pakage)</h2>
								collection Pakage에 포함될 items를 선택하세요.
								<div class="items_bg">
									<div class="includeItems">
									</div>
									<div class="arrow_bg">
										>
									</div>
									
									<div class="selectedItems">
									</div>
								</div>
						</div>
						
					</div>
				
				
					
				
					<div class="includePname_bg">
					<h2>includePname</h2>
						<input type="text" class="includePname" size=25>
					</div>
					
					
			
					<div class="flatformSelect">
					<h2>flatform</h2>
						<input type="checkbox" name="flatform" value="windows">windows
						<input type="checkbox" name="flatform" value="mac">mac
						<input type="checkbox" name="flatform" value="linux">linux
					</div>
					
					
					
					<div class="priceDiv">
					<h2>price</h2>
						<input type="text" class="price" size=25>
					</div>
					
					
					
					
					<div class="contentTxt"><h2>content</h2><textarea rows="15" cols="75" class="content1" placeholder="write content"></textarea></div>
					
					
					
					<div class="aboutGameTxt"><h2>aboutGame</h2><textarea rows="10" cols="75" class="aboutGame" placeholder="write about"></textarea></div>
					
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
					
					
					
					<div class="genru">
						<h2>Genru</h2>
					</div>
					
					
				
					<div>
						<input type="button" class="btnInsert" value="Enter">
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
<script>
$( ".pakageType_bg" ).hide();
$( ".includeItems_bg" ).hide();
$( ".calenderDiv" ).hide();

function itemsRemove(itemsId, itemsName){
	 
	var str = "";
	var id = "#addItems_"+itemsId;
	$(id).remove();
	
	str +="<div class='items' id='items_"+itemsId+"' ><a href='javascript:void(0)' data-value=" + itemsId + " onClick= \"\itemsAdd( "+itemsId+" , '" + itemsName +"')\"\>" + itemsName + "</a></div>";
	
	$(".includeItems").append(str);
}

function itemsAdd(itemsId, itemsName){
 
	var str = "";
	var id = "#items_"+itemsId;
	$(id).remove();
	
	str +="<div class='addItems' id='addItems_"+itemsId+"' ><a href='javascript:void(0)' data-value=" + itemsId + " onClick= \"\itemsRemove( "+itemsId+" , '" + itemsName +"')\"\>" + itemsName + "</a></div>";
	
	$(".selectedItems").append(str);
}

$(".pakageType").on("change",function(){
	if($(this).val() == "collection"){
		$( ".includeItems_bg" ).show();
		var pcode = $('.productCode').val();
		var str = "";
		$.ajax({
			url: "/admin/getIncludeProductList",
			type: "GET",
			dataType: "json",
			data: {"pcode": pcode},
			success:function(response){
				
				$.map(response, function(item){
					console.log(item);
					str +="<div class='items' id='items_"+item.includeId+"' ><a href='javascript:void(0)' data-value=" + item.includeId + " onClick= \"\itemsAdd( "+item.includeId+" , '" + item.includePname +"')\"\>" + item.includePname + "</a></div>"
				});
				
				$('.includeItems').append(str);
			}
		});
		
	}else{
		$( ".includeItems_bg" ).hide();
		$(".selectedItems").children().remove();
	}
});

$(".productCode").on("change",function(){
	if($(".productCode").val() != "none"){
		$( ".pakageType_bg" ).show();
	}else{
		$( ".pakageType_bg" ).hide();
	}
	
});


$(".confirmationCheck").on("change",function(){
	console.log("1");
	var select = $(this).val();
	if(select == "Confirmation"){
		$( ".calenderDiv" ).show();
		
	}else{
		$( ".calenderDiv" ).hide();
	}
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
//			 yearRange: "2010:2013" //연도 범위
		 }); 
	 });
	 
	 
	$('.btnInsert').on("click",function(){
		 var includePname= $('.includePname').val();
		 var productCode= $('.productCode option:selected').val();
		 var price= $('.price').val();
		 var content= $('.content1').val();
		 var aboutGame= $('.aboutGame').val();
		 var flatForm= "";
		 var confirmationCheck = $("#calender").val();
		 var includeItems = "";
		 var includeItemsId = "";
		 var pakageType = $(".pakageType option:selected").val();
		 
		 $("input[name=flatform]:checked").each(function() {
			 flatForm += $(this).val();
			 flatForm += ", ";
			});
		 
		 var id = "";
		
		 if($(".selectedItems").children().length != null){
			 
			 for(var i=1; i <= $(".selectedItems").children().length; i++){
				 
				 id = "#addItems_" + i + " a";
				 includeItems = $(id).html();
				 includeItemsId = $(id).data("value");
				 
			 }
		 }else{
				 includeItems = "none";
				 includeItemsId = "none";
		 }
		 
	 		$.ajax({
	 			url:"/product/productInfoAdd",
	 			type:"POST",
	 			data:{"includePname" : includePname, "productCode":productCode, "price":price, "content":content, "aboutGame": aboutGame, "flatForm":flatForm, "confirmationCheck":confirmationCheck, "includeItems":includeItems, "includeItemsId":includeItemsId, "pakageType":pakageType},
	 			success:function(){
	 				alert("success!!");
	 			}
	 		});
	});
</script>
</html>