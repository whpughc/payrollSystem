package cn.geek51.kun.service;

import cn.geek51.kun.entity.Depart;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author kun
 * @since 2020-07-02
 */
public interface DepartService extends IService<Depart> {
    List<Depart> findList(Integer page, Integer limit);
}
