package com.shinhan.myapp.controller2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shinhan.myapp.emp.EmpDTO;
import com.shinhan.myapp.emp.EmpService;

@RestController
@RequestMapping("/rest")
public class SampleRestController2 {
	
	@Autowired
	EmpService empService;
	
	
	@PostMapping(value="/empinsert.do", 
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces="text/plain;charset=utf-8")
	public String insert(@RequestBody EmpDTO emp) {
		int result = empService.insertService(emp);
		return result>0? "insert성공":"insert실패";
	}
	
	
	@PutMapping(value="/empupdate.do", 
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces="text/plain;charset=utf-8")
	public String update(@RequestBody EmpDTO emp) {
		int result = empService.updateService(emp);
		return result>0? "update성공":"update실패";
	}
	
	
	
	
	//4.모든 직원을 조회하고 return을 map으로 하고싶다. Map<직원번호, 직원DTO>
	@GetMapping(value="/empmap.do", produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<Integer, EmpDTO> f5() {
		Map<Integer, EmpDTO> map = new HashMap<>();
		List<EmpDTO> emplist = empService.selectAllService();
		emplist.forEach(emp->{
			map.put(emp.getEmployee_id(), emp);
		});
		return map;
	}
	
	@GetMapping(value="/test2.do", produces="text/plain;charset=utf-8")
	public String f1() {
		return "Rest방식 연습2(@restcontroller)";
	}
	
	@GetMapping(value = "/emplist.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<EmpDTO> f2(){
		return empService.selectAllService();
	}
	@GetMapping(value = "/empdetail.do/{empid}", produces = MediaType.APPLICATION_JSON_VALUE)
	public EmpDTO f3(@PathVariable("empid") int empid){
		return empService.selectByIdService(empid);
	}
	@GetMapping(value = "/test2.do/{empid}", produces = MediaType.APPLICATION_JSON_VALUE)
	public String f4(){
		EmpDTO emp = empService.selectByIdService(100);
		return "test2"+emp.getFirst_name();
	}
}
