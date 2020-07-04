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
 * @since 2020-07-04
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class NewEmployee implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 员工唯一标识
     */
    private String employeeUuid;

    /**
     * 部门唯一标识
     */
    private String departUuid;

    private Integer departId;
    /**
     * 职位唯一标识
     */
    private Integer positionId;

    /**
     * 员工码
     */
    private String employeeNumber;

    /**
     * 姓名
     */
    private String employeeName;

    /**
     * 性别：0：男 1：女
     */
    private Integer sex;

    /**
     * 手机
     */
    private String phone;

    /**
     * 身份证号码
     */
    private String idCard;

    /**
     * 状态：0：无效 1：有效
     */
    private Integer status;

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
