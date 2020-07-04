package cn.geek51.test.controller;


import cn.geek51.test.entity.Depart;
import cn.geek51.test.service.DepartService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UuidUtil;
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
 * @since 2020-07-02
 */
@RestController
public class DepartController {

    @Autowired
    private DepartService departService;

    //查询
    @GetMapping("/departs")
    public Object list(Integer page,Integer limit){
        List<Depart> list = departService.findList(page, limit);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",list.size());
        return ResponseUtil.general_response(list,map);
    }

    // 新建
    @PostMapping("/departs")
    public Object insertDepart(Depart depart) {
        depart.setDepartUuid(UuidUtil.getUuid());
        depart.setCreateAt(LocalDateTime.now());
        System.out.println(depart);
        boolean save = departService.save(depart);
        return ResponseUtil.general_response(save);
    }

    // 更改
    @PutMapping("/departs")
    public Object updateDepart(@RequestBody Depart depart) {
        System.out.println(depart);
        departService.updateById(depart);
        return ResponseUtil.general_response("success update department!");
    }

    // 删除
    @DeleteMapping("/departs/{id}")
    public Object deleteDepart(@PathVariable("id") Integer id) {
        departService.removeById(id);
        return ResponseUtil.general_response("success delete department!");
    }
}

