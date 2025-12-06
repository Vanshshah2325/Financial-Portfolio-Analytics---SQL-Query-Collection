use market_analytics;

-- Basics  13

SELECT name, balance FROM users;
SELECT DISTINCT risk FROM users;
SELECT id, name, balance FROM users WHERE balance > 400000;
SELECT id, name, age FROM users WHERE age BETWEEN 25 AND 30;
SELECT id, name, email FROM users WHERE email LIKE '%@mail.com';
SELECT * FROM users LIMIT 10;
SELECT id, name, balance FROM users ORDER BY balance DESC;
SELECT * FROM users WHERE risk = 'High';
SELECT * FROM company_info WHERE sector = 'IT';
SELECT * FROM stock_prices ORDER BY price DESC LIMIT 5;
SELECT DISTINCT stockname FROM user_portfolios;
SELECT * FROM market_stats WHERE year = 2023;
SELECT * FROM user_portfolios WHERE quantity > 100;

-- Aggregations  13

SELECT COUNT(*) AS total_users FROM users;
SELECT AVG(balance) AS avg_balance FROM users;
SELECT MIN(age) AS youngest, MAX(age) AS oldest FROM users;
SELECT risk, COUNT(*) AS user_count FROM users GROUP BY risk;
SELECT risk, AVG(balance) AS avg_balance FROM users GROUP BY risk;
SELECT StockName, SUM(quantity) AS total_shares FROM user_portfolios GROUP BY StockName;
SELECT symbol, round(AVG(close),2) AS avg_price FROM stock_prices GROUP BY symbol;
SELECT sector, COUNT(*) AS total_companies FROM company_info GROUP BY sector;
SELECT EXTRACT(Year from date) as Year, SUM(turnover) AS total_volume FROM market_stats GROUP BY year;
SELECT userID, SUM(quantity * price) AS portfolio_value FROM user_portfolios GROUP BY userID;
SELECT risk, SUM(balance) AS total_balance FROM users GROUP BY risk HAVING SUM(balance) > 1000000;
SELECT symbol, COUNT(*) FROM stock_prices GROUP BY symbol HAVING COUNT(*) > 5;
SELECT sector, MAX(market_cap_category) FROM company_info GROUP BY sector;

-- Joins 19
select * from stock_prices;
SELECT u.id, u.name, p.stockname FROM users u INNER JOIN user_portfolios p ON u.id = p.userID;
SELECT u.id, u.name, p.stockname, p.quantity FROM users u LEFT JOIN user_portfolios p ON u.id = p.userID;
SELECT u.id, u.name, c.company_name FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN company_info c ON p.stockname = c.symbol;
SELECT u.id, u.name, sp.close FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN stock_prices sp ON p.stockname = sp.symbol;
SELECT c.company_name, COUNT(p.userID) AS total_investors FROM company_info c JOIN user_portfolios p ON c.symbol = p.stockname GROUP BY c.company_name;
SELECT u.name, COUNT(p.stockname) AS total_stocks FROM users u JOIN user_portfolios p ON u.id = p.userID GROUP BY u.name;
SELECT u.name, SUM(p.quantity * sp.close) AS portfolio_value FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN stock_prices sp ON p.stockname = sp.symbol GROUP BY u.name;
SELECT u.name, AVG(sp.close) AS avg_price FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN stock_prices sp ON p.stockname = sp.symbol GROUP BY u.name;
SELECT c.sector, SUM(sp.close) AS sector_value FROM company_info c JOIN stock_prices sp ON c.symbol = sp.symbol GROUP BY c.sector;
SELECT u.name, c.company_name, sp.close FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN stock_prices sp ON p.stockname = sp.symbol JOIN company_info c ON sp.symbol = c.symbol;
SELECT u.name, COUNT(DISTINCT p.stockname) AS unique_stocks FROM users u JOIN user_portfolios p ON u.id = p.userID GROUP BY u.name;
SELECT u.name, c.sector FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN company_info c ON p.stockname = c.symbol;
SELECT u.name, sp.close FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN stock_prices sp ON p.stockname = sp.symbol WHERE sp.open > 2000;
SELECT u.name, c.company_name FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN company_info c ON p.stockname = c.symbol WHERE c.sector = 'Banking';
SELECT u.name, SUM(p.quantity) AS total_shares FROM users u JOIN user_portfolios p ON u.id = p.userID GROUP BY u.name HAVING SUM(p.quantity) > 300;
SELECT u.name, AVG(sp.close) AS avg_price FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN stock_prices sp ON p.stockname = sp.symbol GROUP BY u.name HAVING AVG(sp.open) > 1000;
SELECT u.name, COUNT(*) AS holding_count FROM users u JOIN user_portfolios p ON u.id = p.userID GROUP BY u.name HAVING COUNT(*) > 2;
SELECT c.sector, AVG(sp.close) FROM company_info c JOIN stock_prices sp ON c.symbol = sp.symbol GROUP BY c.sector HAVING AVG(sp.open) > 1500;
SELECT u.name, SUM(p.quantity * sp.close) AS total_value FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN stock_prices sp ON p.stockname = sp.symbol GROUP BY u.name ORDER BY total_value DESC LIMIT 5;

-- Subqueries (20 Queries)18
SELECT company_name FROM company_info WHERE symbol IN (SELECT stockname FROM user_portfolios WHERE UserID = 10);
SELECT company_name FROM company_info WHERE symbol IN (SELECT symbol FROM stock_prices WHERE volume > 1000000);
SELECT name, email FROM users WHERE ID IN (SELECT UserID FROM user_portfolios WHERE StockName = 'TCS');
SELECT company_name FROM company_info WHERE sector = 'IT' AND symbol IN (SELECT stockname FROM user_portfolios);
SELECT COUNT(*) FROM user_portfolios WHERE UserID IN (SELECT ID FROM users WHERE age > 40);
SELECT AVG(balance) FROM users WHERE ID IN (SELECT UserID FROM user_portfolios);
SELECT name FROM users WHERE balance > (SELECT AVG(balance) FROM users);
SELECT symbol, close FROM stock_prices WHERE close > (SELECT AVG(close) FROM stock_prices);
SELECT index_name FROM market_stats WHERE turnover > (SELECT AVG(turnover) FROM market_stats WHERE extract(year from date) = '2022');
SELECT name FROM users WHERE ID IN (SELECT DISTINCT UserID FROM user_portfolios);
SELECT c.company_name FROM company_info c JOIN user_portfolios p ON c.symbol = p.StockName WHERE p.quantity = (SELECT MAX(quantity) FROM user_portfolios);
SELECT u.name, u.email FROM users u WHERE EXISTS (SELECT 1 FROM user_portfolios p WHERE p.UserID = u.ID AND p.StockName = 'RELIANCE');
SELECT name FROM users WHERE ID IN (SELECT UserID FROM user_portfolios WHERE Price < (SELECT MIN(price) FROM stock_prices WHERE symbol = 'HDFCBANK'));


SELECT date, index_name FROM market_stats WHERE advances > declines AND advances = (SELECT MAX(advances) FROM market_stats WHERE date > '2022-06-01');
SELECT name FROM users WHERE ID IN (SELECT UserID FROM user_portfolios WHERE StockName IN (SELECT symbol FROM company_info WHERE market_cap_category = 'Large Cap'));
SELECT stockname FROM user_portfolios WHERE quantity > (SELECT AVG(quantity) FROM user_portfolios);
SELECT sector FROM company_info WHERE symbol IN (SELECT stockname FROM user_portfolios GROUP BY stockname HAVING COUNT(*) > 5);
SELECT name FROM users WHERE balance < (SELECT AVG(balance) FROM users WHERE risk = 'High');

-- Set Operations 7

SELECT name FROM users WHERE risk = 'High' UNION ALL SELECT name FROM users WHERE risk = 'Medium';
SELECT symbol FROM company_info WHERE sector = 'IT' INTERSECT SELECT StockName FROM user_portfolios;
SELECT symbol FROM stock_prices WHERE date = '2023-01-01' INTERSECT SELECT symbol FROM stock_prices WHERE date = '2023-01-02';
SELECT symbol FROM company_info EXCEPT SELECT StockName FROM user_portfolios;
SELECT ID FROM users WHERE age BETWEEN 25 AND 35 UNION SELECT UserID FROM user_portfolios;
SELECT StockName FROM user_portfolios WHERE UserID = 1 INTERSECT SELECT StockName FROM user_portfolios WHERE UserID = 2;
SELECT index_name FROM market_stats WHERE advances > declines UNION SELECT index_name FROM market_stats WHERE declines > advances;

-- Advanced Filtering 14

-- SELECT * FROM users WHERE age > 30 AND balance > 500000; empty
SELECT * FROM user_portfolios WHERE Quantity >= 50 OR Price > 2000;
SELECT name FROM users WHERE risk IN ('High', 'Medium');
SELECT company_name FROM company_info WHERE industry NOT IN ('Software', 'Banking');
SELECT * FROM stock_prices WHERE symbol = 'RELIANCE' AND (close > open);
SELECT * FROM market_stats WHERE (advances > 25 AND declines < 25) OR turnover > 50000;
SELECT name FROM users WHERE name LIKE 'A%' AND risk = 'Low';
SELECT company_name FROM company_info WHERE market_cap_category IS NOT NULL AND industry = 'Software';
SELECT name, balance FROM users WHERE balance BETWEEN 300000 AND 400000 AND age < 30;
SELECT * FROM stock_prices WHERE symbol IN ('TCS', 'INFY') AND volume > 2000000;
SELECT * FROM users WHERE Email LIKE '%@mail.com' AND ID IN (1, 2, 3);
SELECT * FROM company_info WHERE sector = 'IT' OR sector = 'Banking' ORDER BY sector;
SELECT * FROM market_stats WHERE (index_name = 'NIFTY50' AND advances > declines) OR (index_name = 'SENSEX' AND advances > declines);
SELECT u.name, p.StockName FROM users u JOIN user_portfolios p ON u.ID = p.UserID WHERE u.Risk = 'High' AND p.Quantity BETWEEN 50 AND 100;
SELECT company_name, sector FROM company_info WHERE sector = 'Banking' AND market_cap_category = 'Large Cap' AND industry = 'Private Bank';

-- Window Functions 19
SELECT date, symbol, close, AVG(close) OVER (PARTITION BY symbol ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg FROM stock_prices;
SELECT name, balance, RANK() OVER (ORDER BY balance DESC) AS rank_by_balance FROM users;
SELECT name, balance, NTILE(4) OVER (ORDER BY balance DESC) AS balance_quartile FROM users;
SELECT name, age, DENSE_RANK() OVER (ORDER BY age) AS age_dense_rank FROM users;
SELECT symbol, close, LAG(close, 1, 0) OVER (PARTITION BY symbol ORDER BY date) AS previous_day_close FROM stock_prices;
SELECT symbol, close, LEAD(close, 1, 0) OVER (PARTITION BY symbol ORDER BY date) AS next_day_close FROM stock_prices;
SELECT symbol, date, close, AVG(close) OVER (PARTITION BY symbol) AS avg_stock_price FROM stock_prices;
SELECT date, index_name, turnover, SUM(turnover) OVER (PARTITION BY index_name ORDER BY date) AS running_total_turnover FROM market_stats;
SELECT name, risk, COUNT(*) OVER (PARTITION BY risk) AS users_in_risk_category FROM users;
SELECT symbol, close, close - LAG(close, 1, 0) OVER (PARTITION BY symbol ORDER BY date) AS price_change FROM stock_prices;
SELECT symbol, date, close, FIRST_VALUE(close) OVER (PARTITION BY symbol ORDER BY date) AS first_price_in_period FROM stock_prices;
SELECT symbol, date, close, LAST_VALUE(close) OVER (PARTITION BY symbol ORDER BY date) AS last_price_in_period FROM stock_prices;
SELECT u.name, p.StockName, p.Quantity, RANK() OVER (PARTITION BY p.UserID ORDER BY p.Quantity DESC) AS rank_in_portfolio FROM user_portfolios p JOIN users u ON u.ID = p.UserID;
SELECT symbol, date, close, ROW_NUMBER() OVER (PARTITION BY symbol ORDER BY close DESC) AS price_rank_desc FROM stock_prices;
SELECT symbol, date, volume, SUM(volume) OVER (PARTITION BY symbol ORDER BY date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS sum_volume_3day FROM stock_prices;
SELECT c.company_name, c.sector, AVG(s.close) OVER (PARTITION BY c.sector) AS avg_sector_close FROM company_info c JOIN stock_prices s ON c.symbol = s.symbol;
SELECT u.name, p.StockName, SUM(p.quantity) OVER (PARTITION BY p.UserID) AS total_shares_by_user FROM user_portfolios p JOIN users u ON u.ID = p.UserID;
SELECT date, index_name, advances, declines, SUM(advances) OVER (PARTITION BY index_name) as total_advances FROM market_stats;
SELECT name, age, AVG(age) OVER () AS avg_age_all_users FROM users;

-- Views 10

-- select * from View_name ;
CREATE VIEW HighRiskUsers AS SELECT ID, Name, Balance FROM users WHERE Risk = 'High';select * from HighRiskUsers;
CREATE VIEW ITCompanies AS SELECT symbol, company_name FROM company_info WHERE sector = 'IT';
CREATE VIEW PortfolioValues AS SELECT UserID, SUM(quantity * price) AS total_value FROM user_portfolios GROUP BY UserID;
CREATE VIEW Top5StocksByVolume AS SELECT * FROM stock_prices ORDER BY volume DESC LIMIT 5;
CREATE VIEW UserPortfolioSummary AS SELECT u.ID, u.name, p.StockName, p.Quantity FROM users u JOIN user_portfolios p ON u.ID = p.UserID;
CREATE OR REPLACE VIEW DailyMarketSummary AS SELECT date, SUM(turnover) AS total_turnover FROM market_stats GROUP BY date;
CREATE VIEW BankingStocks AS SELECT symbol, company_name, industry FROM company_info WHERE sector = 'Banking';
CREATE VIEW StockPerformance AS SELECT symbol, date, (close - open) AS daily_change FROM stock_prices;
CREATE VIEW LowBalanceUsers AS SELECT name, balance FROM users WHERE balance < 350000;
CREATE VIEW MostTradedStock AS SELECT symbol, SUM(volume) AS total_volume FROM stock_prices GROUP BY symbol ORDER BY total_volume DESC LIMIT 1;

-- CTEs 13

WITH HighVolumeStocks AS (SELECT symbol FROM stock_prices WHERE volume > 1000000) SELECT DISTINCT company_name FROM company_info WHERE symbol IN (SELECT symbol FROM HighVolumeStocks);
WITH UserTotalQuantity AS (SELECT UserID, SUM(Quantity) AS total_shares FROM user_portfolios GROUP BY UserID) SELECT u.Name, utq.total_shares FROM users u JOIN UserTotalQuantity utq ON u.ID = utq.UserID;
WITH AvgPricePerStock AS (SELECT StockName, AVG(Price) AS avg_price FROM user_portfolios GROUP BY StockName) SELECT * FROM AvgPricePerStock WHERE avg_price > 2000;
WITH Top5Users AS (SELECT ID, Name FROM users ORDER BY Balance DESC LIMIT 5) SELECT Name, Email FROM users WHERE ID IN (SELECT ID FROM Top5Users);
WITH DailyAvgPrice AS (SELECT symbol, date, AVG(close) OVER (PARTITION BY symbol ORDER BY date) AS avg_price FROM stock_prices) SELECT * FROM DailyAvgPrice WHERE avg_price > 2500;
WITH RankedUsers AS (SELECT ID, Name, DENSE_RANK() OVER (ORDER BY balance DESC) as balance_rank FROM users) SELECT Name, balance_rank FROM RankedUsers WHERE balance_rank <= 10;
WITH BankingUsers AS (SELECT DISTINCT u.Name FROM users u JOIN user_portfolios p ON u.ID = p.UserID JOIN company_info c ON p.StockName = c.symbol WHERE c.sector = 'Banking') SELECT COUNT(*) FROM BankingUsers;
WITH UserPortfolioValue AS (SELECT UserID, SUM(Quantity * Price) AS total_value FROM user_portfolios GROUP BY UserID) SELECT u.Name, upv.total_value FROM users u JOIN UserPortfolioValue upv ON u.ID = upv.UserID WHERE upv.total_value > 500000;
WITH HighRiskHighBalance AS (SELECT Name FROM users WHERE Risk = 'High' AND Balance > 450000) SELECT * FROM HighRiskHighBalance;
WITH UserPortfolioCount AS (SELECT UserID, COUNT(*) AS holding_count FROM user_portfolios GROUP BY UserID) SELECT u.Name, upc.holding_count FROM users u JOIN UserPortfolioCount upc ON u.ID = upc.UserID WHERE upc.holding_count > 3;
WITH StockVolume AS (SELECT symbol, SUM(volume) AS total_volume FROM stock_prices GROUP BY symbol) SELECT c.company_name, sv.total_volume FROM company_info c JOIN StockVolume sv ON c.symbol = sv.symbol ORDER BY total_volume DESC LIMIT 5;
WITH PortfolioBySector AS (SELECT p.UserID, c.sector, SUM(p.quantity) AS total_shares FROM user_portfolios p JOIN company_info c ON p.StockName = c.symbol GROUP BY p.UserID, c.sector) SELECT UserID, sector, total_shares FROM PortfolioBySector ORDER BY UserID, total_shares DESC;
WITH HighAndLowPrices AS (SELECT symbol, MAX(high) AS max_high, MIN(low) AS min_low FROM stock_prices GROUP BY symbol) SELECT c.company_name, hlp.max_high, hlp.min_low FROM company_info c JOIN HighAndLowPrices hlp ON c.symbol = hlp.symbol;

-- Index/Performance 4

SHOW INDEXES FROM users;

CREATE INDEX idx_user_balance ON users (Balance);
EXPLAIN SELECT * FROM users WHERE Balance > 400000;
EXPLAIN SELECT u.name, c.company_name FROM users u JOIN user_portfolios p ON u.id = p.userID JOIN company_info c ON p.stockname = c.symbol WHERE c.sector = 'IT';
SHOW INDEXES FROM stock_prices;


SELECT sector, COUNT(CASE WHEN market_cap_category = 'Large Cap' THEN 1 ELSE NULL END) AS large_cap_count FROM company_info GROUP BY sector;
SELECT symbol, high - low AS daily_range FROM stock_prices ORDER BY daily_range DESC LIMIT 5;
SELECT company_name, sector FROM company_info WHERE sector = 'IT' AND industry = 'Software';
SELECT CONCAT(Name, ' - ', Email) AS user_contact FROM users;
SELECT * FROM users WHERE ID % 2 = 0;
SELECT date, index_name, (advances - declines) AS net_change FROM market_stats ORDER BY date DESC;
SELECT * FROM users WHERE risk LIKE '_i%';
SELECT u.name, SUM(p.quantity * p.price) AS estimated_value FROM users u JOIN user_portfolios p ON u.ID = p.UserID GROUP BY u.name;
SELECT company_name, UPPER(sector) AS upper_sector FROM company_info;
SELECT * FROM users WHERE Balance BETWEEN 300000 AND 400000;
SELECT * FROM company_info ORDER BY LENGTH(company_name) DESC;
SELECT u.name, p.StockName FROM users u JOIN user_portfolios p ON u.ID = p.UserID ORDER BY u.name, p.StockName;
SELECT AVG(Balance) FROM users WHERE risk = 'High';
SELECT date, index_name, index_value, ROUND(turnover, 2) AS rounded_turnover FROM market_stats;