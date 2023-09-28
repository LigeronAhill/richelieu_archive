CREATE TABLE categories(
    id uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
    name varchar NOT NULL,
    parent_id uuid,
    active bool NOT NULL DEFAULT (true),
    created_at timestamp NOT NULL DEFAULT (NOW()),
    updated_at timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products(
    id uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
    category_id uuid NOT NULL REFERENCES categories(id),
    brand varchar NOT NULL,
    collection varchar NOT NULL,
    name varchar NOT NULL,
    active bool NOT NULL DEFAULT (true),
    created_at timestamp NOT NULL DEFAULT (NOW()),
    updated_at timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE modifications(
    id uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
    product_id uuid NOT NULL REFERENCES products(id),
    name varchar NOT NULL,
    SKU varchar NOT NULL,
    active bool NOT NULL DEFAULT (true),
    created_at timestamp NOT NULL DEFAULT (NOW()),
    updated_at timestamp NOT NULL DEFAULT (NOW())
)