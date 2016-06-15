package com.fireway.batchat.entity.chat;

/**
 * @author Vladimir Kuriy
 */
public class MessageEntity {
    private String username;
    private String roomname;
    private String content;

    public MessageEntity(String username, String roomname, String content){
        this.username = username;
        this.roomname = roomname;
        this.content = content;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRoomname() {
        return roomname;
    }

    public void setRoomname(String roomname) {
        this.roomname = roomname;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}