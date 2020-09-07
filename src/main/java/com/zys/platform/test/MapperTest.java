package com.zys.platform.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zys.platform.bean.Department;
import com.zys.platform.bean.Employee;
import com.zys.platform.dao.DepartmentMapper;
import com.zys.platform.dao.EmployeeMapper;

/**
 * 测试dao层
 * @author Administrator
 * 推荐spring项目就使用spring的单元测试，可以自动注入需要的组件
 * 1，导入springTest模块
 * 2,使用@ContextConfiguration注解指定spring配置文件的位置
 * 3,使用@Autowired注解直接要用的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	/**
	 * 测试部门
	 */
	@Test
	public void testCRUD() {
//		//1,创建spring ioc 容器
//		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2，从容器获取mapper
//		DepartmentMapper departmentMapper = applicationContext.getBean(DepartmentMapper.class);
		
		/*
		 * System.out.println(departmentMapper.toString());
		 * 
		 * Department department = new Department(); department.setDeptName("测试部");
		 * departmentMapper.insert(department);
		 */
		//批量的
		DepartmentMapper departmentMapper =sqlSession.getMapper(DepartmentMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uuid = UUID.randomUUID().toString().substring(0,5)+i;
			employeeMapper.insertSelective(new Employee(null, uuid, "0", uuid+"@zys.com", 3, null));
		}
		
	}
}
