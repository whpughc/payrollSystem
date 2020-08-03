package cn.geek51.test.service;

import cn.geek51.test.entity.NewEmployee;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author kun
 * @since 2020-07-04
 */
public interface NewEmployeeService extends IService<NewEmployee> {

   IPage<NewEmployee> findList(Integer page, Integer limit, Map queryMap);

}
