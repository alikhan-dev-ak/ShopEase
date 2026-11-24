# Online Shopping & Inventory Management System
## Technology
HTML, CSS, JavaScript, Node.js, Express.js, MySQL.

## Features
Customer registration/login, product search/filter, cart, COD checkout, order history.
Admin dashboard, add/edit/remove products, stock management, order status updates, customer list, low-stock indicator and sales report.

## Setup (Windows / VS Code)
1. Install Node.js 18+ and MySQL 8+.
2. In MySQL Workbench, open and run `db/schema.sql`.
3. Open this folder in VS Code terminal and run `npm install`.
4. Copy `.env.example` to `.env`; enter your MySQL password.
5. Run `npm run seed-admin` to create the admin.
6. Run `npm start`.
7. Open `http://localhost:3000`.

Default demo admin: `admin@example.com` / `Admin12345!`
You can set your own admin with `node seed-admin.js your@email.com YourPassword123!`.
Change the default password after first login.

## Demo sequence
Register a customer, browse products, add items to cart, place a COD order. Log in as admin, open dashboard, show stock reduction, update order status, and demonstrate customer and sales reports.

## Database tables
- users
- categories
- products
- orders
- order_items
- inventory_movements

Relationships: users 1-to-many orders; categories 1-to-many products; orders 1-to-many order_items; products 1-to-many order_items and inventory_movements.

## DBMS concepts for viva
Primary/foreign keys, one-to-many relationships, JOINs, INSERT/SELECT/UPDATE/DELETE, normalization, indexes, transactions and stock consistency.

## Notes
This is a local semester-project implementation. COD only; no real payment gateway. Use your own product image URLs. For production, add HTTPS, secure cookies, CSRF protection, rate limiting, stronger validation and a persistent session store. Never share your `.env` file.
