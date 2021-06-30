<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/css/store_navbar.css" />
</head>
<body>
	<nav class="store_navbar">
		<span class="store_navbar_menu">
			<li><a href="/main/open">Your Store</a></li>
			<li><a href="">New & Noteworthy</a></li>
			<li><a href="">Categories</a></li>
			<li><a href="">Point shop</a></li>
			<li><a href="">News</a></li>
			<li><a href="">Labs</a></li>
			<li></li>
			<li class="search">
			<div class="searchText">
				<input type="text" class="txtSearch" id="txtSearch" value="" placeholder="search" size="17">
			</div>
			<div class="searchSelect">
				<input type="submit" class="btnSearch" value="Search">
			</div>
			</li>
		</span>	
		<div class="searchterm_options" style="display:none;">
			
				<div class="popup_body">
					<div class="search_suggestion_contents">
					</div>
				</div>
		</div>
	</nav>
</body>
<script type="text/javascript">
formSubmit();
function searchForm(str){
	console.log(str);
	location.href="/search/searchForm/" + str;
}

$("#txtSearch").keydown(function (key) {
	if(key.keyCode == 13){
	   		 var str = $('#txtSearch').val();
	   		 searchForm(str);
	   }
});



function formSubmit(){
	var str = "";
	
	str +="<input type='submit' class='btnSearch value='Search' onClick=''>";
	
	$('.searchSelect').append();
	
}

$('.match_ds_collapse_flag').on("click",function(){
	
});


$(function(){
	$("#txtSearch").autocomplete({
		source: function(request, response){
			$.ajax({
				type:'post',
				url: "/main/autocomplete",
				dataType: "json",
				data : {value: request.term},
				success: function(data){
					
					console.log(data);
					
					var url = "";
					var str ="";
					var pcode = "";
					var pname = "";
					var price = "";
					var uploadPath = "";
					var uuid = "";
					var fileName = "";
					var i=0;
					$.map(data, function(item){
						
						if(item.includeId != null){
							pcode = item.includeId;
							pname = item.includePname;
							price = item.includePrice;
							uploadPath = item.includeUploadPath;
							uuid = item.includeUuid;
							fileName = item.includefileName;
							url = "/product/productPakageInfo/" + pcode;
						}else{
							pcode = item.pcode;
							pname = item.pname;
							price = item.price;
							uploadPath = item.uploadPath;
							uuid = item.uuid;
							fileName = item.fileName;
							url = "/product/productInfo/" + pcode;
						}
						if(i<5){
							var fileCallPath = uploadPath + "\\" + uuid + "_" + fileName;
							var url = "/product/productInfo/" + pcode;
							str += "<div class='match_ds_collapse_flag'><a href='javascript:void(0)' onClick='getProductInfo("+url+")' class='searchterm_options_info'style='height:90px;'><div class='match_name'>" + pname + "</div>";
							str += "<div class='match_img'><img src='/display?fileName=" + fileCallPath + "'></div>"
							str += "<div class='match_price'>\\" + price + "</div></a>"
							str += "</div>";
							i++;
						}
					});
						
					$('.match_ds_collapse_flag').detach();
					$('.search_suggestion_contents').append(str);
					
					$('.searchterm_options').attr('style','display:inline-block');
				}
			});
		},
		 disabled: false,
		 minLength: 1,
		 autoFocus: true,
		 delay: 500,
		 select: function(event, ui) {

	            console.log("e:"+ui.item.pname);

	      }
	});
});

function getProductInfo(url){
	location.href= url;
}

$('#txtSearch').on('focusout',function(){
	setTimeout(function(){
		$('.searchterm_options').attr('style','display:none;');
	}, 100);
});
	


</script>
</html>