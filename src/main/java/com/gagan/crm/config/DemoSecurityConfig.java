package com.gagan.crm.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;

@EnableWebSecurity
public class DemoSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private DataSource securityDataSource;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.jdbcAuthentication().dataSource(securityDataSource);
	}

	@Configuration
	@Order(2)
	static public class PageWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.antMatcher("/**")
					.authorizeRequests()
					.antMatchers("/customer/showForm/**").hasAnyRole("MANAGER", "ADMIN")
					.antMatchers("/customer/save/**").hasAnyRole("MANAGER", "ADMIN")
					.antMatchers("/customer/delete/**").hasRole("ADMIN")
					.antMatchers("/customer/**").hasRole("EMPLOYEE")
					.antMatchers("/resources/**").permitAll()
					.and()
					.formLogin()
					.loginPage("/showMyLoginPage")
					.loginProcessingUrl("/authenticateTheUser")
					.permitAll()
					.and()
					.logout().permitAll()
					.and()
					.exceptionHandling().accessDeniedPage("/access-denied");
		}
	}

//	@Configuration
//	@Order(1)
//	public static class ApiWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
//		@Override
//		protected void configure(HttpSecurity http) throws Exception {
//
//			http.antMatcher("/api/**")
//					.csrf().disable()
//					.authorizeRequests()
//					.antMatchers(HttpMethod.GET, "/api/customers").hasRole("EMPLOYEE")
//					.antMatchers(HttpMethod.GET, "/api/customers/**").hasRole("EMPLOYEE")
//					.antMatchers(HttpMethod.POST, "/api/customers").hasAnyRole("MANAGER", "ADMIN")
//					.antMatchers(HttpMethod.POST, "/api/customers/**").hasAnyRole("MANAGER", "ADMIN")
//					.antMatchers(HttpMethod.PUT, "/api/customers").hasAnyRole("MANAGER", "ADMIN")
//					.antMatchers(HttpMethod.PUT, "/api/customers/**").hasAnyRole("MANAGER", "ADMIN")
//					.antMatchers(HttpMethod.DELETE, "/api/customers/**").hasRole("ADMIN")
//					.and()
//					.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
//		}
//	}

	@Bean
	public UserDetailsManager userDetailsManager() {

		JdbcUserDetailsManager jdbcUserDetailsManager = new JdbcUserDetailsManager();

		jdbcUserDetailsManager.setDataSource(securityDataSource);

		return jdbcUserDetailsManager;
	}

}






