package cn.geek51.kun.service;

import cn.geek51.kun.entity.WorkOrder;
import cn.geek51.kun.entity.WorkOrderDto;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.HashMap;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author kun
 * @since 2020-07-22
 */
public interface WorkOrderService extends IService<WorkOrder> {

    IPage<WorkOrder> findList(Integer page, Integer limit, HashMap queryMap);

    int insertBatch(WorkOrderDto workOrderDto);
}
