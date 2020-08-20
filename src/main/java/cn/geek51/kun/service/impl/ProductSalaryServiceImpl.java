package cn.geek51.kun.service.impl;

import cn.geek51.kun.entity.Depart;
import cn.geek51.kun.entity.Product;
import cn.geek51.kun.entity.ProductSalary;
import cn.geek51.kun.mapper.DepartMapper;
import cn.geek51.kun.mapper.ProductMapper;
import cn.geek51.kun.mapper.WorkOrderMapper;
import cn.geek51.kun.service.ProductSalaryService;
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

    @Autowired(required = false)
    private DepartMapper departMapper;

    @Override
    public List<ProductSalary> productSalaryList(Map<String,Object> map) {
        List<ProductSalary> productSalaryList = workOrderMapper.productSalaryList(map);

        if (productSalaryList != null && !productSalaryList.isEmpty()){
            List<String> productUuidList = productSalaryList.stream().map(ProductSalary::getProductUuid).collect(Collectors.toList());
            List<String> departUuidList = productSalaryList.stream().map(ProductSalary::getDepartUuid).collect(Collectors.toList());

            List<Depart> departList = departMapper.findDepartList(departUuidList);
            List<Product> productList = productMapper.findProductList(productUuidList);
            Map<String, Product> productMap = productList.stream().collect(Collectors.toMap(Product::getProductUuid, product -> product));
            Map<String, Depart> departMap = departList.stream().collect(Collectors.toMap(Depart::getDepartUuid, depart -> depart));

            productSalaryList.forEach(productSalary ->{
                Product product = productMap.get(productSalary.getProductUuid());
                Depart depart = departMap.get(productSalary.getDepartUuid());

                if (product != null){
                    productSalary.setName(product.getName());
                    productSalary.setProductNumber(product.getProductNumber());
                }

                if (depart != null){
                    productSalary.setDepartName(depart.getDepartName());
                }
            } );
        }
        return productSalaryList;
    }
}
