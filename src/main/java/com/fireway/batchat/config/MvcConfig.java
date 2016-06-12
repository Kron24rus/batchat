package com.fireway.batchat.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan(basePackages = {"com.fireway.batchat.mvc"})
public class MvcConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("login");
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/403").setViewName("403");
        registry.addViewController("/roomlist").setViewName("roomlist");
        registry.addViewController("/myroomlist").setViewName("roomlist");
        registry.addViewController("/createroom").setViewName("createroom");
        registry.addViewController("/modifyroom").setViewName("createroom");
        registry.addViewController("/createuser").setViewName("createuser");
        registry.addViewController("/modcurrentuser").setViewName("createuser");
        registry.addViewController("/modifyuser").setViewName("modifyuser");
        registry.addViewController("/userinfo").setViewName("userinfo");
        registry.addViewController("/roomchat").setViewName("roomchat");
    }

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
    }
}
