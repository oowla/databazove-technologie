-- Active: 1790162492317@@127.0.0.1@5432@superstore
CREATE TABLE orders (   
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id),
    product_id VARCHAR(20),
    FOREIGN KEY (product_id) 
        REFERENCES products(product_id),
    order_date DATE,
    ship_date DATE,
    sales NUMERIC(18, 2),
    quantity NUMERIC(18,0),
    discount NUMERIC(18,2),
    profit NUMERIC(18,2)
);