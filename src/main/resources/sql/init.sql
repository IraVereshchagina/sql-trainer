-- Сброс старой таблицы, если она была
DROP TABLE IF EXISTS users CASCADE;

-- Создание таблицы пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Наполнение данными
INSERT INTO users (name, email, age) VALUES
('Ivan Ivanov', 'ivan@mail.ru', 25),
('Maria Petrova', NULL, 30),
('Alex Smith', 'alex@gmail.com', 22),
('Anna German', 'ann.german@ussr.ru', 40),
('Elena Kuzmina', 'elena@work.ru', 35);


DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(15, 2),
    coffee_cups_per_day INTEGER DEFAULT 0,
    bugs_created INTEGER DEFAULT 0,
    is_remote BOOLEAN DEFAULT TRUE,
    spirit_animal VARCHAR(50),
    last_promotion_date DATE,
    caffeine_dependency_level VARCHAR(20) -- Low, Medium, High, Beyond Human
);

INSERT INTO employees (full_name, job_title, department, salary, coffee_cups_per_day, bugs_created, spirit_animal, caffeine_dependency_level)
VALUES
('Michael Scott', 'Regional Manager', 'Sales', 50000, 12, 500, 'Robin', 'Beyond Human'),
('Maurice Moss', 'IT Genius', 'IT', 60000, 1, 0, 'Kitten', 'Low'),
('Bertram Gilfoyle', 'DevOps Satanist', 'IT', 150000, 0, 0, 'Goat', 'Low'),
('Dinesh Chugtai', 'Java Hero', 'IT', 145000, 15, 42, 'Goldfish', 'Beyond Human'),
('Dwight Schrute', 'Assistant Regional Manager', 'Sales', 55000, 0, 1000, 'Beet', 'Low'),
('Ron Swanson', 'Director', 'Management', 80000, 0, 0, 'Eagle', 'Low'),
('Chandler Bing', 'Statistical Analysis', 'Data', 70000, 8, 12, 'Duck', 'High'),
('Roy Trenneman', 'IT Support', 'IT', 45000, 6, 999, 'Sloth', 'Medium'),
('Erlich Bachman', 'Incubator Owner', 'Management', 100000, 2, 100, 'Aviato', 'Low'),
('Pam Beesly', 'Receptionist', 'Admin', 40000, 3, 5, 'Cat', 'Medium'),
('Jim Halpert', 'Prankster', 'Sales', 60000, 4, 10, 'Hamster', 'Medium'),
('Jian Yang', 'App Developer', 'IT', 120000, 1, 200, 'Octopus', 'Low'),
('Leslie Knope', 'Workaholic', 'Gov', 75000, 20, 0, 'Waffle', 'Beyond Human'),
('April Ludgate', 'Assistant', 'Gov', 35000, 2, 666, 'Crow', 'Low'),
('Tom Haverford', 'Entrepreneur', 'Marketing', 45000, 5, 50, 'Peacock', 'High');
