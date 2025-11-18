package vn.web.courseShop.service;

import vn.web.courseShop.domain.Account;
import vn.web.courseShop.repository.AccountRepository;

public class AccountService {
    private final AccountRepository accountRepository;

    AccountService(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }  

    public Account handleSaveAccount(Account account) {
        return accountRepository.save(account);
    }
}
