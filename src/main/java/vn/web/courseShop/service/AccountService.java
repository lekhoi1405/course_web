package vn.web.courseShop.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import vn.web.courseShop.domain.Account;
import vn.web.courseShop.domain.CartDetail;
import vn.web.courseShop.domain.Role;
import vn.web.courseShop.domain.dto.RegisterDTO;
import vn.web.courseShop.repository.AccountRepository;
import vn.web.courseShop.repository.CartDetailRepository;
import vn.web.courseShop.repository.EnrollmentRepository;
import vn.web.courseShop.repository.RoleRepository;

@Service
public class AccountService {

    private final EnrollmentRepository enrollmentRepository;
    private final AccountRepository accountRepository;
    private final RoleRepository roleRepository;
    private final CartDetailRepository cartDetailRepository;
    AccountService(AccountRepository accountRepository,RoleRepository roleRepository,CartDetailRepository cartDetailRepository, EnrollmentRepository enrollmentRepository) {
        this.accountRepository = accountRepository;
        this.roleRepository = roleRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.enrollmentRepository = enrollmentRepository;
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
    @Transactional(readOnly = true)
    public int countCartByAccount(HttpSession session){
        int count = 0;
        String email = (String)session.getAttribute("email");
        Account account = this.handleGetAccountByEmail(email);
        List<CartDetail> cartDetails = account.getCart().getCartDetails();
        if(cartDetails!=null){
        for (CartDetail cartDetail : cartDetails) {
                if(!this.enrollmentRepository.existsByAccountAndCourse(account, cartDetail.getCourse())){
                    count++;
                }
            } 
        }
        return count;
    }

}
