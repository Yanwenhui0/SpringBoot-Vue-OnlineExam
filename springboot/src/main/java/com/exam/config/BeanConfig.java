package com.exam.config;

import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.impl.DefaultMapperFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

/**
 * @Author yanwenhui
 * @Date 2019/12/5 16:12
 **/
@Configuration
public class BeanConfig {

    /**
     * MapperFacade用于类与类之间转化
     * @return
     */
    @Bean
    public MapperFacade mapperFacade() {
        return new DefaultMapperFactory.Builder().build().getMapperFacade();
    }

    /**
     * RestTemplate用于发送http请求
     * @return
     */
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }


}
