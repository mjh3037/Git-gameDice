<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<%@ include file="/WEB-INF/views/adminView.jsp" %>
<style>
	.status{
		float:right;
		margin-right:1300px; 
		border-radius: 5px; 
		border: 2px solid black; 
		background: rgb(131,58,180);
		background: linear-gradient(132deg, rgba(131,58,180,1) 0%, rgba(180,46,120,1) 20%, rgba(191,44,106,1) 33%, rgba(207,40,86,1) 45%, rgba(221,37,69,1) 51%, rgba(242,32,43,1) 62%, rgba(253,29,29,1) 78%, rgba(252,176,69,1) 100%);
	}

	.includeProductSelect{
		width: 400px;
		margin: 10px 0px 10px 260px;
/* 		float: left; */
		background-color: black;
		color: white;
		
	}

	.upload_row_bg{
		width: 250px;
		margin-left: 250px;
	}

	.removeData{
		width: 40px;
		height: 20px;
		margin: 5px;
/* 		background: blue; */
		font-size: 25px;
		color: white;
		padding: 5px;
		background: rgb(34,193,195);
		background: linear-gradient(0deg, rgba(34,193,195,1) 0%, rgba(253,187,45,1) 100%);
		border-radius: 5px;
	}

	.listSelectScreen{
		width: 140px;
		height: 100px;
		float: left;
		margin: 5px;
	}

	.uploadList{
		
	}
	
	.uploadList_bg{
		display: inline-block;
		width: 900px;
		height: 100%;
		background: grey;
		opacity: 0.85;
		margin-top: 20px;
		margin-left: 250px;
		margin-bottom: 250px;
	}
	
	.bg {
		  width: 100%;
		  height: 1000px;
		  overflow: hidden;
		  margin: 0px auto;
		  position: relative;
	}

	.uploadResult{
		width: 80%;
		height: 300px;
		background-color: gray;
		margin: 0 auto;
	}
	
	.uploadResult li{
		diplay: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li{
		float: left;
		list-style: none;
		padding: 10px;
		width : 50px;
		height : 20px;
		margin: 50px;
	}
	
	.uploadResult ul li img{
		display: inline-block;
		position: relative;
		width : 125px;
		height: 75px;
		
		
	}
	
	.uploadResult ul li span{
		color : white;
	}
	
	.bigPictureWrapper{
		position: absoulte;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background: rgba(255,255,255,0.5);
	}
	
	.bigPicture{
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img{
		width: 600px;
	}
	
	body{
		height: 100%;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<h1>upload Ajax</h1>
			
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
		<select class="uploadReferences">
				<option class="none" value="none">none</option>
			<c:forEach var="list" items="${productList}">
				<option class="${list.pname}" value="${list.pcode}" value2="${list.pname}">${list.pname}</option>
			</c:forEach>
		</select>
		<div class="status"></div>
		
		<div class="includeProductSelect" style="display:none;">
			<div> 메인 상품 관련 패키지 목록입니다. 업로드 할 패키지 img를 선택해 주십시오.</div>
			<select class='includeProductList' style='width:400px; height:30px;'></select>
		</div>
		
		
		<div class="upload_row_bg">
			<select class="uploadScreenType">
				<option class="screenType" value="M">Main</option>
				<option class="screenType" value="S">Sub</option>
				<option class="screenType" value="L">logo</option>
			</select>
			<button id='uploadBtn'>Upload</button>
		</div>
	</div>
	
	<div class="uploadResult">
		<ul>
		</ul>
		
		<div class="bigPictureWrapper">
			<div class="bigPicture">		
			</div>
		</div>
	</div>
	
	<h1>upload List</h1>
	<div class="uploadList_bg">
		<select class="listSelect">
				
			<c:forEach var="list" items="${productList}">
				<option class="${list.pname}" value="${list.pcode}">${list.pname}</option>
			</c:forEach>
		</select>
		<div class="uploadList"></div>
	</div>
	
</body>
<script>

function getIncludeProduct(pcode){
	
	var str ="";
	
		$.ajax({
			url: "/upload/getUploadIncludeProduct",
			type: "get",
			dataType: "json",
			data: {"pcode": pcode},
			success: function(response){
				
				str += "<select class='includeProductList' style='width:400px; height:30px;'>";
				$.map(response, function(item){
					str += "<option value='" + item.includeId + "'>" + item.includePname + "</option>"
				});
				str += "</select>";
				
				$('.includeProductSelect').append(str);
			}
		});
	
// 	$('.includeProductSelect').append(str);
 };
 
 $('.uploadReferences').on("change",function(){
	var pcode = $(this).val();
	var confirm1 = $('.uploadReferences option:selected').attr("value2");
	var str = "선택한 상품 '" + confirm1 + "' 관련 패키지 상품을 선택하실 수 있습니다. 패키지 상품을 선택하시겠습니까?";
	if(confirm(str)==true){
		$('.status').html("pakage");
		$('.includeProductSelect').attr("style","display:inline-block;");
	}else{
		$('.status').html("none");
		$('.includeProductSelect').attr("style","display:none;");
	}
	
	$('.includeProductSelect').children().remove();
	 getIncludeProduct(pcode);
	 
 });
 
 $(".listSelect").on("change", function(){
	
	var pcode = $(this).val();
	$('.uploadList').children().remove();
	getUploadList(pcode);
	
 });
	$(document).on("click", ".removeData", function(){
 		
 		 var targetFile = $(this).data("file");
 		 var type = $(this).data("type");
 		 
 		 $.ajax({
 			url: '/deleteFile',
 			data: { fileName: targetFile, type: type},
 			dataType: 'text',
 			type: 'POST',
 				success: function(result){
 					alert(result);
 					location.href="";
 				}
 		 });//$.ajax
 	});

 
 	function getUploadList(pcode){	
 		var str ="";
 		
	 		$.ajax({
	 			url: "/upload/uploadList",
	 			dataType: "json",
	 			type: "get",
	 			data: {"pcode": pcode},
	 			success : function(response){
	 				
	 				$.map(response, function(item){
	 					var fileCallPath = item.uploadPath + "\\" + item.uuid + "_" + item.fileName;
	 					
	 					console.log("fileCallPath : " + fileCallPath);
	 					
	 					str +="<div class='listSelectScreen'><img src='/display?fileName="+fileCallPath+"' style='width:100px; height:100px; float:left;'>"
	 					+"<span class='removeData' data-file=\'"+ fileCallPath + "\' data-type='file' onClick='getUploadList()'> x </span>" + "</div></li>"
	 				});
	 				
	 				$('.uploadList').append(str);
	 			}
	 	});	
 	};
 
 
	function videoFileAutoPlay(){
		$("#myVideo").trigger("play");
	};
	
	$(document).ready(function() {
	
	$("#myVideo").on("ended", function() {
	  console.log("Video Finished");
		});
	});
 
	$(document).ready(function() {

	    $("#fullBtn").on("click", function() {

	        var elem = document.getElementById("myVideo");
	        if(elem.requestFullscreen) {
	            elem.requestFullscreen();
	        } else if(elem.mozRequestFullScreen) {
	            elem.mozRequestFullScreen();
	        } else if (elem.webkitRequestFullscreen) {
	            elem.webkitRequestFullscreen();
	        } else if (elem.msRequestFullscreen) {
	            elem.msRequestFullscreen();
	        }
	    });
	});

 
 var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
 var maxSize = 5242880; //5MB
 
 function checkExtenstion(fileName, fileSize){
	 
	 if(fileSize >= maxSize){
		 alert('파일 사이즈 초과');
		 return false;
	 }
	 
	 if(regex.test(fileName)){
		 alert("해당 종류의 파일은 업로드할 수 없습니다.");
		 return false;
	 }
	 return true;
 }
 
 $(".uploadResult").on("click","span", function(e){
	
	 var targetFile = $(this).data("file");
	 var type = $(this).data("type");
	 console.log(targetFile);
	 
	 $.ajax({
		url: '/deleteFile',
		data: { fileName: targetFile, type: type},
		dataType: 'text',
		type: 'POST',
			success: function(result){
				alert(result);
			}
	 });//$.ajax
 });
 
 
 var uploadResult=$(".uploadResult ul");
 
 	function showuploadedFile(uploadResultArr){
 		
 		var str= "";
 		$(uploadResultArr).each(function(i, obj){

 			if(!obj.map.image){
 				
 				var fileCallPath = encodeURIComponent( obj.map.uploadPath + "/"+obj.map.uuid+"_"+obj.map.uploadFileName);
 				
 				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
 				
 				str += "<li><div><a href='/download?fileName="+ fileCallPath + "'>" + 
 						"<img src='/resources/img/attachment.png'>" + obj.map.uploadFileName + "</a>" +
 						"<span data-file=\'"+ fileCallPath + "\' data-type='file'> x </span>" + "</div></li>";
 			} else {
 				
 				//str += "<li>" + obj.map.uploadFileName + "</li>";
 				
 				var fileCallPath = encodeURIComponent( obj.map.uploadPath + "/s_"+obj.map.uuid+"_"+obj.map.uploadFileName);
 				
 				var originPath = obj.map.uploadPath + "\\" + obj.map.uuid + "_" + obj.map.uploadFileName;
 				
 				originPath = originPath.replace(new RegExp(/\\/g),"/");
 				
 				str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName=" + fileCallPath + "'></a>"
 						+ "<span data-file=\'" + fileCallPath + "'\ data-type='image'> x </span>"+ "</li>";
 				
 			}
 		});
 		
 		uploadResult.append(str);
 	}
 

 function showImage(fileCallPath){
// 	 alert(fileCallPath);

	$(".bigPictureWrapper").css("display","flex").show();
	
	$(".bigPicture").html("<img src='/display?fileName=" +encodeURI(fileCallPath)+"'>").animate({width: '100%', height:'100%'}, 1000);

 }
 
 $(".bigPictureWrapper").on("click",function(e){
	
	 $(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
	 setTimeout(() => { $(this).hide(); }, 1000);
 });
 	
 	
 var cloneObj = $(".uploadDiv").clone();
 
 
	 $("#uploadBtn").on("click", function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			console.log(files);
	
			//add filesdate to formdata
			for(var i = 0; i< files.length; i++){
				
				if(!checkExtenstion(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			//add to references game
			if($('.status').html() == 'pakage'){
				var includeId = $(".includeProductList option:selected").val();
				
				formData.append("includeId", includeId);
			}
			
			var pcode= $(".uploadReferences option:selected").val();
			formData.append("pcode", pcode);
			
			var screenType =$(this).parent().find(".uploadScreenType option:selected").val();
			formData.append("screenType", screenType);
			
			alert(pcode);
			$.ajax({
				url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
						dataType: 'json',
						type: 'POST',
						success: function(result){
							
						console.log(result);
						
						showuploadedFile(result);
						
						$(".uploadDiv").html(cloneObj.html());
						}
			});//$.ajax
		 });
 
</script>
</html>