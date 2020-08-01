package cn.geek51.test.service.impl;

import cn.geek51.test.entity.WorkOrder;
import cn.geek51.test.entity.WorkOrder;
import cn.geek51.test.entity.WorkOrderDto;
import cn.geek51.test.mapper.WorkOrderMapper;
import cn.geek51.test.service.WorkOrderService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author kun
 * @since 2020-07-22
 */
@Service
public class WorkOrderServiceImpl extends ServiceImpl<WorkOrderMapper, WorkOrder> implements WorkOrderService {
    
    @Autowired(required = false)
    private WorkOrderMapper workOrderMapper;

    @Override
    public List<WorkOrder> findList(Integer page, Integer limit, HashMap queryMap) {
        
        IPage<WorkOrder> workOrderIPage = new Page<>(page,limit);

        QueryWrapper<WorkOrder> queryWrapper = new QueryWrapper<>();

        if (queryMap.get("qorderNumber") != null){
            queryWrapper.like("order_number",queryMap.get("qorderNumber"));
        }

        if (queryMap.get("qdepartUuid") != null){
            queryWrapper.eq("depart_uuid",queryMap.get("qdepartUuid"));
        }

        if (queryMap.get("qproductUuid") != null){
            queryWrapper.eq("product_uuid",queryMap.get("qproductUuid"));
        }

        if (queryMap.get("qprocessNumber") != null){
            queryWrapper.eq("process_number",queryMap.get("qprocessNumber"));
        }

        if (queryMap.get("qemployeeNumber") != null){
            queryWrapper.like("employee_number",queryMap.get("qemployeeNumber"));
        }

        if (queryMap.get("qstartTime") != null){
            queryWrapper.ge("create_at",queryMap.get("qstartTime"));
        }

        if (queryMap.get("qendTime") != null){
            queryWrapper.le("create_at",queryMap.get("qendTime"));
        }

        queryWrapper.orderByDesc("create_at");

        IPage<WorkOrder> result = workOrderMapper.selectPage(workOrderIPage, queryWrapper);
        List<WorkOrder> WorkOrderList = result.getRecords();
        return WorkOrderList;
    }

    @Override
    public int insertBatch(WorkOrderDto workOrderDto) {
         return workOrderMapper.insertBatch(workOrderDto);
    }


}
