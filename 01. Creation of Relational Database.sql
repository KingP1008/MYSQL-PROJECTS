create database `anon orders`;
use `anon orders`;


create table Customers(
	customer_id INT NOT NULL,
    name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    PRIMARY KEY(customer_id)
);

create table Orders(
	order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE,
    total DECIMAL(10,2),
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);

create table Order_Items(
	order_item_id INT NOT NULL,
    order_id INT NOT NULL,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_item_id),
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);



insert ignore into Customers(customer_id, name, email, phone, address)
VALUES
(1, 'John Doe', 'johndoe@example.com', '123-456-7890', '123 Main St, Anytown, USA'),
(2, 'Jane Smith', 'janesmith@example.com','987-654-3210', '456 Elm St, Othertown, USA'),
(3, 'Bob Johnson', 'bobjohnson@example.com', '555-123-4567', '789 Oak St, Thistown, USA'),
(4, 'Alice Brown', 'alicebrown@example.com', '111-222-3333', '901 Maple St, Anytown, USA'),
(5, 'Mike Davis', 'mikedavis@example.com', '444-555-6666', '345 Pine St, Othertown, USA'),
(6, 'Emily Chen', 'emilychen@example.com','777-888-9999','678 Oak St, Thistown, USA'),
(7, 'David Lee', 'davidlee@example.com', '123-456-7890', '456 Elm St, Anytown, USA'),
(8, 'Sophia Patel', 'sophiapatel@example.com', '987-654-3210', '789 Main St, Othertown, USA'),
(9, 'Oliver Kim', 'oliverkim@example.com', '555-123-4567', '901 Broadway, Thistown, USA'),
(10, 'Ava Wong', 'avawong@example.com', '111-222-3333', '345 Park Ave, Anytown, USA');


insert into Orders(order_id, customer_id, order_date, total)
VALUES
(1, 1, '2022-01-01', 100.00),
(2, 1, '2022-01-15', 200.00),
(3, 2, '2022-02-01', 50.00),
(4, 3, '2022-03-01', 150.00),
(5, 4, '2022-04-01',250.00),
(6, 5, '2022-05-01', 300.00),
(7, 6, '2022-06-01', 200.00),
(8, 7, '2022-07-01', 150.00),
(9, 8, '2022-08-01', 400.00),
(10, 9, '2022-09-01', 350.00),
(11, 10, '2022-10-01', 280.00),
(12, 1, '2022-11-01', 320.00),
(13, 2, '2022-12-01', 220.00),
(14, 3, '2023-01-01', 380.00);

insert into Order_items(order_item_id, order_id, product_name, quantity, price)
VALUES
(1, 1, 'Product A', 2, 20.00),
(2, 1, 'Product B', 1, 30.00),
(3, 2, 'Product C', 3, 50.00),
(4, 3, 'Product D', 2, 70.00),
(5, 4, 'Product E', 3, 10.00),
(6, 5, 'Product F', 2, 40.00),
(7, 5, 'Product G', 1, 60.00),
(8, 6, 'Product H', 3, 30.00),
(9, 6, 'Product I', 2, 50.00),
(10, 7, 'Product J', 1, 75.00),
(11, 7, 'Product K', 2, 35.00),
(12, 8, 'Product L', 3, 25.00),
(13, 8, 'Product M', 1, 90.00),
(14, 9, 'Product N', 2, 55.00),
(15, 9, 'Product O', 1, 110.00),
(16, 10, 'Product P', 3, 45.00),
(17, 10, 'Product Q', 2, 65.00),
(18, 11, 'Product R', 1, 85.00),
(19, 11, 'Product S', 2, 40.00),
(20, 12, 'Product T', 3, 50.00);