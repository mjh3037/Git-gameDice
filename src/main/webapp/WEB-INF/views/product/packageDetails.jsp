<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/store_navbar.css" />
<link rel="stylesheet" href="/resources/css/packageDetails.css" />
<script src="https://kit.fontawesome.com/f765a65399.js" crossorigin="anonymous"></script>
<!-- <script src="textFit.min.js"></script> -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<title>packageDetails</title>
</head>
<body>
	<div class="homepage_body">
		<div class="inputUploadPath"><input type="text" id="inputUploadPathTxt" value="${list.uploadPath}"></div>
		<div class="store_overlay">
				<div class="game_page">
					<div class="back"></div>
					<%@ include file="/WEB-INF/views/layout/store_navbar.jsp" %>
				</div>
				<div class="content">
					<div class="page_content">
					
						<div class="title_area">
							<h1>${list.includePname}</h1>
						</div>
						<div class="leftcol">
							
							<div class="package_header_container">
							</div>
							
							<div class="game_area_purchase">
								<div class="game_area_purchase_game">
									<div class="game_area_purchase_platform">
										<span class="platform_img win"></span>
										<span class="platform_img mac"></span>
									</div>
									<div class="game_purchase_title">${list.includePname}</h3>
									
									<div class="game_purchase_action">
										<div class="game_purchase_action_bg">
											<div class="btn_addtocart">
												<a class="btn_addtocart" href="">
													<span>Download</span>
												</a>
											</div>
										</div>
									</div>
								</div>
								<div class="game_area_purchase_game_wrapper" id="game_area_purchase_section_add_to_cart">
								</div>
							</div>
						</div>
					
							<div class="game_page_autocollapse_ctn">
								<div id="game_area_description" class="game_area_description">
									<h2>About This Game</h2>
									${list.aboutGame}
								</div>
							</div>
							<div class="game_page_autocollapse_ctn">
								<div class=""></div>
							</div>
							<div class="includeTitle"><h3>ITEMS INCLUDED IN THIS PACKAGE</h3></div>
							<div class="tab_item">
							</div>
							<div class="package_totals_area">
								<div class="package_totals_row">
									Price of individual products:
									<div class="price">\3800</div>
								</div>
								<div class="package_totals_row">
									Cost of this package:
									<div class="price">\2000</div>
								</div>
								
								<div class="package_savings_bar">
									<div class="savings"></div>
									<div class="message">Here's what you save by buying this package</div>
								</div>
							</div>
							
							
					</div>
					<div class="rightcol">
							
					</div>
				</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
<script type="text/javascript">
$("#inputUploadPathTxt").hide();

var uuid = "${list.uuid}";
var fileName = "${list.fileName}";
/*uploadPath 깨짐 현상으로 인한 input 호출*/
var uploadPath = $("#inputUploadPathTxt").val();


function getIncludedItems(){
	var includeId = "${list.includeId}";
	var str = "";
		$.ajax({
			url: "/product/getIncludedItems",
			type: "GET",
			dataType: "json",
			data: {"includeId":includeId},
			success:function(response){

				var code ="";
				var name ="";
				var flatform="";
				var fullPrice = 0;
				$(response).each(function(i, obj){
					
					$.map(response[i], function(item){
// 						console.log(item);
						if(item.includeId != null){
							code = item.includeId;
							name = item.includePname;
						}else{
							code = item.pcode;
							name = item.pname;
						}
						
						/* flatform */
						console.log("flatform:" + item.flatform.indexOf('windows'));
						
						flatform = "";
						if(item.flatform.indexOf('windows') != -1){
							flatform += "<i class='fab fa-windows'></i>";
							if(item.flatform.indexOf('mac') != -1){
								flatform += "<i class='fab fa-apple'></i>";
							}
						}
						
						var fileCallPath = item.uploadPath + "\\" + item.uuid + "_" + item.fileName;
						 
						str +="<a href='' class='tab_item_overlay'>";
						str +="<div class='tab_item_header'><img src='/display?fileName="+ fileCallPath + "'></div>";
						str +="<div class='tab_item_sub_bg'><div class='tab_item_content'>" + name + "</div>";
						str +="<div class='tab_item_flatform'>" + flatform + "</div>"
						str +="<div class='tab_item_price'>" + item.price + "</div></div></a>"
						
						fullPrice = fullPrice + item.price;
					});
				});

				$(".tab_item").append(str);
				$(".package_totals_row")
				$(".savings").html();
			}
		});
		
		
}

$(function(){
	var str = "";
	var fileCallPath= uploadPath + "\\" + uuid + "_" + fileName;
		
	str += "<img src='/display?fileName="+fileCallPath + "'>";
	$(".package_header_container").append(str);
	getIncludedItems();
});
</script>



</html>