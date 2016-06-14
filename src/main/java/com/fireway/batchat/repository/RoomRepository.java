package com.fireway.batchat.repository;

import com.fireway.batchat.entity.Room;
import com.fireway.batchat.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by kron on 14.06.16.
 */
@Repository
public interface RoomRepository extends CrudRepository<Room, Long> {
    public List<Room> findByUser(User user);
}
