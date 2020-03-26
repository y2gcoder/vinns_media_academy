package com.vinnsmedia.academy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.vinnsmedia.academy.util.Criteria;
import com.vinnsmedia.academy.vo.ANPScoreDTO;
import com.vinnsmedia.academy.vo.AliceNParkerVO;
import com.vinnsmedia.academy.vo.AvgScoreVO;
import com.vinnsmedia.academy.vo.StudentListVO;
import com.vinnsmedia.academy.vo.StudentScoreDTO;

public interface HomeDAO {

	@Select("SELECT Student.level as level, Student.track as track, AVG(Score.value) as avg FROM Student, Score "
			+ " WHERE Student.seq = Score.student"
			+ " GROUP BY Student.level, Student.track"
			+ " ORDER BY Student.level ASC, Student.track DESC")
	List<AvgScoreVO> getAvgScores() throws Exception;
	
	@Select("SELECT seq, name FROM Student WHERE name='Parker' OR name='Alice' ORDER BY seq DESC")
	List<AliceNParkerVO> createANPList()throws Exception;

	@Select("SELECT lecture, value FROM Score WHERE student = #{seq} AND lecture IN (3, 2, 1) ORDER BY FIELD(lecture, 3, 2, 1)")
	List<ANPScoreDTO> getANPScores(Long seq)throws Exception;

	@Select("SELECT count(*) FROM Student WHERE level=#{level}")
	int totalStudent(Integer level)throws Exception;
	
	@Select("SELECT seq, name, gender, level, track FROM Student WHERE level = #{level} ORDER BY seq ASC"
			+ "	LIMIT #{cri.pageStart}, #{cri.perPageNum}")
	List<StudentListVO> createStudentList(@Param("level") Integer level, @Param("cri") Criteria cri)throws Exception;

	@Select("SELECT Lecture.seq as seq, Lecture.title as title, Score.value as score "
			+ " FROM Lecture"
			+ " INNER JOIN Score ON Score.lecture = Lecture.seq"
			+ " INNER JOIN Student ON Score.student = Student.seq"
			+ " WHERE Student.seq = #{seq}"
			+ "	ORDER BY Student.seq ASC, seq DESC")
	List<StudentScoreDTO> getStudentScores(Long seq)throws Exception;
	
	@Select("SELECT Lecture.seq as seq, Lecture.title as title, Score.value as score "
			+ " FROM Lecture"
			+ " INNER JOIN Score ON Score.lecture = Lecture.seq"
			+ " INNER JOIN Student ON Score.student = Student.seq"
			+ " WHERE Student.seq = #{seq}"
			+ "	ORDER BY Student.seq ASC, FIELD(Lecture.seq,5,4,6) DESC")
	List<StudentScoreDTO> getStudentScoreForTrackFour(Long seq)throws Exception;

	
	
	

}
