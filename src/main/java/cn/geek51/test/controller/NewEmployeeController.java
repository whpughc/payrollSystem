package cn.geek51.test.controller;


import cn.geek51.domain.Department;
import cn.geek51.domain.Employee;
import cn.geek51.domain.Position;
import cn.geek51.test.entity.Depart;
import cn.geek51.test.entity.NewEmployee;
import cn.geek51.test.mapper.DepartMapper;
import cn.geek51.test.service.NewEmployeeService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UuidUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author kun
 * @since 2020-07-04
 */

@RestController
public class NewEmployeeController {

    @Autowired
   private NewEmployeeService newEmployeeService;

    @Autowired(required = false)
    private DepartMapper departMapper;

    //查询
    @GetMapping("/newEmployees")
    public Object list(Integer page,Integer limit,String query) throws Exception {

        HashMap queryMap = new HashMap();
        // 进行拼接, 拼接成一个MAP查询
        if (query != null) {
            queryMap = new ObjectMapper().readValue(query, HashMap.class);
        }

        List<NewEmployee> list = newEmployeeService.findList(page, limit,queryMap);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",newEmployeeService.count());
        return ResponseUtil.general_response(list,map);
    }

    // 新建
    @PostMapping("/newEmployees")
    public Object insertEmployee(NewEmployee newEmployee) {
        System.out.println(newEmployee);
        Depart depart = departMapper.selectById(newEmployee.getDepartId());
        newEmployee.setDepartUuid(depart.getDepartUuid());
        newEmployee.setCreateAt(LocalDateTime.now());
        newEmployee.setEmployeeUuid(UuidUtil.getUuid());
        boolean save = newEmployeeService.save(newEmployee);
        return ResponseUtil.general_response("success update employee!");
    }

    // 更改
    @PutMapping("/newEmployees")
    public Object updateNewEmployee(@RequestBody NewEmployee newEmployee) {
        System.out.println(newEmployee);
        newEmployeeService.updateById(newEmployee);
        return ResponseUtil.general_response("success update department!");
    }

    // 删除
    @DeleteMapping("/newEmployees/{id}")
    public Object deleteNewEmployee(@PathVariable("id") Integer id) {
        newEmployeeService.removeById(id);
        return ResponseUtil.general_response("success delete department!");
    }


}

