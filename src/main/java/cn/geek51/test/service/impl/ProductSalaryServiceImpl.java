package cn.geek51.test.service.impl;

import cn.geek51.test.entity.Product;
import cn.geek51.test.entity.ProductSalary;
import cn.geek51.test.mapper.ProcessMapper;
import cn.geek51.test.mapper.ProductMapper;
import cn.geek51.test.mapper.WorkOrderMapper;
import cn.geek51.test.service.ProductSalaryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @description:
 * @author: kun
 * @create: 2020-08-12 13:18
 **/
@Service
@Slf4j
public class ProductSalaryServiceImpl implements ProductSalaryService {

    @Autowired(required = false)
    private WorkOrderMapper workOrderMapper;

    @Autowired(required = false)
    private ProductMapper productMapper;


    @Override
    public List<ProductSalary> productSalaryList() {
        List<ProductSalary> productSalaryList = workOrderMapper.productSalaryList();

        if (productSalaryList != null && !productSalaryList.isEmpty()){
            List<String> productUuidList = productSalaryList.stream().map(ProductSalary::getProductUuid).collect(Collectors.toList());

            List<Product> productList = productMapper.findProductList(productUuidList);
            Map<String, Product> productMap = productList.stream().collect(Collectors.toMap(Product::getProductUuid, product -> product));

            productSalaryList.forEach(productSalary ->{
                Product product = productMap.get(productSalary.getProductUuid());
                if (product != null){
                    productSalary.setName(product.getName());
                    productSalary.setProductNumber(product.getProductNumber());
                }
            } );
        }
        return productSalaryList;
    }
}
