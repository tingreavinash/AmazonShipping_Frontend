package com.avinash.amazonshipping.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.avinash.amazonshipping.model.User;

@Repository
public class UserDao {

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public User findUserByUsername(String username) {
		System.out.println("findUserByUsername: "+username);
		if("avinash".equals(username)) {

			User user = new User();
			/**
			 * Call rest endpoint to get userdetails 
			 * from firebase and map to user object
			 */
			user.setUsername("avinash");
			user.setPassword(passwordEncoder.encode("1234"));
			user.setAccountNonExpired(true);
			user.setAccountNonLocked(true);
			user.setCredentialsNonExpired(true);
			user.setEnabled(true);
			
			SimpleGrantedAuthority authority_USER = new SimpleGrantedAuthority("USER");
			SimpleGrantedAuthority authority_ADMIN = new SimpleGrantedAuthority("ADMIN");
			
			List<SimpleGrantedAuthority> updatedAuthorities = new ArrayList<SimpleGrantedAuthority>();
			updatedAuthorities.add(authority_USER);
			//updatedAuthorities.add(authority_ADMIN);
			user.setAuthorities(updatedAuthorities);
			
			return user;
		}
		return null;

	}
}
