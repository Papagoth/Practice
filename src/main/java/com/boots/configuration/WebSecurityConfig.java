package com.boots.configuration;

import com.boots.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserService userService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/", "/registration").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .permitAll()
                .defaultSuccessUrl("/main")//глобальная константа!
                .and()
                .logout()
                .permitAll()
                .permitAll()
                .logoutSuccessUrl("/");
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService)
                .passwordEncoder(NoOpPasswordEncoder.getInstance());
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.css", "/resources/image/plus.png", "/resources/image/recycle.png", "/resources/image/disc.png", "/resources/image/back.png", "/resources/image/image_1.png", "/resources/css/style.css", "https://code.jquery.com/jquery-3.6.0.js", "https://code.jquery.com/ui/1.13.2/jquery-ui.js", "https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js", "https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.js", "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css", "/**/*.css");
    }
}
