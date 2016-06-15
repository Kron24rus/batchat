package com.fireway.batchat.controller.scheduleds;

import com.fireway.batchat.controller.AnswerController;
import com.fireway.batchat.entity.Message;
import com.fireway.batchat.entity.Room;
import com.fireway.batchat.entity.User;
import com.fireway.batchat.entity.chat.MessageEntity;
import com.fireway.batchat.repository.MessageRepository;
import com.fireway.batchat.repository.RoomRepository;
import com.fireway.batchat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by kron on 15.06.16.
 */
@Component
public class ScheduledMessageSave {

    @Autowired
    MessageRepository messageRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    RoomRepository roomRepository;

    @PostConstruct
    public void init() {
        List<Message> messages = (List<Message>) messageRepository.findAll();
        List<MessageEntity> preparedMessages = new ArrayList<>();
        for (Message m : messages) {
            preparedMessages.add(new MessageEntity(m.getUser().getUserName(),
                    m.getRoom().getRoomName(), m.getContent()));
        }
        AnswerController.entityListToHistory(preparedMessages);
    }

    @Scheduled(fixedRate = 300000)
    public void saveMessagesAndRefresh() {
        List<MessageEntity> messages = AnswerController.getMessageEntityList();
        if (messages.size() > 0) {
            AnswerController.setMessageEntityList(new ArrayList<MessageEntity>());
         //   System.out.println("Container refreshed");
            User user;
            Room room;
            Message preparedMessage;
            for (MessageEntity message : messages) {
                preparedMessage = new Message();
                user = userRepository.findByUserName(message.getUsername());
                room = roomRepository.findByRoomName(message.getRoomname());
                preparedMessage.setUser(user);
                preparedMessage.setRoom(room);
                preparedMessage.setContent(message.getContent());
                messageRepository.save(preparedMessage);
            }
        }
    }

    @PreDestroy
    public void saveAll() {
        saveMessagesAndRefresh();
    }
}
