package cn.geek51.domain;


import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author kun
 * @since 2020-07-02
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Depart implements Serializable {

    private static final long serialVersionUID=1L;


      private Integer id;

      /**
     * 部门标识
     */
      private String departUuid;

      /**
     * 部门名称
     */
      private String departName;

      /**
     * 部门经理
     */
      private String departManager;

      /**
     * 部门电话
     */
      private String phone;

      /**
     * 部门描述
     */
      private String remark;

      /**
     * 状态：0：无效 1：有效
     */
      private Integer status;

      /**
     * 创建时间
     */
      private LocalDateTime createAt;

      /**
     * 删除时间
     */
      private LocalDateTime deleteAt;


}
