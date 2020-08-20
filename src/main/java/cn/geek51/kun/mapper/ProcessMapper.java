package cn.geek51.kun.mapper;

import cn.geek51.kun.entity.Process;
import cn.geek51.kun.entity.ProcessDto;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author kun
 * @since 2020-07-15
 */
public interface ProcessMapper extends BaseMapper<Process> {

    int insertBatch(@Param("departUuid") String departUuid, @Param("productUuid") String productUuid, @Param("processDtoList") List<ProcessDto> processDtoList);

    Process findProcess(@Param("departUuid") String departUuid, @Param("productUuid") String productUuid,@Param("processNumber") Integer processNumber);

    List<Process> findProcessList(@Param("departUuid") String departUuid, @Param("productUuid") String productUuid);
}
