package cn.geek51.kun.service.impl;

import cn.geek51.kun.entity.Depart;
import cn.geek51.kun.entity.NewEmployee;
import cn.geek51.kun.mapper.NewEmployeeMapper;
import cn.geek51.kun.service.NewEmployeeService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author kun
 * @since 2020-07-04
 */
@Service
public class NewEmployeeServiceImpl extends ServiceImpl<NewEmployeeMapper, NewEmployee> implements NewEmployeeService {

    @Autowired
    private NewEmployeeMapper newEmployeeMapper;

    @Override
    public IPage<NewEmployee> findList(Integer page, Integer limit, Map queryMap) {

        IPage<NewEmployee> newEmployeeIPage = new Page<>(page,limit);

        QueryWrapper<NewEmployee> queryWrapper = new QueryWrapper<>();

        if (queryMap.get("qname")!=null){
            queryWrapper.like("employee_name",queryMap.get("qname"));
        }

        if (queryMap.get("qemployeeNumber")!=null){
            queryWrapper.like("employee_number",queryMap.get("qemployeeNumber"));
        }

        if (queryMap.get("qphone")!=null){
            queryWrapper.like("phone",queryMap.get("qphone"));
        }

        if (queryMap.get("qidcard")!=null){
            queryWrapper.like("id_card",queryMap.get("qidcard"));
        }

        if (queryMap.get("qdepartUuid") != null){
            queryWrapper.eq("depart_uuid",queryMap.get("qdepartUuid"));
        }

        queryWrapper.orderByDesc("create_at");

        IPage<NewEmployee> result = newEmployeeMapper.selectPage(newEmployeeIPage, queryWrapper);

        return result;
    }
}
