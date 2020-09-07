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
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_add_input" placeholder="123@123.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="1"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="0"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="dept_add_select" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交部门ID -->
								<select class="form-control" name="dId" id="dept_add_select">
								</select>

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

	<!-- 员工修改界面 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_update_static" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="email_update_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_update_input" placeholder="123@123.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="1"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="0"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="dept_update_select" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交部门ID -->
								<select class="form-control" name="dId" id="dept_update_select">
								</select>

							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
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
				<h1>Report</h1>
			</div>
		</div>
		<!-- 新增删除按钮 -->
		<div class="row">
			<!-- 总列数12 占了4列 偏移8列 -->
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<a class="btn btn-primary" href="${APP_PATH}/toForm">跳转</a>
				<a class="btn btn-primary" href="Web/Sts/index.html">跳转html</a>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 列表 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页栏 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord = 0;
		var currentNum = 0;
		//页面加载完成后，发送ajax请求，获取分页数据
		$(function() {
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//1,解析数据并显示员工列表
					build_emps_table(result);
					//2,解析并显示分页信息
					build_emps_page_info(result);
					//3,解析显示分页条数据
					build_emps_nav(result);
				}
			});
		}
		//构建员工表格
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$
					.each(
							emps,
							function(index, item) {
								var checkBox = $("<td><input type = 'checkbox' class='check_item'/></td>");
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var genderTd = $("<td></td>").append(
										item.gender == "0" ? "女" : "男");
								var emailTd = $("<td></td>").append(item.email);
								var deptNameTd = $("<td></td>").append(
										item.department.deptName);

								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-primary btn-sm edit_btn")
										.append(
												$(
														"<span aria-hidden='true'></span>")
														.addClass(
																"glyphicon glyphicon-pencil"))
										.append("编辑");
								//为编辑按钮添加一个自定义的属性来表示当前员工ID
								editBtn.attr("edit-id", item.empId);
								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$(
														"<span aria-hidden='true'></span>")
														.addClass(
																"glyphicon glyphicon-trash"))
										.append("删除");

								//为删除按钮添加一个自定义的属性来表示当前员工ID
								delBtn.attr("delete-id", item.empId);
								var btnTd = $("<td></td>").append(editBtn)
										.append(" ").append(delBtn);

								$("<tr></tr>").append(checkBox).append(empIdTd)
										.append(empNameTd).append(genderTd)
										.append(emailTd).append(deptNameTd)
										.append(btnTd).appendTo(
												"#emps_table tbody");
							});
		}

		//构建分页信息
		function build_emps_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页,总共"
							+ result.extend.pageInfo.pages + "页 ,总共"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.pages;
			currentNum = result.extend.pageInfo.pageNum;
		}

		//构建分页条点击分页条，能去指定页
		function build_emps_nav(result) {
			$("#page_nav_area").empty();
			$("#check_all").prop("checked", false);
			var ul = $("<ul></ul>").addClass("pagination");
			//首页
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			//前一页
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));

			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});

				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			ul.append(firstPageLi).append(prePageLi);

			//页码号
			var navigatepageNums = result.extend.pageInfo.navigatepageNums;
			$.each(navigatepageNums, function(index, item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item)
				});
				ul.append(numLi)
			});

			//下一页
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			//末页
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			ul.append(nextPageLi).append(lastPageLi);
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("prePageLi");
			} else {
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});

				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});

			}

			//把ul加入到nav元素中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		/**
		清空表单样式及内容
		 */
		function reset_form(ele) {
			//清除表单数据
			$(ele)[0].reset();
			//清除表单样式
			$(ele).find("*").removeClass("has-error has-succes");
			$(ele).find(".help-block").text("");
		}

		/* 点击新增按钮，弹出新增界面模态框 */
		$("#emp_add_modal_btn").click(function() {
			//重置表单信息和样式
			reset_form("#emp_add_modal_btn")

			//发送ajax请求，查出部门信息，显示下拉列表
			getDepts("#dept_add_select");
			$("#empAndModal").modal({
				backdrop : "static"
			});
		});

		//查出所有部门列表，显示在下拉列表中
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//dept_add_select
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});

				}
			});

		}

		$("#emp_save_btn")
				.click(
						function() {
							//先进行校验
							if (!valisdate_add_form()) {
								return false;
							}
							//校验用户名是否重复
							if ($(this).attr("ajax-va") == "error") {
								return false;
							}
							//提交给服务器
							$
									.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										data : $("#empAndModal form")
												.serialize(),
										success : function(result) {
											if (result.code == 100) {
												//1，关闭表单
												$("#empAndModal").modal('hide');
												//2，来到最后一页
												//发送请求获取最后一页
												to_page(totalRecord + 1);
											} else {
												//显示失败信息
												/* result.errorFields.email */
												if (undefined != result.errorFields.email) {
													//显示邮箱错误信息
													show_validate_msg(
															"#email_add_input",
															"error",
															result.errorFields.email);
												}
												/* result.errorFields.empName */
												if (undefined != result.errorFields.empName) {
													//显示empName错误信息
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.errorFields.empName);
												}
											}
										}
									});
						});

		function valisdate_add_form() {
			//1,获取到需要校验的数据
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				show_validate_msg("#empName_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字组合!");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
			}
			//2,校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确!");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}

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

		$("#empName_add_input").change(
				function() {
					//为用户名的输入框绑定change时间，在发生变化后，发送ajax请求校验用户名是否存在
					$.ajax({
						url : "${APP_PATH}/checkuser",
						type : "GET",
						data : "empName=" + this.value,
						success : function(result) {
							if (result.code == 100) {
								//成功
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_save_btn").attr("ajac-va", "success");
							} else {
								//失败
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_btn").attr("ajac-va", "error");
							}
						}
					});
				});

		//1，创建按钮时，绑定。2，绑定点击，.live()为后来元素绑定
		//jquery新版本没有live()方法，新版本用on()方法进行替代
		$(document).on("click", ".edit_btn", function() {
			//1.查询部门信息并显示部门列表
			getDepts("#dept_update_select");
			//2.查出员工信息
			getEmp($(this).attr("edit-id"));
			//3.弹出模态框,把员工ID传递给更新按钮
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					var gender = empData.gender;
					$("#empUpdateModal input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdateModal select").val([ empData.dId ]);
				}
			});
		}

		$("#emp_update_btn").click(function() {
			//校验邮箱
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确!");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			/* $.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				success:function(result){
					
				}
			}); */
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("edit-id"),
				//使用PUT请求，需要配置springmvc中的org.springframework.web.filter.HttpPutFormContentFilter过滤器
				//这是由于tomcat默认使用post请求，如果直接使用put请求，
				//无法封装表单内容，需要按照上方注释的方式才行，而直接使用put需要按照上一条所说配置在web.xml中配置过滤器
				type : "PUT",
				data : $("#empUpdateModal form").serialize(),
				success : function(result) {
					//1关闭对话框
					$("#empUpdateModal").modal("hide");
					//2回到本页面
					to_page(currentNum);
				}
			});
		});

		//单个删除，需要弹出是否确认对话框
		//1，创建按钮时，绑定。2，绑定点击，.live()为后来元素绑定
		//jquery新版本没有live()方法，新版本用on()方法进行替代
		$(document).on("click", ".delete_btn", function() {
			//获取需要删除的员工姓名
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("delete-id");
			if (confirm("确认删除[" + empName + "]的信息么？")) {
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						//回到本页面
						to_page(currentNum);
					}
				});
			}
		});

		//全选，全部选
		$("#check_all").click(function() {
			//attr 获取 checked 是 undefined
			//这些dom原生属性，attr获取自定义的属性值
			//应用prop修改获取原生属性
			//$(this).prop("checked");
			//$(".check_item")
			$(".check_item").prop("checked", $(this).prop("checked"))
		});
		$(document).on("click", ".check_item", function() {
			//$("#check_all").prop("checked",);
			//判断当前选中的元素是不是当前页的总数
			var checkedSum = $(".check_item:checked").length;
			//所有的个数
			var checkedAllSum = $(".check_item").length;
			$("#check_all").prop("checked", checkedSum == checkedAllSum);
		});

		//emp_delete_all_btn
		//批量删除
		$("#emp_delete_all_btn").click(
				function() {
					if ($(".check_item:checked").length == 0) {
						alert("你还未选择需要删除的学生");
						return;
					}
					//提示所选员工姓名
					//获取所有员工姓名
					//$(".check_item:checked")
					var empNames = "";
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						empNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ ",";
						del_idstr += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});

					if (empNames != "") {
						empNames = empNames.substring(0, empNames.length - 1);
					}
					if (del_idstr != "") {
						del_idstr = del_idstr
								.substring(0, del_idstr.length - 1);
					}
					if (confirm("确认删除[" + empNames + "]的信息么？")) {

						$.ajax({
							url : "${APP_PATH}/emp/" + del_idstr,
							type : "DELETE",
							success : function(result) {

								to_page(currentNum);
							}
						});

					}

				});
	</script>
</body>
</html>