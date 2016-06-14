package com.fireway.batchat.entity.chat;

/**
 * Created by vladimercury on 6/14/16.
 */
public class History {
    private String[] authors;
    private String[] contents;

    public History(String[] authors, String[] contents){
        this.authors = authors;
        this.contents = contents;
    }

    public String[] getContents() {
        return contents;
    }

    public void setContents(String[] contents) {
        this.contents = contents;
    }

    public String[] getAuthors() {
        return authors;
    }

    public void setAuthors(String[] authors) {
        this.authors = authors;
    }
}
