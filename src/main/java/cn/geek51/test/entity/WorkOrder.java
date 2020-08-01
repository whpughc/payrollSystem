package cn.geek51.test.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author kun
 * @since 2020-07-22
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class WorkOrder implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 自增主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 计件单标识
     */
    private String orderUuid;

    /**
     * 计件单号
     */
    private String orderNumber;

    /**
     * 部门标识
     */
    private String departUuid;

    /**
     * 产品标识
     */
    private String productUuid;

    /**
     * 颜色
     */
    private String color;

    /**
     * 尺码名称
     */
    private String skuName;

    /**
     * 数量
     */
    private Integer number;

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

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private LocalDateTime createAt;

    /**
     * 逻辑删除
     */
    @TableLogic
    @TableField(select = false)
    private Integer deleted;


}
