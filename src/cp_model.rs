use chrono::NaiveDateTime;
use diesel::prelude::*;
use uuid::Uuid;
use crate::cp_schema::*;

#[derive(Queryable, Debug)]
#[diesel(table_name = companies)]
pub struct Company {
    pub id: Uuid,
    pub entity_id: Uuid, // supplier, customer or vendor
    pub name: String,
    pub contact_person: Uuid,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Queryable, Debug)]
#[diesel(table_name = customer)]
pub struct Customer {
    pub id: Uuid,
    pub customer_status_id: Uuid,
    pub customer_group_id: Uuid,
    pub name: String,
    pub phone: i32,
    pub email: String,
    pub address: String,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Queryable, Eq, PartialEq, Insertable, Debug)]
#[diesel(table_name = customer_groups)]
pub struct CustomerGroup {
    id: Uuid,
    customer_group: String,
    created_at: NaiveDateTime,
    updated_at: NaiveDateTime,
}

#[derive(Selectable, Queryable, Debug)]
#[diesel(table_name = customer_status)]
pub struct CustomerStatus {
    id: Uuid,
    status: String,
    created_at: NaiveDateTime,
    updated_at: NaiveDateTime,
}

#[derive(Queryable, Debug)]
#[diesel(table_name = payment_information)]
pub struct PaymentInformation {
    pub id: Uuid,
    pub customer_id: Uuid,
    #[diesel(column_name = "TIN")]
    pub tin: i32,
    pub full_name: String,
    pub legal_address: String,
    #[diesel(column_name = "KPP")]
    pub kpp: i32,
    #[diesel(column_name = "OGRN")]
    pub ogrn: i32,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Queryable, Debug)]
#[diesel(table_name = persons)]
pub struct Person {
    pub id: Uuid,
    pub name: String,
    pub lastname: String,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Queryable, Debug)]
#[diesel(table_name = suppliers)]
pub struct Supplier {
    pub id: Uuid,
    pub name: String,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Queryable, Debug)]
#[diesel(table_name = vendors)]
pub struct Vendor {
    pub id: Uuid,
    pub name: String,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}
