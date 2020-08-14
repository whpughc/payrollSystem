package cn.geek51;

import cn.geek51.util.interceptor.LoginInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

@SpringBootApplication
public class Application extends WebMvcConfigurationSupport {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/**").excludePathPatterns(
                "/static/**", "/register", "/login/**", "/**.html", "/**.ico", "/auths/login"
        );

    }
    @Bean
    public LoginInterceptor loginInterceptor() {
        return new LoginInterceptor();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**", "/favicon.ico").addResourceLocations("classpath:/static/");
        super.addResourceHandlers(registry);
    }


}
