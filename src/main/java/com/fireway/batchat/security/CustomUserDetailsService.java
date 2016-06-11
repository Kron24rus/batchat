package com.fireway.batchat.security;

import com.fireway.batchat.domain.User;
import com.fireway.batchat.domain.UserRepository;
import com.fireway.batchat.domain.UserRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kron on 11.06.16.
 */
@Service("customUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final UserRoleRepository userRoleRepository;

    @Autowired
    public CustomUserDetailsService(UserRepository userRepository, UserRoleRepository userRoleRepository) {
        this.userRepository = userRepository;
        this.userRoleRepository = userRoleRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUserName(username);
        if (null == user) {
            throw new UsernameNotFoundException("No user present ith username: " + username);
        } else {
            List<String> userRoles = userRoleRepository.findRoleByUserName(username);
            return new CustomUserDetails(user, userRoles);
        }
    }
}
