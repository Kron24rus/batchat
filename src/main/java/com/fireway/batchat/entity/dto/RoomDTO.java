package com.fireway.batchat.entity.dto;

import com.fireway.batchat.entity.User;

import java.util.List;

/**
 * Created by kron on 14.06.16.
 */
public class RoomDTO {

    private String roomName;
    private boolean access;
    private List<Long> privateUsers;
    private String userName;

    public RoomDTO() {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public List<Long> getPrivateUsers() {
        return privateUsers;
    }

    public void setPrivateUsers(List<Long> privateUsers) {
        this.privateUsers = privateUsers;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public boolean isAccess() {
        return access;
    }

    public void setAccess(boolean access) {
        this.access = access;
    }

    @Override
    public String toString() {
        return "RoomDTO{" +
                "roomName='" + roomName + '\'' +
                ", access=" + access +
                ", privateUsers=" + privateUsers +
                ", userName='" + userName + '\'' +
                '}';
    }
}
