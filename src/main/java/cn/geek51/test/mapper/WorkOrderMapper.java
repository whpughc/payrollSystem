package cn.geek51.test.mapper;

import cn.geek51.test.entity.EmployeeSalary;
import cn.geek51.test.entity.WorkOrder;
import cn.geek51.test.entity.WorkOrderDto;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author kun
 * @since 2020-07-22
 */
public interface WorkOrderMapper extends BaseMapper<WorkOrder> {

    int insertBatch(WorkOrderDto workOrderDto);

    List<EmployeeSalary> employeeSalaryList();
}
