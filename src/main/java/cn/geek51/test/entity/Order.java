package cn.geek51.test.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * @description:
 * @author: kun
 * @create: 2020-07-23 16:40
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 计件单标识
     */
    private String orderUuid;

    /**
     * 工序序号
     */
    private Integer processNumber;

    /**
     * 员工工号
     */
    private String employeeNumber;

    /**
     * 金额
     */
    private Double money;

}
