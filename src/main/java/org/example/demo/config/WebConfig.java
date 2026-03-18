package org.example.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        // ADMIN
        registry.addInterceptor(new AdminInterceptor())
                .addPathPatterns("/admin/**")
                .excludePathPatterns(
                        "/admin/login",
                        "/css/**",
                        "/js/**",
                        "/images/**"
                );

        // USER
        registry.addInterceptor(new UserInterceptor())
                .addPathPatterns(
                        "/checkout",
                        "/cart",
                        "/products",
                        "/order",
                        "/checkout/submit"
                )
                .excludePathPatterns(
                        "/login",
                        "/register",
                        "/css/**",
                        "/js/**",
                        "/images/**"
                );
    }
}