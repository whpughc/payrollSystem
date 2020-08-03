package cn.geek51.test.service.impl;

import cn.geek51.test.entity.NewEmployee;
import cn.geek51.test.entity.Product;
import cn.geek51.test.mapper.ProductMapper;
import cn.geek51.test.service.ProductService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author kun
 * @since 2020-07-06
 */
@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {

    @Autowired(required = false)
    private ProductMapper productMapper;

    @Override
    public IPage<Product> findList(Integer page, Integer limit, Map queryMap) {

        IPage<Product> productIPage = new Page<>(page,limit);

        QueryWrapper<Product> queryWrapper = new QueryWrapper<>();

        if (queryMap.get("qproductNumber") != null){
            queryWrapper.like("product_number",queryMap.get("qproductNumber"));
        }

        if (queryMap.get("qname") != null){
            queryWrapper.like("name",queryMap.get("qname"));
        }

        IPage<Product> result = productMapper.selectPage(productIPage, queryWrapper);
        return result;
    }
}
