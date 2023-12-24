-- Задание 1
CREATE TABLE `students` (
	`student_id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(100),
	`birthday` DATE,
	`address_id` int,
	`phone_id` int,
	`email` varchar(100),
	`group_id` int,
	`is_budget` BOOLEAN,
	PRIMARY KEY (`student_id`)
);

CREATE TABLE `groups` (
	`group_id` int NOT NULL,
	`group_name` varchar(100),
	`direction_id` int NOT NULL,
	PRIMARY KEY (`group_id`)
);

CREATE TABLE `directions` (
	`direction_id` int NOT NULL,
	`direction_name` varchar(100),
	PRIMARY KEY (`direction_id`)
);

CREATE TABLE `addresses` (
    `address_id` INT NOT NULL,
    `city` VARCHAR(50),
    `street` VARCHAR(100),
    `house_number` VARCHAR(10),
 	PRIMARY KEY (`address_id`)
);

CREATE TABLE `phones` (
    `phone_id` INT NOT NULL,
    `phone_number` VARCHAR(20),
  	PRIMARY KEY (`phone_id`)
);

ALTER TABLE `students` ADD CONSTRAINT `students_fk0` FOREIGN KEY (`group_id`) REFERENCES `groups`(`group_id`);

ALTER TABLE `students` ADD CONSTRAINT `students_fk1` FOREIGN KEY (`address_id`) REFERENCES `addresses`(`address_id`);

ALTER TABLE `students` ADD CONSTRAINT `students_fk2` FOREIGN KEY (`phone_id`) REFERENCES `phones`(`phone_id`);

ALTER TABLE `groups` ADD CONSTRAINT `groups_fk0` FOREIGN KEY (`direction_id`) REFERENCES `directions`(`direction_id`);

-- Задание 2

INSERT directions(direction_id, direction_name) VALUES 
(1, "FI"),
(2, "IS"),
(3, "PI");

INSERT groups(group_id, group_name, direction_id) VALUES
(1, "FI101", 1),
(2, "FI201", 1),
(3, "FI202", 1);


INSERT groups (group_id, group_name, direction_id) VALUES 
(4, "IS101", 2),
(5, "IS201", 2),
(6, "IS202", 2);

INSERT groups (group_id, group_name, direction_id) VALUES 
(7, "PI101", 3),
(8, "PI201", 3),
(9, "PI202", 3);

-- FI101
INSERT addresses(address_id, city, street, house_number) VALUES
(1, "город Красногорск", " пл. Чехова", "11"),
(2, "город Пушкино", "шоссе Славы", "42"),
(3, "город Коломна", "ул. Ленина", "73"),
(4, "город Одинцово", "пл. Домодедовская", "65"),
(5, "город Балашиха", " пр. Ленина", "82"),
(6, "город Видное", "въезд 1905 года", "1"),
(7, "город Дорохово", "проезд Будапештсткая", "76");

INSERT phones(phone_id, phone_number) VALUES
(1, "(35222) 93-8908"),
(2, "(35222) 92-5037"),
(3, "(495) 733-9728"),
(4, "8-800-822-0588"),
(5, "(35222) 10-9712"),
(6, "(495) 765-0119"),
(7, "(35222) 61-8282");

INSERT students(name, birthday, address_id, phone_id, email, group_id, is_budget) VALUES 
("Егоров Александр Романович", "2004-03-14", 1, 1, "fritsch.josefina@gmail.com", 1, False),
("Лобанова Виктория Романовна", "2003-06-16", 2, 2, "vida.maggio@yahoo.com", 1, True),
("Прохорова Дарья Филипповна", "2002-07-11", 3, 3, "sbahringer@hotmail.com", 1, False),
("Шапошников Владимир Мирославович", "2003-10-31", 4, 4, "krajcik.ashly@yahoo.com", 1, True),
("Прохоров Вадим Иванович", "2002-07-20", 5, 5, "jaylon.schneider@schroeder.com", 1, False),
("Островский Семён Константинович", "2002-01-24", 6, 6, "junius.cremin@hotmail.com", 1, False),
("Пахомова Арина Васильевна", "2002-09-22", 7, 7, "adelbert.tremblay@yahoo.com", 1, True);

-- FI201
INSERT addresses(address_id, city, street, house_number) VALUES
(8, "город Мытищи", "наб. Космонавтов", "2"),
(9, "город Озёры", "бульвар Чехова", "2"),
(10, "город Мытищи", "бульвар Гагарина", "82"),
(11, "город Павловский Посад", "спуск Лениная", "47"),
(12, "город Ногинск", "шоссе Бухарестская", "33"),
(13, "город Шаховская", "ул. Чехова", "71"),
(14, "город Серпухов", "бульвар Сталина", "85");
(15, "город Коломна", "бульвар Сталина", "27");

INSERT phones(phone_id, phone_number) VALUES
(8, "+7 (922) 046-1753"),
(9, "(495) 819-8838"),
(10, "(35222) 13-1192"),
(11, "8-800-399-6199"),
(12,"(35222) 70-0249"),
(13, "(495) 293-5869"),
(14, "8-800-535-2513");
(15, "(35222) 74-0411");

INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Серов Тимофей Миронович", "2003-02-07", 8, 8, "hfarrell@gmail.com", 2, True),
("Спиридонова Аделина Кирилловна", "2003-11-15", 9, 9, "hope06@gmail.com", 2, True),
("Нечаева София Владимировна", "2003-11-10", 10, 10, "ismael82@yahoo.com", 2, False),
("Березин Артём Святославович", "2003-02-05", 11, 11, "bertrand.sanford@armstrong.com", 2, False),
("Прокофьев Алексей Васильевич", "2003-04-15", 12, 12, "nayeli.schoen@hotmail.com", 2, True),
("Морозова Кира Владимировна", "2004-04-28", 13, 13, "xbauch@yahoo.com", 2, False),
("Трифонов Михаил Алексеевич", "2004-05-14", 14, 14, "fritsch@hahn.net", 2, False),
("Кудрявцев Михаил Артёмович", "2003-11-17", 15, 15, "ylangworth@hotmail.co", 2, True);


-- FI202
INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Ушакова Виктория Данииловна", "2002-09-23", "город Шаховская, проезд Славы, 79", "8-800-752-7641", "tbecker@schiller.com", 3, True),
("Давыдов Станислав Михайлович", "2003-12-20", "город Шаховская, въезд Ленина, 17", "(812) 439-61-32", "daisha.nitzsche@bashirian.org", 3, True),
("Яковлев Егор Андреевич", "2004-08-17", "город Ступино, въезд Ломоносова, 78", "(35222) 59-5439", "bkeebler@gmail.com", 3, False),
("Фролов Иван Фёдорович", "2003-12-06", "город Серпухов, бульвар Бухарестская, 9", "(35222) 59-5439", "keegan.wolf@yahoo.com", 3, False),
("Новикова Анна Владиславовна", "2004-05-02", "город Лотошино, ул. Сталина, 92", "8-800-362-5827", "hulda51@dietrich.com", 3, False),
("Маслова Анисия Арсеновна", "2003-03-26", "город Дмитров, шоссе Балканская, 51", "(495) 796-3123", "ortiz.pinkie@windler.net", 3, True),
("Ушакова Виктория Данииловна", "2003-06-10", " город Сергиев Посад, наб. Сталина, 79", "8-800-586-4536", "chloe.kiehn@yahoo.com", 3, True);

-- IS101
INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Иванова Вероника Стефановна", "2002-05-01", "город Егорьевск, ул. Гоголя, 31", "(495) 563-4031", "amara38@champlin.com", 4, True),
("Ермолова Валерия Алексеевна", "2002-03-20", "город Озёры, ул. Ленина, 84", "(812) 202-78-14", "eduardo.dubuque@walker.com", 4, True),
("Чернышева Анна Максимовна", "2003-07-20", "город Чехов, наб. Ленина, 14", "+7 (922) 609-9463", "aletha90@hotmail.com", 4, True),
("Моисеев Даниил Кириллович", "2004-07-25", "город Чехов, наб. Сталина, 55", "8-800-082-6615", "rudolph.cartwright@jenkins.com", 4, False),
("Куликова Ольга Глебовна", "2004-05-16", "город Шаховская, шоссе Ленина, 42", "8-800-835-0693", "calista82@yahoo.com", 4, False),
("Иванова Эмма Романовна", "2002-04-23", "город Шаховская, спуск Космонавтов, 13", "(35222) 56-1888", "porter.bruen@mayert.info", 4, True),
("Родионова Анна Владимировна", "2002-04-22", "город Можайск, въезд Ломоносова, 75", "(495) 330-3545", "stanton.manuel@yahoo.com", 4, True),
("Шевцова Ксения Ивановна", "2003-09-18", "город Люберцы, бульвар Славы, 60", "(812) 189-95-33", "amber04@hotmail.com", 4, True);

-- IS201
INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Ермолова Валерия Алексеевна", "2004-02-29", "город Балашиха, въезд Космонавтов, 74", "(35222) 08-4679", "sanford.gutkowski@beatty.com", 5, True),
("Чернышева Анна Максимовна", "2003-06-10", "город Щёлково, пр. Ломоносова, 64", "(812) 888-80-11", "manley.huels@hotmail.com", 5, True),
("Моисеев Даниил Кириллович", "2002-05-01", "город Ногинск, проезд Будапештсткая, 27", "(495) 673-5816", "annalise.bruen@yahoo.com", 5, True),
("Иванова Эмма Романовна", "2002-03-20", "город Егорьевск, пер. Славы, 55", "8-800-311-1246", "claude.hamill@hotmail.com", 5, False),
("Родионова Анна Владимировна", "2003-07-20", "город Ступино, пл. Балканская, 33", "8-800-622-7898", "tressa.schaden@hoeger.com", 5, False),
("Шевцова Ксения Ивановна", "2004-07-25", "город Шаховская, въезд Чехова, 14", "(35222) 01-8840", "mcdermott.lelah@block.com", 5, False),
("Зверев Максим Эмирович", "2004-05-16", "город Раменское, пр. Гагарина, 86", "(812) 814-74-78", "damion53@yahoo.com", 5, False);

-- IS202
INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Беляева Мария Матвеевна", "2002-04-23", "город Павловский Посад, наб. Гоголя, 34", "8-800-327-2499", "avern.fahey@hotmail.com", 6, True),
("Шаповалов Денис Егорович", "2003-09-18", "город Павловский Посад, пер. Гагарина, 75", "+7 (922) 263-8691", "moore.scarlett@ortiz.com", 6, True),
("Морозова Нина Евгеньевна", "2004-02-29", "город Видное, пер. Славы, 44", "(35222) 85-0144", "qmoen@hotmail.com", 6, False),
("Лобанова Алиса Егоровна", "2003-08-10", "город Волоколамск, бульвар Бухарестская, 33", "(35222) 99-4382", "kkirlin@mclaughlin.com", 6, True),
("Киселев Артём Фёдорович", "2003-06-24", "город Шатура, бульвар Славы, 27", "(812) 798-80-95", "jamir14@yahoo.com", 6, False),
("Казаков Семён Даниилович", "2004-05-16", "город Ногинск, проезд Славы, 45", "(35222) 54-7547", "laverna33@williamson.info", 6, False),
("Латышева Анастасия Григорьевна", "2004-07-13", "город Воскресенск, въезд Сталина, 94", "+7 (922) 153-7723", "lkoss@hotmail.com", 6, False);

-- PI101
INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Иванова Екатерина Кирилловна", "2004-09-17", "город Шаховская, пр. Гоголя, 81", "(812) 547-04-69", "mohr.tyrique@hotmail.com", 7, True),
("Широков Роберт Константинович", "2003-05-16", "город Мытищи, въезд Ленина, 88", "(812) 237-76-49", "amara24@hotmail.com", 7, True),
("Климова Виктория Владимировна", "2004-07-10", "город Дмитров, ул. Балканская, 12", "(35222) 27-8230", "jeramy.pagac@yahoo.com", 7, True),
("Тарасов Антон Романович", "2003-12-03", "город Москва, спуск Гоголя, 75", "(35222) 47-3294", "della.rolfson@denesik.com", 7, False),
("Зайцев Сергей Георгиевич", "2002-03-03", "город Чехов, проезд Балканская, 93", "+7 (922) 068-5584", "auer.victoria@lind.com", 7, False),
("Зиновьева Арина Дмитриевна", "2003-09-05", "город Павловский Посад, проезд Ладыгина, 06", "8-800-207-0915", "alessia84@gmail.com", 7, False),
("Николаев Лев Тимурович", "2004-07-08", "город Щёлково, пр. Ладыгина, 93", "(812) 648-53-84", "gwilkinson@pfannerstill.com", 7, False),
("Михайлова Арина Олеговна", "2004-03-15", "город Кашира, въезд Домодедовская, 04", "+7 (922) 424-9466", "metz.jamel@yahoo.com", 7, False);

-- PI201
INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Ильинский Марк Михайлович", "2004-02-01", "город Домодедово, шоссе Гоголя, 42", "+7 (922) 796-6026", "vonrueden.miles@hotmail.com", 8, True),
("Баранов Алексей Максимович", "2003-06-30", "город Серпухов, наб. Бухарестская, 04", "+7 (922) 950-1437", "denesik.lilyan@brakus.com", 8, False),
("Панкратов Дмитрий Никитич", "2002-03-29", "город Егорьевск, въезд Ленина, 01", "(35222) 86-3396", "kennith08@schamberger.net", 8, True),
("Рыбаков Андрей Артёмович", "2004-03-08", "город Луховицы, пл. Ленина, 41", "(35222) 01-1284", "silas34@hotmail.com", 8, False),
("Покровская Таисия Алексеевна", "2002-05-25", "город Домодедово, шоссе Домодедовская, 65", "8-800-181-8334", "ruecker.donna@mohr.com", 8, True),
("Семенов Александр Ильич", "2002-12-14", "город Красногорск, спуск Ладыгина, 26", "+7 (922) 008-7679", "grant.summer@abernathy.com", 8, True),
("Данилов Глеб Даниилович", "2002-04-05", "город Шатура, спуск Ломоносова, 67", "(812) 922-84-96", "lorna98@hotmail.com", 8, False);

-- PI202
INSERT students(name, birthday, address, phone, email, group_id, is_budget) VALUES 
("Сальникова Майя Евгеньевна", "2002-01-13", "город Орехово-Зуево, проезд Гоголя, 25", "(35222) 91-9949", "nicola.collins@yahoo.com", 9, False),
("Демьянова Ника Егоровна", "2003-02-06", "город Пушкино, пер. Ломоносова, 47", "8-800-083-9880", "hirthe.ramiro@yahoo.com", 9, True),
("Максимов Никита Эмирович", "2004-01-22", "город Егорьевск, спуск Ленина, 04", "(35222) 21-9732", "floy.towne@mitchell.org", 9, False),
("Кудрявцева Екатерина Евгеньевна", "2002-01-04", "город Дорохово, наб. Ленина, 09", "(812) 835-69-15", "clifford.goyette@botsford.com", 9, True),
("Анисимова Есения Романовна", "2002-02-03", "город Дорохово, ул. Славы, 14", "8-800-179-5688", "erdman.gussie@yahoo.com", 9, False),
("Андреева Анна Данииловна", "2003-01-11", "город Шаховская, спуск Гагарина, 97", "(495) 549-7142", "mills.green@keebler.biz", 9, True),
("Чеботарев Александр Евгеньевич", "2004-03-27", "город Красногорск, бульвар Будапештсткая, 60", "8-800-559-7829", "leannon.jerod@gmail.com", 9, True);

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
SELECT s.name AS 'ФИО', g.group_id AS 'Номер группы', d.direction_name AS 'Направление'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
WHERE s.name LIKE 'Твоя_фамилия%'
ORDER BY s.name;

-- Вывести список студентов для поздравления по месяцам рождения

SELECT s.name AS 'Фамилия И.О.',
       DAY(s.birthday) AS 'День рождения',
       MONTHNAME(s.birthday) AS 'Месяц рождения',
       g.group_id AS 'Номер группы',
       d.direction_name AS 'Направление'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
ORDER BY MONTH(s.birthday);

-- Вывести студентов с указанием возраста в годах
SELECT s.name AS 'ФИО',
       TIMESTAMPDIFF(YEAR, s.birthday, CURDATE()) AS 'Возраст (лет)',
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
WHERE MONTH(s.birthday) = MONTH(CURDATE());

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
       SUM(CASE WHEN s.is_budget THEN 1 ELSE 0 END) AS 'Бюджетные места',
       SUM(CASE WHEN NOT s.is_budget THEN 1 ELSE 0 END) AS 'Внебюджетные места'
FROM students s
JOIN groups g ON s.group_id = g.group_id
JOIN directions d ON g.direction_id = d.direction_id
GROUP BY g.group_id, d.direction_name;

-- Задание 4

CREATE TABLE teachers (
    teacher_id INT NOT NULL AUTO_INCREMENT,
    teacher_name VARCHAR(100),
    PRIMARY KEY (teacher_id)
);

CREATE TABLE subjects (
    subject_id INT NOT NULL AUTO_INCREMENT,
    subject_name VARCHAR(100),
    direction_id INT NOT NULL,
    teacher_id INT,
    PRIMARY KEY (subject_id),
    FOREIGN KEY (direction_id) REFERENCES directions(direction_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE grades (
    grade_id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    grade_value INT CHECK (grade_value >= 2 AND grade_value <= 5),
    PRIMARY KEY (grade_id),
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
SELECT s.subject_name, COUNT(*) AS student_count
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
GROUP BY s.subject_name
ORDER BY student_count DESC
LIMIT 1;

-- Определить, сколько студентов обучаются у каждого из преподавателей:
SELECT t.teacher_name, COUNT(DISTINCT g.student_id) AS student_count
FROM grades g
JOIN subjects s ON g.subject_id = s.subject_id
JOIN teachers t ON s.teacher_id = t.teacher_id
GROUP BY t.teacher_name;

-- Определить долю сдавших студентов по каждой дисциплине (не оценки или 2 считать не сдавшими):
SELECT s.subject_name,
       COUNT(CASE WHEN g.grade_value > 2 THEN 1 END) / COUNT(*) AS pass_ratio
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
    timetable_id INT NOT NULL AUTO_INCREMENT,
    day DATE,
    start_time TIME,
    end_time TIME,
    subject_id INT,
    teacher_id INT,
    PRIMARY KEY (timetable_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE attendance (
    attendance_id INT NOT NULL AUTO_INCREMENT,
    student_id INT,
    timetable_id INT,
    is_attended BOOLEAN,
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
WHERE a.is_attended = true
GROUP BY s.subject_name;

-- Вывести по заданному предмету количество пропущенных занятий:
SELECT s.subject_name, COUNT(*) AS missed_count
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects s ON t.subject_id = s.subject_id
WHERE a.is_attended = false
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
       SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(t.end_time, t.start_time)))) AS total_time
FROM attendance a
JOIN timetable t ON a.timetable_id = t.timetable_id
JOIN subjects sub ON t.subject_id = sub.subject_id
JOIN students s ON a.student_id = s.student_id
GROUP BY s.student_id, sub.subject_name;