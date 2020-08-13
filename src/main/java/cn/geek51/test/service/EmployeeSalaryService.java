package cn.geek51.test.service;

import cn.geek51.domain.Department;
import cn.geek51.service.AbstractIService;
import cn.geek51.test.entity.Depart;
import cn.geek51.test.entity.EmployeeSalary;
import com.baomidou.mybatisplus.extension.service.IService;
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
