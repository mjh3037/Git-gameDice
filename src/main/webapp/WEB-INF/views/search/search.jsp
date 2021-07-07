<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/store_navbar.css" />
<link rel="stylesheet" href="/resources/css/search.css" />
<script src="https://kit.fontawesome.com/f765a65399.js" crossorigin="anonymous"></script>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<title>searchForm</title>
</head>
<body>
a
	<div class="homepage_body">
		<div class="store_overlay">
			<div class="game_page">
				<%@ include file="/WEB-INF/views/layout/store_navbar.jsp" %>
			</div>
			<div class="content">
				<div class="left_col">
					<div class="search_results">
						<div class="search_results_count"></div>
					</div>
					<div class="search_result_container">
						<div class="search_resultsRows">
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
<script type="text/javascript">
getSearchList();

function getProductInfo(pcode){
	console.log("pcode:" + pcode);
	var idx = pcode;
	location.href="/product/productInfo/"+ idx;
}

function unixTimeConvert(unix_timeStamp){
	  var date = new Date( unix_timeStamp);
	  return $.datepicker.formatDate('dd MM,yy', date);
}


function getSearchList(){
	var str = "";
	var text = "${text}";
	var strCnt = "";
	var cnt = 0;

	$.ajax({
		url: "/search/searchAjax",
		type: "get",
		dataType: "json",
		data: {"text" : text},
		success:function(response){

			$.map(response, function(item){
				var fileCallPath = item.uploadPath + "\\" + item.uuid + "_" + item.fileName;
				var flatform = "";
				var pname ="";
				var releasedDate = "";
				var price = "";
				var pcode = "";
				/* flatform */
				if(item.flatform.indexOf('windows') != -1){
					flatform += "<i class='fab fa-windows'></i>";
					
					if(item.flatform.indexOf('mac') != -1){
						flatform += "<i class='fab fa-apple'></i>";
						
					}
				}
				console.log("flatform"+ flatform);
				
				/*pakage product*/
				if(item.includeId != null){
					pname = item.inclPname;
					releasedDate = item.inclReg_dt;
					price = item.inclPrice;
					if(item.packageType !=null){
						pcode = "pak_"+ item.packageType + "_" + item.includeId;
					}else{
						pcode = "pak_"+ item.includeId;
					}
					
				}else{
					pname = item.pname
					releasedDate = item.releasedDate;
					price = item.price;
					pcode = item.pcode;
				}
				
				str += "<a class='search_result_row' href='javascript:void(0);' onClick=getProductInfo(\'" + pcode + "'\)><div class='search_capsule'><img src='/display?fileName=" + fileCallPath + "'></div>";
				str += "<div class='search_name_combined'><div class='search_name_ellipsis'><span class='title'>" + pname + "</span><p>" + flatform + "</p></div>"
				str += "<div class='search_released'>" + unixTimeConvert(releasedDate) + "</div><div class='search_reviewscore'></div>"
				str += "<div class='search_price_discount_combined'><div class='search_discount'></div><div class='search_price'>"+ "\\" + price + "</div></div>"
				str += "</div></a>";
				cnt++;
			});
			strCnt +="<strong>" + cnt + "</strong> results match your search.";
			
			$('.search_resultsRows').append(str);
			$('.search_results_count').html(strCnt);
		}
	});
	
}
</script>
</html>