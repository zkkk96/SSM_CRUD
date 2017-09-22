package com.weibin.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weibin.bean.Employee;
import com.weibin.bean.Msg;
import com.weibin.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的CRUD请求
 * Created by wei.bin on 2017/9/12.
 */

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 单个批量二合一
     * 批量：1-2-3
     * 单个删除：1
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String str : str_ids){
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.delete(id);
        }
        return Msg.success();
    }


    /**
     * 请求体中有数据，Employee拼装不上，
     * Tomcat ：请求体中的数据，封装成map
     *        SpringMVC封装POJO对象的时候，
     *        会把每个属性的值调用request.getParamter("");
     *
     * Ajax发送PUT请求会引发异常：
     *          Tomcat看到PUT不会封装请求体中的数据为map
     * 若要能直接支持PUT之类的请求，需要重新封装请求体中的数据
     * 配置HttpPutFormContentFilter,
     * 将请求体中的数据解析包装成一个map
     * request被重新包装,getParameter()被重写,
     * 就会重自己封装的map中取数据
     *
     * 员工更新
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println("将要更行的数据： " + employee.toString());
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 查询 根据id
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|([\\u2E80-\\u9FFF]{2,5})";
        boolean reg = empName.matches(regName);
        if (!reg){
            return Msg.fail().add("va_msg", "用户名应为6-16位英文和数字的组合或者2-5位中文。。。");
        }
        boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }


    /**
     * 增加 并保存员工数据
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator
     * @param employee
     * @return
     */
    @RequestMapping(value="/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，返回时报，显示错误信息
            Map<String, Object> map = new HashMap<String, Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors){
                System.out.println("错误字段名：" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * RequestMapping正常工作需要导入jackson包。负责将对象转换为字符串
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJSON(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        //这不是一个分页查询
        //引入PageHelper分页查询
        //在查询之前只需要调用，传入页码以及分页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employees = employeeService.getAll();

        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo<Employee> page = new PageInfo<Employee>(employees, 5);

        return Msg.success().add("pageInfo", page);
    }


    /**
     * 查询员工数据（分页查询）
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model){
        //这不是一个分页查询
        //引入PageHelper分页查询
        //在查询之前只需要调用，传入页码以及分页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employees = employeeService.getAll();

        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo<Employee> page = new PageInfo<Employee>(employees, 5);

        model.addAttribute("pageInfo", page);

        return "list";
    }
}
