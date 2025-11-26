package vn.web.courseShop.service.validator;

import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import vn.web.courseShop.service.AccountService;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final AccountService accountService;

    public CustomUserDetailsService (AccountService accountService){
        this.accountService = accountService;
    }
    
        @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        vn.web.courseShop.domain.Account account = this.accountService.handleGetAccountByEmail(username);
        if(account == null){
            throw new UsernameNotFoundException("Account not found: ");
        }
         return new User( 
                account.getEmail(), 
                account.getPassword(), 
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + account.getRole().getName()))); 
    }
}
