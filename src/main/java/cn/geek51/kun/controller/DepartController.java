package cn.geek51.kun.controller;


import cn.geek51.domain.PageHelper;
import cn.geek51.kun.entity.Depart;
import cn.geek51.kun.service.DepartService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UuidUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

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
    public Object list(PageHelper pageHelper){
        Integer page = pageHelper.getPage();
        Integer limit = pageHelper.getLimit();
        List<Depart> list = departService.findList(page, limit);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",departService.count());
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
        boolean b = departService.updateById(depart);
        if (b)
            return ResponseUtil.general_response("success update department!");
        else
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"更新失败");

    }

    // 删除
    @DeleteMapping("/departs/{id}")
    public Object deleteDepart(@PathVariable("id") Integer id) {
        boolean b = departService.removeById(id);
        if (b)
            return ResponseUtil.general_response("success delete department!");
        else
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"删除失败");
    }

    // 批量删除
    @DeleteMapping("/departs")
    public Object deleteDepartBatch(@RequestBody JSONObject params) {
        JSONArray ids = params.getJSONArray("ids");
        List<String> idList = ids.toJavaList(String.class);
        boolean b = departService.removeByIds(idList);
        if (b)
            return ResponseUtil.general_response("success delete department!");
        else
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"删除失败");
    }
}

