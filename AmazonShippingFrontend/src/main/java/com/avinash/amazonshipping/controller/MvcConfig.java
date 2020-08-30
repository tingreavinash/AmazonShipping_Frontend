package com.avinash.amazonshipping.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.avinash.amazonshipping.model.Emp;
import com.avinash.amazonshipping.model.Mail;
import com.avinash.amazonshipping.model.Order;
import com.avinash.amazonshipping.model.OrderListWrapper;
import com.avinash.amazonshipping.service.FileHandler;
import com.avinash.amazonshipping.service.MailService;
import com.avinash.amazonshipping.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;

@Controller
public class MvcConfig {

	List<Order> sampleList = new ArrayList<Order>();

	@Value("${API.OUTPUT_FILE_PATH}")
	private String OUTPUT_FILE_PATH;
	
	@Autowired
	MailService mailService;

	@Autowired
	OrderService orderService;
	
	@Autowired
	FileHandler fileHander;
	
	@GetMapping("/")
	public String index() {
		return "index";
	}

	@RequestMapping(value = "/search", method = { RequestMethod.GET, RequestMethod.POST })
	public String search() {
		return "search";
	}

	@RequestMapping(value = "/updateOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView search(@RequestParam String orderid) {
		System.out.println("orderid=" + orderid);
		ModelAndView model = new ModelAndView("/updateorder");
		model.addObject("orderid", orderid);
		return model;
	}

	@GetMapping("/user")
	public String home() {
		return "user";
	}

	@GetMapping("/admin")
	public String hello() {
		return "admin";
	}

	@GetMapping("/index")
	public String login() {
		return "index";
	}

	// Test code below

	/*
	 * It displays a form to input data, here "command" is a reserved request
	 * attribute which is used to display object data into form
	 */
	@RequestMapping("/empform")
	public String showform(Model m) {
		m.addAttribute("command", new Order());
		return "empform";
	}

	/*
	 * It saves object into database. The @ModelAttribute puts request data into
	 * model object. You need to mention RequestMethod.POST method because default
	 * request is GET
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(@ModelAttribute("order") Order order) throws JsonProcessingException {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = "-";
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}

		order.setRecord_created_by(username);
		order.setRecord_last_modified(new Date().toString());

		//sampleList.add(order);
		orderService.createOrder(order);

		Mail mail = new Mail();
		mail.setBody("Order ID:" + order.getOrder_id() + "\nUpdated By: " + username);
		mail.setSubject("Order Notification");
		List<String> recipient = new ArrayList<>();
		recipient.add("skncoeavinash@gmail.com");
		recipient.add("tingre.avinash@gmail.com");
		mail.setRecipient(recipient);

		String result = mailService.sendMail(mail);
		System.out.println("Mail Status: " + result);

		return "redirect:/viewemp";// will redirect to viewemp request mapping
	}

	/* It provides list of employees in model object */
	@RequestMapping("/viewemp")
	public String viewemp(Model m) throws JsonProcessingException {
		
		//List<Order> orderList = sampleList;
		List<Order> orderList = orderService.getAllOrders();
		m.addAttribute("list", orderList);
		return "viewOrders";
	}

	/*
	 * It displays object data into form for the given id. The @PathVariable puts
	 * URL data into variable.
	 */
	@RequestMapping(value = "/editemp/{order_id}")
	public String edit(@PathVariable String order_id, Model m) throws JsonProcessingException {
		// Emp emp = new Emp();
		System.out.println("Order ID: " + order_id);
		/*List<Order> orderList = orderService.getAllOrders();
		Order order = new Order();
		for (Order o : orderList) {
			if (order_id.equals(o.getOrder_id())) {
				order = o;
			}
		}*/
		Order order = orderService.getOrderByOrderId(order_id);

		m.addAttribute("command", order);
		return "updateorder";
	}
	@RequestMapping(value="/downloadFile")
	public void downloadFile(HttpServletResponse response) throws IOException {
		
		fileHander.createFile(orderService.getAllOrders(), OUTPUT_FILE_PATH);
		
		File file = new File(OUTPUT_FILE_PATH);
		
		if(!file.exists()){
            String errorMessage = "Sorry. The file you are looking for does not exist";
            System.out.println(errorMessage);
            OutputStream outputStream = response.getOutputStream();
            outputStream.write(errorMessage.getBytes(Charset.forName("UTF-8")));
            outputStream.close();
            return;
        }
         
        String mimeType= URLConnection.guessContentTypeFromName(file.getName());
        if(mimeType==null){
            System.out.println("mimetype is not detectable, will take default");
            mimeType = "application/octet-stream";
        }
         
        System.out.println("mimetype : "+mimeType);
         
        response.setContentType(mimeType);
         
        /* "Content-Disposition : inline" will show viewable types [like images/text/pdf/anything viewable by browser] right on browser 
            while others(zip e.g) will be directly downloaded [may provide save as popup, based on your browser setting.]*/
        response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() +"\""));
 
         
        /* "Content-Disposition : attachment" will be directly download, may provide save as popup, based on your browser setting*/
        //response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));
         
        response.setContentLength((int)file.length());
 
        InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
 
        //Copy bytes from source to destination(outputstream in this example), closes both streams.
        FileCopyUtils.copy(inputStream, response.getOutputStream());
		
	}
	@RequestMapping(value = "/batchEditOrders")
	public String batchEditOrders( Model m) throws JsonProcessingException {
				
		List<Order> list = orderService.getAllOrders();
		OrderListWrapper olwrapper = new OrderListWrapper();
		olwrapper.setOrderList(list);
		for (Order o : list) {
			System.out.println("order id: "+o.getOrder_id());
		}
		m.addAttribute("orderListWrapper", olwrapper);
		return "batchUpdateOrders";
	}
	
	@RequestMapping(value = "/batcheditsave", method = RequestMethod.POST)
	public String batcheditsave(@ModelAttribute("orderListWrapper") OrderListWrapper orderList) throws JsonProcessingException {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = "-";
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}


		List<Order> list = orderList.getOrderList();
		for(Order o: list) {
			o.setRecord_created_by(username);
			o.setRecord_last_modified(new Date().toString());
		}
		orderService.updateBatchOrders(list);
		
		Mail mail = new Mail();
		String msgbody = "Below Orders updated by: "+username;
		
		for (Order o: list) {
			msgbody+="\n"+o.getOrder_id();
		}
		mail.setBody(msgbody);
		mail.setSubject("Order Notification - Batch Update");
		List<String> recipient = new ArrayList<>();
		recipient.add("skncoeavinash@gmail.com");
		recipient.add("tingre.avinash@gmail.com");
		mail.setRecipient(recipient);

		String result = mailService.sendMail(mail);
		System.out.println("Mail Status: " + result);

		
		return "redirect:/viewemp";
	}

	
	/* It updates model object. */
	@RequestMapping(value = "/editsave", method = RequestMethod.POST)
	public String editsave(@ModelAttribute("order") Order order) throws JsonProcessingException {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = "-";
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}

		System.out.println("Input Order: " + order);
		/*for (Order o : sampleList) {
			if (order.getOrder_id().equals(o.getOrder_id())) {
				o.setBuyer_email(order.getBuyer_email());
				o.setBuyer_name(order.getBuyer_name());
				o.setBuyer_phone_number(order.getBuyer_phone_number());
				o.setOrder_item_id(order.getOrder_item_id());
				o.setRecipient_name(order.getRecipient_name());
				o.setPayment_method(order.getPayment_method());
				o.setCod_collectible_amount(order.getCod_collectible_amount());
				o.setTracking_id(order.getTracking_id());
				o.setCourier_code(order.getCourier_code());

				o.setRecord_created_by(username);
				o.setRecord_last_modified(new Date().toString());

			}
		}*/
		order.setRecord_created_by(username);
		order.setRecord_last_modified(new Date().toString());
		orderService.updateOrder(order);
		
		Mail mail = new Mail();
		mail.setBody("Order ID:" + order.getOrder_id() + "\nUpdated By: " + username);
		mail.setSubject("Order Notification");
		List<String> recipient = new ArrayList<>();
		recipient.add("skncoeavinash@gmail.com");
		recipient.add("tingre.avinash@gmail.com");
		mail.setRecipient(recipient);

		String result = mailService.sendMail(mail);
		System.out.println("Mail Status: " + result);

		// dao.update(emp);
		return "redirect:/viewemp";
	}

	/* It deletes record for the given id in URL and redirects to /viewemp */
	@RequestMapping(value = "/deleteemp/{order_id}", method = RequestMethod.GET)
	public String delete(@PathVariable String order_id) {
		/*for (Order o : sampleList) {
			if (order_id.equals(o.getOrder_id())) {
				sampleList.remove(o);
			}
		}*/
		
		orderService.deleteOrder(order_id);

		// dao.delete(id);
		return "redirect:/viewemp";
	}

}