package com.fireway.batchat.repository;

import com.fireway.batchat.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by kron on 13.06.16.
 */
@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    public User findByUserName(String username);
    public User findRoleByUserName(String username);
    public User findUserInfoByUserName(String username);
}
