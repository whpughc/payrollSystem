package cn.geek51.kun.mapper;

import cn.geek51.kun.entity.EmployeeSalary;
import cn.geek51.kun.entity.Process;
import cn.geek51.kun.entity.ProductSalary;
import cn.geek51.kun.entity.WorkOrder;
import cn.geek51.kun.entity.WorkOrderDto;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

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

    List<EmployeeSalary> employeeSalaryList(Map<String,Object> map);

    List<ProductSalary> productSalaryList(Map<String,Object> map);

    int updateMoney(@Param("departUuid") String departUuid,@Param("productUuid") String productUuid,@Param("processNumber") Integer processNumber,@Param("price") Double price);
}
