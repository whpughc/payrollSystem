package cn.geek51.zrgjhrm;

import cn.geek51.kun.entity.EmployeeSalary;
import cn.geek51.kun.entity.ProductSalary;
import cn.geek51.kun.mapper.WorkOrderMapper;
import cn.geek51.kun.service.EmployeeSalaryService;
import cn.geek51.kun.service.ProductSalaryService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;
import java.util.stream.Collectors;

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

    @Autowired
    private ProductSalaryService productSalaryService;
    @Test
    public void test(){
        List<EmployeeSalary> employeeSalaryList = workOrderMapper.employeeSalaryList(null);
        List<String> collect = employeeSalaryList.stream().map(EmployeeSalary::getEmployeeNumber).collect(Collectors.toList());

    }

    @Test
    public void test1(){
        List<EmployeeSalary> employeeSalaries = employeeSalaryService.employeeSalaryList(null);
        /*employeeSalaries.forEach(S);*/
    }

    @Test
    public void test2(){
        List<ProductSalary> productSalaryList = workOrderMapper.productSalaryList(null);
        productSalaryList.forEach(System.out::println);

        List<ProductSalary> productSalaryList1 = productSalaryService.productSalaryList(null);
        productSalaryList1.forEach(System.out::println);
    }
}
