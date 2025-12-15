CREATE DATABASE college_db;
USE college_db;

-- Departments
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    office_location VARCHAR(50),
    phone_number VARCHAR(20)
);

INSERT INTO departments (department_name, office_location, phone_number) VALUES
('Computer Science', 'Block A', '555-1001'),
('Mathematics', 'Block B', '555-1002'),
('Physics', 'Block C', '555-1003');

-- Majors
CREATE TABLE majors (
    major_id INT AUTO_INCREMENT PRIMARY KEY,
    major_name VARCHAR(100) NOT NULL,
    degree_type VARCHAR(20),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO majors (major_name, degree_type, department_id) VALUES
('Computer Science', 'BS', 1),
('Data Science', 'MS', 1),
('Applied Mathematics', 'BS', 2);

-- Students
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE,
    enrollment_year INT,
    status VARCHAR(20),
    major_id INT,
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

INSERT INTO students (first_name, last_name, email, date_of_birth, enrollment_year, status, major_id) VALUES
('Aarav', 'Patel', 'aarav.patel@uni.edu', '2003-05-12', 2021, 'Active', 1),
('Emily', 'Johnson', 'emily.johnson@uni.edu', '2002-11-22', 2020, 'Active', 3),
('Rahul', 'Mehta', 'rahul.mehta@uni.edu', '2001-08-10', 2019, 'Graduated', 2);

-- Faculty
CREATE TABLE faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    title VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO faculty (first_name, last_name, email, title, department_id) VALUES
('John', 'Smith', 'john.smith@uni.edu', 'Professor', 1),
('Linda', 'Brown', 'linda.brown@uni.edu', 'Associate Professor', 2),
('Michael', 'Lee', 'michael.lee@uni.edu', 'Lecturer', 1);

-- Courses
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20),
    course_title VARCHAR(100),
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO courses (course_code, course_title, credits, department_id) VALUES
('CS101', 'Introduction to Programming', 4, 1),
('CS201', 'Data Structures', 4, 1),
('MATH101', 'Calculus I', 3, 2);

-- Course Offerings
CREATE TABLE course_offerings (
    offering_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    faculty_id INT,
    semester VARCHAR(20),
    year INT,
    classroom VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

INSERT INTO course_offerings (course_id, faculty_id, semester, year, classroom) VALUES
(1, 1, 'Fall', 2024, 'A101'),
(2, 3, 'Spring', 2025, 'A102'),
(3, 2, 'Fall', 2024, 'B201');

-- Enrollments
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    offering_id INT,
    enrollment_date DATE,
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (offering_id) REFERENCES course_offerings(offering_id)
);

INSERT INTO enrollments (student_id, offering_id, enrollment_date, grade) VALUES
(1, 1, '2024-08-15', 'A'),
(1, 2, '2025-01-10', NULL),
(2, 3, '2024-08-16', 'B'),
(3, 2, '2025-01-12', 'A');

-- Attendance
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    attendance_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

INSERT INTO attendance (enrollment_id, attendance_date, status) VALUES
(1, '2024-09-01', 'Present'),
(1, '2024-09-03', 'Absent'),
(2, '2025-01-15', 'Present'),
(3, '2024-09-02', 'Present');
