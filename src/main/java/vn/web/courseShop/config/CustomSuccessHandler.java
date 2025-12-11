package vn.web.courseShop.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.web.courseShop.domain.Account;
import vn.web.courseShop.service.AccountService;

public class CustomSuccessHandler implements AuthenticationSuccessHandler{
    private final AccountService accountService;
    private RequestCache requestCache = new HttpSessionRequestCache();
    
    public CustomSuccessHandler(AccountService accountService){
        this.accountService = accountService;
    }

    protected String determineTargetUrl(final Authentication authentication) {

    Map<String, String> roleTargetUrlMap = new HashMap<>();
    roleTargetUrlMap.put("ROLE_User", "/");
    roleTargetUrlMap.put("ROLE_Admin", "/");

    final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
    for (final GrantedAuthority grantedAuthority : authorities) {
        String authorityName = grantedAuthority.getAuthority();
        if(roleTargetUrlMap.containsKey(authorityName)) {
            return roleTargetUrlMap.get(authorityName);
        }
    }

        throw new IllegalStateException();
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request,Authentication authentication) {
        HttpSession session = request.getSession(false);
        if(session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        String email = authentication.getName();
        Account account = accountService.handleGetAccountByEmail(email);
        if(account != null){
            session.setAttribute("fullName", account.getFullname());
            session.setAttribute("email", account.getEmail());
        }

    }

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {
        if (response.isCommitted()) {
            return;
        }

        clearAuthenticationAttributes(request, authentication);
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        if (savedRequest != null) {
            // TRƯỜNG HỢP A: Có trang cũ -> Redirect về trang đó
            String targetUrl = savedRequest.getRedirectUrl();
            redirectStrategy.sendRedirect(request, response, targetUrl);
        } else {
            // TRƯỜNG HỢP B: Không có trang cũ (User bấm Login chủ động) -> Dùng logic Role
            String targetUrl = determineTargetUrl(authentication);
            redirectStrategy.sendRedirect(request, response, targetUrl);
        }
    }
}
