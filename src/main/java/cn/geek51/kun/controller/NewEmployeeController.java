package cn.geek51.kun.controller;


import cn.geek51.kun.entity.Depart;
import cn.geek51.kun.entity.NewEmployee;
import cn.geek51.kun.mapper.DepartMapper;
import cn.geek51.kun.service.NewEmployeeService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.StringUtils;
import cn.geek51.util.UuidUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

        IPage<NewEmployee> newEmployeeIPage = newEmployeeService.findList(page, limit, queryMap);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",newEmployeeIPage.getTotal());
        return ResponseUtil.general_response(newEmployeeIPage.getRecords(),map);
    }

    // 新建
    @PostMapping("/newEmployees")
    public Object insertEmployee(NewEmployee newEmployee) {
        String employeeNumber = newEmployee.getEmployeeNumber();
        QueryWrapper<NewEmployee> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty(employeeNumber)){
            queryWrapper.eq("employee_number",employeeNumber);
        }
        NewEmployee tempEmployee = newEmployeeService.getOne(queryWrapper);
        if (tempEmployee != null){
            return ResponseUtil.general_response(405,"员工工号已存在");
        }
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
        String employeeNumber = newEmployee.getEmployeeNumber();
        QueryWrapper<NewEmployee> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty(employeeNumber)){
            queryWrapper.eq("employee_number",employeeNumber);
        }
        NewEmployee tempEmployee = newEmployeeService.getOne(queryWrapper);
        if (tempEmployee != null && !tempEmployee.getId().equals(newEmployee.getId())){
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"员工工号已存在");
        }
        Depart depart = departMapper.selectById(newEmployee.getDepartId());
        newEmployee.setDepartUuid(depart.getDepartUuid());
        boolean b = newEmployeeService.updateById(newEmployee);
        if (b)
        return ResponseUtil.general_response("success update!");
        else
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"更新失败");
    }

    // 删除
    @DeleteMapping("/newEmployees/{id}")
    public Object deleteNewEmployee(@PathVariable("id") Integer id) {
        newEmployeeService.removeById(id);
        return ResponseUtil.general_response("success delete department!");
    }

    // 批量删除
    @DeleteMapping("/newEmployees")
    public Object deleteEmployeeBatch(@RequestBody JSONObject params) {
        JSONArray ids = params.getJSONArray("ids");
        List<String> idList = ids.toJavaList(String.class);
        boolean b = newEmployeeService.removeByIds(idList);
        if (b)
            return ResponseUtil.general_response("success delete department!");
        else
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"删除失败");
    }

}

