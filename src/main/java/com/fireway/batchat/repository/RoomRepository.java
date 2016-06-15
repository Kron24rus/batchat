package com.fireway.batchat.repository;

import com.fireway.batchat.entity.Room;
import com.fireway.batchat.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Alexander Mikheev
 */
@Repository
public interface RoomRepository extends CrudRepository<Room, Long> {
    public List<Room> findByUser(User user);
    public Room findByRoomName(String roomname);
}
