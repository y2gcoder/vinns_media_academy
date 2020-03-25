package com.vinnsmedia.academy.vo;

import java.util.List;

import lombok.Data;

@Data
public class StudentListVO {
	private Long seq;
	private String name;
	private String gender;
	private Integer level;
	private Integer track;
	
	private List<StudentScoreDTO> Scores;
}
