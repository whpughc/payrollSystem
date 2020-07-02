package cn.geek51.test.controller;


import cn.geek51.domain.Department;
import cn.geek51.domain.PageHelper;
import cn.geek51.test.entity.Depart;
import cn.geek51.test.service.DepartService;
import cn.geek51.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author kun
 * @since 2020-07-02
 */
@RestController
public class DepartController {

    @Autowired
    private DepartService departService;

    @GetMapping("/departs")
    public Object list(PageHelper pageHelper){
        List<Depart> list = departService.list();
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",list.size());
        return ResponseUtil.general_response(list,map);
    }

}

