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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.avinash.amazonshipping.constant.Values;
import com.avinash.amazonshipping.model.ApiResponse;
import com.avinash.amazonshipping.model.Mail;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MailService {

	@Autowired
	RestClient restClient;

	@Value("${API.ENDPOINT_SENDMAIL}")
	private String ENDPOINT_SENDMAIL;

	public String sendMail(Mail mail) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(mail);
		ApiResponse apiResponse = restClient.callAPI(ENDPOINT_SENDMAIL, Values.POST, jsonString);
		if (Values.FAILURE.equals(apiResponse.getOutput())) {
			return Values.FAILURE;
		}
		return Values.SUCCESS;
	}
}