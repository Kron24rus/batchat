package com.fireway.batchat.domain;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by kron on 11.06.16.
 */
@Repository
public interface UserRoleRepository extends CrudRepository<UserRole, Long> {
    @Query("select a.role from UserRole a, User b where b.userName=? and a.userId=b.userId")
    public List<String> findRoleByUserName(String username);
}
