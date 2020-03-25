package com.vinnsmedia.academy.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.vinnsmedia.academy.dao.HomeDAO;
import com.vinnsmedia.academy.vo.ANPScoreDTO;
import com.vinnsmedia.academy.vo.AliceNParkerVO;
import com.vinnsmedia.academy.vo.AvgScoreVO;
import com.vinnsmedia.academy.vo.StudentListVO;
import com.vinnsmedia.academy.vo.StudentScoreDTO;

@Service
public class HomeServiceImpl implements HomeService{
	@Inject
	HomeDAO homeDAO;

	@Override
	public List<AvgScoreVO> getAvgScores() throws Exception {
				
		return homeDAO.getAvgScores();
	}

	@Override
	public List<AliceNParkerVO> getANPScores() throws Exception {
		// 먼저 Alice와 Parker 리스트 형성
		List<AliceNParkerVO> list = homeDAO.createANPList();
		
		// 만들어진 리스트에 점수들 넣기
		for(AliceNParkerVO vo : list){
			Long seq = vo.getSeq();
			List<ANPScoreDTO> scores = homeDAO.getANPScores(seq);
			vo.setScores(scores);
		}
		
		return list;
	}

	@Override
	public List<StudentListVO> getStudentList(Integer i) throws Exception {
		// 인자로 받은 학년 전체 리스트 불러오기
		List<StudentListVO> list = homeDAO.createStudentList(i);
		
		// 만들어진 리스트에 점수들 넣기
		for(StudentListVO vo : list) {
			Long seq = vo.getSeq();
			// track이 4가 아닐 땐 DESC로 정렬 가능
			List<StudentScoreDTO> scores = null;
			if(vo.getTrack() != null && vo.getTrack() != 4){
				scores = homeDAO.getStudentScores(seq);
			// track이 4일 땐 5, 4, 6 순서로 정렬
			}else if(vo.getTrack() == 4){
				scores = homeDAO.getStudentScoreForTrackFour(seq);
			}
			vo.setScores(scores);
		}
		
		return list;
	}
	
	
	
	
	
	
}
