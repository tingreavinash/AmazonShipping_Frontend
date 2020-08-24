package com.avinash.amazonshipping.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.avinash.amazonshipping.model.Order;


@Controller
public class MvcConfig {
	
	List<Emp> emplist= new ArrayList<Emp>();
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	
	@RequestMapping(value="/search", method= {RequestMethod.GET, RequestMethod.POST})
	public String search() {
		return "search";
	}
	
	@RequestMapping(value="/SearchResult", method= {RequestMethod.GET, RequestMethod.POST})
	public String SearchResult() {
		return "hotfixResult";
	}
	
	@RequestMapping(value="/updateOrder", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView search(@RequestParam String orderid) {
		System.out.println("orderid="+orderid);
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
	
	/*It displays a form to input data, here "command" is a reserved request attribute  
     *which is used to display object data into form  
     */    
    @RequestMapping("/empform")    
    public String showform(Model m){    
        m.addAttribute("command", new Emp());  
        return "empform";   
    }    
    /*It saves object into database. The @ModelAttribute puts request data  
     *  into model object. You need to mention RequestMethod.POST method   
     *  because default request is GET*/    
    @RequestMapping(value="/save",method = RequestMethod.POST)    
    public String save(@ModelAttribute("emp") Emp emp){    
        //dao.save(emp);
    	emplist.add(emp);
        return "redirect:/viewemp";//will redirect to viewemp request mapping    
    }    
    /* It provides list of employees in model object */    
    @RequestMapping("/viewemp")    
    public String viewemp(Model m){    
        List<Emp> list=emplist;    
        m.addAttribute("list",list);  
        return "viewOrders";    
    }    
    /* It displays object data into form for the given id.   
     * The @PathVariable puts URL data into variable.*/    
    @RequestMapping(value="/editemp/{id}")    
    public String edit(@PathVariable int id, Model m){    
    	Emp emp = new Emp();
    	for (Emp e: emplist) {
        	if(e.getId() == id){
        		emp= e;
        	}
        }
        m.addAttribute("command",emp);  
        return "empeditform";    
    }    
    /* It updates model object. */    
    @RequestMapping(value="/editsave",method = RequestMethod.POST)    
    public String editsave(@ModelAttribute("emp") Emp emp){    
    	
    	for (Emp e: emplist) {
        	if(e.getId() == emp.getId()){
        		e.setName(emp.getName());
        		e.setDesignation(emp.getDesignation());
        		e.setSalary(emp.getSalary());
        		
        	}
        }
    	
    	//dao.update(emp);    
        return "redirect:/viewemp";    
    }    
    /* It deletes record for the given id in URL and redirects to /viewemp */    
    @RequestMapping(value="/deleteemp/{id}",method = RequestMethod.GET)    
    public String delete(@PathVariable int id){    
    	for (Emp e: emplist) {
        	if(e.getId() == id){
        		emplist.remove(e);
        	}
        }
    	
    	//dao.delete(id);    
        return "redirect:/viewemp";    
    }
	
    
	
}