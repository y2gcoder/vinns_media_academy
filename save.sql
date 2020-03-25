USE test;

DESC Student;
DESC Score;
DESC Lecture;

-- 학년별 평균 시험 점수
/*
	학년		트랙 번호		해당 과목
	10			1			3
    10			2			4
    10			3			8
    10			4			5
    
    11			1			2
    11			2			3
    11			3			7
    11			4			4
    
    12			1			1
    12			2			2
    12			3			6
    12			4			6
*/ 

SELECT * FROM Student ORDER BY level ASC ;

SELECT * FROM Score ORDER BY student ASC;

SELECT * FROM Lecture;

SELECT Student.level as level, Student.track as track, AVG(Score.value) as avg FROM Student, Score 
WHERE Student.seq = Score.student
GROUP BY Student.level, Student.track
ORDER BY Student.level ASC, Student.track DESC;

-- Alice 와 Parker의 트랙 1 학년별 점수
SELECT * FROM Student WHERE name='Parker' OR name='Alice';
SELECT * FROM Score WHERE student = 8;

SELECT seq, name FROM Student WHERE name='Parker' OR name='Alice' ORDER BY seq DESC;

SELECT lecture, value FROM Score WHERE student = 41 AND lecture IN (3, 2, 1) ORDER BY FIELD(lecture, 3, 2, 1);


SELECT Student.name as name, Score.lecture, Score.value as score FROM Student, Score
WHERE Student.seq = Score.student
AND (Student.name = 'Alice' OR Student.name = 'Parker')
AND (Score.lecture = 3 OR Score.lecture = 2 OR Score.lecture = 1)
ORDER BY Student.seq DESC;

-- 학년별 학생 목록
-- 전체 학생의 No, Name, Gender, Level, Track, Lecture/Score (최대 3개) 학년 당 듣는 과목으로 정렬하자. 
-- 일단 전체 학년별로 명단을 뽑아내고 
SELECT seq, name, gender, level, track FROM Student 
WHERE level = 12
ORDER BY seq ASC; 
-- 그 다음 그 사람에 해당하는 각 과목 점수들을 넣기 (Service 단에서 track 4번 11학년이랑 12학년은 5, 4, 6 순서에 맞게 넣어주자.)
SELECT Lecture.seq as seq, Lecture.title as title, Score.value as score 
FROM Lecture
INNER JOIN Score ON Score.lecture = Lecture.seq
INNER JOIN Student ON Score.student = Student.seq
WHERE Student.seq = 8
ORDER BY Student.seq ASC, seq DESC;

-- 4번일 때
SELECT Lecture.seq as seq, Lecture.title as title, Score.value as score 
FROM Lecture
INNER JOIN Score ON Score.lecture = Lecture.seq
INNER JOIN Student ON Score.student = Student.seq
WHERE Student.seq = 39
ORDER BY Student.seq ASC, FIELD(Lecture.seq,5,4,6) DESC;


-- 뭉뚱그려 뽑기
SELECT Student.seq as seq, Student.name as name, Student.gender as gender, Student.level as level, Student.track as track, Lecture.title as title, Score.value as score
FROM Lecture
INNER JOIN Score ON Score.lecture = Lecture.seq
INNER JOIN Student ON Score.student = Student.seq
WHERE Student.level = 11
ORDER BY Student.seq ASC;



