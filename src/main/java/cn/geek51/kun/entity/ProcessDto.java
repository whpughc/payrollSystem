package cn.geek51.kun.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * @description:
 * @author: kun
 * @create: 2020-07-16 16:25
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ProcessDto implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 工序标识
     */
    private String processUuid;

    /**
     * 工序序号
     */
    private Integer processNumber;

    /**
     * 工序名称
     */
    private String processName;

    /**
     * 工序价格
     */
    private Double price;
}
