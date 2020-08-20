package cn.geek51.kun.service;

import cn.geek51.kun.entity.Process;
import cn.geek51.kun.entity.ProcessDto;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.HashMap;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author kun
 * @since 2020-07-15
 */
public interface ProcessService extends IService<Process> {

    IPage<Process> findList(Integer page, Integer limit, HashMap queryMap);

    int insertBatch(String departUuid, String productUuid, List<ProcessDto> processDtoList);
}
