package com.fireway.batchat.domain;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by kron on 11.06.16.
 */
@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    public User findByUserName(String username);
    public User findByUserId(Long userid);
    public User findBypassword(String password);
    public User findByEmail(String email);
}
