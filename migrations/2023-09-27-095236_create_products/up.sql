CREATE SCHEMA products;

CREATE TABLE products.countries (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "country" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.categories (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "parent_id" uuid,
  "name" varchar UNIQUE NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE products.categories ADD FOREIGN KEY ("parent_id") REFERENCES products.categories ("id");

CREATE TABLE products.brands (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "country_id" uuid NOT NULL,
  "brand" varchar NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE products.brands ADD FOREIGN KEY ("country_id") REFERENCES products.countries ("id");

CREATE TABLE products.collections (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "category_id" uuid NOT NULL,
  "brand_id" uuid NOT NULL,
  "supplier_id" uuid NOT NULL,
  "collection" varchar NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE products.collections ADD FOREIGN KEY ("category_id") REFERENCES products.categories ("id");
ALTER TABLE products.collections ADD FOREIGN KEY ("brand_id") REFERENCES products.brands ("id");
ALTER TABLE products.collections ADD FOREIGN KEY ("supplier_id") REFERENCES counterparties.suppliers ("id");

CREATE TABLE products.products (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "collection_id" uuid NOT NULL,
  "name" varchar NOT NULL,
  "description" text NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE products.products ADD FOREIGN KEY ("collection_id") REFERENCES products.collections ("id");

CREATE TABLE products.modifications (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "product_id" uuid NOT NULL,
  "modification" varchar NOT NULL,
  "SKU" varchar UNIQUE NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE products.modifications ADD FOREIGN KEY ("product_id") REFERENCES products.products ("id");

CREATE TABLE products.units_of_measure (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "unit" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.colors (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "color" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.styles (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "style" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.rooms (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "room" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.compositions (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "composition" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.roll_widths (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "roll_width" float UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.pile_types (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "products.pile_types" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.fire_classes (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "fire_class" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.durability_classes (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "durability_class" integer UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.size (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "size" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.modification_data (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "modification_id" uuid NOT NULL,
  "picture_path" varchar NOT NULL,
  "unit_of_measure_id" uuid NOT NULL,
  "minimum_quantity" float NOT NULL,
  "maximum_quantity" float NOT NULL,
  "quantity_step" float NOT NULL,
  "color_id" uuid[],
  "style_id" uuid,
  "rooms_id" uuid[],
  "delivery_date" integer NOT NULL,
  "composition_id" uuid,
  "roll_width_id" uuid,
  "roll_length" float,
  "pile_height" float,
  "total_height" float,
  "pile_weight" integer,
  "total_weight" integer,
  "pyle_type_id" uuid,
  "pyle_density" integer,
  "pattern_repeat" varchar,
  "fire_class_id" uuid,
  "durability_class_id" uuid,
  "size_id" uuid,
  "pieces_in_package" integer,
  "packing_area" float,
  "protective_layer" float,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.currencies (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "currency" varchar NOT NULL,
  "coefficient" float NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE products.prices (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "modification_id" uuid NOT NULL,
  "retail_price" float NOT NULL,
  "discount_price" float,
  "purchase_price" float NOT NULL,
  "purchase_currency_id" uuid NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE products.modification_data ADD FOREIGN KEY ("modification_id") REFERENCES products.modifications ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("unit_of_measure_id") REFERENCES products.units_of_measure ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("style_id") REFERENCES products.styles ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("composition_id") REFERENCES products.compositions ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("fire_class_id") REFERENCES products.fire_classes ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("durability_class_id") REFERENCES products.durability_classes ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("pyle_type_id") REFERENCES products.pile_types ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("roll_width_id") REFERENCES products.roll_widths ("id");
ALTER TABLE products.modification_data ADD FOREIGN KEY ("size_id") REFERENCES products.size ("id");
ALTER TABLE products.prices ADD FOREIGN KEY ("modification_id") REFERENCES products.modifications ("id");
ALTER TABLE products.prices ADD FOREIGN KEY ("purchase_currency_id") REFERENCES products.currencies ("id");