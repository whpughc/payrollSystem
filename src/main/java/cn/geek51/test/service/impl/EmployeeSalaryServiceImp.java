package cn.geek51.test.service.impl;

import cn.geek51.test.mapper.ProcessMapper;
import cn.geek51.test.mapper.WorkOrderMapper;
import cn.geek51.test.service.EmployeeSalaryService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @description:
 * @author: kun
 * @create: 2020-07-24 14:45
 **/
public class EmployeeSalaryServiceImp implements EmployeeSalaryService {

    @Autowired
    private ProcessMapper processMapper;

    @Autowired
    private WorkOrderMapper workOrderMapper;

    public String employeeSalary(){


        return null;
    }

}
