CREATE SCHEMA hr;
CREATE TABLE hr.departments (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "company_id" uuid NOT NULL,
  "department" varchar UNIQUE NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE hr.departments ADD FOREIGN KEY ("company_id") REFERENCES counterparties.companies ("id");

CREATE TABLE hr.positions (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "department_id" uuid NOT NULL,
  "position" varchar NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE hr.positions ADD FOREIGN KEY ("department_id") REFERENCES hr.departments ("id");

CREATE TABLE hr.employees (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "person_id" uuid NOT NULL,
  "position_id" uuid NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE hr.employees ADD FOREIGN KEY ("person_id") REFERENCES counterparties.persons ("id");
ALTER TABLE hr.employees ADD FOREIGN KEY ("position_id") REFERENCES hr.positions ("id");
