package com.shinhan.myapp.vo;

import java.sql.Date;

import com.shinhan.myapp.emp.EmpDTO;
import com.shinhan.myapp.emp.JobDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmpJoinDeptVO {
	int employee_id;    
	String first_name ;    
	String last_name;      
	String email ;         
	String phone_number ;  
	Date hire_date ;     	        
	double salary;         
	double commission_pct ;
	int manager_id;     
	JobDTO job_id ;
	DeptDTO department_id  ;
}
