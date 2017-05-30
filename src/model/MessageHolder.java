package model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Stefan on 30.05.2017.
 */
public class MessageHolder {
    List<Message> items = new ArrayList<>();

    public List<Message> getItems() {
        return items;
    }

    public void setItems(List<Message> items) {
        this.items = items;
    }

}
