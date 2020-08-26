package com.avinash.amazonshipping.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.avinash.amazonshipping.constant.Values;
import com.avinash.amazonshipping.model.ApiResponse;
import com.avinash.amazonshipping.model.Order;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OrderService {
	@Autowired
	RestClient restClient;

	@Value("${API.ENDPOINT_CREATEORDER}")
	private String ENDPOINT_CREATEORDER;

	@Value("${API.ENDPOINT_GETALLORDERS}")
	private String ENDPOINT_GETALLORDERS;
	
	@Value("${API.ENDPOINT_UPDATEORDER}")
	private String ENDPOINT_UPDATEORDER;

	@Value("${API.ENDPOINT_DELETEORDER}")
	private String ENDPOINT_DELETEORDER;
	
	@Value("${API.ENDPOINT_GETORDERBYID}")
	private String ENDPOINT_GETORDERBYID;
	
	public String createOrder(Order order) throws JsonProcessingException {

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(order);
		ApiResponse apiResponse = restClient.callAPI(ENDPOINT_CREATEORDER, Values.POST, jsonString);
		if (apiResponse.getStatuscode() != Values.STATUS_OK) {
			return Values.FAILURE;
		}
		return Values.SUCCESS;
	}

	public Order getOrderByOrderId(String orderid) throws JsonMappingException, JsonProcessingException  {

		ObjectMapper mapper = new ObjectMapper();
		Order order = new Order();
		ApiResponse apiResponse = restClient.callAPI(ENDPOINT_GETORDERBYID+orderid, Values.GET, null);
		if (apiResponse.getStatuscode() != Values.STATUS_OK) {
			return null;
		}
		order = mapper.readValue(apiResponse.getOutput(), Order.class);
		return order;
	}
	
	
	public String deleteOrder(String orderid)  {

		//ObjectMapper mapper = new ObjectMapper();
		//String jsonString = mapper.writeValueAsString(order);
		ApiResponse apiResponse = restClient.callAPI(ENDPOINT_DELETEORDER+orderid, Values.DELETE, null);
		if (apiResponse.getStatuscode() != Values.STATUS_OK) {
			return Values.FAILURE;
		}
		return Values.SUCCESS;
	}
	
	public String updateOrder(Order order) throws JsonProcessingException {

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(order);
		ApiResponse apiResponse = restClient.callAPI(ENDPOINT_UPDATEORDER, Values.PUT, jsonString);
		if (apiResponse.getStatuscode() != Values.STATUS_OK) {
			return Values.FAILURE;
		}
		return Values.SUCCESS;
	}
	
	public List<Order> getAllOrders() throws JsonProcessingException {

		ObjectMapper mapper = new ObjectMapper();
		List<Order> orders = new ArrayList<Order>();
		//String jsonString = mapper.writeValueAsString(order);
		ApiResponse apiResponse = restClient.callAPI(ENDPOINT_GETALLORDERS, Values.GET, null);
		if (apiResponse.getStatuscode() != Values.STATUS_OK) {
			
			return null;
		}
		orders =Arrays.asList(mapper.readValue(apiResponse.getOutput(), Order[].class));
		return orders;
	}

}
