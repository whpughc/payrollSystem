package cn.geek51.kun.controller;


import cn.geek51.kun.entity.*;
import cn.geek51.kun.entity.Process;
import cn.geek51.kun.mapper.NewEmployeeMapper;
import cn.geek51.kun.mapper.ProcessMapper;
import cn.geek51.kun.service.WorkOrderService;
import cn.geek51.util.ResponseUtil;
import cn.geek51.util.UuidUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

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
        List<Process> processList = processMapper.findProcessList(workOrderDto.getDepartUuid(), workOrderDto.getProductUuid());
        if (processList !=null && !processList.isEmpty()){
            if (orderList.size() != processList.size()){
                return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"工序未添加完整");
            }
        }else {
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"工序不存在，无法添加");
        }

        //设置Uuid和金额
        for (Order order : orderList) {
            QueryWrapper<NewEmployee> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("employee_number",order.getEmployeeNumber());
            NewEmployee newEmployee = newEmployeeMapper.selectOne(queryWrapper);
            if (newEmployee == null){
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

        int i = workOrderService.insertBatch(workOrderDto);
        return ResponseUtil.general_response(i);
    }

    // 更改
    @PutMapping("/workOrders")
    public Object updateWorkOrder(@RequestBody WorkOrder workOrder) {
        System.out.println(workOrder);
        boolean b = workOrderService.updateById(workOrder);
        if (b)
            return ResponseUtil.general_response("success update");
        else
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"更新失败");
    }

    // 删除
    @DeleteMapping("/workOrders/{id}")
    public Object deleteWorkOrder(@PathVariable("id") Integer id) {
        workOrderService.removeById(id);
        return ResponseUtil.general_response("success delete department!");
    }

    // 批量删除
    @DeleteMapping("/workOrders")
    public Object deleteWorkOrderBatch(@RequestBody JSONObject params) {
        JSONArray ids = params.getJSONArray("ids");
        List<String> idList = ids.toJavaList(String.class);
        boolean b = workOrderService.removeByIds(idList);
        if (b)
            return ResponseUtil.general_response("success delete department!");
        else
            return ResponseUtil.general_response(ResponseUtil.CODE_EXCEPTION,"删除失败");
    }
}

