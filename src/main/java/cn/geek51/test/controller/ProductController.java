package cn.geek51.test.controller;


import cn.geek51.test.entity.Depart;
import cn.geek51.test.entity.NewEmployee;
import cn.geek51.test.entity.Product;
import cn.geek51.test.service.DepartService;
import cn.geek51.test.service.ProductService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UuidUtil;
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
 * @since 2020-07-06
 */
@RestController
public class ProductController {

    @Autowired
    private ProductService productService;

    //查询
    @GetMapping("/products")
    public Object list(Integer page,Integer limit,String query) throws Exception {

        HashMap queryMap = new HashMap();
        // 进行拼接, 拼接成一个MAP查询
        if (query != null) {
            queryMap = new ObjectMapper().readValue(query, HashMap.class);
        }

        List<Product> list = productService.findList(page, limit,queryMap);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",productService.count());
        return ResponseUtil.general_response(list,map);
    }

    // 新建
    @PostMapping("/products")
    public Object insertProduct(Product product) {
        product.setProductUuid(UuidUtil.getUuid());
        product.setCreateAt(LocalDateTime.now());
        System.out.println(product);
        boolean save = productService.save(product);
        return ResponseUtil.general_response(save);
    }

    // 更改
    @PutMapping("/products")
    public Object updateProduct(@RequestBody Product product) {
        System.out.println(product);
        productService.updateById(product);
        return ResponseUtil.general_response("success update department!");
    }

    // 删除
    @DeleteMapping("/products/{id}")
    public Object deleteProduct(@PathVariable("id") Integer id) {
        productService.removeById(id);
        return ResponseUtil.general_response("success delete department!");
    }

}

