package com.zys.platform.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zys.platform.bean.Department;
import com.zys.platform.bean.Msg;
import com.zys.platform.service.DepartmentService;

/**
 * 处理部门请求
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有部门信息
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> list = new ArrayList<Department>();
		list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}

}
