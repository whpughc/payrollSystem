package cn.geek51.test.service;

import cn.geek51.test.entity.WorkOrder;
import cn.geek51.test.entity.WorkOrderDto;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.HashMap;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author kun
 * @since 2020-07-22
 */
public interface WorkOrderService extends IService<WorkOrder> {

    List<WorkOrder> findList(Integer page, Integer limit, HashMap queryMap);

    int insertBatch(WorkOrderDto workOrderDto);
}
