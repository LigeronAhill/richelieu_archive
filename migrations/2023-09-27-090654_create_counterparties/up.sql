CREATE SCHEMA counterparties;

CREATE TABLE counterparties.vendors (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "name" varchar NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);
CREATE TABLE counterparties.suppliers (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "name" varchar NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);
CREATE TABLE counterparties.customer (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "customer_status_id" uuid NOT NULL,
  "customer_group_id" uuid NOT NULL,
  "name" varchar NOT NULL,
  "phone" integer NOT NULL DEFAULT '7777777',
  "email" varchar NOT NULL DEFAULT 'no@email.got',
  "address" text NOT NULL DEFAULT 'Москва',
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE counterparties.customer_status (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "status" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE counterparties.customer_groups (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "customer_group" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE counterparties.persons (
  id uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  name varchar NOT NULL,
  lastname varchar NOT NULL,
  active bool NOT NULL DEFAULT true,
  created_at timestamp NOT NULL DEFAULT (NOW()),
  updated_at timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE counterparties.companies (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "entity_id" uuid NOT NULL,
  "name" varchar UNIQUE NOT NULL,
  "contact_person" uuid NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE counterparties.payment_information (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "customer_id" uuid NOT NULL,
  "TIN" integer NOT NULL,
  "full_name" text NOT NULL,
  "legal_address" text NOT NULL,
  "KPP" integer NOT NULL,
  "OGRN" integer NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE counterparties.customer ADD FOREIGN KEY ("customer_status_id") REFERENCES counterparties.customer_status ("id");
ALTER TABLE counterparties.customer ADD FOREIGN KEY ("customer_group_id") REFERENCES counterparties.customer_groups ("id");
ALTER TABLE counterparties.companies ADD FOREIGN KEY ("contact_person") REFERENCES counterparties.persons ("id");
ALTER TABLE counterparties.payment_information ADD FOREIGN KEY ("customer_id") REFERENCES counterparties.persons ("id");
ALTER TABLE counterparties.payment_information ADD FOREIGN KEY ("customer_id") REFERENCES counterparties.companies ("id");
ALTER TABLE counterparties.companies ADD FOREIGN KEY ("entity_id") REFERENCES counterparties.suppliers ("id");
ALTER TABLE counterparties.companies ADD FOREIGN KEY ("entity_id") REFERENCES counterparties.vendors ("id");
ALTER TABLE counterparties.companies ADD FOREIGN KEY ("entity_id") REFERENCES counterparties.customer ("id");