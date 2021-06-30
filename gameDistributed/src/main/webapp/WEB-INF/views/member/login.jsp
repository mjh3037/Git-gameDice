<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/login.css" />
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<title>gameDice 로그인</title>
</head>
<body>
	<div class="homepage_login_body">
			<div class="page_content">
				<div class="page_content_flex">
					<span class="login_left_col">
						<div class="login_left">
							<div class="login_box_content">
								<div class="login_title">Sign up</div>
								<div class="error_display">The account name or password that you have entered is incorrect.</div>
								<form name="login" action method="POST" id="login_form" style="display:block;">
									<div class="login_row">
										<div class="input_title">Accout name</div>
										<input class="text_field" type="text" name="username" autocomplete="on">
									</div>
									<div class="login_row">
										<div class="input_title">Password</div>
										<input class="text_field" type="text" name="password">
									</div>
									<div class="login_btn_ctn">
										<button type="submit" class="btn_submit">
											<span>Sign In</span>
										</button>
										<div class=""></div>
									</div>
								</form>
							</div>
						</div>
					</span>
					<span class="login_right_col">
						<div class="login_right">
						 <h2>right</h2>
						</div>
					</span>
				</div>
			</div>
	 </div>
</body>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
<script src="/resources/js/memberRelation.js"></script>
<script>
</script>
</html>