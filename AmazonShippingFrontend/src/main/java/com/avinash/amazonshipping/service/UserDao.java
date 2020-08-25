package com.avinash.amazonshipping.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.avinash.amazonshipping.constant.Values;
import com.avinash.amazonshipping.model.ApiResponse;
import com.avinash.amazonshipping.model.User;
import com.avinash.amazonshipping.model.UserFirebase;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Repository
public class UserDao {

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private RestClient restClient;

	@Value("${API.ENDPOINT_GETUSERDETAILS}")
	private String ENDPOINT_GETUSERDETAILS;

	public User findUserByUsername(String username) {
		System.out.println("findUserByUsername: " + username);

		UserFirebase userFirebase = new UserFirebase();
		User user = new User();
		ObjectMapper objectMapper = new ObjectMapper();

		// Converting the Object to JSONString
		// String jsonString = objectMapper.writeValueAsString(user);

		ApiResponse apiResponse = restClient.callAPI(getUserDetailsURL(username), Values.GET, null);

		if (apiResponse.getOutput() != null && apiResponse.getStatuscode() == 200) {
			try {
				userFirebase = objectMapper.readValue(apiResponse.getOutput(), UserFirebase.class);
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}

			user.setAccountNonExpired(userFirebase.isAccountNonExpired());
			user.setAccountNonLocked(userFirebase.isAccountNonLocked());
			user.setCredentialsNonExpired(userFirebase.isCredentialsNonExpired());
			user.setEnabled(userFirebase.isEnabled());
			user.setPassword(passwordEncoder.encode(userFirebase.getPassword()));
			user.setUsername(userFirebase.getUsername());

			List<SimpleGrantedAuthority> updatedAuthorities = new ArrayList<SimpleGrantedAuthority>();

			for (String role : userFirebase.getAuthorities()) {
				updatedAuthorities.add(new SimpleGrantedAuthority(role));
			}
			user.setAuthorities(updatedAuthorities);

		} else {
			userFirebase = null;
			user = null;
		}

		return user;

	}

	private String getUserDetailsURL(String username) {
		return ENDPOINT_GETUSERDETAILS + username;
	}

}
