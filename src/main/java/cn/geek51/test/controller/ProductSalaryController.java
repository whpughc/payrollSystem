package cn.geek51.test.controller;

import cn.geek51.test.entity.EmployeeSalary;
import cn.geek51.test.entity.ProductSalary;
import cn.geek51.test.service.EmployeeSalaryService;
import cn.geek51.test.service.ProductSalaryService;
import cn.geek51.util.ResponseUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

/**
 * @description: 按产品统计金额
 * @author: kun
 * @create: 2020-08-12 13:12
 **/
@RestController
public class ProductSalaryController {

    @Autowired(required = false)
    private ProductSalaryService productSalaryService;

    //查询
    @GetMapping("/productSalarys")
    public Object list(Integer page,Integer limit,String query) throws Exception {

        HashMap queryMap = new HashMap();
        // 进行拼接, 拼接成一个MAP查询
        if (query != null) {
            queryMap = new ObjectMapper().readValue(query, HashMap.class);
        }
       /* queryMap.put("page",page);
*/
        PageHelper.startPage(page,limit);
        List<ProductSalary> productSalaryList = productSalaryService.productSalaryList(queryMap);
        PageInfo<ProductSalary> pageInfo = new PageInfo<>(productSalaryList);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",pageInfo.getTotal());
        return ResponseUtil.general_response(productSalaryList,map);
    }

}
