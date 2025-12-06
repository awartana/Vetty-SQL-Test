# Vetty SQL Test – Solution  
Author: **Awartana Prawin**  
Date: 2025

---

## 📌 Overview
This repository contains my solutions to the Vetty SQL Assessment.  
The task involved writing SQL queries based on two given tables:

- **transactions**
- **items**

The provided dataset snapshot was used directly, and where column meanings were unclear, reasonable assumptions have been clearly stated.

---

## 🗂  Table Structure (from the assignment)

### **transactions**
| Column               | Description                        |
|----------------------|------------------------------------|
| buyer_id             | Buyer ID                           |
| purchase_time        | Timestamp of purchase              |
| refund_item (assumed refund_time) | Timestamp of refund or NULL |
| store_id             | Store identifier                   |
| item_id              | Item purchased                     |
| gross_transaction_value | Value of transaction (text format '$XX') |

### **items**
| Column        | Description      |
|---------------|------------------|
| store_id      | Store identifier |
| item_id       | Item identifier  |
| item_category | Category         |
| item_name     | Name of item     |

---

## 🧠 Assumptions
- The column `refund_item` in the transactions table actually represents `refund_time` (because the values are timestamps).
- NULL refund_time = purchase not refunded.
- gross_transaction_value is stored as text ('$24'), so numeric casting is applied where needed.
- All queries use only the provided dataset, as instructed.

---

## 📜 SQL Solutions
All eight SQL answers are included in the file:

👉 **vetty_solution.sql**

The script includes:
1. Monthly purchase count (excluding refunded)
2. Stores with ≥5 purchases in Oct 2020  
3. Shortest purchase → refund interval per store  
4. First order value per store  
5. Most popular item in first purchase per buyer  
6. Refund eligibility flag (within 72 hours)  
7. Second purchase per buyer  
8. Second transaction timestamp per buyer (without MIN/MAX)


---


## 📁 How to Run
1. Load the dataset into your SQL environment (MySQL recommended).  
2. Execute the commands in **vetty_solution.sql**.  
3. Verify results match expected logic.

---

## ✔ Final Notes
All queries were written to be readable, properly commented, and aligned exactly with the dataset provided in the assessment PDF.

If you need help running the SQL file or generating output screenshots, feel free to ask!
