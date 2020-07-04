package cn.geek51.test.controller;


import cn.geek51.test.entity.Depart;
import cn.geek51.test.entity.NewEmployee;
import cn.geek51.test.service.NewEmployeeService;
import cn.geek51.util.ResponseUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

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
    NewEmployeeService newEmployeeService;

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
        map.put("size",list.size());
        return ResponseUtil.general_response(list,map);
    }

}

