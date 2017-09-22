package com.weibin.test;

import com.github.pagehelper.PageInfo;
import com.weibin.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试提供的测试请求功能，测试CRUD功能
 * Spring4测试的时候需要servlet3.0的支持
 * D:\IdeaPro\SSMCRUD\src\main\webapp\WEB-INF\dispatcherServlet-servlet.xml
 * Created by wei.bin on 2017/9/12.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
@WebAppConfiguration
public class MvcTest {

    //传入SpringMvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {

        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get(
                "/emps").param("pn", "1")).andReturn();

        //请求成功后，请求域中会有pageInfo，我们可以去除pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码：" + pi.getPageNum());
        System.out.println("总页码：" + pi.getPages());
        System.out.println("总记录数：" + pi.getTotal());
        System.out.println("在页面连续显示的页码");
        int [] nums = pi.getNavigatepageNums();
        for (int i : nums){
            System.out.println(" " + i);
        }
        List<Employee> employees = pi.getList();
        for (Employee e : employees){
            System.out.println("ID : " + e.getEmpId() + ", Name：" + e.getEmpName());
        }

    }
}
