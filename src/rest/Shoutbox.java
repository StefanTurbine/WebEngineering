package rest;

import com.google.gson.Gson;
import jdk.nashorn.internal.ir.debug.JSONWriter;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
import java.util.List;

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
        String response;
        if (message != null && !message.isEmpty()
                && author != null && !author.isEmpty()){
            ShoutEntry entry = new ShoutEntry();
            entry.setAuthor(author);
            entry.setMessage(message);
            shoutEntries.add(entry);
            response = "entry created successfully";
        } else {
            response = "param is missing";
        }
        return new Gson().toJson(response);
    }

}
