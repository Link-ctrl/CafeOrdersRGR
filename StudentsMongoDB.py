from pymongo import MongoClient
from datetime import datetime

# Подключение к локальной MongoDB
client = MongoClient('localhost', 27017)
db = client['university_db']

# Создание коллекций
students = db['students']
groups = db['groups']
directions = db['directions']
addresses = db['addresses']
phones = db['phones']

# Пример вставки данных

# Вставка направления
direction_data = {
    "_id": 1,
    "direction_name": "Computer Science"
}
directions.insert_one(direction_data)

# Вставка группы
group_data = {
    "_id": 1,
    "group_name": "CS101",
    "direction": direction_data  # Вложенный документ направления
}
groups.insert_one(group_data)

# Вставка адреса
address_data = {
    "_id": 1,
    "city": "New York",
    "street": "5th Avenue",
    "house_number": "10"
}
addresses.insert_one(address_data)

# Вставка телефона
phone_data = {
    "_id": 1,
    "phone_number": "+1234567890"
}
phones.insert_one(phone_data)

# Вставка студента
student_data = {
    "name": "John Doe",
    "birthday": "1995-05-15",
    "address": address_data,  # Вложенный документ адреса
    "phone": phone_data,  # Вложенный документ телефона
    "email": "john.doe@example.com",
    "group": group_data,  # Вложенный документ группы
    "is_budget": True
}
students.insert_one(student_data)

# Задание 3 

# 1. Списки групп по заданному направлению с указанием номера группы в формате ФИО, бюджет/внебюджет. Студентов выводить в алфавитном порядке.
def get_students_by_direction(direction_name):
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'group.group_id',
                'foreignField': '_id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$lookup': {
                'from': 'directions',
                'localField': 'group.direction.direction_id',
                'foreignField': '_id',
                'as': 'direction'
            }
        },
        {
            '$unwind': '$direction'
        },
        {
            '$match': {
                'direction.direction_name': direction_name
            }
        },
        {
            '$project': {
                'Студенты': {
                    '$concat': ['$name', ', ', {'$cond': [{'$eq': ['$is_budget', True]}, 'бюджет', 'внебюджет']}]
                },
                'Номер группы': '$group.group_name'
            }
        },
        {
            '$sort': {
                'name': 1
            }
        }
    ])
    return list(result)

# 2. Студенты с фамилией, начинающейся с первой буквы вашей фамилии, с указанием ФИО, номера группы и направления обучения
def get_students_by_surname_letter(surname_letter):
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'group.group_id',
                'foreignField': '_id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$lookup': {
                'from': 'directions',
                'localField': 'group.direction.direction_id',
                'foreignField': '_id',
                'as': 'direction'
            }
        },
        {
            '$unwind': '$direction'
        },
        {
            '$match': {
                'name': {'$regex': f'^{surname_letter}'}
            }
        },
        {
            '$project': {
                'ФИО': '$name',
                'Номер группы': '$group.group_id',
                'Направление': '$direction.direction_name'
            }
        },
        {
            '$sort': {
                'name': 1
            }
        }
    ])
    return list(result)

# 3. Список студентов для поздравления по месяцам рождения
def get_students_by_birthday_month():
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'group.group_id',
                'foreignField': '_id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$lookup': {
                'from': 'directions',
                'localField': 'group.direction.direction_id',
                'foreignField': '_id',
                'as': 'direction'
            }
        },
        {
            '$unwind': '$direction'
        },
        {
            '$project': {
                'Фамилия И.О.': '$name',
                'День рождения': {'$dayOfMonth': '$birthday'},
                'Месяц рождения': {'$month': '$birthday'},
                'Номер группы': '$group.group_id',
                'Направление': '$direction.direction_name'
            }
        },
        {
            '$sort': {
                'Месяц рождения': 1,
                'День рождения': 1
            }
        }
    ])
    return list(result)

# 4. Студенты с указанием возраста в годах
def get_students_with_age():
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'group.group_id',
                'foreignField': '_id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$lookup': {
                'from': 'directions',
                'localField': 'group.direction.direction_id',
                'foreignField': '_id',
                'as': 'direction'
            }
        },
        {
            '$unwind': '$direction'
        },
        {
            '$project': {
                'ФИО': '$name',
                'Возраст (лет)': {
                    '$subtract': [
                        {'$year': datetime.now()},
                        {'$year': '$birthday'}
                    ]
                },
                'Номер группы': '$group.group_id',
                'Направление': '$direction.direction_name'
            }
        }
    ])
    return list(result)

# 5. Студенты с днем рождения в текущем месяце
def get_students_with_birthday_this_month():
    current_month = datetime.now().month
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'group.group_id',
                'foreignField': '_id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$lookup': {
                'from': 'directions',
                'localField': 'group.direction.direction_id',
                'foreignField': '_id',
                'as': 'direction'
            }
        },
        {
            '$unwind': '$direction'
        },
        {
            '$match': {
                '$expr': {
                    '$eq': [{'$month': '$birthday'}, current_month]
                }
            }
        },
        {
            '$project': {
                'ФИО': '$name',
                'День рождения': {'$dayOfMonth': '$birthday'},
                'Номер группы': '$group.group_id',
                'Направление': '$direction.direction_name'
            }
        }
    ])
    return list(result)

# 6. Количество студентов по каждому направлению
def get_student_count_by_direction():
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'group.group_id',
                'foreignField': '_id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$lookup': {
                'from': 'directions',
                'localField': 'group.direction.direction_id',
                'foreignField': '_id',
                'as': 'direction'
            }
        },
        {
            '$unwind': '$direction'
        },
        {
            '$group': {
                '_id': '$direction.direction_name',
                'Количество студентов': {'$sum': 1}
            }
        },
        {
            '$project': {
                'Направление': '$_id',
                'Количество студентов': 1,
                '_id': 0
            }
        }
    ])
    return list(result)

# 7. Количество бюджетных и внебюджетных мест по группам
def get_budget_non_budget_count_by_group():
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'group.group_id',
                'foreignField': '_id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$lookup': {
                'from': 'directions',
                'localField': 'group.direction.direction_id',
                'foreignField': '_id',
                'as': 'direction'
            }
        },
        {
            '$unwind': '$direction'
        },
        {
            '$group': {
                '_id': {'group_id': '$group.group_id', 'direction_name': '$direction.direction_name'},
                'Бюджетные места': {'$sum': {'$cond': ['$is_budget', 1, 0]}},
                'Внебюджетные места': {'$sum': {'$cond': ['$is_budget', 0, 1]}}
            }
        },
        {
            '$project': {
                'Номер группы': '$_id.group_id',
                'Название направления': '$_id.direction_name',
                'Бюджетные места': 1,
                'Внебюджетные места': 1,
                '_id': 0
            }
        }
    ])
    return list(result)

# Задание 4

# Коллекции
teachers = db['teachers']
subjects = db['subjects']
grades = db['grades']

# 1. Вывести список предметов, преподаваемых учителем с именем "Jane Smith"
def get_subjects_by_teacher_name(teacher_name):
    result = subjects.aggregate([
        {
            '$lookup': {
                'from': 'teachers',
                'localField': 'teacher._id',
                'foreignField': '_id',
                'as': 'teacher'
            }
        },
        {
            '$unwind': '$teacher'
        },
        {
            '$match': {
                'teacher.teacher_name': teacher_name
            }
        },
        {
            '$project': {
                'Предметы': '$subject_name',
                '_id': 0
            }
        }
    ])
    return list(result)

# 2. Вывести оценки студента с именем "John Doe"
def get_grades_by_student_name(student_name):
    result = grades.aggregate([
        {
            '$lookup': {
                'from': 'students',
                'localField': 'student._id',
                'foreignField': '_id',
                'as': 'student'
            }
        },
        {
            '$unwind': '$student'
        },
        {
            '$match': {
                'student.name': student_name
            }
        },
        {
            '$project': {
                'Предмет': '$subject.subject_name',
                'Оценка': '$grade_value',
                '_id': 0
            }
        }
    ])
    return list(result)

# Задание 5

# 1. Вывести списки групп каждому предмету с указанием преподавателя
def get_groups_for_each_subject():
    result = subjects.aggregate([
        {
            '$lookup': {
                'from': 'teachers',
                'localField': 'teacher._id',
                'foreignField': '_id',
                'as': 'teacher'
            }
        },
        {
            '$unwind': '$teacher'
        },
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'direction._id',
                'foreignField': 'direction._id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$project': {
                'subject_name': 1,
                'group_name': '$group.group_name',
                'teacher_name': '$teacher.teacher_name'
            }
        }
    ])
    return list(result)

# 2. Определить, какую дисциплину изучает максимальное количество студентов
def get_subject_with_max_students():
    result = grades.aggregate([
        {
            '$lookup': {
                'from': 'subjects',
                'localField': 'subject._id',
                'foreignField': '_id',
                'as': 'subject'
            }
        },
        {
            '$unwind': '$subject'
        },
        {
            '$group': {
                '_id': '$subject.subject_name',
                'student_count': {'$sum': 1}
            }
        },
        {
            '$sort': {
                'student_count': -1
            }
        },
        {
            '$limit': 1
        }
    ])
    return list(result)

# 3. Определить, сколько студентов обучаются у каждого из преподавателей
def get_student_count_per_teacher():
    result = grades.aggregate([
        {
            '$lookup': {
                'from': 'subjects',
                'localField': 'subject._id',
                'foreignField': '_id',
                'as': 'subject'
            }
        },
        {
            '$unwind': '$subject'
        },
        {
            '$lookup': {
                'from': 'teachers',
                'localField': 'subject.teacher._id',
                'foreignField': '_id',
                'as': 'teacher'
            }
        },
        {
            '$unwind': '$teacher'
        },
        {
            '$group': {
                '_id': '$teacher.teacher_name',
                'student_count': {'$sum': 1}
            }
        }
    ])
    return list(result)

# 4. Определить долю сдавших студентов по каждой дисциплине
def get_pass_ratio_per_subject():
    result = grades.aggregate([
        {
            '$lookup': {
                'from': 'subjects',
                'localField': 'subject._id',
                'foreignField': '_id',
                'as': 'subject'
            }
        },
        {
            '$unwind': '$subject'
        },
        {
            '$group': {
                '_id': '$subject.subject_name',
                'pass_count': {'$sum': {'$cond': [{'$gt': ['$grade_value', 2]}, 1, 0]}},
                'total_count': {'$sum': 1}
            }
        },
        {
            '$project': {
                'subject_name': '$_id',
                'pass_ratio': {'$divide': ['$pass_count', '$total_count']}
            }
        }
    ])
    return list(result)

# 5. Определить среднюю оценку по предметам (для сдавших студентов)
def get_average_grade_per_subject():
    result = grades.aggregate([
        {
            '$lookup': {
                'from': 'subjects',
                'localField': 'subject._id',
                'foreignField': '_id',
                'as': 'subject'
            }
        },
        {
            '$unwind': '$subject'
        },
        {
            '$match': {
                'grade_value': {'$gt': 2}
            }
        },
        {
            '$group': {
                '_id': '$subject.subject_name',
                'average_grade': {'$avg': '$grade_value'}
            }
        }
    ])
    return list(result)

# 6. Определить группу с максимальной средней оценкой (включая не сдавших)
def get_group_with_max_average_grade():
    result = grades.aggregate([
        {
            '$lookup': {
                'from': 'subjects',
                'localField': 'subject._id',
                'foreignField': '_id',
                'as': 'subject'
            }
        },
        {
            '$unwind': '$subject'
        },
        {
            '$lookup': {
                'from': 'groups',
                'localField': 'subject.direction._id',
                'foreignField': 'direction._id',
                'as': 'group'
            }
        },
        {
            '$unwind': '$group'
        },
        {
            '$group': {
                '_id': '$group.group_name',
                'average_grade': {'$avg': '$grade_value'}
            }
        },
        {
            '$sort': {
                'average_grade': -1
            }
        },
        {
            '$limit': 1
        }
    ])
    return list(result)

# 7. Вывести студентов со всеми оценками отлично и не имеющих несданный экзамен
def get_students_with_all_excellent_grades():
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'grades',
                'localField': '_id',
                'foreignField': 'student._id',
                'as': 'grades'
            }
        },
        {
            '$match': {
                '$expr': {
                    '$not': {
                        '$setIsSubset': [[2, 3, 4], '$grades.grade_value']
                    }
                }
            }
        },
        {
            '$project': {
                'student_id': '$_id',
                'name': 1
            }
        }
    ])
    return list(result)

# 8. Вывести кандидатов на отчисление (не сдано не менее двух предметов)
def get_students_for_dismissal():
    result = students.aggregate([
        {
            '$lookup': {
                'from': 'grades',
                'localField': '_id',
                'foreignField': 'student._id',
                'as': 'grades'
            }
        },
        {
            '$project': {
                'student_id': '$_id',
                'name': 1,
                'failed_subjects': {
                    '$size': {
                        '$filter': {
                            'input': '$grades',
                            'as': 'grade',
                            'cond': {'$lt': ['$$grade.grade_value', 3]}
                        }
                    }
                }
            }
        },
        {
            '$match': {
                'failed_subjects': {'$gte': 2}
            }
        }
    ])
    return list(result)

# Задание 6

# Коллекции
timetable = db['timetable']
attendance = db['attendance']

# 1. Вывести расписание для студента
def get_timetable_for_student(student_id):
    result = attendance.aggregate([
        {
            '$match': {
                'student._id': student_id
            }
        },
        {
            '$lookup': {
                'from': 'timetable',
                'localField': 'timetable._id',
                'foreignField': '_id',
                'as': 'timetable'
            }
        },
        {
            '$unwind': '$timetable'
        },
        {
            '$project': {
                'day': '$timetable.day',
                'start_time': '$timetable.start_time',
                'end_time': '$timetable.end_time',
                'subject_name': '$timetable.subject.subject_name',
                'teacher_name': '$timetable.teacher.teacher_name',
                'is_attended': 1
            }
        }
    ])
    return list(result)

# 2. Вывести посещаемость для студента
def get_attendance_for_student(student_id):
    result = attendance.aggregate([
        {
            '$match': {
                'student._id': student_id
            }
        },
        {
            '$lookup': {
                'from': 'timetable',
                'localField': 'timetable._id',
                'foreignField': '_id',
                'as': 'timetable'
            }
        },
        {
            '$unwind': '$timetable'
        },
        {
            '$project': {
                'day': '$timetable.day',
                'subject_name': '$timetable.subject.subject_name',
                'is_attended': 1
            }
        }
    ])
    return list(result)

# Задание 7

# 1. Количество посещенных занятий по заданному предмету
def get_attended_count_by_subject(subject_name):
    result = attendance.aggregate([
        {
            '$lookup': {
                'from': 'timetable',
                'localField': 'timetable._id',
                'foreignField': '_id',
                'as': 'timetable'
            }
        },
        {
            '$unwind': '$timetable'
        },
        {
            '$match': {
                'timetable.subject.subject_name': subject_name,
                'is_attended': True
            }
        },
        {
            '$group': {
                '_id': '$timetable.subject.subject_name',
                'attended_count': {'$sum': 1}
            }
        }
    ])
    return list(result)

# 2. Количество пропущенных занятий по заданному предмету
def get_missed_count_by_subject(subject_name):
    result = attendance.aggregate([
        {
            '$lookup': {
                'from': 'timetable',
                'localField': 'timetable._id',
                'foreignField': '_id',
                'as': 'timetable'
            }
        },
        {
            '$unwind': '$timetable'
        },
        {
            '$match': {
                'timetable.subject.subject_name': subject_name,
                'is_attended': False
            }
        },
        {
            '$group': {
                '_id': '$timetable.subject.subject_name',
                'missed_count': {'$sum': 1}
            }
        }
    ])
    return list(result)

# 3. Количество студентов на каждом занятии по заданному преподавателю
def get_student_count_per_teacher(teacher_name):
    result = attendance.aggregate([
        {
            '$lookup': {
                'from': 'timetable',
                'localField': 'timetable._id',
                'foreignField': '_id',
                'as': 'timetable'
            }
        },
        {
            '$unwind': '$timetable'
        },
        {
            '$match': {
                'timetable.teacher.teacher_name': teacher_name
            }
        },
        {
            '$group': {
                '_id': {
                    'teacher_name': '$timetable.teacher.teacher_name',
                    'subject_name': '$timetable.subject.subject_name'
                },
                'student_count': {'$addToSet': '$student._id'}
            }
        },
        {
            '$project': {
                'teacher_name': '$_id.teacher_name',
                'subject_name': '$_id.subject_name',
                'student_count': {'$size': '$student_count'}
            }
        }
    ])
    return list(result)

# 4. Общее время, потраченное на изучение каждого предмета для каждого студента
def get_total_time_per_subject_for_student():
    result = attendance.aggregate([
        {
            '$lookup': {
                'from': 'timetable',
                'localField': 'timetable._id',
                'foreignField': '_id',
                'as': 'timetable'
            }
        },
        {
            '$unwind': '$timetable'
        },
        {
            '$group': {
                '_id': {
                    'student_id': '$student._id',
                    'student_name': '$student.name',
                    'subject_name': '$timetable.subject.subject_name'
                },
                'total_time': {
                    '$sum': {
                        '$subtract': [
                            {'$toDate': {'$concat': ['$timetable.end_time', 'T00:00:00Z']}},
                            {'$toDate': {'$concat': ['$timetable.start_time', 'T00:00:00Z']}}
                        ]
                    }
                }
            }
        },
        {
            '$project': {
                'student_id': '$_id.student_id',
                'student_name': '$_id.student_name',
                'subject_name': '$_id.subject_name',
                'total_time': {
                    '$dateToString': {
                        'format': '%H:%M:%S',
                        'date': {'$add': [new Date(0), '$total_time']}
                    }
                }
            }
        }
    ])
    return list(result)