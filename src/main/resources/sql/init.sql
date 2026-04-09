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




CREATE SCHEMA IF NOT EXISTS multiverse_sn;

-- 1. ТАБЛИЦА ПОЛЬЗОВАТЕЛЕЙ
CREATE TABLE IF NOT EXISTS multiverse_sn.users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    universe VARCHAR(50),
    bio TEXT,
    account_balance NUMERIC(10, 2) DEFAULT 0.00,
    registration_date DATE DEFAULT CURRENT_DATE
);

-- 2. ТАБЛИЦА ПОСТОВ
CREATE TABLE IF NOT EXISTS multiverse_sn.posts (
    id SERIAL PRIMARY KEY,
    author_id INTEGER REFERENCES multiverse_sn.users(id),
    content TEXT NOT NULL,
    likes INTEGER DEFAULT 0,
    views INTEGER DEFAULT 0,
    post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. ТАБЛИЦА ДРУЗЕЙ
CREATE TABLE IF NOT EXISTS multiverse_sn.friendships (
    user_id_1 INTEGER REFERENCES multiverse_sn.users(id),
    user_id_2 INTEGER REFERENCES multiverse_sn.users(id),
    status VARCHAR(20) DEFAULT 'accepted',
    friends_since DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (user_id_1, user_id_2)
);

-- 4. ТАБЛИЦА ГРУПП/ГИЛЬДИЙ
CREATE TABLE IF NOT EXISTS multiverse_sn.guilds (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    founder_id INTEGER REFERENCES multiverse_sn.users(id),
    description TEXT
);

-- 5. ТАБЛИЦА УЧАСТНИКОВ ГРУПП
CREATE TABLE IF NOT EXISTS multiverse_sn.guild_members (
    guild_id INTEGER REFERENCES multiverse_sn.guilds(id),
    user_id INTEGER REFERENCES multiverse_sn.users(id),
    role VARCHAR(20) DEFAULT 'member',
    joined_at DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (guild_id, user_id)
);

-- НАПОЛНЕНИЕ ДАННЫМИ:
INSERT INTO multiverse_sn.users (username, full_name, universe, bio, account_balance) VALUES
-- Lord of the Rings
('ringbearer', 'Frodo Baggins', 'LOTR', 'Люблю долгие пешие прогулки к вулканам.', 50.00),
('gardener_hero', 'Samwise Gamgee', 'LOTR', 'Картошка: сварить, пожарить, сделать пюре.', 15.50),
('fool_of_a_took', 'Peregrin Took', 'LOTR', 'Где мой второй завтрак?', 0.00),
('brandybuck', 'Meriadoc Brandybuck', 'LOTR', 'Пин опять куда-то влез.', 5.00),
('grey_white', 'Gandalf', 'LOTR', 'Никогда не опаздываю. Прихожу именно тогда, когда нужно.', 999.99),
('strider', 'Aragorn', 'LOTR', 'Король на удаленке. Ищу меч, желательно целый.', 150.00),
('hair_goals', 'Legolas', 'LOTR', 'Они забрали хоббитов в Изенгард! x100', 800.00),
('axe_master', 'Gimli', 'LOTR', 'Никто не швыряет гнома!', 450.00),
('one_does_not', 'Boromir', 'LOTR', 'Нельзя просто так взять и зарегистрироваться в соцсети.', 120.00),
('quality_captain', 'Faramir', 'LOTR', 'Папа меня не любит.', 40.00),
('half_elven', 'Elrond', 'LOTR', 'Я был там, Гэндальф. Три тысячи лет назад.', 5000.00),
('lady_of_light', 'Galadriel', 'LOTR', 'Вместо Темного Властелина у вас будет Королева!', 9999.99),
('evenstar', 'Arwen', 'LOTR', 'Отказалась от бессмертия ради парня с грязными волосами.', 100.00),
('preciousss', 'Gollum', 'LOTR', 'Моя прелесть... Отдайте прелесть!', 0.01),
('eye_in_the_sky', 'Sauron', 'LOTR', 'Вижу тебя. Потерял кольцо, нашедшему вознаграждение.', 99999.99),
('many_colors', 'Saruman', 'LOTR', 'Строю индустриальный парк в Изенгарде.', 8500.00),
('no_man', 'Eowyn', 'LOTR', 'Я не муж! И суп мой нормальный.', 300.00),
('horse_lord', 'Eomer', 'LOTR', 'Рохан явится!', 400.00),
('king_theoden', 'Theoden', 'LOTR', 'Где был Гондор, когда пал Вестфолд?', 1000.00),
('burglar', 'Bilbo Baggins', 'LOTR', 'Я не знаю и половины из вас наполовину так хорошо, как вы того заслуживаете.', 888.88),

-- Harry Potter
('chosen_one', 'Harry Potter', 'Harry Potter', 'Шрам опять болит.', 1500.00),
('weasley_king', 'Ron Weasley', 'Harry Potter', 'Ненавижу пауков.', 12.50),
('brightest_witch', 'Hermione Granger', 'Harry Potter', 'Это ЛевиОса, а не ЛевиосА.', 250.00),
('headmaster', 'Albus Dumbledore', 'Harry Potter', 'Люблю лимонные дольки и сложные многолетние планы.', 5000.00),
('half_blood_prince', 'Severus Snape', 'Harry Potter', 'Всегда.', 850.00),
('dark_lord', 'Lord Voldemort', 'Harry Potter', 'Ищу мастера по ринопластике.', 0.00),
('my_father', 'Draco Malfoy', 'Harry Potter', 'Мой отец узнает об этом!', 9999.00),
('padfoot', 'Sirius Black', 'Harry Potter', 'Отсидел 12 лет в Азкабане за то, чего не делал.', 400.00),
('moony', 'Remus Lupin', 'Harry Potter', 'В полночь бываю не в духе. Есть шоколад?', 20.00),
('keeper_of_keys', 'Rubeus Hagrid', 'Harry Potter', 'Зря я это сказал...', 45.00),
('cat_lady', 'Minerva McGonagall', 'Harry Potter', 'Возьмите печенье, Поттер.', 1200.00),
('plant_guy', 'Neville Longbottom', 'Harry Potter', 'Опять забыл пароль от гостиной.', 50.00),
('nargles', 'Luna Lovegood', 'Harry Potter', 'Мозгошмыги повсюду.', 15.00),
('i_killed_sirius', 'Bellatrix Lestrange', 'Harry Potter', 'Я убила Сириуса Блэка!', 3000.00),
('peacock_owner', 'Lucius Malfoy', 'Harry Potter', 'У меня дома живут павлины-альбиносы.', 85000.00),
('rubber_duck', 'Arthur Weasley', 'Harry Potter', 'Каково точное назначение резиновой уточки?', 100.00),
('not_my_daughter', 'Molly Weasley', 'Harry Potter', 'Только не моя дочь, мерзавка!', 80.00),
('forge', 'Fred Weasley', 'Harry Potter', 'Торжественно клянусь, что замышляю шалость.', 400.00),
('gred', 'George Weasley', 'Harry Potter', '...и только шалость!', 400.00),
('bat_bogey', 'Ginny Weasley', 'Harry Potter', 'Летучемышиный сглаз работает безотказно.', 110.00),

-- Game of Thrones
('knows_nothing', 'Jon Snow', 'GOT', 'Я ничего не знаю.', 0.00),
('mother_of_dragons', 'Daenerys Targaryen', 'GOT', 'Бурерожденная, Неопалимая, Разрушительница оков и т.д. (остальное не влезло).', 50000.00),
('drinks_and_knows', 'Tyrion Lannister', 'GOT', 'Я пью и я знаю вещи.', 15000.00),
('no_one', 'Arya Stark', 'GOT', 'У девочки нет имени. Зато есть список.', 15.00),
('queen_in_the_north', 'Sansa Stark', 'GOT', 'Лимонные пирожные — моя слабость.', 2000.00),
('three_eyed_raven', 'Bran Stark', 'GOT', 'А у кого история лучше, чем у меня?', 0.00),
('kingslayer', 'Jaime Lannister', 'GOT', 'Отдам золотую руку в хорошие руки.', 8000.00),
('wine_aunt', 'Cersei Lannister', 'GOT', 'Когда играешь в престолы, ты либо побеждаешь, либо умираешь.', 25000.00),
('golden_lion', 'Tywin Lannister', 'GOT', 'Ланнистеры всегда платят свои долги.', 999999.99),
('worst_king', 'Joffrey Baratheon', 'GOT', 'Я КОРОЛЬ!', 50000.00),
('honorable_fool', 'Ned Stark', 'GOT', 'Зима близко.', 300.00),
('young_wolf', 'Robb Stark', 'GOT', 'Не люблю свадьбы.', 1500.00),
('family_duty_honor', 'Catelyn Stark', 'GOT', 'Семья, долг, честь.', 800.00),
('oathkeeper', 'Brienne of Tarth', 'GOT', 'Служу леди Старк.', 45.00),
('chicken_lover', 'Sandor Clegane', 'GOT', 'Я съем всех кур в этой комнате.', 12.00),
('mountain', 'Gregor Clegane', 'GOT', '...', 50.00),
('chaos_is_a_ladder', 'Petyr Baelish', 'GOT', 'Хаос — это лестница.', 12000.00),
('spiders_web', 'Varys', 'GOT', 'Пташки шепчут.', 8500.00),
('reader', 'Samwell Tarly', 'GOT', 'Прочитал всю библиотеку Цитадели.', 20.00),
('red_woman', 'Melisandre', 'GOT', 'Ночь темна и полна ужасов.', 666.00),

-- The Witcher
('white_wolf', 'Geralt of Rivia', 'Witcher', 'Зараза.', 350.00),
('lilac_and_gooseberries', 'Yennefer of Vengerberg', 'Witcher', 'Пахну сиренью и крыжовником. Люблю единорогов.', 8000.00),
('lady_of_space_and_time', 'Ciri', 'Witcher', 'Прячусь от Дикой Охоты.', 50.00),
('fourteenth_of_the_hill', 'Triss Merigold', 'Witcher', 'Аллергия на магию.', 1500.00),
('crimson_avenger', 'Dandelion', 'Witcher', 'Бард, поэт, любовник, друг Геральта.', 15.00),
('mahakam_steel', 'Zoltan Chivay', 'Witcher', 'Наливай!', 45.00),
('old_master', 'Vesemir', 'Witcher', 'Староват я для всего этого.', 200.00),
('spy_master', 'Sigismund Dijkstra', 'Witcher', 'Шпионы Новиграда докладывают...', 25000.00),
('chess_player', 'Radovid V', 'Witcher', 'Шах и мат.', 90000.00),
('white_flame', 'Emhyr var Emreis', 'Witcher', 'Белое Пламя, Пляшущее на Курганах Врагов.', 99999.00),
('herbalist_vampire', 'Emiel Regis', 'Witcher', 'Не пью кровь уже 50 лет.', 0.00),
('archer_girl', 'Milva', 'Witcher', 'Моя стрела не знает промаха.', 25.00),
('black_knight', 'Cahir', 'Witcher', 'Я не нильфгаардец!', 100.00),
('foul_mouth', 'Angouleme', 'Witcher', 'Геральт, ты обещал бордель!', 5.00),
('star_reader', 'Vilgefortz', 'Witcher', 'Вы перепутали небо со звездами, отраженными в поверхности пруда.', 12000.00),
('headhunter', 'Leo Bonhart', 'Witcher', 'Коллекционирую ведьмачьи медальоны.', 4000.00),
('blind_owl', 'Philippa Eilhart', 'Witcher', 'Ложа чародеек правит миром.', 15000.00),
('rectoress', 'Margarita Laux-Antille', 'Witcher', 'Директор Аретузы.', 8000.00),
('plague_maiden', 'Keira Metz', 'Witcher', 'Ищу рецепт от Катрионы.', 1200.00),
('heart_of_stone', 'Olgierd von Everec', 'Witcher', 'Мое сердце превратилось в камень.', 50000.00),

-- Pirates of the Caribbean
('captain_jack', 'Jack Sparrow', 'Pirates', 'КАПИТАН Джек Воробей, смекаешь?', 1.00),
('apple_eater', 'Hector Barbossa', 'Pirates', 'Я чувствую холод...', 800.00),
('blacksmith', 'Will Turner', 'Pirates', 'Я практикуюсь с мечами по 3 часа в день.', 45.00),
('pirate_king', 'Elizabeth Swann', 'Pirates', 'Парлай!', 2000.00),
('squid_face', 'Davy Jones', 'Pirates', 'Ты боишься смерти?', 9999.00),
('blackbeard', 'Edward Teach', 'Pirates', 'Пью ром из черепов.', 5000.00),
('mr_gibbs', 'Joshamee Gibbs', 'Pirates', 'Забирай все, не отдавай ничего.', 20.00),
('commodore', 'James Norrington', 'Pirates', 'Вы самый жалкий из всех пиратов, о которых я слышал.', 500.00),
('governor', 'Weatherby Swann', 'Pirates', 'Мой парик стоит дороже вашего корабля.', 15000.00),
('just_business', 'Cutler Beckett', 'Pirates', 'Это просто бизнес.', 99999.00),
('wooden_eye', 'Ragetti', 'Pirates', 'Мой глаз постоянно выпадает.', 2.00),
('hello_poppet', 'Pintel', 'Pirates', 'Привет, куколка.', 3.00),
('voodoo_lady', 'Tia Dalma', 'Pirates', 'Судьба — это то, что мы делаем.', 400.00),
('bootstrap', 'Bootstrap Bill Turner', 'Pirates', 'Часть корабля, часть команды.', 0.00),
('parrot_guy', 'Cotton', 'Pirates', '*Звуки попугая*', 10.00),
('small_pirate', 'Marty', 'Pirates', 'Люблю большие пушки.', 15.00),
('eic_agent', 'Mercer', 'Pirates', 'Выполняю грязную работу для Беккета.', 800.00),
('lieutenant', 'Groves', 'Pirates', 'Выполняю приказы.', 150.00),
('officer', 'Gillette', 'Pirates', 'Где мой корабль?!', 120.00),
('dog_with_keys', 'Prison Dog', 'Pirates', 'Гав-гав. Ключи не отдам.', 99.00);

-- НАПОЛНЕНИЕ ДАННЫМИ: ПОСТЫ
INSERT INTO multiverse_sn.posts (author_id, content, likes, views) VALUES
(15, 'Потеряно Кольцо Всевластья. Нашедшему — должность назгула в мордорском филиале.', 666, 10000),
(1, 'Кто-нибудь знает, как удалить аккаунт Ока Саурона из черного списка? Он все равно пробивается.', 120, 400),
(2, 'Рецепт дня: рагу из кролика с картошкой. Идеально для походов.', 850, 1200),
(5, 'Лечу в Валинор. Всем пока!', 9999, 50000),
(61, 'Опять утопец в подвале. Когда муниципалитет Новиграда начнет чистить канализацию?', 400, 800),
(65, 'Написал новую балладу о Ведьмаке. Доступна на всех лютнях Континента.', 1200, 3000),
(41, 'Оказывается, я Таргариен. Как теперь смотреть в глаза тете?', 50000, 1000000),
(42, 'Где мои драконы?!', 15000, 40000),
(48, 'Выпила вина. Взорвала септу. Отличный вторник.', 85000, 200000),
(21, 'Снейп опять задал 5 свитков по зельеварению. Помогите.', 2000, 5000),
(26, 'Этот мальчишка продолжает выживать. Бесит.', 666, 1000),
(81, 'Куплю ром. Дорого. Или украду. Скорее второе.', 3000, 8000),
(85, 'Разблокировал шкатулку с сердцем. Пишите в директ.', 150, 600),
(4, 'Второй завтрак отменяется из-за орков. Обидно.', 45, 100),
(11, 'Сдаю комнаты в Ривенделле. Только для эльфов (гномам вход воспрещен).', 200, 500),
(23, 'Я провела в библиотеке 18 часов подряд. Это мой новый личный рекорд!', 4000, 6000),
(62, 'Геральт, если ты читаешь это: купи молока по пути из Каэр Морхена.', 12000, 25000),
(50, 'Свадьба была огонь! В прямом смысле. Пирог был суховат, правда.', 15000, 30000),
(84, 'Кодекс пиратов — это скорее свод указаний, а не жестких правил.', 4500, 9000),
(3, 'Случайно уронил ведро в колодец в Мории. Надеюсь, никто не услышал.', 5, 20000);

-- НАПОЛНЕНИЕ ДАННЫМИ: ГРУППЫ/ГИЛЬДИИ
INSERT INTO multiverse_sn.guilds (name, founder_id, description) VALUES
('Братство Кольца', 1, 'Группа из 9 пешеходов. Цель: вулкан.'),
('Орден Феникса', 24, 'Тайная организация по борьбе с Тем-Кого-Нельзя-Называть.'),
('Пожиратели Смерти', 26, 'Любители черных мантий и татуировок в виде черепа с змеей.'),
('Ночной Дозор', 41, 'Служим на Стене. Холодно. Одиноко. Платим мало.'),
('Ложа Чародеек', 77, 'Политика, магия и дорогие наряды.'),
('Команда Черной Жемчужины', 81, 'Берем всё, не отдаем ничего! Ром обязателен.');

-- НАПОЛНЕНИЕ ДАННЫМИ: УЧАСТНИКИ ГРУПП (СВЯЗИ)
INSERT INTO multiverse_sn.guild_members (guild_id, user_id, role) VALUES
(1, 1, 'admin'), (1, 2, 'member'), (1, 3, 'member'), (1, 4, 'member'),
(1, 5, 'admin'), (1, 6, 'member'), (1, 7, 'member'), (1, 8, 'member'), (1, 9, 'member'),
(2, 24, 'admin'), (2, 28, 'member'), (2, 29, 'member'), (2, 31, 'member'), (2, 36, 'member'),
(3, 26, 'admin'), (3, 34, 'member'), (3, 35, 'member'), (3, 25, 'spy'),
(4, 41, 'commander'), (4, 59, 'member'),
(5, 77, 'admin'), (5, 78, 'member'), (5, 79, 'member'), (5, 62, 'member'), (5, 64, 'member'),
(6, 81, 'captain'), (6, 82, 'mutineer'), (6, 87, 'first_mate'), (6, 95, 'member'), (6, 96, 'member');

-- НАПОЛНЕНИЕ ДАННЫМИ: ДРУЖБА (СВЯЗИ)
INSERT INTO multiverse_sn.friendships (user_id_1, user_id_2, status) VALUES
(1, 2, 'accepted'),
(3, 4, 'accepted'),
(6, 7, 'accepted'),
(7, 8, 'accepted'),
(21, 22, 'accepted'),
(21, 23, 'accepted'),
(22, 23, 'accepted'),
(41, 59, 'accepted'),
(44, 54, 'accepted'),
(61, 65, 'accepted'),
(61, 66, 'accepted'),
(81, 87, 'accepted'),
(83, 84, 'accepted'),
(26, 34, 'accepted'),
(48, 49, 'accepted'),
(62, 63, 'accepted');
