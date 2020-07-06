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
 * @since 2020-07-06
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 自增主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 产品唯一标识
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
     * 季节:1：春；2：夏；3：秋；4：冬
     */
    private Integer season;

    /**
     * 描述
     */
    private String remark;

    /**
     * 状态：0：无效；1：有效
     */
    private Boolean status;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private LocalDateTime createAt;

    /**
     * 删除
     */
    @TableLogic
    @TableField(select = false)
    private Integer deleted;


}
