package cn.geek51.kun.service;

import cn.geek51.kun.entity.ProductSalary;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: kun
 * @create: 2020-08-12 13:17
 **/
@Service
public interface ProductSalaryService {
    List<ProductSalary> productSalaryList(Map<String,Object> map);
}
