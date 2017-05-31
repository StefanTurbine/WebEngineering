package controller;

import model.Message;
import model.MessageHolder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Stefan on 30.05.2017.
 */
@WebServlet(name = "controller.Servlet")
public class Servlet extends HttpServlet {

    MessageHolder messages = new MessageHolder();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        System.out.println("Da passiert was!!! -->" + action);
        switch (action) {
            case "":
                renderIndexPage(request, response);
                break;
            case "/index":
                renderIndexPage(request, response);
                break;
            case "/kontakt":
                handleKontaktRequest(request, response);
                break;
            case "/detail":
                handleDetailRequest(request, response);
                break;
            default:
                //renderIndexPage(request, response);
                break;
        }
    }

    private void handleKontaktRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("handleKontaktRequest!");
        System.out.println(request.getParameterMap().keySet());
        Message message = null;

        try {
            // parsing the data!
            String fn = request.getParameter("firstname");
            String ln = request.getParameter("name");
            String mail = request.getParameter("email");
            String dateString = request.getParameter("date");
            Date date = null;
            if (dateString != null && !dateString.isEmpty()) {
                date = sdf.parse(dateString);
            }
            String cat = request.getParameter("category");
            String subject = request.getParameter("topic");
            String msg = request.getParameter("msg");

            if (fn != null && !fn.isEmpty() &&
                    ln != null && !ln.isEmpty() &&
                    mail != null && !mail.isEmpty() &&
                    date != null &&
                    cat != null && !cat.isEmpty() &&
                    subject != null && !subject.isEmpty() &&
                    msg != null && !msg.isEmpty()) {
                message = new Message();
                message.setFirstName(fn);
                message.setLastName(ln);
                message.setEmail(mail);
                message.setDate(date);
                message.setCategory(cat);
                message.setSubject(subject);
                message.setMessage(msg);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Message created?
        if (message != null) {
            // logging aus aufgabe 1
            messages.getItems().add(message);
            System.out.println(messages);
            // redirect to message gsp.
            request.setAttribute("message", message);
            request.setAttribute("id", messages.getItems().indexOf(message));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/detail.jsp");
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/kontakt.html");
            dispatcher.forward(request, response);
        }

    }

    private void renderIndexPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Forwarding to index-page!");
        request.setAttribute("messages", messages);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    private void handleDetailRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Show detailPage");
        String idString = request.getRequestURI().replace("detail", "").replace("/", "");
        System.out.println(idString);
        Integer id = null;
        if (idString != null && !idString.isEmpty()) {
            try {

                id = Integer.parseInt(idString);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (id != null && id < messages.getItems().size()) {
            Message message = messages.getItems().get(id);
            request.setAttribute("message", message);
            request.setAttribute("id", messages.getItems().indexOf(message));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/detail.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("/");
        }

    }
}
