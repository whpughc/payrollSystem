package cn.geek51.config;

import cn.geek51.Application;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/**
 * @description:
 * @author: kun
 * @create: 2020-08-14 09:35
 **/
public class ServletInitializer extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        //此处的Application.class为带有@SpringBootApplication注解的启动类
        return builder.sources(Application.class);
    }

}