package cn.geek51.test.service;

import cn.geek51.test.entity.ProductSalary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: kun
 * @create: 2020-08-12 13:17
 **/
@Service
public interface ProductSalaryService {
    List<ProductSalary> productSalaryList();
}