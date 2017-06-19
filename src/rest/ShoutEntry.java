package rest;

import java.util.Date;

/**
 * Created by Stefan on 20.06.2017.
 */
public class ShoutEntry {

    String message;
    String author;
    Date date;

    public ShoutEntry(){
        this.date = new Date();
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
