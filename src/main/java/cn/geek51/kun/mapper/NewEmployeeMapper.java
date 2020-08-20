package cn.geek51.kun.mapper;

import cn.geek51.kun.entity.NewEmployee;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author kun
 * @since 2020-07-04
 */
public interface NewEmployeeMapper extends BaseMapper<NewEmployee> {

    List<NewEmployee> findEmployeeList(@Param("employeeNumberList") List employeeNumberList);

}
