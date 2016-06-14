package com.fireway.batchat.controller;

import com.fireway.batchat.entity.chat.Answer;
import com.fireway.batchat.entity.chat.History;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kron on 14.06.16.
 */
@Controller
public class AnswerController {

    private static List<Answer> history = new ArrayList<Answer>();
    private static String tagScreening(String str){
        str = str.replace("&", "&amp;");
        str = str.replace("<", "&lt;");
        str = str.replace(">", "&gt");
        return str;
    }

    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Answer answer(com.fireway.batchat.entity.chat.Message message, SimpMessageHeaderAccessor simpMessageHeaderAccessor) throws Exception{
        Answer ans = new Answer(simpMessageHeaderAccessor.getSessionId(), tagScreening(message.getContent()));
        history.add(ans);
        return ans;
    }

    @MessageMapping("/history")
    @SendTo("/topic/history")
    public History getHistory() throws Exception{
        String[] authors = new String[history.size()];
        String[] messages = new String[history.size()];
        int index = 0;
        for (Answer answer : history) {
            authors[index] = answer.getAuthor();
            messages[index] = answer.getContent();
            index++;
        }
        return new History(authors, messages);
    }

}
