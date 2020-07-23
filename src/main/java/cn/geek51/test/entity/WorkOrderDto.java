package cn.geek51.test.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

/**
 * @description: 计件单插入类
 * @author: kun
 * @create: 2020-07-22 16:09
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class WorkOrderDto extends WorkOrder implements Serializable {

    private List<Order> orderList;
}
