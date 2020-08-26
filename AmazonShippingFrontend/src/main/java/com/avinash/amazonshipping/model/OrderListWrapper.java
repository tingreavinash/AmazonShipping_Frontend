package com.avinash.amazonshipping.model;

import java.util.ArrayList;
import java.util.List;

public class OrderListWrapper {
	private List<Order> orderList;

	
	public List<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
	}

	public OrderListWrapper() {
		this.orderList = new ArrayList<Order>();
	}
	
	public void add(Order order) {
		this.orderList.add(order);
	}
}
