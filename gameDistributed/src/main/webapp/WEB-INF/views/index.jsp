<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/mainpage.css" />

<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script> -->
<!-- <script src="jquery.fittext.js"></script> -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<title>index</title>
</head>
<body>	
	
	<div class="homepage_body">
		<div class="store_overlay">
			<div class="fullscreen_bg">
<!-- 				<a href="" class=""  style="background-image: url('/resources/img/it takes two.jpg');"> -->
<!-- 				</a> -->
				
				<div class="video_bg">
					<div class="side_left_bg">
						<img src="/resources/img/darkside image01.jpg">
					</div>
					<video id="myVideo" src="/resources/mp4/Astronaut - 73821.mp4" width="1200" height="700"  muted="muted" controls autoplay loop>
					</video>
					<div class="side_right_bg">
						<img src="/resources/img/darkside image02.jpg">
					</div>
				</div>
				<div class="navbar_skin">
					<%@ include file="/WEB-INF/views/layout/store_navbar.jsp" %>
				</div>
			</div>
		</div>
		
		<div class="home_cluster">
			<div class="home_cluster_overlay">
				<div class="home_cluster_content">
					<h2>FEATURED & RECOMMANDED</h2>
					
					<div id="home_maincap" class="carousel_container">
						carousel
						<div class="carousel_items">
						</div>
						<div class="arrow_left"><a href="javascript:void(0)" onClick="onClickfasLeft()"><i class="fas fa-chevron-left"></i></a></div>
						<div class="arrow_right"><a href="javascript:void(0)" onClick="onClickfasRight()"><i class="fas fa-chevron-right"></i></a></div>
						<div class="carousel_thumbs">
							<div class="focus"></div>
							<div></div>
							<div></div>
							<div></div>
							<div></div>
							<div></div>
							<div></div>
							<div></div>
						</div>
					</div>
					<div class="responsive_store_navbar">
						<div class="responsive_store_navbar_menu">
							<div class="responsive_store_navbar_content">
								<h2>responsive store navbar</h2>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	

		<div class="home__special_offers">
			<div class="home_special_offer_overlay">
				<div class="home_special_offer_content">
					<h2>SPECIAL OFFERS</h2>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
<script type="text/javascript">
broadCastMainScreen();

// $(document).ready(function() {

//     $("#playBtn").on("click", function() {
//         $("#myVideo").trigger("play");
//     });
// });

// $(document).ready(function() {

//     $("#myVideo").on("ended", function() {
//          console.log("Video Finished");
//     });
// });


function focusAction(focus){
	
	$('.carousel_thumbs div').removeClass();
	$('.carousel_thumbs div').attr('style','background:#0489B1');
	$('.carousel_thumbs div:nth-child('+focus+')').addClass('focus');
	$('.carousel_thumbs div:nth-child('+focus+')').attr('style','background:#2ECCFA');
	
	$('.carousel_items a').attr('data-inline', 0);
	$('.carousel_items a').attr('style','display:none');
	$('.carousel_items a:nth-child('+focus+')').attr('data-inline', 1);
	$('.carousel_items a:nth-child('+focus+')').attr('style','display:inline');
}


function onClickfasRight(){
	var focus = $('.carousel_thumbs').find('.focus').index();
	var nowFocus = focus + 1;
	var nextFocus = nowFocus +1;
		
	if(nowFocus >= 8){
		nowFocus = 8;
		nextFocus = 1;
	}
	focusAction(nextFocus);
}

function onClickfasLeft(){
	var focus = $('.carousel_thumbs').find('.focus').index();
	var nowFocus = focus + 1;
	var prevFocus = nowFocus - 1;

	if(nowFocus == 1){
		prevFocus = 8;
	}
	
	focusAction(prevFocus);
}


$('.carousel_thumbs div').on("click",function(){
	var i = $(this).index();
	var id = "#store_main_capsule_broad" + i;
	var className = ".store_main_capsule_broad";
	var arrayId = "";
	var array = new Array('0', '1', '2', '3', '4', '5', '6', '7');

	for(var c=0; c< array.length; c++){
		
		if(array[c] == i){
			$(className).attr('data-inline', 0);
			
			$(id).attr('data-inline', 1);
			$(id).attr('style','display:inline');
			
			$('.carousel_thumbs div').attr('style','background:#0489B1');
			$('.carousel_thumbs div').removeClass();
			
			$(this).addClass('focus');
			$(this).attr('style','background:#01A9DB');
		}else{
			arrayId = "#store_main_capsule_broad" + c;
			$(arrayId).attr('style','display:none');
			
		}
	}
});


function onMouseOver(uuid, screenId){
	
	var strScreenId = "#screenshot" + screenId + " img";
	$.ajax({
		url: "/main/getAttach",
		dataType: "json",
		type: "GET",
		data: { "uuid" : uuid },
		success: function(result){
			
			$(result).each(function(i, obj){
	 			var fileCallPath= encodeURIComponent( result[i].uploadPath + "\\" + result[i].uuid + "_" + result[i].fileName );
	 			var str ="/display?fileName="+fileCallPath;
	 			
	 			$(strScreenId).attr("src", str);
	 			
			});
		}
	});
}		
		
function getProductInfo(pcode){
	var idx = pcode;
	location.href="/product/productInfo/"+ idx;
}
 
function setTime(){
		var carsoulDiv = "";
		var carsoulNextDiv = "";
		var index = 0;
		var nextIndex =0;
		setInterval(function(){

				var className = document.getElementsByClassName('store_main_capsule_broad');
				
				for(var i=0; i<className.length; i++){
					var value = className[i].dataset.inline;
					
					if(value == 1){
						index = i;
					}
				}
				
				if(nextIndex < 7){
					nextIndex = index + 1;
				}else{
					nextIndex = 0;
// 					index = 7;
				}
				
				broadcastId = $('.carousel_items').children().eq(index);
				broadCastNextId = $('.carousel_items').children().eq(nextIndex);
				
// 				console.log(broadcastId.index() +","+broadCastNextId.index());
				
				if(broadCastNextId.index() == -1){
					broadcastId = $('.carousel_items').children().eq(0);
				}
				
				carsoulDiv = $(".carousel_thumbs").children().eq(index);	
				carsoulNextDiv = $(".carousel_thumbs").children().eq(nextIndex);

				$(broadcastId).attr('style',"display:none;");
				$(broadcastId).attr('data-inline', 0);
				// 메인 이미지 노출
				if($(broadcastId).hide()){
					
					$(broadCastNextId).fadeToggle();
					$(broadCastNextId).attr('data-inline', 1);
					
					$('.carousel_thumbs div').removeClass();
					carsoulNextDiv.addClass('focus');
					carsoulDiv.attr('style', 'background-color: #0489B1;');
					carsoulNextDiv.attr('style', 'background-color: #2ECCFA;');
					
				}else if($(broadcastId).show()){
					
					$(broadCastNextId).fadeTo("fast", 0.15);
					$(broadCastNextId).attr('data-inline', 0);
					
					$('.carousel_thumbs div').removeClass();
					carsoulDiv.addClass('focus');
					carsoulNextDiv.attr('style','background-color: #0489B1;');
					carsoulDiv.attr('style','background-color: #2ECCFA;');
					
				}
		}, 5000);
					
}


function addImage(strInfo){
	
	var mainInfo = strInfo.map.mainAttach;
	var subInfo = strInfo.map.subAttach;
	var str = "";
	
	$(mainInfo).each(function(i, obj){
		
		var fileCallPath= encodeURIComponent( mainInfo[i].uploadPath + "\\" + mainInfo[i].uuid + "_" + mainInfo[i].fileName );
		
		str += "<a class='store_main_capsule_broad' id='store_main_capsule_broad" + i + "' style='display:none;' data-inline=0  href='javascript:void(0)' onClick='getProductInfo(" + mainInfo[i].pcode + ")'>";
		str += "<div class='capsule_main'>";
		str += "<div class='capsule_main_capsule'>";
		str += "<div class='screenshot' id='screenshot"+ i +"'><img src='/display?fileName=" + fileCallPath + "' style='display: inline;' data-value='"+ mainInfo[i].pcode +"'></div>";
		
		str += "<div class='info' id='info" + i + "' style='display: inline;'>";
		str += "<div class='appName'>" + mainInfo[i].pname + "</div>";
// 		$('.appName').fitText();
		str += "<div class='screenshot' >";
		
		var cnt = 0;
		for(var c=0; c< subInfo.length; c++){
		
				if(mainInfo[i].pcode == subInfo[c].pcode){
						
						if(cnt < 4){
							fileCallPath = subInfo[c].uploadPath + "\\" + subInfo[c].uuid + "_" + subInfo[c].fileName;
							var screenId =  i;
							str += "<div><img src='/display?fileName=" + fileCallPath + "' onmouseover=onMouseOver('" + subInfo[c].uuid + "'," + screenId + ")></div>";
							cnt++;
						}
					}
		}
		str += "</div>";	
		str += "<div class='reason'><div class='default'>" + "Pre-Purchase Now" + "Now Available" + "</div><div class='additional'>" + "Top seller" + "</div></div>";
		str += "<div class='discount_block'><div class='discount_price'>" + "12,000" + "</div></div><div class='platform'>" + "windows" + "</div></div>";
		str += "</div></div>";
		str += "</a>";
	});	
	
	$(".carousel_items").append(str);
// 	$("#store_main_capsule_broad0").attr('style',"display:inline;");
	$('.carousel_items').children().eq(0).attr('style',"display:inline;");
	$('.carousel_items').children().eq(0).attr('data-inline', 1);
	$(".carousel_thumbs").children().eq(0).attr('style','background-color: #2ECCFA;');
	setTime();
}


function broadCastMainScreen(){
	
	$.ajax({
		url: '/main/getAttachMain',
		processData: false,
		contentType: false,
		dataType: 'json',
		type: "GET",
		success: function(result){
			addImage(result);
		}
	});
}

</script>
</html>