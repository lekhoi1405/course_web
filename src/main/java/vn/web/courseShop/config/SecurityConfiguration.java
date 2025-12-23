package vn.web.courseShop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import jakarta.servlet.DispatcherType;
import vn.web.courseShop.service.AccountService;
import vn.web.courseShop.service.validator.CustomUserDetailsService;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
    
    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
        public UserDetailsService userDetailsService(AccountService accountService) { 
        return new CustomUserDetailsService(accountService); 
    } 

    @Bean 
    public DaoAuthenticationProvider authProvider( 
            PasswordEncoder passwordEncoder, 
            UserDetailsService userDetailsService) { 
 
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider(userDetailsService); 
        authProvider.setPasswordEncoder(passwordEncoder); 
 
        return authProvider; 
    } 

    @Bean
    public AuthenticationSuccessHandler customSuccessHandler(AccountService accountService) {
        return new CustomSuccessHandler(accountService);
    }

    @Bean 
    public SpringSessionRememberMeServices rememberMeServices() { 
        SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices(); 
        rememberMeServices.setAlwaysRemember(false); 
        return rememberMeServices; 
    } 

    @Bean 
    SecurityFilterChain filterChain(HttpSecurity http,AccountService accountService) throws Exception { 

        http    
                .authorizeHttpRequests(authorize -> authorize
                    .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE) 
                    .permitAll()  

                    .requestMatchers("/","/login","/error/**","/explore/**","/course/**",
                     "/css/**", "/js/**", "/images/**","/register").permitAll()

                    .requestMatchers("/admin/**").hasRole("Admin")

                    .anyRequest().authenticated()) 
 
                .formLogin(formLogin -> formLogin 
                    .loginPage("/login") 
                    .failureUrl("/login?error")
                    .successHandler(customSuccessHandler(accountService)) 
                    .permitAll())
                .exceptionHandling(ex->ex.accessDeniedPage("/access-denied"))

                .sessionManagement((sessionManagement) -> sessionManagement 
                    .sessionCreationPolicy(SessionCreationPolicy.ALWAYS) 
                    .invalidSessionUrl("/login?expired=session_expired") 
                    .maximumSessions(1) 
                    .expiredUrl("/login?expired=account_in_use")
                    .maxSessionsPreventsLogin(false)) 
                    
                    .logout(logout -> logout.deleteCookies("JSESSIONID").invalidateHttpSession(true))

                .rememberMe(rememberMe -> rememberMe.rememberMeServices(rememberMeServices()));
                
        return http.build(); 
    } 
}
