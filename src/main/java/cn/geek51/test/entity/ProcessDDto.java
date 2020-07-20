package cn.geek51.test.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

/**
 * @description:
 * @author: kun
 * @create: 2020-07-16 20:59
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ProcessDDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private String departId;
    private String productId;
    private List<ProcessDto> processDtoList;
}
