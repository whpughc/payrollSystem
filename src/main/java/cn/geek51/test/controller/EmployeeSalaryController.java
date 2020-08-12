package cn.geek51.test.controller;

import cn.geek51.test.entity.Depart;
import cn.geek51.test.entity.EmployeeSalary;
import cn.geek51.test.service.EmployeeSalaryService;
import cn.geek51.util.ResponseUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

/**
 * @description: 员工工资统计
 * @author: kun
 * @create: 2020-07-24 14:40
 **/
@RestController
public class EmployeeSalaryController {

    @Autowired(required = false)
    private EmployeeSalaryService employeeSalaryService;

    //查询
    @GetMapping("/employeeSalarys")
    public Object list(Integer page,Integer limit){
        PageHelper.startPage(page,limit);
        List<EmployeeSalary> employeeSalaryList = employeeSalaryService.employeeSalaryList();
        PageInfo<EmployeeSalary> pageInfo = new PageInfo<>(employeeSalaryList);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",pageInfo.getTotal());
        return ResponseUtil.general_response(employeeSalaryList,map);
    }

}