package cn.geek51.test.service.impl;

import cn.geek51.test.entity.Depart;
import cn.geek51.test.mapper.DepartMapper;
import cn.geek51.test.service.DepartService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Wrapper;
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

        IPage<Depart> result = departMapper.selectPage(departIPage, null);

        List<Depart> departList = result.getRecords();

        return departList;

    }

}
