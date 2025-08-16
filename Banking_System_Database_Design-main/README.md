# 🏦 Banking System Database – BUDDY BANK

## 📌 Project Overview
This project is a **relational database system** designed to manage core banking operations, built as part of CS3700 Assignments 1 & 3.  
It models various entities such as **Branches, Customers, Accounts, Loans, Employees, Credit/Debit Cards, Passbooks, and Transactions**, supporting realistic banking functionalities and relationships.

The project includes:
- **Database design** using ER diagrams and relational schema.
- **MySQL implementation** with populated sample data.
- **Advanced SQL queries** for business insights and reporting.

---

## 📂 Project Structure
```
├── ERD&Scheme.pdf       # ER Diagram, Domain Description & Relational Schema
├── SQL_Queries.pdf         # SQL Queries with explanations
├── BUDDY BANK Database.sql        # MySQL database creation & sample data population
```

---

## 🗄️ Database Features
- **Entities:** Branch, Employee, Customer, Account, Loan, DebitCard, Passbook, CreditCard, Transaction.
- **Relationships:** One-to-many, many-to-many, and one-to-one links between banking entities.
- **Constraints:** Primary keys, foreign keys, referential integrity.
- **Data Population:** Includes multiple sample records for testing queries.

---

## 📊 Example SQL Queries Implemented
1. Average loan amount per branch.
2. Day with highest number of transactions & total value.
3. Top 5 customers by transaction count.
4. Employees without subordinates.
5. Branch with highest total loan amount in the last year.
6. Employee supervising the most people (directly/indirectly).

---

## 🚀 How to Run
1. **Clone the repository:**
   ```bash
   git clone <your-repo-link>
   cd <repo-folder>
   ```
2. **Open MySQL** and run:
   ```sql
   SOURCE "BUDDY BANK Database.sql";
   ```
3. **Execute queries** from `SQL_Queries.pdf` in MySQL Workbench or CLI.
4. **Test your own queries** using the populated data.

---

## 📜 ER Diagram & Schema
The **ER diagram** and **relational schema** can be found in `ERD&Scheme.pdf`.

---

## 🏆 Learning Outcomes
- Designing a **normalized relational database** from a real-world domain.
- Implementing **referential integrity and constraints** in MySQL.
- Writing **complex SQL queries** for analytics and reporting.
- Understanding **banking workflows** through database modeling.

---

## 👨‍💻 Author
**Gurrala Abhishek**  
CS22B049 – CS3700 Database Systems Project
