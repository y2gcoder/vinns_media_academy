package com.vinnsmedia.academy.service;

import java.util.List;

import com.vinnsmedia.academy.vo.AliceNParkerVO;
import com.vinnsmedia.academy.vo.AvgScoreVO;
import com.vinnsmedia.academy.vo.StudentListVO;

public interface HomeService {
	
	// 평균 점수 리스트 호출
	List<AvgScoreVO> getAvgScores()throws Exception;

	// Alice와 Parker의 트랙 1 점수 구하기
	List<AliceNParkerVO> getANPScores()throws Exception;

	// 학년별 학생 목록 불러오기
	List<StudentListVO> getStudentList(Integer i)throws Exception;

}
