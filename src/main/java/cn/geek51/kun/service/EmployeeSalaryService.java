package cn.geek51.kun.service;

import cn.geek51.kun.entity.EmployeeSalary;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: kun
 * @create: 2020-07-24 14:44
 **/
@Service
public interface EmployeeSalaryService  {
    List<EmployeeSalary> employeeSalaryList(Map<String,Object> map);
}
