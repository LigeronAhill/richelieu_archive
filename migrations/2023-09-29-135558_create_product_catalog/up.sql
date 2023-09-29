
CREATE TABLE IF NOT EXISTS categories(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name varchar NOT NULL UNIQUE,
    parent_name varchar REFERENCES categories(name),
    active bool NOT NULL DEFAULT true,
    created_at timestamp NOT NULL DEFAULT NOW(),
    last_update timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS brands(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name varchar NOT NULL UNIQUE,
    active bool NOT NULL DEFAULT true,
    created_at timestamp NOT NULL DEFAULT NOW(),
    last_update timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS collections(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    brand_id uuid NOT NULL REFERENCES brands(id),
    name varchar NOT NULL,
    active bool NOT NULL DEFAULT true,
    created_at timestamp NOT NULL DEFAULT NOW(),
    last_update timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS products(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    brand_id uuid NOT NULL REFERENCES brands(id),
    collection_id uuid REFERENCES collections(id),
    product_name varchar NOT NULL,
    country varchar NOT NULL,
    active bool NOT NULL DEFAULT true,
    created_at timestamp NOT NULL DEFAULT NOW(),
    last_update timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS modifications(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name varchar NOT NULL,
    SKU varchar NOT NULL UNIQUE,
    product_id uuid NOT NULL REFERENCES products(id),
    active bool NOT NULL DEFAULT true,
    created_at timestamp NOT NULL DEFAULT NOW(),
    last_update timestamp NOT NULL DEFAULT NOW()
);

-- CREATE TABLE IF NOT EXISTS category_brand(
--     id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
--     category_id uuid NOT NULL REFERENCES categories(id),
--     brand_id uuid NOT NULL REFERENCES brands(id),
--     UNIQUE (category_id, brand_id)
--     );
--
