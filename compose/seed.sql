-- Тестовые заказы из обращения поддержки: загружаются в Postgres при первом запуске базы
-- (папка /docker-entrypoint-initdb.d). После docker compose down -v загрузятся заново.
CREATE TABLE test_orders (
  id         INT PRIMARY KEY,
  number     TEXT NOT NULL,
  coupon     TEXT,
  total_rub  INT NOT NULL,
  status     TEXT NOT NULL
);
INSERT INTO test_orders (id, number, coupon, total_rub, status) VALUES
  (101, 'SH-100101', NULL,      9800, 'paid'),
  (102, 'SH-100102', 'POLKA25', 7350, 'paid'),
  (103, 'SH-100103', NULL,      4900, 'paid'),
  (104, 'SH-100104', 'POLKA25', 3675, 'paid'),
  (105, 'SH-100105', NULL,     12990, 'awaiting_payment'),
  (106, 'SH-100106', 'POLKA25', 9800, 'awaiting_payment'),
  (107, 'SH-100107', 'SAVE25',  7300, 'paid'),
  (108, 'SH-100108', NULL,      2490, 'cancelled'),
  (109, 'SH-100109', 'POLKA25', 4900, 'awaiting_payment'),
  (110, 'SH-100110', NULL,      5990, 'paid'),
  (111, 'SH-100111', 'POLKA25', 2450, 'paid'),
  (112, 'SH-100112', NULL,      8990, 'paid');
