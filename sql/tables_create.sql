CREATE TABLE "HW2".customer(
    customer_id           INT PRIMARY KEY,
    first_name            VARCHAR(50)  NOT NULL,
    last_name             VARCHAR(50),
    gender                VARCHAR(10),
    DOB                   DATE,
    job_title             VARCHAR(200),
    job_industry_category VARCHAR(50),
    wealth_segment        VARCHAR(30)  NOT NULL,
    deceased_indicator    BOOLEAN      NOT NULL,
    owns_car              BOOLEAN      NOT NULL,
    address               VARCHAR(200) NOT NULL,
    postcode              VARCHAR(10)  NOT NULL,
    state                 VARCHAR(50)  NOT NULL,
    country               VARCHAR(50)  NOT NULL,
    property_valuation    SMALLINT     NOT NULL
);


 CREATE TABLE "HW2".product (
    product_id     INT          NOT NULL,
    brand          VARCHAR(50)  NOT NULL,
    product_line   VARCHAR(20)  NOT NULL,
    product_class  VARCHAR(10)  NOT NULL,
    product_size   VARCHAR(10)  NOT NULL,
    list_price     NUMERIC(10,2) NOT NULL,
    standard_cost  NUMERIC(10,2) 
);

CREATE TABLE "HW2".orders (
    order_id     INT         PRIMARY KEY,
    customer_id  INT         NOT NULL,
    order_date   DATE        NOT NULL,
    online_order BOOLEAN,              
    order_status VARCHAR(20) NOT NULL
);

CREATE TABLE "HW2".order_items (
    order_item_id                INT           PRIMARY KEY,
    order_id                     INT           NOT NULL,
    product_id                   INT           NOT NULL,
    quantity                     SMALLINT      NOT NULL,
    item_list_price_at_sale      NUMERIC(10,2) NOT NULL,
    item_standard_cost_at_sale   NUMERIC(10,2)    
);

CREATE TABLE "HW2".product_cor AS
SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY product_id 
            ORDER BY list_price DESC
        ) AS rn
    FROM "HW2".product
) t
WHERE rn = 1;

























