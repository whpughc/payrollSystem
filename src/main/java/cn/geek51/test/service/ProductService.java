package cn.geek51.test.service;

import cn.geek51.test.entity.Depart;
import cn.geek51.test.entity.Product;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
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

    List<Product> findList(Integer page, Integer limit, Map queryMap);
}
