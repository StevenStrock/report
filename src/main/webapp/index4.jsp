<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径，不以/开始的相对路径，找资源，以当前资源的路径为准
以/开始的相对路径，找资源，是以服务器的路径为标准(http://localhost:8080/crud)需要加上项目名
	http://localhost:8080/crud
 -->
<!-- Bootstrap 样式 -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${APP_PATH}/static/js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- 员工添加界面 -->
	<div class="modal fade" id="empAndModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">用户注册</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="LoginName" class="col-sm-2 control-label">账户</label>
							<div class="col-sm-10">
								<input type="text" name="LoginName" class="form-control"
									id="LoginName" value="账号@ncsoft.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="Password" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10">
								<input type="password" name="Password" class="form-control"
									id="Password"> <span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="UserName" class="col-sm-2 control-label">账户名</label>
							<div class="col-sm-10">
								<input type="text" name="UserName" class="form-control"
									id="UserName" placeholder="直接填账户，不用写后面的邮箱后缀"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="UserCenter" class="col-sm-2 control-label">用户中心</label>
							<div class="col-sm-10">
								<input type="text" name="UserCenter" class="form-control"
									id="UserCenter" value="17"> <span>无需修改</span>
							</div>
						</div>
						<div class="form-group">
							<label for="EffectiveUntil" class="col-sm-2 control-label">有效期至</label>
							<div class="col-sm-10">
								<input type="text" name="EffectiveUntil" class="form-control"
									id="EffectiveUntil" value=""><span>空着不填</span>
							</div>
						</div>
						<div class="form-group">
							<label for="LoginNameValidated" class="col-sm-2 control-label">登录名已验证</label>
							<div class="col-sm-10">
								<input type="text" name="LoginNameValidated"
									class="form-control" id="LoginNameValidated" value="1"><span>无需修改</span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题行 -->
		<div class="row">
			<div class="col-md-12">
				<h1>注册和点券</h1>
			</div>
		</div>
		<!-- 新增删除按钮 -->
		<div class="row">
			<!-- 总列数12 占了4列 偏移8列 -->
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">注册</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">点券</button>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		/* 点击新增按钮，弹出新增界面模态框 */
		$("#emp_add_modal_btn").click(function() {

			$("#empAndModal").modal({
				backdrop : "static"
			});
		});

		$("#emp_save_btn")
				.click(
						function() {
							//提交给服务器
							$
									.ajax({
										url : "http://192.168.200.128:6605/spawned/AuthSrv.1.620467866/test/create_account",
										type : "POST",
										data : $("#empAndModal form")
												.serialize(),
										contentType : "application/json;charset=UTF-8",
										success : function(result) {
											alert(result);
										}
									});
						});

		function show_validate_msg(ele, status, msg) {
			//清除校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if (status == "success") {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}

		}
	</script>
</body>
</html>