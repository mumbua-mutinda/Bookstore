-- Create database
CREATE DATABASE BookStore_DB;

USE BookStore_DB;

-- Address_Status_Table

CREATE TABLE Address_Status_Table (
    Status_ID INT AUTO_INCREMENT PRIMARY KEY,
    Status_Name VARCHAR(50) NOT NULL
);

-- Order_Status_Table

CREATE TABLE Order_Status_Table (
    Status_ID INT AUTO_INCREMENT PRIMARY KEY,
    Status_Name VARCHAR(50) NOT NULL
);

-- Shipping_Method_Table

CREATE TABLE Shipping_Method_Table (
    Shipping_Method_ID INT AUTO_INCREMENT PRIMARY KEY,
    Shipping_Method_Name VARCHAR(100) NOT NULL
);

-- Customer_Table

CREATE TABLE Customer_Table (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Customer_Email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO Customer_Table (Customer_Name, Customer_Email) VALUES
    ('Alice Achieng', 'alice@example.com'),
    ('Brian Okello', 'brian@example.com'),
    ('Caroline Njeri', 'caroline@example.com'),
    ('David Otieno', 'david@example.com'),
    ('Emily Wambui', 'emily@example.com');

-- Order_Line_Table

CREATE TABLE Order_Line_Table(
    Order_ID INT,
    Book_ID INT,
    Order_Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Order_ID, Book_ID),
    FOREIGN KEY (Order_ID) REFERENCES Customer_Order_Table(Order_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book_Table(Book_ID)
);

-- Order_History_Table

CREATE TABLE Order_History_Table (
    History_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT,
    Status_ID INT,
    Change_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Order_ID) REFERENCES Customer_Order_Table(Order_ID),
    FOREIGN KEY (Status_ID) REFERENCES Order_Status_Table(Status_ID)
);

-- Customer_Order_Table

CREATE TABLE Customer_Order_Table (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Shipping_Method_ID INT,
    Order_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Table(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Shipping_Method_ID) REFERENCES Shipping_Method_Table(Shipping_Method_ID)
);

-- Customer_Address_Table

CREATE TABLE Customer_Address_Table (
    Customer_ID INT,
    Address_ID INT,
    Status_ID INT,
    PRIMARY KEY (Customer_ID, Address_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Table(Customer_ID),
    FOREIGN KEY (Address_ID) REFERENCES Address_Table(Address_ID),
    FOREIGN KEY (Status_ID) REFERENCES Address_Status_Table(Status_ID)
);

-- Book_Language_Table

CREATE TABLE Book_Language_Table (
    Languge_ID INT AUTO_INCREMENT PRIMARY KEY,
    Language_Name VARCHAR(50) NOT NULL
);

INSERT INTO Book_Language_Table (Language_Name) VALUES
    ('English'),
    ('Swahili'),
    ('French'),
    ('Arabic'),
    ('Zulu');

-- Publisher_Table

CREATE TABLE Publisher_Table (
    Publisher_ID INT AUTO_INCREMENT PRIMARY KEY,
    Publisher_Name VARCHAR(100) NOT NULL
);

INSERT INTO Publisher_Table (Publisher_Name) VALUES
    ('East African Publishers'),
    ('Oxford University Press'),
    ('Longhorn Publishers'),
    ('Pearson Education'),
    ('Macmillan Kenya');

-- Book_Table

CREATE TABLE Book_Table (
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Book_Title VARCHAR(200) NOT NULL,
    Publisher_ID INT,
    Language_ID INT,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Publisher_ID) REFERENCES Publisher_Table(Publisher_ID)
);

INSERT INTO Book_Table (Book_Title, Publisher_ID, Price) VALUES
    ('Weep Not, Child', 1, 950.00),
    ('Things Fall Apart', 2, 1050.50),
    ('The River and The Source', 3, 875.00),
    ('Ake: The Years of Childhood', 4, 990.00),
    ('Land Without Thunder', 5, 790.00);

-- Book_Author_Table

CREATE TABLE Book_Author_Table (
    Book_ID INT,
    Author_ID INT,
    PRIMARY KEY (Book_ID, author_id),
    FOREIGN KEY (Book_ID) REFERENCES Book_Table(Book_ID),
    FOREIGN KEY (Author_ID) REFERENCES Author_Table(Author_ID)
);

INSERT INTO Book_Author_Table (Book_ID, Author_ID) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

--Author_Table

CREATE TABLE Author_Table (
    Author_ID INT AUTO_INCREMENT PRIMARY KEY,
    Author_Name VARCHAR(100) NOT NULL
);

INSERT INTO Author_Table (Author_Name) VALUES
    ('Ngugi wa Thiongo'),
    ('Chinua Achebe'),
    ('Margaret Ogola'),
    ('Wole Soyinka'),
    ('Grace Ogot');

-- Country_Table

CREATE TABLE Country_Table (
    Country_ID INT AUTO_INCREMENT PRIMARY KEY,
    Country_Name VARCHAR(100) NOT NULL
);

INSERT INTO Country_Table (Country_Name) VALUES
    ('Kenya'),
    ('Uganda'),
    ('Tanzania'),
    ('Nigeria'),
    ('South Africa');

-- Address_Table

CREATE TABLE Address_Table (
    Address_ID INT AUTO_INCREMENT PRIMARY KEY,
    Street VARCHAR(150) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Pstal_Code VARCHAR(20),
    Country_ID INT,
    FOREIGN KEY (Country_ID) REFERENCES Country_Table(Country_ID)
);




















