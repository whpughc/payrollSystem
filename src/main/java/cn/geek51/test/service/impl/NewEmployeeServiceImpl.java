package cn.geek51.test.service.impl;

import cn.geek51.test.entity.Depart;
import cn.geek51.test.entity.NewEmployee;
import cn.geek51.test.mapper.NewEmployeeMapper;
import cn.geek51.test.service.NewEmployeeService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
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
    public List<NewEmployee> findList(Integer page, Integer limit, Map queryMap) {

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

        IPage<NewEmployee> result = newEmployeeMapper.selectPage(newEmployeeIPage, queryWrapper);

        List<NewEmployee> newEmployeeList = result.getRecords();

        return newEmployeeList;
    }
}
