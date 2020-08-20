package cn.geek51.kun.service.impl;

import cn.geek51.kun.entity.Process;
import cn.geek51.kun.entity.ProcessDto;
import cn.geek51.kun.mapper.ProcessMapper;
import cn.geek51.kun.service.ProcessService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author kun
 * @since 2020-07-15
 */
@Service
public class ProcessServiceImpl extends ServiceImpl<ProcessMapper, Process> implements ProcessService {

    @Autowired(required = false)
    ProcessMapper processMapper;
    
    @Override
    public IPage<Process> findList(Integer page, Integer limit, HashMap queryMap) {

        IPage<Process> processIPage = new Page<>(page,limit);

        QueryWrapper<Process> queryWrapper = new QueryWrapper<>();

        if (queryMap.get("qprocessName") != null){
            queryWrapper.like("process_name",queryMap.get("qprocessName"));
        }

        if (queryMap.get("qdepartUuid") != null){
            queryWrapper.eq("depart_uuid",queryMap.get("qdepartUuid"));
        }

        if (queryMap.get("qproductUuid") != null){
            queryWrapper.eq("product_uuid",queryMap.get("qproductUuid"));
        }

        IPage<Process> result = processMapper.selectPage(processIPage, queryWrapper);
        return result;
    }

    @Override
    public int insertBatch(String departUuid, String productUuid, List<ProcessDto> processDtoList) {
        return processMapper.insertBatch(departUuid, productUuid, processDtoList);
    }
}
