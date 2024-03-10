-- Задание 1
CREATE TABLE students (
    student_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100),
    birthday DATE,
    address_id INT,
    phone_id INT,
    email VARCHAR(100),
    group_id INT,
    is_budget BIT
);

CREATE TABLE groups (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(100),
    direction_id INT NOT NULL
);

CREATE TABLE directions (
    direction_id INT PRIMARY KEY,
    direction_name VARCHAR(100)
);

CREATE TABLE addresses (
    address_id INT PRIMARY KEY,
    city VARCHAR(50),
    street VARCHAR(100),
    house_number VARCHAR(10)
);

CREATE TABLE phones (
    phone_id INT PRIMARY KEY,
    phone_number VARCHAR(20)
);

ALTER TABLE students ADD CONSTRAINT students_fk0 FOREIGN KEY (group_id) REFERENCES groups(group_id);

ALTER TABLE students ADD CONSTRAINT students_fk1 FOREIGN KEY (address_id) REFERENCES addresses(address_id);

ALTER TABLE students ADD CONSTRAINT students_fk2 FOREIGN KEY (phone_id) REFERENCES phones(phone_id);

ALTER TABLE groups ADD CONSTRAINT groups_fk0 FOREIGN KEY (direction_id) REFERENCES directions(direction_id);

-- Задание 2

-- Вставка направлений
INSERT INTO directions(direction_id, direction_name) VALUES 
(1, 'FI'),
(2, 'IS'),
(3, 'PI');

-- Вставка групп
INSERT INTO groups(group_id, group_name, direction_id) VALUES
(1, 'FI101', 1),
(2, 'FI201', 1),
(3, 'FI202', 1),
(4, 'IS101', 2),
(5, 'IS201', 2),
(6, 'IS202', 2),
(7, 'PI101', 3),
(8, 'PI201', 3),
(9, 'PI202', 3);

-- Вставка адресов
-- FI101
INSERT INTO addresses(address_id, city, street, house_number) VALUES
(1, 'город Красногорск', 'пл. Чехова', '11'),
(2, 'город Пушкино', 'шоссе Славы', '42'),
(3, 'город Коломна', 'ул. Ленина', '73'),
(4, 'город Одинцово', 'пл. Домодедовская', '65'),
(5, 'город Балашиха', 'пр. Ленина', '82'),
(6, 'город Видное', 'въезд 1905 года', '1'),
(7, 'город Дорохово', 'проезд Будапештсткая', '76');

-- FI201
INSERT INTO addresses(address_id, city, street, house_number) VALUES
(8, 'город Мытищи', 'наб. Космонавтов', '2'),
(9, 'город Озёры', 'бульвар Чехова', '2'),
(10, 'город Мытищи', 'бульвар Гагарина', '82'),
(11, 'город Павловский Посад', 'спуск Лениная', '47'),
(12, 'город Ногинск', 'шоссе Бухарестская', '33'),
(13, 'город Шаховская', 'ул. Чехова', '71'),
(14, 'город Серпухов', 'бульвар Сталина', '85'),
(15, 'город Коломна', 'бульвар Сталина', '27');

-- Вставка телефонов
INSERT INTO phones(phone_id, phone_number) VALUES
(1, '(35222) 93-8908'),
(2, '(35222) 92-5037'),
(3, '(495) 733-9728'),
(4, '8-800-822-0588'),
(5, '(35222) 10-9712'),
(6, '(495) 765-0119'),
(7, '(35222) 61-8282'),
(8, '+7 (922) 046-1753'),
(9, '(495) 819-8838'),
(10, '(35222) 13-1192'),
(11, '8-800-399-6199'),
(12, '(35222) 70-0249'),
(13, '(495) 293-5869'),
(14, '8-800-535-2513'),
(15, '(35222) 74-0411');

-- Вставка студентов
-- FI101
INSERT INTO students(name, birthday, address_id, phone_id, email, group_id, is_budget) VALUES 
('Егоров Александр Романович', '2004-03-14', 1, 1, 'fritsch.josefina@gmail.com', 1, 0),
('Лобанова Виктория Романовна', '2003-06-16', 2, 2, 'vida.maggio@yahoo.com', 1, 1),
('Прохорова Дарья Филипповна', '2002-07-11', 3, 3, 'sbahringer@hotmail.com', 1, 0),
('Шапошников Владимир Мирославович', '2003-10-31', 4, 4, 'krajcik.ashly@yahoo.com', 1, 1),
('Прохоров Вадим Иванович', '2002-07-20', 5, 5, 'jaylon.schneider@schroeder.com', 1, 0),
('Островский Семён Константинович', '2002-01-24', 6, 6, 'junius.cremin@hotmail.com', 1, 0),
('Пахомова Арина Васильевна', '2002-09-22', 7, 7, 'adelbert.tremblay@yahoo.com', 1, 1);

-- FI201
INSERT INTO students(name, birthday, address_id, phone_id, email, group_id, is_budget) VALUES 
('Серов Тимофей Миронович', '2003-02-07', 8, 8, 'hfarrell@gmail.com', 2, 1),
('Спиридонова Аделина Кирилловна', '2003-11-15', 9, 9, 'hope06@gmail.com', 2, 1),
('Нечаева София Владимировна', '2003-11-10', 10, 10, 'ismael82@yahoo.com', 2, 0),
('Березин Артём Святославович', '2003-02-05', 11, 11, 'bertrand.sanford@armstrong.com', 2, 0),
('Прокофьев Алексей Васильевич', '2003-04-15', 12, 12, 'nayeli.schoen@hotmail.com', 2, 1),
('Морозова Кира Владимировна', '2004-04-28', 13, 13, 'xbauch@yahoo.com', 2, 0),
('Трифонов Михаил Алексеевич', '2004-05-14', 14, 14, 'fritsch@hahn.net', 2, 0),
('Кудрявцев Михаил Артёмович', '2003-11-17', 15, 15, 'ylangworth@hotmail.co', 2, 1);

-- Задание 3

-- Вывести списки групп по заданному направлению с указанием номера группы в формате ФИО, бюджет/внебюджет. Студентов выводить в алфавитном порядке.
SELECT CONCAT(s.name, ', ', IIF(s.is_budget = 1, 'бюджет', 'внебюджет')) AS 'Студенты',
       g.group_name AS 'Номер группы'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
WHERE d.direction_name = 'Твое направление'
ORDER BY s.name;

-- Вывести студентов с фамилией, начинающейся с первой буквы вашей фамилии, с указанием ФИО, номера группы и направления обучения
SELECT s.name AS 'ФИО', g.group_id AS 'Номер группы', d.direction_name AS 'Направление'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
WHERE s.name LIKE 'Твоя_фамилия%'
ORDER BY s.name;

-- Вывести список студентов для поздравления по месяцам рождения
SELECT s.name AS 'Фамилия И.О.',
       DAY(s.birthday) AS 'День рождения',
       DATENAME(MONTH, s.birthday) AS 'Месяц рождения',
       g.group_id AS 'Номер группы',
       d.direction_name AS 'Направление'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
ORDER BY MONTH(s.birthday);

-- Вывести студентов с указанием возраста в годах
SELECT s.name AS 'ФИО',
       DATEDIFF(YEAR, s.birthday, GETDATE()) AS 'Возраст (лет)',
       g.group_id AS 'Номер группы',
       d.direction_name AS 'Направление'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id;

-- Вывести студентов с днем рождения в текущем месяце
SELECT s.name AS 'ФИО',
       DAY(s.birthday) AS 'День рождения',
       g.group_id AS 'Номер группы',
       d.direction_name AS 'Направление'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
WHERE MONTH(s.birthday) = MONTH(GETDATE());

-- Вывести количество студентов по каждому направлению
SELECT d.direction_name AS 'Направление',
       COUNT(s.student_id) AS 'Количество студентов'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
GROUP BY d.direction_name;

-- Вывести количество бюджетных и внебюджетных мест по группам
SELECT g.group_id AS 'Номер группы',
       d.direction_name AS 'Название направления',
       SUM(CASE WHEN s.is_budget = 1 THEN 1 ELSE 0 END) AS 'Бюджетные места',
       SUM(CASE WHEN s.is_budget = 0 THEN 1 ELSE 0 END) AS 'Внебюджетные места'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
GROUP BY g.group_id, d.direction_name;

-- Задание 4

CREATE TABLE teachers (
    teacher_id INT IDENTITY(1,1) PRIMARY KEY,
    teacher_name VARCHAR(100)
);

CREATE TABLE subjects (
    subject_id INT IDENTITY(1,1) PRIMARY KEY,
    subject_name VARCHAR(100),
    direction_id INT NOT NULL,
    teacher_id INT,
    FOREIGN KEY (direction_id) REFERENCES directions(direction_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE grades (
    grade_id INT IDENTITY(1,1) PRIMARY KEY,
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
SELECT TOP 1 WITH TIES s.subject_name, COUNT(*) AS student_count
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
GROUP BY s.subject_name
ORDER BY student_count DESC;

-- Определить, сколько студентов обучаются у каждого из преподавателей:
SELECT t.teacher_name, COUNT(DISTINCT g.student_id) AS student_count
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
JOIN teachers t ON s.teacher_id = t.teacher_id
GROUP BY t.teacher_name;

-- Определить долю сдавших студентов по каждой дисциплине (не оценки или 2 считать не сдавшими):
SELECT s.subject_name,
       1.0 * COUNT(CASE WHEN g.grade_value > 2 THEN 1 END) / COUNT(*) AS pass_ratio
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
GROUP BY s.subject_name;

-- Определить среднюю оценку по предметам (для сдавших студентов):
SELECT s.subject_name, AVG(g.grade_value) AS average_grade
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
WHERE g.grade_value > 2
GROUP BY s.subject_name;

-- Определить группу с максимальной средней оценкой (включая не сдавших):
SELECT TOP 1 WITH TIES g.group_name, AVG(g.grade_value) AS average_grade
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
JOIN groups gr ON s.direction_id = gr.direction_id
GROUP BY g.group_name
ORDER BY average_grade DESC;

-- Вывести студентов со всеми оценками отлично и не имеющих несданный экзамен:
SELECT s.student_id, s.name
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.name
HAVING COUNT(DISTINCT g.subject_id) = (SELECT COUNT(*) FROM subjects)
   AND NOT EXISTS (
       SELECT 1
       FROM grades gr
       WHERE gr.student_id = s.student_id AND gr.grade_value <> 5
   );

-- Вывести кандидатов на отчисление (не сдано не менее двух предметов):
SELECT s.student_id, s.name
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.name
HAVING COUNT(DISTINCT CASE WHEN g.grade_value > 2 THEN g.subject_id END) < 2;


-- Задание 6
CREATE TABLE timetable (
    timetable_id INT NOT NULL IDENTITY(1,1),
    [day] DATE,
    start_time TIME,
    end_time TIME,
    subject_id INT,
    teacher_id INT,
    PRIMARY KEY (timetable_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE attendance (
    attendance_id INT NOT NULL IDENTITY(1,1),
    student_id INT,
    timetable_id INT,
    is_attended BIT,
    PRIMARY KEY (attendance_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (timetable_id) REFERENCES timetable(timetable_id)
);

-- Задание 7

-- Вывести по заданному предмету количество посещенных занятий:
SELECT s.subject_name, COUNT(*) AS attended_count
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects s ON t.subject_id = s.subject_id
WHERE a.is_attended = 1
GROUP BY s.subject_name;

-- Вывести по заданному предмету количество пропущенных занятий:
SELECT s.subject_name, COUNT(*) AS missed_count
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects s ON t.subject_id = s.subject_id
WHERE a.is_attended = 0
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
       CONVERT(TIME, DATEADD(SECOND, SUM(DATEDIFF(SECOND, t.start_time, t.end_time)), 0)) AS total_time
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects sub ON t.subject_id = sub.subject_id
JOIN students s ON a.student_id = s.student_id
GROUP BY s.student_id, sub.subject_name;
