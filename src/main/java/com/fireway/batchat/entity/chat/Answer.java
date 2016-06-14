package com.fireway.batchat.entity.chat;

/**
 * Created by vladimercury on 6/13/16.
 */
public class Answer {
    private String author;
    private String content;

    public Answer(){

    }

    public Answer(String author, String content){
        this.author = author;
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}