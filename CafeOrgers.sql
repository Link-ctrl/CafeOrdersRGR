

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE Dishes (
    DishID INT PRIMARY KEY AUTO_INCREMENT,
    DishName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL
);

CREATE TABLE Tables (
    table_id INT PRIMARY KEY AUTO_INCREMENT,
    capacity INT NOT NULL
);

-- Вставка данных в таблицу Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
    ('John', 'Doe', 'john.doe@email.com', '123-456-7890'),
    ('Jane', 'Smith', 'jane.smith@email.com', '987-654-3210'),


-- Вставка данных в таблицу Orders
INSERT INTO Orders (CustomerID, OrderDate)
VALUES
    (1, NOW()),  -- NOW() используется для вставки текущей даты и времени
    (2, NOW()),

-- Вставка данных в таблицу Dishes
INSERT INTO Dishes (DishName, Price)
VALUES
    ('Spaghetti Bolognese', 12.99),
    ('Chicken Alfredo', 15.99),


-- Вставка данных в таблицу Employees
INSERT INTO Employees (FirstName, LastName, Position)
VALUES
    ('Manager', 'One', 'Manager'),
    ('Waiter', 'Two', 'Waiter'),

-- Вставка данных в таблицу Tables
INSERT INTO Tables (capacity)
VALUES
    (4),
    (6),


-- Триггер для автоматического добавления сотрудника при создании заказа
DELIMITER //
CREATE TRIGGER Before_Insert_Order
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE EmployeeCount INT;
    SELECT COUNT(*) INTO EmployeeCount FROM Employees;
    
    IF EmployeeCount > 0 THEN
        SET NEW.EmployeeID = (SELECT EmployeeID FROM Employees ORDER BY RAND() LIMIT 1);
    END IF;
END;
//
DELIMITER ;


-- Триггер для проверки, что количество заказанных блюд не превышает вместимость стола
DELIMITER //
CREATE TRIGGER Before_Insert_OrderItems
BEFORE INSERT ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE TotalCapacity INT;
    SELECT SUM(capacity) INTO TotalCapacity FROM Tables
    WHERE table_id IN (SELECT table_id FROM Orders WHERE OrderID = NEW.OrderID);
    
    IF TotalCapacity + NEW.Quantity > (SELECT capacity FROM Tables WHERE table_id IN (SELECT table_id FROM Orders WHERE OrderID = NEW.OrderID)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Total quantity of ordered items exceeds table capacity';
    END IF;
END;
//
DELIMITER ;

-- Триггер для удаления связанных заказов при удалении клиента
DELIMITER //
CREATE TRIGGER Before_Delete_Customers
BEFORE DELETE ON Customers
FOR EACH ROW
BEGIN
    DELETE FROM Orders WHERE CustomerID = OLD.CustomerID;
END;
//
DELIMITER ;
