CREATE TABLE IF NOT EXISTS category_product(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id uuid NOT NULL REFERENCES categories(id),
    product_id uuid NOT NULL REFERENCES products(id),
    UNIQUE (category_id, product_id)
    );