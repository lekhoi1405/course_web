package vn.web.courseShop.service;

import org.springframework.stereotype.Service;

import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.Role;
import vn.web.courseShop.domain.dto.RegisterDTO;
import vn.web.courseShop.repository.AccountRepository;
import vn.web.courseShop.repository.RoleRepository;

@Service
public class AccountService {
    private final AccountRepository accountRepository;
    private final RoleRepository roleRepository;
    AccountService(AccountRepository accountRepository,RoleRepository roleRepository) {
        this.accountRepository = accountRepository;
        this.roleRepository = roleRepository;
    }  

    public Account registerDTOToAccount(RegisterDTO dto){
        Account account = new Account();
        account.setFullname(dto.getFullname());
        account.setPassword(dto.getPassword());
        account.setEmail(dto.getEmail());
        return account;
    }

    public Account handleSaveAccount(Account account) {
        return accountRepository.save(account);
    }

    public Account handleGetAccountByEmail(String email){
        return accountRepository.findByEmail(email);
    }

    public Role handleGetRoleByName(String name){
        return roleRepository.findByName(name);
    }

    public boolean checkEmailExists(String mail){
        return accountRepository.existsByEmail(mail);
    }
}
