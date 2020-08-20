package cn.geek51.zrgjhrm;

import cn.geek51.kun.entity.Depart;
import cn.geek51.kun.mapper.DepartMapper;
import cn.geek51.kun.service.DepartService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

/**
 * @description: 测试逻辑删除
 * @author: kun
 * @create: 2020-07-03 21:40
 **/
@SpringBootTest
@RunWith(SpringRunner.class)
public class DeleteTest {

    @Autowired
    private DepartService departService;

    @Autowired
    private DepartMapper departMapper;

    @Test
    public void test(){

        List<Depart> departList = departService.list();
        System.out.println(departList.size());


        int i = departMapper.deleteById(2);
        System.out.println(i);
        List<Depart> list = departService.list();
        System.out.println(list.size());
    }
}
