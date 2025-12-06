# Financial Portfolio Analytics System 📊

A comprehensive SQL-based analytics system for stock market portfolio management and financial data analysis, featuring 140+ production-ready queries across 8 advanced SQL topics.

## 🎯 Project Overview

This project demonstrates advanced SQL query techniques applied to a real-world financial portfolio management scenario. It includes comprehensive analysis of user portfolios, stock prices, company information, and market statistics.

## 📁 Database Schema

The system uses 5 interconnected tables:

- **users** - User profile and account information
- **user_portfolios** - Individual stock holdings per user
- **company_info** - Company details and sector classification
- **stock_prices** - Daily stock price OHLCV data
- **market_stats** - Market index performance metrics

## 🚀 Features

### Query Categories (140+ Queries)

1. **Basic Queries (13)** - SELECT, DISTINCT, WHERE, ORDER BY, LIMIT
2. **Aggregations (13)** - COUNT, AVG, SUM, GROUP BY, HAVING
3. **Joins (19)** - INNER, LEFT, multi-table joins with complex conditions
4. **Subqueries (18)** - Nested queries, correlated subqueries, EXISTS
5. **Set Operations (7)** - UNION, INTERSECT, EXCEPT
6. **Advanced Filtering (14)** - Complex WHERE conditions, pattern matching
7. **Window Functions (19)** - RANK, DENSE_RANK, LAG, LEAD, moving averages
8. **CTEs (13)** - Common Table Expressions for complex queries
9. **Views (10)** - Reusable query abstractions
10. **Performance Optimization (4)** - Indexes, EXPLAIN plans

## 💡 Key Use Cases

- **Portfolio Valuation** - Calculate total portfolio value by user
- **Risk Analysis** - Analyze user distribution across risk categories
- **Sector Performance** - Track stock performance by industry sector
- **Market Trends** - Identify top performers and market movements
- **User Segmentation** - Group users by balance, age, and holdings
- **Investment Patterns** - Discover which stocks are most popular

## 🛠️ Technologies Used

- **Database**: MySQL
- **Language**: SQL
- **Concepts**: Relational Database Design, Query Optimization, Data Analysis

## 📊 Sample Insights

- Track portfolio values in real-time across all users
- Identify high-risk investors with large balances
- Calculate moving averages for stock price trends
- Analyze sector-wise investment distribution
- Monitor market index performance (NIFTY50, SENSEX)

## 🔧 Setup Instructions

1. **Create Database**
   ```sql
   CREATE DATABASE market_analytics;
   USE market_analytics;
   ```

2. **Run Schema**
   ```bash
   mysql -u username -p market_analytics < schema.sql
   ```

3. **Load Data**
   - Import CSV files using MySQL LOAD DATA or import tool
   - Or run the data loader script

4. **Execute Queries**
   ```bash
   mysql -u username -p market_analytics < queries/ftn_1-140.sql
   ```

## 📂 Project Structure

```
financial-portfolio-analytics/
├── README.md
├── schema.sql
├── data/
│   ├── users.csv
│   ├── user_portfolios.csv
│   ├── company_info.csv
│   ├── stock_prices.csv
│   └── market_stats.csv
├── queries/
│   ├── 01_basics.sql
│   ├── 02_aggregations.sql
│   ├── 03_joins.sql
│   ├── 04_subqueries.sql
│   ├── 05_set_operations.sql
│   ├── 06_advanced_filtering.sql
│   ├── 07_window_functions.sql
│   ├── 08_ctes.sql
│   ├── 09_views.sql
│   └── 10_performance.sql
├── outputs/
│   └── sample_results/
└── docs/
    └── QUERY_DOCUMENTATION.md
```

## 🎓 Learning Outcomes

This project demonstrates proficiency in:
- Complex SQL query construction
- Database design and normalization
- Performance optimization techniques
- Financial data analysis
- Business intelligence queries
- Advanced SQL features (CTEs, Window Functions, Views)

## 📈 Query Complexity Breakdown

- **Beginner**: 26 queries (Basics, Simple Aggregations)
- **Intermediate**: 52 queries (Joins, Subqueries, Set Operations)
- **Advanced**: 62 queries (Window Functions, CTEs, Optimization)

## 🤝 Contributing

Feel free to fork this project and add your own queries or improvements!

## 📝 License

This project is open source and available for educational purposes.

## 👤 Author

Vansh Shah
- LinkedIn: https://www.linkedin.com/in/vansh-shah-632757244/
- GitHub: https://github.com/Vanshshah2325
- Email: vanshshah2325@gmail.com

## 🌟 Acknowledgments

Built as a comprehensive SQL learning project covering real-world financial data analysis scenarios.

---

**⭐ If you find this project helpful, please give it a star!**