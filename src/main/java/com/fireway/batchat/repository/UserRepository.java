package com.fireway.batchat.repository;

import com.fireway.batchat.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Alexander Mikheev
 */
@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    public User findByUserId(Long userId);
    public User findByUserName(String username);
    public User findRoleByUserName(String username);
    public User findUserInfoByUserName(String username);
}
