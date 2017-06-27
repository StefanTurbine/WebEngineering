package rest;

import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Stefan on 19.06.2017.
 */
@Path("/shoutbox")
public class Shoutbox {

    public static List<ShoutEntry> shoutEntries = new ArrayList<>();


    @GET
    public String getMessages() {
        System.out.println(shoutEntries);
        return new Gson().toJson(shoutEntries);
    }


    @PUT
    public String addMessage(@QueryParam("message") String message, @QueryParam("author") String author) {
        Map<String, String> response = new HashMap<>();
        boolean success = false;
        if (message != null && !message.isEmpty()
                && author != null && !author.isEmpty()) {
            ShoutEntry entry = new ShoutEntry();
            entry.setAuthor(author);
            entry.setMessage(message);
            shoutEntries.add(entry);
            success = true;
            response.put("message", "entry added successfully");

        } else {
            response.put("message", "param is missing");
        }
        response.put("success", success + "");
        return new Gson().toJson(response);
    }

}
