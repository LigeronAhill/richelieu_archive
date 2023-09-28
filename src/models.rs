use diesel::{Insertable, Queryable};
use crate::schema::{products, modifications, categories};
#[derive(Queryable, Debug)]
pub struct Category {
    id: uuid::Uuid,
    name: String,
    parent_id: Option<uuid::Uuid>,
    active: bool,
    created_at: chrono::NaiveDateTime,
    updated_at: chrono::NaiveDateTime,
}

#[derive(Insertable, Debug)]
#[table_name = "categories"]
pub struct CreateCategory {
    name: String,
    parent_id: Option<uuid::Uuid>,
}

#[derive(Queryable, Debug)]
pub struct Product {
    id: uuid::Uuid,
    category_id: uuid::Uuid,
    brand: String,
    collection: String,
    name: String,
    active: bool,
    created_at: chrono::NaiveDateTime,
    updated_at: chrono::NaiveDateTime,
}
#[derive(Insertable, Debug)]
#[table_name = "products"]
pub struct CreateProduct {
    category_id: uuid::Uuid,
    brand: String,
    collection: String,
    name: String,
}
#[derive(Queryable, Debug)]
pub struct Modification {
    id: uuid::Uuid,
    product_id: uuid::Uuid,
    name: String,
    sku: String,
    active: bool,
    created_at: chrono::NaiveDateTime,
    updated_at: chrono::NaiveDateTime,
}
#[derive(Insertable, Debug)]
#[table_name = "modifications"]
pub struct CreateModification {
    product_id: uuid::Uuid,
    name: String,
    sku: String,
    active: bool,
}