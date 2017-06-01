package model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Stefan on 30.05.2017.
 */
public class MessageHolder {
    List<MessageBean> items = new ArrayList<>();

    public List<MessageBean> getItems() {
        return items;
    }

    public void setItems(List<MessageBean> items) {
        this.items = items;
    }

}
