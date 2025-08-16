DROP DATABASE IF EXISTS BUDDY_BANK;

CREATE DATABASE BUDDY_BANK ;

USE BUDDY_BANK ;

-- Drop existing tables if they exist (for re-runs)
DROP TABLE IF EXISTS Registered_at, Transaction, Supervise, Customer_creditcard, Employee_phone, Passbook,
                     DebitCard, Loan, Account, Customer, Employee, Branch;

-- Create tables
CREATE TABLE Branch (
    IFSC VARCHAR(20) PRIMARY KEY,
    Manager_ID VARCHAR(10),
    Helpdeskcontact VARCHAR(15),
    Hno VARCHAR(10),
    Street VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30),
    Pincode VARCHAR(10)
);

CREATE TABLE Employee (
    EmpID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    Branch_IFSC VARCHAR(20),
    Email VARCHAR(100),
    DOJ DATE,
    Designation VARCHAR(50)
);

INSERT INTO Branch VALUES
('IFSC001', 'E001', '1800123456', '12', 'Main Street', 'Mumbai', 'MH', '400001'),
('IFSC002', 'E002', '1800654321', '34', 'Park Lane', 'Delhi', 'DL', '110001');

INSERT INTO Employee VALUES
('E001', 'Amit Sharma', 'IFSC001', 'amit@bank.com', '2015-06-01', 'Manager'),
('E002', 'Sunita Rao', 'IFSC002', 'sunita@bank.com', '2017-03-15', 'Clerk');

ALTER TABLE Branch
ADD CONSTRAINT fk_manager
FOREIGN KEY (Manager_ID) REFERENCES Employee(EmpID);

ALTER TABLE Employee
ADD CONSTRAINT fk_branch
FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC);

CREATE TABLE Customer (
    CID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    DOB DATE,
    Phoneno VARCHAR(10),
    Hno VARCHAR(10),
    Street VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30),
    Pincode VARCHAR(10)
);

CREATE TABLE Account (
    Accno VARCHAR(20) PRIMARY KEY,
    CID VARCHAR(10),
    Branch_IFSC VARCHAR(20),
    Date_opened DATE,
    PANno VARCHAR(10),
    Account_type VARCHAR(20),
    Balance DECIMAL(12, 2),
    FOREIGN KEY (CID) REFERENCES Customer(CID),
    FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC)
);

CREATE TABLE Loan (
    LoanID VARCHAR(20) PRIMARY KEY,
    Accno VARCHAR(20),
    Start_date DATE,
    Amount DECIMAL(12, 2),
    Term INT,
    Loan_type VARCHAR(30),
    Interest_rate DECIMAL(5,2),
    FOREIGN KEY (Accno) REFERENCES Account(Accno)
);

CREATE TABLE DebitCard (
    Cardno VARCHAR(20) PRIMARY KEY,
    Accno VARCHAR(20),
    CVV INT,
    exp_month INT,
    exp_year INT,
    FOREIGN KEY (Accno) REFERENCES Account(Accno)
);

CREATE TABLE Passbook (
    PID VARCHAR(20) PRIMARY KEY,
    Accno VARCHAR(20),
    Branch_IFSC VARCHAR(20),
    DOI DATE,
    Date_of_last_commit DATE,
    FOREIGN KEY (Accno) REFERENCES Account(Accno),
    FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC)
);

CREATE TABLE Employee_phone (
    EmpID VARCHAR(10),
    Phoneno VARCHAR(15) PRIMARY KEY,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

CREATE TABLE Customer_creditcard (
    CID VARCHAR(10),
    Cardno VARCHAR(20) PRIMARY KEY,
    exp_month INT,
    exp_year INT,
    FOREIGN KEY (CID) REFERENCES Customer(CID)
);

CREATE TABLE Supervise (
    Supervisor VARCHAR(10),
    Subordinate VARCHAR(10),
    PRIMARY KEY (Supervisor, Subordinate),
    FOREIGN KEY (Supervisor) REFERENCES Employee(EmpID),
    FOREIGN KEY (Subordinate) REFERENCES Employee(EmpID)
);

CREATE TABLE Transaction (
    TID VARCHAR(20) PRIMARY KEY,
    from_acc VARCHAR(20),
    to_acc VARCHAR(20),
    method VARCHAR(30),
    Date DATE,
    Time TIME,
    Amount DECIMAL(12, 2),
    FOREIGN KEY (from_acc) REFERENCES Account(Accno),
    FOREIGN KEY (to_acc) REFERENCES Account(Accno)
);

CREATE TABLE Registered_at (
    Branch_IFSC VARCHAR(20),
    CID VARCHAR(10),
    PRIMARY KEY (Branch_IFSC, CID),
    FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC),
    FOREIGN KEY (CID) REFERENCES Customer(CID)
);


-- Insert Customers
INSERT INTO Customer VALUES 
('C001', 'Riya Verma', '2000-01-15', '9876543210', '101', 'Rose Ave', 'Mumbai', 'MH', '400002'),
('C002', 'Rahul Jain', '1995-09-20', '9123456780', '202', 'Lake View', 'Delhi', 'DL', '110002');

-- Insert Accounts
INSERT INTO Account VALUES 
('ACC001', 'C001', 'IFSC001', '2020-08-10', 'ABCDE1234F', 'Savings', 50000.00),
('ACC002', 'C002', 'IFSC002', '2021-05-12', 'PQRSX9876Y', 'Current', 75000.00);

-- Insert Loans
INSERT INTO Loan VALUES 
('L001', 'ACC001', '2022-01-01', 200000.00, 60, 'Home', 7.5),
('L002', 'ACC002', '2023-06-15', 100000.00, 36, 'Personal', 10.0);

-- Insert DebitCards
INSERT INTO DebitCard VALUES 
('DC001', 'ACC001', 123, 12, 2025),
('DC002', 'ACC002', 456, 5, 2026);

-- Insert Passbooks
INSERT INTO Passbook VALUES 
('PB001', 'ACC001', 'IFSC001', '2020-08-10', '2025-04-01'),
('PB002', 'ACC002', 'IFSC002', '2021-05-12', '2025-04-02');

-- Insert Employee phones
INSERT INTO Employee_phone VALUES 
('E001', '9876543211'),
('E002', '9123456789');

-- Insert Customer credit cards
INSERT INTO Customer_creditcard VALUES 
('C001', 'CC001', 10, 2026),
('C002', 'CC002', 11, 2027);

-- Insert Supervise relationships
INSERT INTO Supervise VALUES 
('E001', 'E002');

-- Insert Transactions
INSERT INTO Transaction VALUES 
('T001', 'ACC001', 'ACC002', 'NEFT', '2025-04-01', '12:30:00', 1000.00),
('T002', 'ACC002', 'ACC001', 'IMPS', '2025-04-02', '15:45:00', 2000.00);

-- Insert Registered_at entries
INSERT INTO Registered_at VALUES 
('IFSC001', 'C001'),
('IFSC002', 'C002');

-- Populate Branch table
INSERT INTO Branch (IFSC, Manager_ID, Helpdeskcontact, Hno, Street, City, State, Pincode)
VALUES
('IFSC003', 'E003', '1800123987', '11', 'Purple Lane', 'Hyderabad', 'TS', '500001'),
('IFSC004', 'E004', '1800765432', '22', 'Orange Street', 'Pune', 'MH', '411001'),
('IFSC005', 'E005', '1800543210', '33', 'White Road', 'Ahmedabad', 'GJ', '380001'),
('IFSC006', 'E006', '1800321654', '44', 'Black Avenue', 'Jaipur', 'RJ', '302001'),
('IFSC007', 'E007', '1800210987', '55', 'Pink Lane', 'Lucknow', 'UP', '226001'),
('IFSC008', 'E008', '1800987654', '66', 'Yellow Road', 'Bangalore', 'KA', '560001'),
('IFSC009', 'E009', '1800456789', '77', 'Blue Avenue', 'Kolkata', 'WB', '700001'),
('IFSC010', 'E010', '1800789123', '88', 'Green Street', 'Chennai', 'TN', '600001');

-- Populate Employee table
INSERT INTO Employee (EmpID, Name, Branch_IFSC, Email, DOJ, Designation)
VALUES
('E003', 'Sachin Tendulkar', 'IFSC003', 'sachin@bank.com', '2018-01-10', 'Manager'),
('E004', 'Rahul Dravid', 'IFSC004', 'rahul@bank.com', '2019-02-20', 'Clerk'),
('E005', 'Sourav Ganguly', 'IFSC005', 'sourav@bank.com', '2020-03-15', 'Manager'),
('E006', 'V.V.S. Laxman', 'IFSC006', 'laxman@bank.com', '2021-04-25', 'Clerk'),
('E007', 'Harbhajan Singh', 'IFSC007', 'harbhajan@bank.com', '2022-05-30', 'Manager'),
('E008', 'Yuvraj Singh', 'IFSC008', 'yuvraj@bank.com', '2023-06-10', 'Clerk'),
('E009', 'Gautam Gambhir', 'IFSC009', 'gautam@bank.com', '2024-07-15', 'Manager'),
('E010', 'Virender Sehwag', 'IFSC010', 'virender@bank.com', '2025-08-20', 'Clerk');

-- Populate Customer table
INSERT INTO Customer (CID, Name, DOB, Phoneno, Hno, Street, City, State, Pincode)
VALUES
('C003', 'Suresh Raina', '1995-09-20', '9123456780', '203', 'Lake View', 'Delhi', 'DL', '110002'),
('C004', 'Robin Uthappa', '1990-09-20', '9123456781', '204', 'Lake View', 'Delhi', 'DL', '110002'),
('C005', 'Pragyan Ojha', '1990-09-20', '9123456782', '205', 'Lake View', 'Delhi', 'DL', '110002'),
('C006', 'Murali Vijay', '1990-09-20', '9123456783', '206', 'Lake View', 'Delhi', 'DL', '110002'),
('C007', 'Cheteshwar Pujara', '1990-09-20', '9123456784', '207', 'Lake View', 'Delhi', 'DL', '110002'),
('C008', 'Ajinkya Rahane', '1990-09-20', '9123456785', '208', 'Lake View', 'Delhi', 'DL', '110002'),
('C009', 'Wriddhiman Saha', '1990-09-20', '9123456786', '209', 'Lake View', 'Delhi', 'DL', '110002'),
('C010', 'Ravichandran Ashwin', '1990-09-20', '9123456787', '210', 'Lake View', 'Delhi', 'DL', '110002'),
('C011', 'Umesh Yadav', '1990-09-20', '9123456788', '211', 'Lake View', 'Delhi', 'DL', '110002'),
('C012', 'Mohammed Shami', '1990-09-20', '9123456789', '212', 'Lake View', 'Delhi', 'DL', '110002');

-- Populate Account table
INSERT INTO Account (Accno, CID, Branch_IFSC, Date_opened, PANno, Account_type, Balance)
VALUES
('ACC003', 'C003', 'IFSC003', '2020-08-10', 'ABCDE1235F', 'Savings', 60000.00),
('ACC004', 'C004', 'IFSC004', '2021-05-12', 'PQRSX9877Y', 'Current', 80000.00),
('ACC005', 'C005', 'IFSC005', '2022-01-01', 'ABCDE1236F', 'Savings', 70000.00),
('ACC006', 'C006', 'IFSC006', '2023-06-15', 'PQRSX9878Y', 'Current', 90000.00),
('ACC007', 'C007', 'IFSC007', '2024-07-20', 'ABCDE1237F', 'Savings', 100000.00),
('ACC008', 'C008', 'IFSC008', '2025-08-25', 'PQRSX9879Y', 'Current', 110000.00),
('ACC009', 'C009', 'IFSC009', '2026-09-30', 'ABCDE1238F', 'Savings', 120000.00),
('ACC010', 'C010', 'IFSC010', '2027-10-31', 'PQRSX9880Y', 'Current', 130000.00),
('ACC011', 'C011', 'IFSC003', '2028-11-01', 'ABCDE1239F', 'Savings', 140000.00),
('ACC012', 'C012', 'IFSC004', '2029-12-01', 'PQRSX9881Y', 'Current', 150000.00);

-- Populate Loan table
INSERT INTO Loan (LoanID, Accno, Start_date, Amount, Term, Loan_type, Interest_rate)
VALUES
('L003', 'ACC003', '2022-01-01', 250000.00, 60, 'Home', 7.5),
('L004', 'ACC004', '2023-06-15', 150000.00, 36, 'Personal', 10.0),
('L005', 'ACC005', '2024-07-20', 300000.00, 60, 'Car', 8.0),
('L006', 'ACC006', '2025-08-25', 200000.00, 36, 'Education', 9.0),
('L007', 'ACC007', '2026-09-30', 350000.00, 60, 'Home', 7.5),
('L008', 'ACC008', '2027-10-31', 250000.00, 36, 'Personal', 10.0),
('L009', 'ACC009', '2028-11-01', 400000.00, 60, 'Car', 8.0),
('L010', 'ACC010', '2029-12-01', 300000.00, 36, 'Education', 9.0),
('L011', 'ACC011', '2030-01-01', 450000.00, 60, 'Home', 7.5),
('L012', 'ACC012', '2031-02-01', 350000.00, 36, 'Personal', 10.0);

-- Populate DebitCard table
INSERT INTO DebitCard (Cardno, Accno, CVV, exp_month, exp_year)
VALUES
('DC003', 'ACC003', 123, 12, 2025),
('DC004', 'ACC004', 456, 5, 2026),
('DC005', 'ACC005', 789, 10, 2027),
('DC006', 'ACC006', 101, 11, 2028),
('DC007', 'ACC007', 112, 12, 2029),
('DC008', 'ACC008', 123, 1, 2030),
('DC009', 'ACC009', 456, 2, 2031),
('DC010', 'ACC010', 789, 3, 2032),
('DC011', 'ACC011', 101, 4, 2033),
('DC012', 'ACC012', 112, 5, 2034);

-- Populate Passbook table
INSERT INTO Passbook (PID, Accno, Branch_IFSC, DOI, Date_of_last_commit)
VALUES
('PB003', 'ACC003', 'IFSC003', '2020-08-10', '2025-04-01'),
('PB004', 'ACC004', 'IFSC004', '2021-05-12', '2025-04-02'),
('PB005', 'ACC005', 'IFSC005', '2022-01-01', '2025-04-03'),
('PB006', 'ACC006', 'IFSC006', '2023-06-15', '2025-04-04'),
('PB007', 'ACC007', 'IFSC007', '2024-07-20', '2025-04-05'),
('PB008', 'ACC008', 'IFSC008', '2025-08-25', '2025-04-06'),
('PB009', 'ACC009', 'IFSC009', '2026-09-30', '2025-04-07'),
('PB010', 'ACC010', 'IFSC010', '2027-10-31', '2025-04-08'),
('PB011', 'ACC011', 'IFSC003', '2028-11-01', '2025-04-09'),
('PB012', 'ACC012', 'IFSC004', '2029-12-01', '2025-04-10');

-- Add more Employee_phone entries
INSERT INTO Employee_phone (EmpID, Phoneno)
VALUES
('E003', '9876543212'),
('E004', '9123456781'),
('E005', '9876543213'),
('E006', '9123456782'),
('E007', '9876543214'),
('E008', '9123456783'),
('E009', '9876543215'),
('E010', '9123456784');

-- Add more Customer_creditcard entries
INSERT INTO Customer_creditcard (CID, Cardno, exp_month, exp_year)
VALUES
('C003', 'CC003', 12, 2028),
('C004', 'CC004', 1, 2029),
('C005', 'CC005', 2, 2030),
('C006', 'CC006', 3, 2031),
('C007', 'CC007', 4, 2032),
('C008', 'CC008', 5, 2033),
('C009', 'CC009', 6, 2034),
('C010', 'CC010', 7, 2035),
('C011', 'CC011', 8, 2036),
('C012', 'CC012', 9, 2037);

-- Add more Supervise relationships
INSERT INTO Supervise (Supervisor, Subordinate)
VALUES
('E003', 'E004'),
('E005', 'E006'),
('E007', 'E008'),
('E009', 'E010');

-- Add more Transaction entries
INSERT INTO Transaction (TID, from_acc, to_acc, method, Date, Time, Amount)
VALUES
('T003', 'ACC003', 'ACC004', 'NEFT', '2025-04-03', '10:00:00', 1500.00),
('T004', 'ACC004', 'ACC005', 'IMPS', '2025-04-04', '11:30:00', 2500.00),
('T005', 'ACC005', 'ACC006', 'NEFT', '2025-04-05', '12:45:00', 3500.00),
('T006', 'ACC006', 'ACC007', 'IMPS', '2025-04-06', '14:00:00', 4500.00),
('T007', 'ACC007', 'ACC008', 'NEFT', '2025-04-07', '15:15:00', 5500.00),
('T008', 'ACC008', 'ACC009', 'IMPS', '2025-04-08', '16:30:00', 6500.00),
('T009', 'ACC009', 'ACC010', 'NEFT', '2025-04-09', '17:45:00', 7500.00),
('T010', 'ACC010', 'ACC011', 'IMPS', '2025-04-10', '19:00:00', 8500.00),
('T011', 'ACC011', 'ACC012', 'NEFT', '2025-04-11', '20:15:00', 9500.00);

-- Add more Registered_at entries
INSERT INTO Registered_at (Branch_IFSC, CID)
VALUES
('IFSC003', 'C003'),
('IFSC004', 'C004'),
('IFSC005', 'C005'),
('IFSC006', 'C006'),
('IFSC007', 'C007'),
('IFSC008', 'C008'),
('IFSC009', 'C009'),
('IFSC010', 'C010');

