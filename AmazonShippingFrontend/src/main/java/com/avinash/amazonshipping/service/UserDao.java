package com.avinash.amazonshipping.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.avinash.amazonshipping.model.User;
import com.avinash.amazonshipping.model.UserFirebase;
import com.fasterxml.jackson.databind.ObjectMapper;

@Repository
public class UserDao {

	@Autowired
	private PasswordEncoder passwordEncoder;

	public User findUserByUsername(String username) {
		System.out.println("findUserByUsername: " + username);
		if ("avinash".equals(username)) {
			UserFirebase userFirebase = new UserFirebase();
			User user = new User();
			ObjectMapper objectMapper = new ObjectMapper();
			HttpURLConnection con = null;
			try {

				URL url = new URL("http://localhost:7777/ShippingApplication/getUserDetails?username=" + username);
				con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("Content-Type", "application/json");

				con.setConnectTimeout(5000);
				con.setReadTimeout(5000);

				int status = con.getResponseCode();
				if (status > 299) {
					Reader streamReader = null;

					BufferedReader in = new BufferedReader(streamReader);
					String inputLine;
					StringBuffer content = new StringBuffer();
					while ((inputLine = in.readLine()) != null) {
						content.append(inputLine);
					}
					in.close();
					System.out.println("Below error occured: \n" + content.toString());

				} else {
					BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
					String inputLine;
					StringBuffer content = new StringBuffer();
					while ((inputLine = in.readLine()) != null) {
						content.append(inputLine);
					}
					in.close();
					String response = content.toString();
					if (response != null) {
						userFirebase = objectMapper.readValue(response, UserFirebase.class);
						user.setAccountNonExpired(userFirebase.isAccountNonExpired());
						user.setAccountNonLocked(userFirebase.isAccountNonLocked());
						user.setCredentialsNonExpired(userFirebase.isCredentialsNonExpired());
						user.setEnabled(userFirebase.isEnabled());
						user.setPassword(passwordEncoder.encode(userFirebase.getPassword()));
						user.setUsername(userFirebase.getUsername());

						List<SimpleGrantedAuthority> updatedAuthorities = new ArrayList<SimpleGrantedAuthority>();
						
						for(String role: userFirebase.getAuthorities()) {
							updatedAuthorities.add(new SimpleGrantedAuthority(role));							
						}
						user.setAuthorities(updatedAuthorities);

					} else {
						userFirebase = null;
						user =null;
					}
				}
			} catch (Exception ex) {
				System.out.println("Exception caught:\n");
				ex.printStackTrace();
			}

			return user;
		}
		return null;

	}
}
