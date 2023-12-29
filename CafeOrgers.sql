

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

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    DishID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (DishID) REFERENCES Dishes(DishID) ON DELETE CASCADE
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

-- Добавление клиентов
INSERT INTO Customers (FirstName, LastName, Email, Phone) VALUES
('Иван', 'Иванов', 'ivan@example.com', '123-456-7890'),
('Мария', 'Петрова', 'maria@example.com', '987-654-3210');
-- Добавление блюд
INSERT INTO Dishes (DishName, Price) VALUES
('Пицца Маргарита', 12.99),
('Стейк из говядины', 24.99);
-- Добавление заказов
INSERT INTO Orders (CustomerID) VALUES
(1),
(2);
-- Добавление состава заказа
INSERT INTO OrderItems (OrderID, DishID, Quantity) VALUES
(1, 1, 2),
(2, 2, 1);
-- Добавление сотрудников
INSERT INTO Employees (FirstName, LastName, Position) VALUES
('Алексей', 'Сидоров', 'Официант'),
('Екатерина', 'Иванова', 'Повар');

-- Триггер для предотвращения удаления клиентов, связанных с заказами
CREATE TRIGGER prevent_delete_customers
BEFORE DELETE ON Customers
FOR EACH ROW
BEGIN
    DECLARE count_orders INT;

    SELECT COUNT(*) INTO count_orders
    FROM Orders
    WHERE CustomerID = OLD.CustomerID;

    IF count_orders > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя удалить клиента, связанного с заказами';
    END IF;
END;

-- Триггер для предотвращения изменения блюд, связанных с составом заказа
CREATE TRIGGER prevent_update_dishes
BEFORE UPDATE ON Dishes
FOR EACH ROW
BEGIN
    DECLARE count_order_items INT;

    SELECT COUNT(*) INTO count_order_items
    FROM OrderItems
    WHERE DishID = OLD.DishID;

    IF count_order_items > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя изменить блюдо, связанное с заказами';
    END IF;
END;
