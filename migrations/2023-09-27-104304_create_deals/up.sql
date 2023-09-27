CREATE SCHEMA deals;

CREATE TABLE deals.deal_statuses (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "status" varchar UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE deals.deals (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "name" varchar NOT NULL,
  "status_id" uuid NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE deals.deals ADD FOREIGN KEY ("status_id") REFERENCES deals.deal_statuses ("id");

CREATE TABLE deals.sales_channels (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "channel" varchar NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE deals.deals_data (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "deal_id" uuid NOT NULL,
  "employee_id" uuid NOT NULL,
  "customer_id" uuid NOT NULL,
  "sales_channel_id" uuid NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE deals.deals_data ADD FOREIGN KEY ("deal_id") REFERENCES deals.deals ("id");
ALTER TABLE deals.deals_data ADD FOREIGN KEY ("employee_id") REFERENCES hr.employees ("id");
ALTER TABLE deals.deals_data ADD FOREIGN KEY ("customer_id") REFERENCES counterparties.customer ("id");
ALTER TABLE deals.deals_data ADD FOREIGN KEY ("sales_channel_id") REFERENCES deals.sales_channels ("id");

CREATE TABLE deals.deal_details (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "deal_id" uuid NOT NULL,
  "modification_id" uuid NOT NULL,
  "quantity" float NOT NULL,
  "discount" float,
  "total_sum" float NOT NULL,
  "commentary" text,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE deals.deal_details ADD FOREIGN KEY ("deal_id") REFERENCES deals.deals ("id");
ALTER TABLE deals.deal_details ADD FOREIGN KEY ("modification_id") REFERENCES products.modifications ("id");

CREATE TABLE deals.invoices (
  "number" serial PRIMARY KEY,
  "vendor_company_id" uuid NOT NULL,
  "deal_id" uuid NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE deals.invoices ADD FOREIGN KEY ("vendor_company_id") REFERENCES counterparties.companies ("id");
ALTER TABLE deals.invoices ADD FOREIGN KEY ("deal_id") REFERENCES deals.deals ("id");
