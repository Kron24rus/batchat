package com.fireway.batchat.controller;

import com.fireway.batchat.entity.chat.Answer;
import com.fireway.batchat.entity.chat.History;
import com.fireway.batchat.entity.chat.MessageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Alexander Mikheev
 */
@Controller
public class AnswerController {
    private static Map<String, List<Answer>> history = new HashMap<>();
    private static List<MessageEntity> messageEntityList = new ArrayList<>();
    private SimpMessageSendingOperations messageSendingOperations;

    @Autowired
    public AnswerController(SimpMessageSendingOperations messageSendingOperations){
        this.messageSendingOperations = messageSendingOperations;
    }

    public static List<MessageEntity> getMessageEntityList() {
        return messageEntityList;
    }

    public static void setMessageEntityList(List<MessageEntity> messageEntityList) {
        AnswerController.messageEntityList = messageEntityList;
    }

    private static String tagScreening(String str){
        str = str.replace("&", "&amp;");
        str = str.replace("<", "&lt;");
        str = str.replace(">", "&gt");
        return str;
    }

    public static void entityListToHistory(List<MessageEntity> entityList){
        for (MessageEntity entity : entityList){
            if (!history.containsKey(entity.getRoomname())){
                history.put(entity.getRoomname(), new ArrayList<Answer>());
            }
            history.get(entity.getRoomname()).add(new Answer(entity.getUsername(), entity.getContent()));
        }
    }

    @MessageMapping("/hello/{roomId}")
    public void answer(@DestinationVariable String roomId, Answer message) throws Exception{
        Answer ans = new Answer(message.getAuthor(), tagScreening(message.getContent()));
        if (!history.containsKey(roomId)){
            history.put(roomId, new ArrayList<Answer>());
        }
        history.get(roomId).add(ans);
        messageEntityList.add(new MessageEntity(ans.getAuthor(), roomId, ans.getContent()));
        messageSendingOperations.convertAndSend("/topic/greetings/" + roomId, ans);
    }


    @MessageMapping("/history/{roomId}")
    public void getHistory(@DestinationVariable String roomId) throws Exception{
        if (!history.containsKey(roomId)){
            history.put(roomId, new ArrayList<Answer>());
        }
        List<Answer> thisChat = history.get(roomId);
        String[] authors = new String[thisChat.size()];
        String[] messages = new String[thisChat.size()];
        int index = 0;

        for (Answer answer : thisChat) {
            authors[index] = answer.getAuthor();
            messages[index] = answer.getContent();
            index++;
        }
        messageSendingOperations.convertAndSend("/topic/history/" + roomId, new History(authors, messages));
    }
}