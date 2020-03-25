package com.vinnsmedia.academy.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vinnsmedia.academy.service.HomeService;
import com.vinnsmedia.academy.vo.AliceNParkerVO;
import com.vinnsmedia.academy.vo.AvgScoreVO;
import com.vinnsmedia.academy.vo.StudentListVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	HomeService homeService;
		
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@GetMapping("/")
	public String home() throws Exception{
		// 실험용 - 학년별 평균 시험 점수
//		List<AvgScoreVO> avgScores = homeService.getAvgScores();
//		System.out.println(avgScores);
		// 실험용 - Alice와 Parker의 시험점수
//		List<AliceNParkerVO> aNPScores = homeService.getANPScores();
//		System.out.println(aNPScores);
		// 실험용 - 학년별 학생 목록(지금은 페이징 되어있지 않음, 학년만)
//		List<StudentListVO> studentList = homeService.getStudentList(12);
		
		return "home";
	}
	
	// chart 그릴 정보
	@GetMapping("/chart")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> chart() throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			List<AvgScoreVO> avgScores = homeService.getAvgScores();
			List<AliceNParkerVO> aNPScores = homeService.getANPScores();
			
			map.put("totalAvgList", avgScores);
			map.put("ANP", aNPScores);
			
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	// 리스트 불러오기
	@GetMapping("/{level}")
	@ResponseBody
	public ResponseEntity<List<StudentListVO>> studentList(@PathVariable("level") Integer level) throws Exception {
		ResponseEntity<List<StudentListVO>> entity = null;
		
		try {
			List<StudentListVO> studentList = homeService.getStudentList(level);
			
			entity = new ResponseEntity<>(studentList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	
	
	
}
