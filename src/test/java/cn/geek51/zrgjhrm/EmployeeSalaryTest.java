package cn.geek51.zrgjhrm;

import cn.geek51.test.entity.EmployeeSalary;
import cn.geek51.test.mapper.WorkOrderMapper;
import cn.geek51.test.service.EmployeeSalaryService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @description:
 * @author: kun
 * @create: 2020-08-03 15:38
 **/
@SpringBootTest
@RunWith(SpringRunner.class)
public class EmployeeSalaryTest {

    @Autowired(required = false)
    private WorkOrderMapper workOrderMapper;

    @Autowired
    private EmployeeSalaryService employeeSalaryService;

    @Test
    public void test(){
        List<EmployeeSalary> employeeSalaryList = workOrderMapper.employeeSalaryList();
        List<String> collect = employeeSalaryList.stream().map(EmployeeSalary::getEmployeeNumber).collect(Collectors.toList());

    }

    @Test
    public void test1(){
        List<EmployeeSalary> employeeSalaries = employeeSalaryService.employeeSalaryList();
        /*employeeSalaries.forEach(S);*/
    }
}
