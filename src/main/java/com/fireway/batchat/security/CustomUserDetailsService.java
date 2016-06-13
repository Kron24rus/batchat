package com.fireway.batchat.security;

import com.fireway.batchat.entity.Role;
import com.fireway.batchat.repository.RoleRepository;
import com.fireway.batchat.entity.User;
import com.fireway.batchat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by kron on 13.06.16.
 */
@Service("customUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Autowired
    public CustomUserDetailsService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUserName(username);
        if (null == user) {
            throw new UsernameNotFoundException("No user present with username: " + username);
        } else {
            User u = userRepository.findRoleByUserName(username);
            List<Role> userRoles = u.getRoles();
            List<String> stringRoles = new LinkedList<String>();
            for (Role r : userRoles) {
                stringRoles.add(r.getRole());
            }
            return new CustomUserDetails(user, stringRoles);
        }
    }
}
