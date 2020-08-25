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
	private UserService userDao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userDao.findUserByUsername(username);

		if (user == null) {
			System.out.println("User is null..");
			throw new UsernameNotFoundException(username);
		}
		CustomUserPrincipal userDetails = new CustomUserPrincipal(user);
		return userDetails;
	}

}
