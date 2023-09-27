CREATE SCHEMA cash_flows;

CREATE TABLE cash_flows.payments (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "invoice_id" integer,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE cash_flows.expenses (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "value" float NOT NULL,
  "expense_item_id" uuid NOT NULL,
  "commentary" text NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE cash_flows.expense_items (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "expense_item" varchar UNIQUE NOT NULL,
  "active" bool NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

CREATE TABLE cash_flows.cash_flows (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "positive_flow_id" uuid,
  "negative_flow_id" uuid,
  "total" float,
  "created_at" timestamp NOT NULL DEFAULT (NOW()),
  "updated_at" timestamp NOT NULL DEFAULT (NOW())
);

ALTER TABLE cash_flows.payments ADD FOREIGN KEY ("invoice_id") REFERENCES deals.invoices ("number");
ALTER TABLE cash_flows.expenses ADD FOREIGN KEY ("expense_item_id") REFERENCES cash_flows.expense_items ("id");
ALTER TABLE cash_flows.cash_flows ADD FOREIGN KEY ("positive_flow_id") REFERENCES cash_flows.payments ("id");
ALTER TABLE cash_flows.cash_flows ADD FOREIGN KEY ("negative_flow_id") REFERENCES cash_flows.expenses ("id");
