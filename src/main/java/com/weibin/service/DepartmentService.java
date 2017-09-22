package com.weibin.service;

import com.weibin.bean.Department;
import com.weibin.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wei.bin on 2017/9/19.
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     *
     * @return
     */
    public List<Department> getDepts() {
        List<Department> list =
                departmentMapper.selectByExample(null);
        return list;
    }
}
