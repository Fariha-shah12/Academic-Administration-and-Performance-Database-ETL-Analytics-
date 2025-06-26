SELECT P.Prof_id, P.Prof_fname first_name, P.Prof_lname last_name,
       D.Dept_code department,
       COUNT(*) sections_taught
FROM Professor P
LEFT JOIN Section S ON S.Prof_id = P.Prof_id
LEFT JOIN Department D ON P.Dept_id = D.Dept_id
WHERE (S.Sect_year = 2023 and S.Sect_quarter = 1) or
      (S.Sect_year = 2024 and S.Sect_quarter > 1)
GROUP BY P.Prof_id
ORDER BY department DESC, sections_taught DESC;


SELECT D.Dept_code department, C.Crs_num course_num, C.Crs_name course_name,
       COUNT(DISTINCT FG.Sect_id) num_sections,
       COUNT(FG.Stud_id) num_students,
       -- use 1.0 as passing cut off
       ROUND(SUM(CASE WHEN FG.grade_point >= 1.0 THEN 1 ELSE 0 END)/COUNT(*),2) passing_rate
FROM COURSE C, Section S, Department D, Final_Grade FG
WHERE C.Crs_id = S.Crs_id AND C.Dept_id = D.Dept_id AND S.Sect_id = FG.Sect_id
GROUP BY C.Crs_id
HAVING COUNT(FG.Stud_id) >= 20  -- only courses with more than 20 sample size
ORDER BY passing_rate ASC
LIMIT 5;


SELECT P.Prof_id id, P.Prof_fname first_name, P.Prof_lname last_name,
       COUNT(DISTINCT FG.Sect_id) num_sections,
       COUNT(FG.Stud_id) num_students,
       ROUND(AVG(FG.overall_grade),3) average_grade,
       ROUND(AVG(FG.grade_point),2) average_grade_point
FROM Professor P, Section S, Final_Grade FG
WHERE P.Prof_id = S.Prof_id AND S.Sect_id = FG.Sect_id
GROUP BY P.Prof_id
HAVING COUNT(FG.Stud_id) >= 20  -- only courses with at least 20 sample size
ORDER BY average_grade ASC
LIMIT 5;


SELECT B.Bld_name building, COUNT(DISTINCT WS.Sect_id) num_sections
FROM Building B, Weekly_Session WS
WHERE B.Bld_id = WS.Bld_id
GROUP BY building
ORDER BY num_sections DESC
LIMIT 10;


SELECT D.Dept_name, mm.type,
       COUNT(mm.stud_id) AS num_students
FROM Department D, Major_Minor MM
WHERE MM.Dept_id = D.Dept_id
GROUP BY D.dept_name, MM.type
ORDER BY num_students DESC;


WITH TA_counts AS (
    SELECT 
        Stud_id,
        COUNT(DISTINCT Sect_id) as times_TAd
    FROM TA
    GROUP BY Stud_id
)
SELECT 
    CASE 
        WHEN TC.times_TAd > 5 THEN 'Frequent TA (>5 sections)'
        WHEN tc.times_TAd IS NOT NULL THEN 'Occasional TA (1-5 sections)'
        ELSE 'Never TA'
    END TA_frequency,
    COUNT(DISTINCT s.Stud_id) student_count,
    ROUND(AVG(S.Stud_GPA),2) average_GPA,
    ROUND(MIN(s.Stud_GPA),2) minimum_GPA,
    ROUND(MAX(s.Stud_GPA),2) maximum_GPA
FROM Student S
LEFT JOIN TA_counts TC ON S.Stud_id = TC.Stud_id
WHERE S.Stud_GPA IS NOT NULL
GROUP BY TA_frequency
ORDER BY average_GPA DESC;


SELECT d.Dept_name department, AVG(fg.grade_point) AS avg_gpa
FROM Department d
    JOIN Major_Minor mm ON mm.Dept_id = d.Dept_id
    JOIN Student s ON s.Stud_id = mm.Stud_id
    JOIN Final_Grade fg ON fg.Stud_id = s.Stud_id
WHERE mm.type = 'MAJOR'
GROUP BY d.Dept_name
ORDER BY avg_gpa DESC;


WITH Student_programs AS (
    SELECT 
        Stud_id,
        COUNT(DISTINCT Dept_id) total_programs
    FROM Major_Minor
    GROUP BY Stud_id
)
SELECT 
    SP.total_programs,
    ROUND(AVG(S.Stud_GPA), 3) as avg_gpa
FROM Student S
JOIN Student_programs SP ON S.Stud_id = SP.Stud_id
WHERE S.Stud_GPA IS NOT NULL
GROUP BY SP.total_programs
ORDER BY total_programs;


SELECT Sect_quarter,
       ROUND(AVG(fg.grade_point), 3) as avg_grade_point,
	   ROUND(AVG(fg.overall_grade * 100), 2) as avg_percentage
FROM Section S, Final_Grade FG
WHERE S.Sect_id = FG.Sect_id
GROUP BY Sect_quarter
ORDER BY Sect_quarter;


SELECT 
    UPPER(LEFT(S.Stud_lname, 1)) as last_name_initial,
    COUNT(DISTINCT s.Stud_id) as num_Students,
    ROUND(AVG(s.Stud_GPA), 3) as avg_gpa
FROM Student S
WHERE S.Stud_GPA IS NOT NULL
GROUP BY last_name_initial
ORDER BY avg_gpa DESC;