package com.vinnsmedia.academy.vo;

import java.util.List;

import lombok.Data;

@Data
public class AliceNParkerVO {
	private Long seq;
	private String name;
	
	private List<ANPScoreDTO> scores;
}
