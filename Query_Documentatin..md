# SQL Query Documentation - Complete Reference Guide

This document provides detailed explanations, business use cases, and sample outputs for all 140+ queries in the Financial Portfolio Analytics project.

---

## Table of Contents

1. [Basic Queries](#1-basic-queries)
2. [Aggregation Queries](#2-aggregation-queries)
3. [Join Queries](#3-join-queries)
4. [Subqueries](#4-subqueries)
5. [Set Operations](#5-set-operations)
6. [Advanced Filtering](#6-advanced-filtering)
7. [Window Functions](#7-window-functions)
8. [Common Table Expressions (CTEs)](#8-common-table-expressions-ctes)
9. [Views](#9-views)
10. [Performance Optimization](#10-performance-optimization)

---

## 1. Basic Queries (13 Queries)

### 1.1 SELECT name, balance FROM users

**Purpose**: Retrieve user names and their account balances

**Business Use Case**: 
- Quick view of user wealth distribution
- Identify users for targeted marketing campaigns
- Customer service reference

**Sample Output**:
```
name          | balance
--------------|-----------
Alice Smith   | 450000.00
Bob Johnson   | 380000.00
Carol Davis   | 520000.00
```

---

### 1.2 SELECT DISTINCT risk FROM users

**Purpose**: List all unique risk categories in the system

**Business Use Case**:
- Understand risk segmentation
- Verify data integrity (ensure only valid risk levels exist)
- Risk category reporting

**Sample Output**:
```
risk
------
Low
Medium
High
```

---

### 1.3 SELECT id, name, balance FROM users WHERE balance > 400000

**Purpose**: Find high-net-worth individuals

**Business Use Case**:
- Premium service eligibility
- Wealth management outreach
- VIP customer identification

**When to Use**: Target users for premium features or personalized advisory services

---

### 1.4 SELECT id, name, age FROM users WHERE age BETWEEN 25 AND 30

**Purpose**: Filter users by age range

**Business Use Case**:
- Demographic-specific marketing campaigns
- Age-appropriate investment products
- Millennial investor analysis

**Why Important**: This age group represents high-growth potential customers

---

### 1.5 SELECT id, name, email FROM users WHERE email LIKE '%@mail.com'

**Purpose**: Find users with specific email domains

**Business Use Case**:
- Email campaign segmentation
- Domain-based analysis
- Data quality checks

**Pattern Matching**: `%` matches any characters, useful for filtering

---

### 1.6 SELECT * FROM users LIMIT 10

**Purpose**: Get a sample of user data

**Business Use Case**:
- Quick data preview
- Testing queries before full execution
- Sample data for presentations

**Best Practice**: Always use LIMIT when exploring large datasets

---

### 1.7 SELECT id, name, balance FROM users ORDER BY balance DESC

**Purpose**: Rank users by account balance

**Business Use Case**:
- Identify top investors
- Wealth distribution analysis
- Premium tier qualification

**Output**: Users sorted from highest to lowest balance

---

### 1.8 SELECT * FROM users WHERE risk = 'High'

**Purpose**: Filter high-risk profile users

**Business Use Case**:
- Risk management monitoring
- Targeted investment product offerings
- Compliance tracking

---

### 1.9 SELECT * FROM company_info WHERE sector = 'IT'

**Purpose**: List all IT sector companies

**Business Use Case**:
- Sector-specific analysis
- Investment recommendations
- Portfolio sector allocation

---

### 1.10 SELECT * FROM stock_prices ORDER BY price DESC LIMIT 5

**Purpose**: Find top 5 highest-priced stocks

**Business Use Case**:
- Premium stock identification
- Price range analysis
- Market leaders identification

---

## 2. Aggregation Queries (13 Queries)

### 2.1 SELECT COUNT(*) AS total_users FROM users

**Purpose**: Count total users in the system

**Business Use Case**:
- User growth metrics
- Platform size reporting
- Capacity planning

**Sample Output**: `total_users: 150`

---

### 2.2 SELECT AVG(balance) AS avg_balance FROM users

**Purpose**: Calculate average user balance

**Business Use Case**:
- Platform wealth metrics
- Benchmark individual users against average
- Financial health indicator

**Key Insight**: Helps identify if individual users are above or below average

---

### 2.3 SELECT MIN(age) AS youngest, MAX(age) AS oldest FROM users

**Purpose**: Find age range of users

**Business Use Case**:
- Demographic analysis
- Age-appropriate marketing
- Service customization

---

### 2.4 SELECT risk, COUNT(*) AS user_count FROM users GROUP BY risk

**Purpose**: Count users in each risk category

**Business Use Case**:
- Risk distribution analysis
- Portfolio segmentation
- Compliance reporting

**Sample Output**:
```
risk    | user_count
--------|------------
Low     | 45
Medium  | 62
High    | 43
```

---

### 2.5 SELECT risk, AVG(balance) AS avg_balance FROM users GROUP BY risk

**Purpose**: Average balance per risk category

**Business Use Case**:
- Risk vs wealth correlation
- Investment capacity by risk profile
- Product pricing strategy

**Insight**: Often shows high-risk users have higher balances

---

### 2.6 SELECT StockName, SUM(quantity) AS total_shares FROM user_portfolios GROUP BY StockName

**Purpose**: Total shares held across all users per stock

**Business Use Case**:
- Platform's total exposure to each stock
- Most popular stocks identification
- Liquidity planning

---

### 2.7 SELECT symbol, ROUND(AVG(close), 2) AS avg_price FROM stock_prices GROUP BY symbol

**Purpose**: Average closing price per stock

**Business Use Case**:
- Price benchmarking
- Valuation analysis
- Fair value estimation

---

### 2.8 SELECT sector, COUNT(*) AS total_companies FROM company_info GROUP BY sector

**Purpose**: Count companies per sector

**Business Use Case**:
- Sector coverage analysis
- Diversification opportunities
- Market representation

---

### 2.9 SELECT EXTRACT(Year FROM date) AS Year, SUM(turnover) AS total_volume FROM market_stats GROUP BY year

**Purpose**: Annual market turnover analysis

**Business Use Case**:
- Market growth trends
- Trading activity patterns
- Economic health indicators

---

### 2.10 SELECT userID, SUM(quantity * price) AS portfolio_value FROM user_portfolios GROUP BY userID

**Purpose**: Calculate total portfolio value per user

**Business Use Case**:
- Wealth ranking
- Portfolio performance tracking
- Advisory services targeting

**Critical Query**: Core metric for user portfolio valuation

---

### 2.11 SELECT risk, SUM(balance) AS total_balance FROM users GROUP BY risk HAVING SUM(balance) > 1000000

**Purpose**: Find risk categories with total balance exceeding threshold

**Business Use Case**:
- High-value segment identification
- Risk concentration analysis
- Capital allocation strategy

**HAVING vs WHERE**: HAVING filters after aggregation, WHERE filters before

---

## 3. Join Queries (19 Queries)

### 3.1 SELECT u.id, u.name, p.stockname FROM users u INNER JOIN user_portfolios p ON u.id = p.userID

**Purpose**: Match users with their stock holdings

**Business Use Case**:
- Portfolio ownership reports
- User investment tracking
- Relationship mapping

**Join Type**: INNER JOIN returns only matching records

---

### 3.2 SELECT u.id, u.name, p.stockname, p.quantity FROM users u LEFT JOIN user_portfolios p ON u.id = p.userID

**Purpose**: Show all users, including those without portfolios

**Business Use Case**:
- Identify inactive users
- Non-investor outreach campaigns
- Platform adoption rates

**Key Difference**: LEFT JOIN includes users with NULL portfolio data

---

### 3.3 Multi-table Join: Users → Portfolios → Companies

```sql
SELECT u.id, u.name, c.company_name 
FROM users u 
JOIN user_portfolios p ON u.id = p.userID 
JOIN company_info c ON p.stockname = c.symbol
```

**Purpose**: Link users to actual company names they invest in

**Business Use Case**:
- Readable investment reports
- Company-specific user lists
- Marketing partnerships with companies

---

### 3.4 Users → Portfolios → Stock Prices (Live Valuation)

```sql
SELECT u.id, u.name, sp.close 
FROM users u 
JOIN user_portfolios p ON u.id = p.userID 
JOIN stock_prices sp ON p.stockname = sp.symbol
```

**Purpose**: Real-time portfolio valuation

**Business Use Case**:
- Live portfolio tracking
- Current market value calculation
- Profit/loss reporting

**Critical**: Used for real-time dashboards

---

### 3.5 SELECT c.company_name, COUNT(p.userID) AS total_investors FROM company_info c JOIN user_portfolios p ON c.symbol = p.stockname GROUP BY c.company_name

**Purpose**: Count investors per company

**Business Use Case**:
- Stock popularity rankings
- Investment trend analysis
- Company-specific user base

**Insight**: Identifies platform's most popular stocks

---

### 3.6 SELECT u.name, COUNT(p.stockname) AS total_stocks FROM users u JOIN user_portfolios p ON u.id = p.userID GROUP BY u.name

**Purpose**: Count number of different stocks per user

**Business Use Case**:
- Diversification analysis
- Portfolio complexity measurement
- Investment sophistication indicator

---

### 3.7 Portfolio Value Calculation (Most Important)

```sql
SELECT u.name, SUM(p.quantity * sp.close) AS portfolio_value 
FROM users u 
JOIN user_portfolios p ON u.id = p.userID 
JOIN stock_prices sp ON p.stockname = sp.symbol 
GROUP BY u.name
```

**Purpose**: Calculate exact current portfolio value

**Business Use Case**:
- Wealth leaderboard
- Performance tracking
- Net worth calculation

**Why Critical**: Core metric for all financial reporting

---

### 3.8 Average Stock Price per User

**Purpose**: Shows average price of stocks in user's portfolio

**Business Use Case**:
- Investment style analysis (value vs growth)
- Price range preferences
- Risk appetite indicator

---

### 3.9 Sector Value Aggregation

**Purpose**: Total value of all stocks per sector

**Business Use Case**:
- Sector performance comparison
- Market cap distribution
- Investment concentration risks

---

### 3.10 Complete User Portfolio Details

**Purpose**: Full details of user holdings with company info and prices

**Business Use Case**:
- Comprehensive portfolio reports
- Customer service reference
- Detailed investment statements

---

## 4. Subqueries (18 Queries)

### 4.1 SELECT company_name FROM company_info WHERE symbol IN (SELECT stockname FROM user_portfolios WHERE UserID = 10)

**Purpose**: Find companies owned by specific user

**Business Use Case**:
- Individual portfolio reports
- User-specific recommendations
- Personalized analysis

**Subquery Advantage**: Nested logic for complex filtering

---

### 4.2 Companies with High Trading Volume

```sql
SELECT company_name FROM company_info 
WHERE symbol IN (SELECT symbol FROM stock_prices WHERE volume > 1000000)
```

**Purpose**: Find actively traded companies

**Business Use Case**:
- Liquidity analysis
- High-volume stock identification
- Trading opportunity discovery

---

### 4.3 Users Holding Specific Stock

```sql
SELECT name, email FROM users 
WHERE ID IN (SELECT UserID FROM user_portfolios WHERE StockName = 'TCS')
```

**Purpose**: Find all TCS investors

**Business Use Case**:
- Stock-specific user targeting
- Company-related communications
- Shareholder notifications

---

### 4.4 IT Sector Investors

**Purpose**: Users invested in IT sector stocks

**Business Use Case**:
- Sector-specific campaigns
- Technology investment analysis
- Specialized advisory services

---

### 4.5 SELECT COUNT(*) FROM user_portfolios WHERE UserID IN (SELECT ID FROM users WHERE age > 40)

**Purpose**: Count holdings of users over 40

**Business Use Case**:
- Age-based investment patterns
- Demographic portfolio analysis
- Lifecycle investing research

---

### 4.6 Average Balance of Investors

```sql
SELECT AVG(balance) FROM users 
WHERE ID IN (SELECT UserID FROM user_portfolios)
```

**Purpose**: Average balance of active investors vs all users

**Business Use Case**:
- Investor vs non-investor comparison
- Conversion value analysis
- Platform engagement metrics

---

### 4.7 Above-Average Balance Users

```sql
SELECT name FROM users 
WHERE balance > (SELECT AVG(balance) FROM users)
```

**Purpose**: Find users with above-average wealth

**Business Use Case**:
- High-value customer identification
- Premium service targeting
- Wealth tier segmentation

**Subquery Type**: Scalar subquery (returns single value)

---

### 4.8 Stocks Priced Above Average

**Purpose**: Identify premium-priced stocks

**Business Use Case**:
- Value stock vs growth stock classification
- Price range analysis
- Investment recommendations

---

### 4.9 High-Activity Market Days

**Purpose**: Find days with above-average market turnover

**Business Use Case**:
- Market sentiment analysis
- Volatility identification
- Trading pattern recognition

---

### 4.10 Active Investors List

```sql
SELECT name FROM users 
WHERE ID IN (SELECT DISTINCT UserID FROM user_portfolios)
```

**Purpose**: Users with at least one investment

**Business Use Case**:
- Active user count
- Engagement metrics
- Conversion tracking

---

### 4.11 Users with Maximum Quantity Holdings

**Purpose**: Find users with largest position in any stock

**Business Use Case**:
- Concentration risk identification
- Large position monitoring
- Portfolio risk management

---

### 4.12 EXISTS Clause Example

```sql
SELECT u.name, u.email FROM users u 
WHERE EXISTS (SELECT 1 FROM user_portfolios p 
              WHERE p.UserID = u.ID AND p.StockName = 'RELIANCE')
```

**Purpose**: Check if user owns RELIANCE stock

**Business Use Case**:
- Stockholder identification
- Targeted communications
- Ownership verification

**EXISTS vs IN**: EXISTS stops at first match (more efficient)

---

## 5. Set Operations (7 Queries)

### 5.1 UNION ALL - Combine Risk Categories

```sql
SELECT name FROM users WHERE risk = 'High' 
UNION ALL 
SELECT name FROM users WHERE risk = 'Medium'
```

**Purpose**: List all high and medium risk users

**Business Use Case**:
- Multi-segment targeting
- Risk-based grouping
- Campaign list creation

**UNION vs UNION ALL**: UNION ALL keeps duplicates (faster)

---

### 5.2 INTERSECT - Common Stocks

```sql
SELECT symbol FROM company_info WHERE sector = 'IT' 
INTERSECT 
SELECT StockName FROM user_portfolios
```

**Purpose**: IT stocks that users actually own

**Business Use Case**:
- Popular IT stock identification
- Sector adoption rate
- Product-market fit analysis

---

### 5.3 EXCEPT - Unloved Stocks

```sql
SELECT symbol FROM company_info 
EXCEPT 
SELECT StockName FROM user_portfolios
```

**Purpose**: Stocks available but not owned by anyone

**Business Use Case**:
- Unpopular stock identification
- Promotion opportunities
- Coverage gap analysis

**Insight**: Helps identify stocks needing marketing push

---

### 5.4 User ID Aggregation

**Purpose**: Combine age-based users with portfolio holders

**Business Use Case**:
- Broad user list compilation
- Multi-criteria targeting
- Comprehensive reach

---

## 6. Advanced Filtering (14 Queries)

### 6.1 Multiple AND Conditions

```sql
SELECT * FROM user_portfolios 
WHERE Quantity >= 50 OR Price > 2000
```

**Purpose**: Large or expensive holdings

**Business Use Case**:
- High-value position identification
- Risk exposure analysis
- Premium stock holdings

---

### 6.2 IN Operator for Multiple Values

```sql
SELECT name FROM users 
WHERE risk IN ('High', 'Medium')
```

**Purpose**: Filter multiple risk categories

**Business Use Case**:
- Multi-segment queries
- Exclude low-risk users
- Targeted analysis

**Advantage**: Cleaner than multiple OR conditions

---

### 6.3 NOT IN for Exclusion

```sql
SELECT company_name FROM company_info 
WHERE industry NOT IN ('Software', 'Banking')
```

**Purpose**: Find companies outside major industries

**Business Use Case**:
- Diversification opportunities
- Niche sector identification
- Alternative investments

---

### 6.4 Complex Boolean Logic

```sql
SELECT * FROM stock_prices 
WHERE symbol = 'RELIANCE' AND (close > open)
```

**Purpose**: Find profitable trading days for RELIANCE

**Business Use Case**:
- Gain days identification
- Positive momentum tracking
- Trading pattern analysis

---

### 6.5 Pattern Matching with LIKE

```sql
SELECT name FROM users 
WHERE name LIKE 'A%' AND risk = 'Low'
```

**Purpose**: Low-risk users with names starting with 'A'

**Business Use Case**:
- Alphabetical segmentation
- Personalized communications
- Name-based filtering

---

### 6.6 NULL Handling

```sql
SELECT company_name FROM company_info 
WHERE market_cap_category IS NOT NULL AND industry = 'Software'
```

**Purpose**: Complete data records only

**Business Use Case**:
- Data quality filtering
- Complete profile requirements
- Analysis accuracy

---

### 6.7 Range and Age Filter

```sql
SELECT name, balance FROM users 
WHERE balance BETWEEN 300000 AND 400000 AND age < 30
```

**Purpose**: Young users in middle wealth bracket

**Business Use Case**:
- Age-wealth segment targeting
- Growth potential identification
- Specific product fit

---

### 6.8 Multi-Value IN with Volume Filter

```sql
SELECT * FROM stock_prices 
WHERE symbol IN ('TCS', 'INFY') AND volume > 2000000
```

**Purpose**: High-volume days for specific stocks

**Business Use Case**:
- Liquidity analysis
- Trading opportunity identification
- Activity spike detection

---

## 7. Window Functions (19 Queries)

### 7.1 Moving Average

```sql
SELECT date, symbol, close, 
       AVG(close) OVER (PARTITION BY symbol ORDER BY date 
                        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM stock_prices
```

**Purpose**: 3-day moving average for each stock

**Business Use Case**:
- Trend identification
- Smoothing price volatility
- Technical analysis

**Why Important**: Core technical indicator for trading decisions

---

### 7.2 RANK by Balance

```sql
SELECT name, balance, 
       RANK() OVER (ORDER BY balance DESC) AS rank_by_balance
FROM users
```

**Purpose**: Rank users by wealth

**Business Use Case**:
- Leaderboard creation
- Tier assignment (Gold, Silver, Bronze)
- Competitive positioning

**RANK vs DENSE_RANK**: RANK skips numbers after ties

---

### 7.3 NTILE for Quartiles

```sql
SELECT name, balance, 
       NTILE(4) OVER (ORDER BY balance DESC) AS balance_quartile
FROM users
```

**Purpose**: Divide users into 4 equal groups

**Business Use Case**:
- Quartile analysis
- Percentile-based segmentation
- Distribution visualization

**Use Case**: Top 25%, Second 25%, etc.

---

### 7.4 LAG - Previous Day Price

```sql
SELECT symbol, close, 
       LAG(close, 1, 0) OVER (PARTITION BY symbol ORDER BY date) AS previous_day_close
FROM stock_prices
```

**Purpose**: Access previous day's closing price

**Business Use Case**:
- Day-over-day comparison
- Price change calculation
- Momentum analysis

---

### 7.5 LEAD - Next Day Price

```sql
SELECT symbol, close, 
       LEAD(close, 1, 0) OVER (PARTITION BY symbol ORDER BY date) AS next_day_close
FROM stock_prices
```

**Purpose**: Look ahead to next day

**Business Use Case**:
- Forward-looking analysis
- Prediction validation
- Trend continuation

---

### 7.6 Partition Average

**Purpose**: Average stock price within each symbol group

**Business Use Case**:
- Compare daily price to stock's average
- Relative valuation
- Overvalued/undervalued identification

---

### 7.7 Running Total

```sql
SELECT date, index_name, turnover, 
       SUM(turnover) OVER (PARTITION BY index_name ORDER BY date) AS running_total_turnover
FROM market_stats
```

**Purpose**: Cumulative market turnover

**Business Use Case**:
- Cumulative volume tracking
- Growth trajectory visualization
- Year-to-date metrics

---

### 7.8 Count by Risk Category

**Purpose**: Show category size to each user

**Business Use Case**:
- Comparative context ("You're 1 of 45 high-risk users")
- Segmentation metrics
- Distribution visibility

---

### 7.9 Price Change Calculation

```sql
SELECT symbol, close, 
       close - LAG(close, 1, 0) OVER (PARTITION BY symbol ORDER BY date) AS price_change
FROM stock_prices
```

**Purpose**: Daily price change in rupees

**Business Use Case**:
- Absolute change tracking
- Volatility measurement
- Gain/loss calculation

**Key Metric**: Foundation for returns calculation

---

### 7.10 FIRST_VALUE

**Purpose**: First price in period

**Business Use Case**:
- Period start benchmark
- Return calculation base
- Historical reference

---

### 7.11 LAST_VALUE

**Purpose**: Last price in period

**Business Use Case**:
- Current period end value
- Latest available data
- Comparison endpoint

---

### 7.12 Portfolio Ranking

```sql
SELECT u.name, p.StockName, p.Quantity, 
       RANK() OVER (PARTITION BY p.UserID ORDER BY p.Quantity DESC) AS rank_in_portfolio
FROM user_portfolios p 
JOIN users u ON u.ID = p.UserID
```

**Purpose**: Rank holdings within each user's portfolio

**Business Use Case**:
- Top holding identification
- Portfolio concentration analysis
- Largest position tracking

---

### 7.13 ROW_NUMBER for Ranking

**Purpose**: Assign unique rank to each stock price

**Business Use Case**:
- Distinct ordering
- Tie-breaking
- Sequential numbering

**ROW_NUMBER vs RANK**: ROW_NUMBER never has ties

---

### 7.14 3-Day Volume Sum

**Purpose**: Sum volume across 3-day window

**Business Use Case**:
- Short-term volume trends
- Liquidity patterns
- Activity spikes

---

## 8. Common Table Expressions (CTEs) (13 Queries)

### 8.1 High Volume Stocks CTE

```sql
WITH HighVolumeStocks AS (
    SELECT symbol FROM stock_prices WHERE volume > 1000000
)
SELECT DISTINCT company_name FROM company_info 
WHERE symbol IN (SELECT symbol FROM HighVolumeStocks)
```

**Purpose**: Find companies with high trading volume

**Business Use Case**:
- Liquid stock identification
- Actively traded securities
- Low-slippage trading opportunities

**CTE Advantage**: Makes query more readable and reusable

---

### 8.2 User Total Quantity

**Purpose**: Calculate total shares held by each user

**Business Use Case**:
- Investment scale measurement
- Portfolio size comparison
- Holding concentration

---

### 8.3 Average Price Filter

**Purpose**: Stocks with above-threshold average purchase price

**Business Use Case**:
- Premium stock portfolios
- High-value holdings
- Investment style analysis

---

### 8.4 Top 5 Users by Balance

**Purpose**: Identify wealthiest users

**Business Use Case**:
- VIP identification
- Premium service targeting
- Wealth management outreach

**CTE Use**: Clean separation of ranking logic from output selection

---

### 8.5 Daily Average Price with Window

**Purpose**: Moving average embedded in CTE

**Business Use Case**:
- Technical analysis preparation
- Trend data preprocessing
- Complex metric calculation

---

### 8.6 Ranked Users (Top 10)

```sql
WITH RankedUsers AS (
    SELECT ID, Name, DENSE_RANK() OVER (ORDER BY balance DESC) as balance_rank 
    FROM users
)
SELECT Name, balance_rank FROM RankedUsers WHERE balance_rank <= 10
```

**Purpose**: Top 10 users by balance

**Business Use Case**:
- Top tier identification
- Leaderboard display
- Elite customer recognition

---

### 8.7 Banking Sector Investor Count

**Purpose**: Count users invested in banking

**Business Use Case**:
- Sector penetration metrics
- Market share analysis
- Segment size estimation

---

### 8.8 High-Value Portfolio Filter

**Purpose**: Users with portfolio value above threshold

**Business Use Case**:
- Wealth-based segmentation
- Advisory service eligibility
- Risk limit enforcement

---

### 8.9 High Risk + High Balance

**Purpose**: Wealthy aggressive investors

**Business Use Case**:
- Premium risky product targeting
- Sophisticated investor identification
- Alternative investment candidates

---

### 8.10 Portfolio Holding Count

**Purpose**: Users with many different holdings

**Business Use Case**:
- Diversification leaders
- Active investor identification
- Engagement metrics

---

### 8.11 Stock Volume Ranking

**Purpose**: Top 5 stocks by total volume

**Business Use Case**:
- Most traded stocks
- Market leader identification
- Liquidity ranking

---

### 8.12 Portfolio by Sector

**Purpose**: User holdings grouped by sector

**Business Use Case**:
- Sector allocation analysis
- Diversification assessment
- Concentration risk identification

---

### 8.13 High and Low Prices

**Purpose**: Price range for each stock

**Business Use Case**:
- Volatility assessment
- Trading range identification
- Risk measurement

---

## 9. Views (10 Queries)

### 9.1 HighRiskUsers View

```sql
CREATE VIEW HighRiskUsers AS 
SELECT ID, Name, Balance FROM users WHERE Risk = 'High'
```

**Purpose**: Permanent virtual table for high-risk users

**Business Use Case**:
- Quick access to risky profiles
- Monitoring dashboard
- Compliance reporting

**View Advantage**: Query simplification and security

---

### 9.2 ITCompanies View

**Purpose**: Reusable IT sector company list

**Business Use Case**:
- Sector-specific reports
- Investment recommendations
- Quick filtering

---

### 9.3 PortfolioValues View

**Purpose**: Pre-calculated portfolio values

**Business Use Case**:
- Dashboard performance
- Regular reporting
- Fast access to valuations

**Performance**: Avoid recalculating complex aggregations

---

### 9.4 Top5StocksByVolume View

**Purpose**: Most liquid stocks

**Business Use Case**:
- Trading recommendations
- Market movers identification
- Liquidity reference

---

### 9.5 UserPortfolioSummary View

**Purpose**: User-stock relationship snapshot

**Business Use Case**:
- Quick portfolio lookup
- Customer service reference
- Relationship reporting

---

### 9.6 DailyMarketSummary View

**Purpose**: Daily turnover aggregation

**Business Use Case**:
- Market activity tracking
- Trading volume trends
- Economic indicators

---

### 9.7 BankingStocks View

**Purpose**: Banking sector focus

**Business Use Case**:
- Sector-specific analysis
- Industry reports
- Specialized recommendations

---

### 9.8 StockPerformance View

**Purpose**: Daily price changes

**Business Use Case**:
- Performance tracking
- Winners/losers identification
- Momentum analysis

---

### 9.9 LowBalanceUsers View

**Purpose**: Users below balance threshold

**Business Use Case**:
- At-risk customer identification
- Retention campaigns
- Minimum balance monitoring

---

### 9.10 MostTradedStock View

**Purpose**: Single most traded stock

**Business Use Case**:
- Market favorite identification
- Featured stock display
- Trading volume champion

---

## 10. Performance Optimization (4 Queries)

### 10.1 SHOW INDEXES

**Purpose**: List all indexes on a table

**Business Use Case**:
- Index audit
- Performance troubleshooting
- Optimization planning

---

### 10.2 CREATE INDEX

```sql
CREATE INDEX idx_user_balance ON users (Balance)
```

**Purpose**: Speed up balance-based queries

**Business Use Case**:
- Query optimization
- Faster filtering
- Improved response times

**Impact**: 50-90% performance improvement on indexed columns

---

### 10.3 EXPLAIN SELECT

```sql
EXPLAIN SELECT * FROM users WHERE Balance > 400000
```

**Purpose**: Analyze query execution plan

**Business Use Case**:
- Performance diagnosis
- Index usage verification
- Optimization validation

**Key Metrics**: rows examined, execution time, index usage

---

### 10.4 EXPLAIN Complex Join

**Purpose**: Optimize multi-table queries

**Business Use Case**:
- Join performance analysis
- Bottleneck identification
- Query refactoring guidance

---

## Summary

This documentation covers 140+ queries demonstrating:

- **Basic SQL**: Foundation operations
- **Aggregations**: Business metrics calculation
- **Joins**: Relationship navigation
- **Subqueries**: Complex filtering logic
- **Set Operations**: Data combination
- **Window Functions**: Advanced analytics
- **CTEs**: Query organization
- **Views**: Abstraction and reusability
- **Performance**: Optimization techniques

Each query serves specific business needs in financial portfolio management, from user segmentation to real-time valuation to risk analysis.

---

**Document Version**: 1.0  
**Last Updated**: December 2024  
**Coverage**: 140+ SQL Queries  
**Complexity Levels**: Beginner → Intermediate → Advanced