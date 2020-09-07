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
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题行 -->
		<div class="row">
			<div class="col-md-12">
				<h1>Report</h1>
			</div>
		</div>
		<!-- 新增删除按钮 -->
		<div class="row">
			<!-- 总列数12 占了4列 偏移8列 -->
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 列表 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<th>${emp.empId}</th>
							<th>${emp.empName}</th>
							<th>${emp.gender=="0"?"女":"男"}</th>
							<th>${emp.email}</th>
							<th>${emp.department.deptName}</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
								</button>
							</th>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
		<!-- 分页栏 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum}页,总共${pageInfo.pages},总共${pageInfo.total}条记录</div>
			<!-- 分页条 -->
			<div>
				<nav aria-label="Page navigation">
					<ul class="pagination">

						<!-- <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li> -->
						<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
						<c:if test="${pageInfo.hasPreviousPage}">
							<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
							<c:if test="${page_Num==pageInfo.pageNum}">
								<li class="active"><a href="#">${page_Num}</a></li>
							</c:if>
							<c:if test="${page_Num!=pageInfo.pageNum}">
								<li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.hasNextPage}">
							<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>

						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>

</body>
</html>