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
<link rel="stylesheet" href="/resources/css/productInfo.css" />
<!-- <script src="textFit.min.js"></script> -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<title>productInfo</title>
</head>
<body>
	<div class="inputuploadPath" value="" style="display:none;">${list.uploadPath}</div>
	<div class="homepage_body">
	
		<div class="store_overlay">
			<div class="game_page">
				<div class="back"></div>
				<%@ include file="/WEB-INF/views/layout/store_navbar.jsp" %>
			</div>
			<div class="content">
				<div class= "appHubAppName">${list.pname}</div>
				<div class= "game_background_glow">
					<div class= "block_content">
						<div class= "rightcol">
							<div class="glance_ctn">
								<div class="gameHeaderImageCtn">			
								</div>
								<div class="game_description_snippet">
									${list.content}
								</div>
								<div class="glance_ctn_responsive_left">
									<div class="subtitle_column">Recent Reviews:</div>
										<div class="summary_column">
											<span class="game_review_summary_positive">Very Positive</span>
											<span class="responsive_hidden">(1,749)</span>
										</div>
										<div class="appReviewsAll">
											<div class="subtitle_column_all">All Reviews:</div>
											<div class="summary column alltime">
												<div class="game_review_summary_positive">Very Positive</div>
												<div class="responsive_hidden">(64,840)</div>
											</div>
											
											<div class="release_date">
												<div class="subtitle_column">Release Date:</div>
												<div class="date">16 Feb, 2017</div>
											</div>
											
											<div class="dev_row">
												<div class="subtitle_column">Developer:</div>
												<div class="subtitle_column"><a href="">Expansive Worlds</a></div>
												
											</div>
											<div class="dev_row">
												<div class="subtitle_column">Publisher:</div>
												<div class="subtitle_column"><a href="">Expansive Worlds</a></div>
	
											</div>
										
										</div>
									<div class="glanceCtnResponsiveRight">
										
									</div>
								</div>
							</div>
						</div>
						<div class= "leftcol">
							<div class="highlight_overflow">
								<div id="highlight_player_area" style="display:inline-block;">
									<img src="">
									highlight_area
								</div>
								<div id="highlight_strip">
								</div>
							</div>
						</div>
					</div>
				</div>	
				<div class="page_content">
					<div class="leftcol_game_description_column">
						<div class="queue_overflow_ctn">
							<div class="queue_ctn">
								<div id="queueActionsCtn" class="queue_actions_ctn">
									<p>
										<a href="/member/loginPage">Sign in</a> 
										to add this item to your wishlist, follow it, or mark it as ignored
									</p>
								</div>
							</div>
						</div>
						
						<div class="game_area_purchase">
							<div class="game_area_purchase_game">
								<div class="game_area_purchase_platform">
									<span class="platform_img win"></span>
									<span class="platform_img mac"></span>
								</div>
								<div class="game_purchase_title">${list.pname}</h3>
								
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
						
						<div class="game_page_autocollapse_ctn">
							<div id="game_area_description" class="game_area_description">
								<h2>About This Game</h2>
								${list.aboutGame}
							</div>
						</div>
						<div class="game_page_autocollapse_ctn">
							<div class=""></div>
						</div>
						<div class="game_page_autocollapse_ctn">
							<div class="game_page_autocollapse">
								<h2>System Requirements</h2>
								<div class="sysreq_contents">
									<div class="game_area_sys_req">
										<div class="game_area_sys_req_leftCol">
											<strong>MINIMUM:</strong>
											<ul class= "bb_ul">${list.systemMinRequirements}</ul>
										</div>
										<div class="game_area_sys_req_rightCol">
											<strong>RECOMMENDED:</strong>
											<ul class= "bb_ul">${list.systemMaxRequirements}</ul>
										</div>
									</div>
								
								</div>
							</div>
						</div>
						<div class="game_page_autocollapse_ctn">
							<div class=""></div>
						</div>
					</div>
				</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
<script type="text/javascript">
getGameHeaderImg();
getHighlightStripItemImg();
getFirstMainImg();

function getFirstMainImg(){
	
}


function getHightlightMain(uuid){

	$.ajax({
		url: "/main/getAttach",
		dataType: "json",
		type: "GET",
		data: { "uuid" : uuid },
		success: function(result){
			
			$(result).each(function(i, obj){
	 			var fileCallPath= encodeURIComponent( result[i].uploadPath + "\\" + result[i].uuid + "_" + result[i].fileName );
	 			var str = "/display?fileName="+fileCallPath;
	 			
	 			$('#highlight_player_area img').attr("src", str);
	 			
			});
		}
	});
}		


function setHighlightStripItemImg(strPath){
	var str = "";
	var mainStr = "";
	$(strPath).each(function(i, obj){
		
		var fileCallPath= encodeURIComponent( strPath[i].uploadPath + "\\" + strPath[i].uuid + "_" + strPath[i].fileName );
		var screenId= i;
		
		str += "<div class='highlight_strip_item'><img src='/display?fileName="+ fileCallPath +"' onClick=getHightlightMain('" + strPath[i].uuid + "')></div>";
		
	});
	
	mainStr += "/display?fileName="+ encodeURIComponent( $(strPath)[0].uploadPath + "\\" + $(strPath)[0].uuid + "_" + $(strPath)[0].fileName );
	$('#highlight_player_area img').attr('src', mainStr);
	$('#highlight_strip').append(str);
}


function getHighlightStripItemImg(){
	var str ="";
	var pcode = "${list.pcode}";
	
	if("${pak}"){
		var pak = "${pak}";
	}
	
		$.ajax({
			url: "/product/highlight",
			type: "GET",
			dataType: "json",
			data: {"pcode": pcode, "pak": pak},
			success: function(result){
				setHighlightStripItemImg(result);
			}
		});
}



function getGameHeaderImg(){
	var fileCallPath = "";
	var str = "";
	var pcode = "${list.pcode}";
	
	if("${pak}"){
		var pak = "${pak}";
	}
	
		$.ajax({
			url: "/product/getLogoInfo",
			type: "GET",
			dataType: "json",
			data: {"pcode": pcode, "pak": pak},
			success: function(result){
				
				$.map(result, function(item){
					
					console.log(item.uploadPath + "\\" + item.uuid + "_" + item.fileName);
					fileCallPath = encodeURIComponent(item.uploadPath + "\\" + item.uuid + "_" + item.fileName);
					str ="<img src='/display?fileName="+ fileCallPath + "'>";
					
				});
			 	$('.gameHeaderImageCtn').append(str);
			}
		});
	
	

	
	
}


</script>
</html>