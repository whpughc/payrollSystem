package cn.geek51.kun.service.impl;

import cn.geek51.kun.entity.Depart;
import cn.geek51.kun.mapper.DepartMapper;
import cn.geek51.kun.service.DepartService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author kun
 * @since 2020-07-02
 */
@Service
public class DepartServiceImpl extends ServiceImpl<DepartMapper, Depart> implements DepartService {
   
    @Autowired
    private DepartMapper departMapper;

    @Override
    public List<Depart> findList(Integer page, Integer limit) {

        IPage<Depart> departIPage = new Page<>(page,limit);

        QueryWrapper<Depart> queryWrapper = new QueryWrapper<>();

        queryWrapper.orderByDesc("create_at");

        IPage<Depart> result = departMapper.selectPage(departIPage, null);

        List<Depart> departList = result.getRecords();

        return departList;

    }

}
