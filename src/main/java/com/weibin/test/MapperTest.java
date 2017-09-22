package com.weibin.test;

import com.weibin.bean.Department;
import com.weibin.bean.Employee;
import com.weibin.bean.EmployeeExample;
import com.weibin.dao.DepartmentMapper;
import com.weibin.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层的工作
 * Created by wei.bin on 2017/9/12.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    Employee employee;

    @Autowired
    SqlSession sqlSession;


    @Test
    public void testCRUD(){
//        ApplicationContext ioc =
//                new ClassPathXmlApplicationContext("applicationContext.xml");
        System.out.println(departmentMapper);
        employee = new Employee();
        //插入部门
//        Department department1 = new Department(null, "开发部");
//        Department department2 = new Department(null, "测试部");
//        departmentMapper.insertSelective(department1);
//        departmentMapper.insertSelective(department2);
        // 插入员工
//        employeeMapper.insertSelective(
//                new Employee(null, "Jerry", "M", "11111abc@163.com",1)
//        );

        //批量插入多个员工。使用可执行批量操作的sqlSession
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++){
//            String uuid = UUID.randomUUID().toString().substring(0, 5);
//            mapper.insertSelective(new Employee(
//                    null, uuid, "M", uuid + "@163.com", 1
//            ));
//        }
//        System.out.println("批量完成。。。");
        for (int i = 1; i<1000; i++){
            int id = employeeMapper.selectByPrimaryKey(i).getEmpId();
            if (id%2==1){

            }
        }

    }
}
