package com.fireway.batchat.repository;

import com.fireway.batchat.entity.Message;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by kron on 15.06.16.
 */
@Repository
public interface MessageRepository extends CrudRepository<Message, Long> {
}
