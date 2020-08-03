package cn.geek51.test.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * @description: 员工工资对象
 * @author: kun
 * @create: 2020-08-03 15:28
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class EmployeeSalary implements Serializable {

    private static final long serialVersionUID=1L;

    /*
    员工工号
    * */
    private String employeeNumber;

    /**
     * 姓名
     */
    private String employeeName;

    /**
     * 部门名称
     */
    private String departName;

    /**
     * 总工资
     */
    private Double wage;
}
