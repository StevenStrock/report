package com.zys.platform.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zys.platform.bean.Employee;
import com.zys.platform.bean.EmployeeExample;
import com.zys.platform.bean.EmployeeExample.Criteria;
import com.zys.platform.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	/**
	 * 查询所有员工方法
	 * @return
	 */
	public List<Employee> getAll() {
		List<Employee> list = new ArrayList<Employee>();
		list = employeeMapper.selectByExampleWithDept(null);
		return list;
	}
	
	public int saveEmp(Employee employee) {
		return employeeMapper.insertSelective(employee);
	}
	
	/**
	 * 
	 * @param empName
	 * @return true 当前姓名可用，否则不可用
	 */
	public boolean getUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long num = employeeMapper.countByExample(example);
		return num == 0;
	}
	
	public Employee getEmp(Integer id) {
		Employee employee= employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	
	
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	
	public void deleteEMp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
	
}
