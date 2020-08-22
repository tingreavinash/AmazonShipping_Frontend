package com.avinash.amazonshipping.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.avinash.amazonshipping.model.CustomUserPrincipal;
import com.avinash.amazonshipping.model.User;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UserDao userDao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("Username: "+username);
		User user = userDao.findUserByUsername(username);
		System.out.println("Inside loadUserByUsername");
		
		if (user==null) {
			System.out.println("User is null..");
			throw new UsernameNotFoundException(username);
		}
		System.out.println(user);
		CustomUserPrincipal userDetails = new CustomUserPrincipal(user);
		System.out.println(userDetails.getAuthorities());
		return userDetails;
	}

	
}
