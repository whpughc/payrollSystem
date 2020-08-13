package cn.geek51.test.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @description:
 * @author: kun
 * @create: 2020-08-12 13:13
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ProductSalary implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 产品标识
     */
    private String productUuid;

    /**
     * 产品名称
     */
    private String name;

    /**
     * 产品型号
     */
    private String productNumber;

    /**
     * 计件总数
     */
    private Integer totalNumber;

    /**
     * 计件总额
     */
    private Double totalMoney;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private LocalDateTime createAt;
}
