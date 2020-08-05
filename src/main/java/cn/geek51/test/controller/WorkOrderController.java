package cn.geek51.test.controller;


import cn.geek51.test.entity.*;
import cn.geek51.test.entity.Process;
import cn.geek51.test.mapper.NewEmployeeMapper;
import cn.geek51.test.mapper.ProcessMapper;
import cn.geek51.test.service.WorkOrderService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UuidUtil;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
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

    @Autowired(required = false)
    private ProcessMapper processMapper;

    @Autowired
    private WorkOrderService workOrderService;

    @Autowired(required = false)
    private NewEmployeeMapper newEmployeeMapper;

    //查询
    @GetMapping("/workOrders")
    public Object list(Integer page,Integer limit,String query) throws Exception {

        HashMap queryMap = new HashMap();
        // 进行拼接, 拼接成一个MAP查询
        if (query != null) {
            queryMap = new ObjectMapper().readValue(query, HashMap.class);
        }

        IPage<WorkOrder> result = workOrderService.findList(page, limit, queryMap);
        List<WorkOrder> workOrderList = result.getRecords();
        long total = result.getTotal();
        HashMap<Object, Object> map = new HashMap<>();
        map.put("size",total);
        return ResponseUtil.general_response(workOrderList,map);
    }

    // 新建
    @PostMapping("/workOrders")
    public Object insertWorkOrder(HttpServletRequest request,@RequestBody WorkOrderDto workOrderDto) {
        request.getSession().setAttribute("departUuid",workOrderDto.getDepartUuid());
        request.getSession().setAttribute("productUuid",workOrderDto.getProductUuid());

        List<Order> orderList = workOrderDto.getOrderList();
        orderList.forEach(System.out::println);
        //设置Uuid和金额
        for (Order order : orderList) {
            QueryWrapper<NewEmployee> queryWrapper = new QueryWrapper<>();
            queryWrapper.like("employee_number",order.getEmployeeNumber());
            NewEmployee newEmployee = newEmployeeMapper.selectOne(queryWrapper);
            if (newEmployee ==null){
                return ResponseUtil.general_response(400,"员工不存在，无法添加");
            }
            Process process = processMapper.findProcess(workOrderDto.getDepartUuid(), workOrderDto.getProductUuid(), order.getProcessNumber());
            if (process==null){
                return ResponseUtil.general_response(400,"工序不存在，无法添加");
            }
            double money = workOrderDto.getNumber() * process.getPrice();
            order.setMoney(money);
            order.setOrderUuid(UuidUtil.getUuid());
        }
        /*workOrderDto.setOrderList(orderList);
        System.out.println(workOrderDto);*/
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

