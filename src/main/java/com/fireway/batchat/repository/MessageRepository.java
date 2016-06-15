package com.fireway.batchat.repository;

import com.fireway.batchat.entity.Message;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * @author Alexander Mikheev
 */
@Repository
public interface MessageRepository extends CrudRepository<Message, Long> {
}
