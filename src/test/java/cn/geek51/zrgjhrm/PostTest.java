package cn.geek51.zrgjhrm;

import cn.geek51.dao.PostDao;
import cn.geek51.domain.Post;
import cn.geek51.service.IPostService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class PostTest extends BaseApplicationTest {
    @Autowired
    IPostService service;
    @Test
    public void postDaoTest() {
       // List<Post> list = dao.selectAll();
        //System.out.println(list);
        LocalDateTime localDateTime = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String format = dateTimeFormatter.format(localDateTime);
        System.out.println(localDateTime);
        System.out.println(format);
    }

    @Test
    public void postServiceTest() {
        Post post = service.listOneById(1);
        System.out.println(post);
    }
}
