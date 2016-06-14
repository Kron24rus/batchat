package com.fireway.batchat.repository;

import com.fireway.batchat.entity.UserInfo;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by kron on 13.06.16.
 */
@Repository
public interface UserInfoRepository extends CrudRepository<UserInfo, Long> {
    public UserInfo findByUserId(Long userId);
}
