package cn.geek51.test.mapper;

import cn.geek51.test.entity.Product;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author kun
 * @since 2020-07-06
 */
public interface ProductMapper extends BaseMapper<Product> {

    List<Product> findProductList(@Param("productUuidList") List<String> productUuidList);
}
