package com.avinash.amazonshipping.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import com.avinash.amazonshipping.constant.Values;
import com.avinash.amazonshipping.model.ApiResponse;
import com.avinash.amazonshipping.model.UserFirebase;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class RestClient {

	@Value("${API.REST_URL}")
	private String REST_URL;

	public ApiResponse callAPI(String endpoint, String requestMethod, String requestBody) {

		HttpURLConnection con = null;

		ApiResponse response = new ApiResponse();
		try {

			System.out.println("Request Body: \n" + requestBody);
			System.out.println("Request Type: \n" + requestMethod);

			URL url = new URL(REST_URL + endpoint);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod(requestMethod);
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("Accept", "application/json");

			con.setConnectTimeout(50000);
			con.setReadTimeout(50000);

			if (requestBody != null) {
				con.setDoOutput(true);
				try (OutputStream os = con.getOutputStream()) {
					byte[] input = requestBody.getBytes("utf-8");
					os.write(input, 0, input.length);
				}
			}

			int status = con.getResponseCode();
			if (status != 200) {

				response.setStatuscode(status);
				response.setOutput("Unknown Failure.");

			} else {
				BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
				String inputLine;
				StringBuffer content = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					content.append(inputLine);
				}
				in.close();

				response.setStatuscode(status);
				response.setOutput(content.toString());

			}

		} catch (Exception ex) {
			System.out.println("Exception caught:\n");
			ex.printStackTrace();
			response.setStatuscode(-1);
			response.setOutput(ex.getMessage());
		}
		return response;
	}
}
