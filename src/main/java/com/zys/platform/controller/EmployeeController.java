package com.zys.platform.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zys.platform.bean.Employee;
import com.zys.platform.bean.Msg;
import com.zys.platform.service.EmployeeService;

/**
 * 处理员工请求
 * @author Administrator
 * /emp/{id} GET 获取单个员工
 * /emp POST 保存一个员工
 * /emp/{id} PUT 修改一个员工
 * /emp/{id} DELETE 删除一个员工
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	
	
	/**
	 * 导入jack包才能使用@ResponseBody
	 * 获取所有员工列表
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> list = new ArrayList<Employee>();
		list = employeeService.getAll();
		PageInfo pageInfo = new PageInfo<>(list,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 1,要支持jsr303
	 * 2，导入Hibernate-Validator
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		//新增前要进行后端数据校验,在bean中加注解
		if (result.hasErrors()) {
			//校验失败，返回错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> erros = result.getFieldErrors();
			for (FieldError fieldError : erros) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("erroFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	@RequestMapping(value="/checkuser",method = RequestMethod.GET)
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName) {
		//先校验下用户长度和字符是否合法
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		boolean regexFlag = empName.matches(regex);
		if (!regexFlag) {
			return Msg.fail().add("va_msg", "用户名可以是2-5位中文或者6-16位英文和数字组合!");
		}
		//数据库校验
		boolean b = employeeService.getUser(empName);
		if (b) {
			return Msg.success().add("va_msg", "用户可用");
		}else {
			return Msg.fail().add("va_msg", "用户名重复，不可用");
		}
	}
	
	
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg emp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	@RequestMapping(value="/emp/{empId}",method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(@Valid Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
//	@RequestMapping(value="/emp/{id}",method = RequestMethod.DELETE)
//	@ResponseBody
//	public Msg delempById(@PathVariable("id")Integer id) {
//		employeeService.deleteEMp(id);
//		return Msg.success();
//	}
	
	/**
	 * 批量删除
	 * 如果是批量删除用-隔开 1-2-3-4
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method = RequestMethod.DELETE)
	@ResponseBody
	public Msg delemp(@PathVariable("ids")String ids) {
		if (ids.contains("-")) {
			String[] str_ids = ids.split("-");
			List<Integer> del_ids = new ArrayList<Integer>();
			for (String id : str_ids) {
				int i = Integer.parseInt(id);
				del_ids.add(i);
			}
			employeeService.deleteBatch(del_ids);
			return Msg.success();
		}else {
			//单个删除
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEMp(id);
			return Msg.success();
		}
		
	}
	@RequestMapping(value="/toForm")
	@ResponseBody
	public ModelAndView toForm() {
		 ModelAndView retMap = new ModelAndView();  //返回新的ModelAndView
         retMap.setViewName("form");
         return retMap;
	}
	
//	@RequestMapping(value="/toIndex")
//	@ResponseBody
//	public ModelAndView toIndex() {
//		 ModelAndView retMap = new ModelAndView();  //返回新的ModelAndView
//         retMap.setViewName("../Web/Sts/index");
//         return retMap;
//	}
	
	/**
	 * 获取所有员工列表
	 * @return
	 */
//	@RequestMapping("/emps")
	/*
	 * public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer
	 * pn,Model model) {
	 * 
	 * //引入PageHelper分页插件传入页码以及每页多少条 PageHelper.startPage(pn, 5);
	 * 
	 * List<Employee> list = new ArrayList<Employee>(); list =
	 * employeeService.getAll(); //使用PageInfo包裝，最终将PageInfo交给页面,连续显示5页，后面传入5
	 * PageInfo pageInfo = new PageInfo<>(list,5);
	 * model.addAttribute("pageInfo",pageInfo); return "list"; }
	 */
}
