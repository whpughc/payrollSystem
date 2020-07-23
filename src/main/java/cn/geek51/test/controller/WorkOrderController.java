package cn.geek51.test.controller;


import cn.geek51.test.entity.Order;
import cn.geek51.test.entity.WorkOrder;
import cn.geek51.test.entity.WorkOrderDto;
import cn.geek51.test.service.WorkOrderService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UuidUtil;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author kun
 * @since 2020-07-22
 */
@RestController
public class WorkOrderController {

    @Autowired
    private WorkOrderService workOrderService;

    //查询
    @GetMapping("/workOrders")
    public Object list(Integer page,Integer limit,String query) throws Exception {

        HashMap queryMap = new HashMap();
        // 进行拼接, 拼接成一个MAP查询
        if (query != null) {
            queryMap = new ObjectMapper().readValue(query, HashMap.class);
        }

        List<WorkOrder> list = workOrderService.findList(page, limit,queryMap);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",workOrderService.count());
        return ResponseUtil.general_response(list,map);
    }

    // 新建
    @PostMapping("/workOrders")
    public Object insertWorkOrder(@RequestBody WorkOrderDto workOrderDto) {

        List<Order> orderList = workOrderDto.getOrderList();
        orderList.forEach(System.out::println);
        for (Order order : orderList) {
            order.setOrderUuid(UuidUtil.getUuid());
        }
        workOrderDto.setOrderList(orderList);
        System.out.println(workOrderDto);
        int i = workOrderService.insertBatch(workOrderDto);
        return ResponseUtil.general_response(i);
    }

    // 更改
    @PutMapping("/workOrders")
    public Object updateWorkOrder(@RequestBody WorkOrder workOrder) {
        System.out.println(workOrder);
        workOrderService.updateById(workOrder);
        return ResponseUtil.general_response("success update department!");
    }

    // 删除
    @DeleteMapping("/workOrders/{id}")
    public Object deleteWorkOrder(@PathVariable("id") Integer id) {
        workOrderService.removeById(id);
        return ResponseUtil.general_response("success delete department!");
    }

}

