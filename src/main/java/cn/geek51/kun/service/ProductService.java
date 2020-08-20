package cn.geek51.kun.service;

import cn.geek51.kun.entity.Product;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author kun
 * @since 2020-07-06
 */
public interface ProductService extends IService<Product> {

    IPage<Product> findList(Integer page, Integer limit, Map queryMap);
}
