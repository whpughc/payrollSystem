package cn.geek51.kun.mapper;

import cn.geek51.kun.entity.Depart;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author kun
 * @since 2020-07-02
 */
public interface DepartMapper extends BaseMapper<Depart> {

    List<Depart> findDepartList(List<String> departUuidList);
}
