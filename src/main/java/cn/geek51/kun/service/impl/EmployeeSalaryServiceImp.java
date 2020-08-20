package cn.geek51.kun.service.impl;

import cn.geek51.kun.entity.Depart;
import cn.geek51.kun.entity.EmployeeSalary;
import cn.geek51.kun.entity.NewEmployee;
import cn.geek51.kun.mapper.DepartMapper;
import cn.geek51.kun.mapper.NewEmployeeMapper;
import cn.geek51.kun.mapper.ProcessMapper;
import cn.geek51.kun.mapper.WorkOrderMapper;
import cn.geek51.kun.service.EmployeeSalaryService;
import cn.geek51.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @description:
 * @author: kun
 * @create: 2020-07-24 14:45
 **/
@Service
@Slf4j
public class EmployeeSalaryServiceImp implements EmployeeSalaryService {

    @Autowired
    private ProcessMapper processMapper;

    @Autowired
    private DepartMapper departMapper;

    @Autowired
    private NewEmployeeMapper newEmployeeMapper;

    @Autowired
    private WorkOrderMapper workOrderMapper;

    @Override
    public List<EmployeeSalary> employeeSalaryList(Map<String,Object> map){

        List<EmployeeSalary> employeeSalaryList = workOrderMapper.employeeSalaryList(map);

        if (employeeSalaryList != null && !employeeSalaryList.isEmpty()){
            List<String> employeeNumberList = employeeSalaryList.stream().map(EmployeeSalary::getEmployeeNumber).collect(Collectors.toList());

            List<NewEmployee> newEmployeeList = newEmployeeMapper.findEmployeeList(employeeNumberList);
            Map<String, NewEmployee> newEmployeeMap = newEmployeeList.stream().collect(Collectors.toMap(NewEmployee::getEmployeeNumber, e -> e));

           employeeSalaryList.forEach(employeeSalary -> {
               if (StringUtils.isNotEmpty(employeeSalary.getEmployeeNumber())){
                   if (newEmployeeMap.get(employeeSalary.getEmployeeNumber()) != null){
                       employeeSalary.setEmployeeName(newEmployeeMap.get(employeeSalary.getEmployeeNumber()).getEmployeeName());
                       QueryWrapper<Depart> queryWrapper = new QueryWrapper<>();
                       if (StringUtils.isNotEmpty(newEmployeeMap.get(employeeSalary.getEmployeeNumber()).getDepartUuid())){
                           queryWrapper.eq("depart_uuid",newEmployeeMap.get(employeeSalary.getEmployeeNumber()).getDepartUuid());
                           Depart depart = departMapper.selectOne(queryWrapper);
                           employeeSalary.setDepartName(depart.getDepartName());
                       }
                   }
               }
           });
        }
        return employeeSalaryList;
    }
}
