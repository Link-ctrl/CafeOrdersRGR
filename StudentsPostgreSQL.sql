-- Задание 1

CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  birthday DATE,
  address_id INT,
  phone_id INT,
  email VARCHAR(100),
  group_id INT,
  is_budget BOOLEAN
);

CREATE TABLE groups (
  group_id INT NOT NULL,
  group_name VARCHAR(100),
  direction_id INT NOT NULL,
PRIMARY KEY (group_id)
);

CREATE TABLE directions (
  direction_id INT NOT NULL,
  direction_name VARCHAR(100),
  PRIMARY KEY (direction_id)
);

CREATE TABLE addresses (
  address_id INT NOT NULL,
  city VARCHAR(50),
  street VARCHAR(100),
  house_number VARCHAR(10),
  PRIMARY KEY (address_id)
);

CREATE TABLE phones (
  phone_id INT NOT NULL,
  phone_number VARCHAR(20),
  PRIMARY KEY (phone_id)
);

ALTER TABLE students ADD CONSTRAINT students_fk0 FOREIGN KEY (group_id) REFERENCES groups(group_id);

ALTER TABLE students ADD CONSTRAINT students_fk1 FOREIGN KEY (address_id) REFERENCES addresses(address_id);

ALTER TABLE students ADD CONSTRAINT students_fk2 FOREIGN KEY (phone_id) REFERENCES phones(phone_id);

ALTER TABLE groups ADD CONSTRAINT groups_fk0 FOREIGN KEY (direction_id) REFERENCES directions(direction_id);

-- Задание 3

-- Вывести списки групп по заданному направлению с указание номера группы в формате ФИО, бюджет/внебюджет. Студентов выводить в алфавитном порядке.
SELECT CONCAT(s.name, ', ', IF(s.is_budget, 'бюджет', 'внебюджет')) AS 'Студенты',
g.group_name AS 'Номер группы'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
WHERE d.direction_name = 'Твое направление'
ORDER BY s.name;

-- Вывести студентов с фамилией, начинающейся с первой буквы вашей фамилии, с указанием ФИО, номера группы и направления обучения
SELECT s.name AS "ФИО", g.group_id AS "Номер группы", d.direction_name AS "Направление"
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
WHERE s.name LIKE 'Твоя_фамилия%'
ORDER BY s.name;

-- Вывести список студентов для поздравления по месяцам рождения
SELECT s.name AS "Фамилия И.О.",
EXTRACT(DAY FROM s.birthday) AS "День рождения",
TO_CHAR(s.birthday, 'Month') AS "Месяц рождения",
g.group_id AS "Номер группы",
d.direction_name AS "Направление"
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
ORDER BY EXTRACT(MONTH FROM s.birthday);

-- Вывести студентов с указанием возраста в годах
SELECT s.name AS "ФИО",
DATE_PART('year', age(s.birthday)) AS "Возраст (лет)",
g.group_id AS "Номер группы",
d.direction_name AS "Направление"
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id;

-- Вывести студентов с днем рождения в текущем месяце
SELECT s.name AS "ФИО",
EXTRACT(DAY FROM s.birthday) AS "День рождения",
	g.group_id AS "Номер группы",
	d.direction_name AS "Направление"
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
WHERE EXTRACT(MONTH FROM s.birthday) = EXTRACT(MONTH FROM CURRENT_DATE);

-- Вывести количество студентов по каждому направлению
SELECT d.direction_name AS "Направление",
COUNT(s.student_id) AS "Количество студентов"
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
GROUP BY d.direction_name;

-- Вывести количество бюджетных и внебюджетных мест по группам
SELECT g.group_id AS "Номер группы",
d.direction_name AS "Название направления",
SUM(CASE WHEN s.is_budget THEN 1 ELSE 0 END) AS "Бюджетные места",
SUM(CASE WHEN NOT s.is_budget THEN 1 ELSE 0 END) AS "Внебюджетные места"
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
GROUP BY g.group_id, d.direction_name;

-- Задание 4

CREATE TABLE teachers (
  teacher_id SERIAL PRIMARY KEY,
  teacher_name VARCHAR(100)
);

CREATE TABLE subjects (
  subject_id SERIAL PRIMARY KEY,
  subject_name VARCHAR(100),
  direction_id INT NOT NULL,
  teacher_id INT,
  FOREIGN KEY (direction_id) REFERENCES directions(direction_id),
  FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE grades (
  grade_id SERIAL PRIMARY KEY,
  student_id INT NOT NULL,
  subject_id INT NOT NULL,
  grade_value INT CHECK (grade_value >= 2 AND grade_value <= 5),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
 );
 
-- Задание 5

-- Вывести списки групп каждому предмету с указанием преподавателя
SELECT s.subject_name, g.group_name, t.teacher_name
FROM subjects s
JOIN groups g ON s.direction_id = g.direction_id
JOIN teachers t ON s.teacher_id = t.teacher_id;

-- Определить, какую дисциплину изучает максимальное количество студентов:
SELECT s.subject_name, COUNT() AS student_count FROM grades g JOIN subjects s ON g.subject_id = s.subject_id GROUP BY s.subject_name ORDER BY COUNT() DESC
LIMIT 1;

-- Определить, сколько студентов обучаются у каждого из преподавателей:
SELECT t.teacher_name, COUNT(DISTINCT g.student_id) AS student_count
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
JOIN teachers t ON s.teacher_id = t.teacher_id
GROUP BY t.teacher_name;

-- Определить долю ставших студентов по каждой дисциплине (не оценки или 2 считать не сдавшими):
SELECT s.subject_name,
COUNT(CASE WHEN g.grade_value > 2 THEN 1 END) / COUNT(*) AS pass_ratio
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
GROUP BY s.subject_name;

-- Определить среднюю оценку по предметам (для сдавших студентов):
SSELECT s.subject_name, AVG(g.grade_value) AS average_grade
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
WHERE g.grade_value > 2
GROUP BY s.subject_name;

-- Определить группу с максимальной средней оценкой (включая не сдавших):
SELECT g.group_name, AVG(g.grade_value) AS average_grade
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
JOIN groups gr ON s.direction_id = gr.direction_id
GROUP BY g.group_name
ORDER BY average_grade DESC
LIMIT 1;

-- Вывести студентов со всеми оценками отлично и не имеющих несданный экзамен:
SELECT s.student_id, s.name
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE NOT EXISTS (
	SELECT 1
	FROM subjects subj
	WHERE NOT EXISTS (
		SELECT 1
		FROM grades gr
		WHERE gr.subject_id = subj.subject_id AND gr.student_id = s.student_id AND gr.grade_value = 5
	)
);

-- Вывести кандидатов на отчисление (не сдано не менее двух предметов):
SELECT s.student_id, s.name
FROM students s
WHERE (
	SELECT COUNT(DISTINCT g.subject_id)
	FROM grades g
	WHERE g.student_id = s.student_id AND g.grade_value > 2
) < 2;

-- Задание 6

CREATE TABLE timetable (
    timetable_id SERIAL PRIMARY KEY,
    group_id INT NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    start_time TIME,
    end_time TIME,
    day_of_week VARCHAR(20),
    FOREIGN KEY (group_id) REFERENCES groups(group_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    timetable_id INT NOT NULL,
    attendance_date DATE,
    is_present BOOLEAN,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (timetable_id) REFERENCES timetable(timetable_id)
);

-- Задание 7

-- Вывести по заданному предмету количество посещенных занятий:
SELECT s.subject_name, COUNT(*) AS attended_count
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects s ON t.subject_id = s.subject_id
WHERE a.is_attended = true
GROUP BY s.subject_name;

-- Вывести по заданному предмету количество пропущенных занятий:
SELECT s.subject_name, COUNT(*) AS missed_count
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects s ON t.subject_id = s.subject_id
WHERE NOT a.is_attended
GROUP BY s.subject_name;

-- Вывести по заданному преподавателю количество студентов на каждом занятии:
SELECT t.teacher_name, s.subject_name, COUNT(DISTINCT a.student_id) AS student_count
FROM attendance a
JOIN timetable tm ON a.timetable_id = tm.timetable_id
JOIN subjects s ON tm.subject_id = s.subject_id
JOIN teachers t ON tm.teacher_id = t.teacher_id
GROUP BY t.teacher_name, s.subject_name;

-- Для каждого студента вывести общее время, потраченное на изучение каждого предмета:
SELECT s.student_id, s.name, sub.subject_name,
       ( SELECT '00:' || (SUM(EXTRACT(EPOCH FROM (t.end_time - t.start_time))) || ' seconds')::interval )
         AS total_time
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects sub ON t.subject_id = sub.subject_id
JOIN students s ON a.student_id = s.student_id
GROUP BY s.student_id, sub.subject_name;