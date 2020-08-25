package com.avinash.amazonshipping.service;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	@Value("${key.MAIL_TO}")
	private String MAIL_TO; 
	
	@Value("${key.MAIL_FROM}")
	private String MAIL_FROM; 

	@Value("${key.MAIL_PASS}")
	private String MAIL_PASS;
    
    public String sendMail(String orderId, String username) {

    	try {
            String to = MAIL_TO;

            String from = MAIL_FROM;

            String host = "smtp.gmail.com";

            Properties properties = System.getProperties();

            properties.put("mail.smtp.host", host);
            properties.put("mail.smtp.port", "465");
            properties.put("mail.smtp.ssl.enable", "true");
            properties.put("mail.smtp.auth", "true");

            Session session = Session.getInstance(properties, new javax.mail.Authenticator() {

                protected PasswordAuthentication getPasswordAuthentication() {

                    return new PasswordAuthentication(MAIL_FROM, MAIL_PASS);

                }

            });

            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(from));

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            message.setSubject("Update order notification");

            message.setText("Order ID: "+orderId+"\nUpdated by: "+ username);

            System.out.println("sending...");
            Transport.send(message);
            System.out.println("Sent message successfully....");
            
    		
    	}catch(Exception ex) {
    		System.out.println("Exception: "+ex.getMessage());
    		return "Failure";
    	}
    	return "Success";
        
        
    
    }

}