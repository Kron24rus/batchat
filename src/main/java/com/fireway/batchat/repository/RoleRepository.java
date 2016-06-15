package com.fireway.batchat.repository;

import com.fireway.batchat.entity.Role;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * @author Alexander Mikheev
 */
@Repository
public interface RoleRepository extends CrudRepository<Role, Long> {
/*
    @Query(value = "select r.role from users u join user_roles ur on " +
            "u.user_id = ur.user_id join roles r on ur.role_id = r.role_id where u.username=?", nativeQuery = true)
    public String findRoleByUserName(String username);*/
    public Role findByRole(String role);
}
