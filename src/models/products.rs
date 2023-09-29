

use chrono::NaiveDateTime;
use diesel::{ExpressionMethods, PgConnection, Queryable, RunQueryDsl};
use uuid::Uuid;
use anyhow::Result;

use crate::schema;

#[derive(Queryable, Debug)]
pub struct Brand {
    pub id: Uuid,
    pub name: String,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub last_update: NaiveDateTime,
}

impl Brand {
    pub async fn new(brand: String, conn: &mut PgConnection) -> Result<Brand> {
        use self::schema::brands;
        let b = diesel::insert_into(brands::table)
            .values(brands::name.eq(brand))
            .get_result(conn)?;
        Ok(b)
    }
}

#[derive(Queryable, Debug, Clone)]
pub struct Category {
    pub id: Uuid,
    pub name: String,
    pub parent_name: Option<String>,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub last_update: NaiveDateTime,
}

impl Category {
    pub async fn new(category: String, conn: &mut PgConnection) -> Result<Category> {
        use self::schema::categories;
        let c = diesel::insert_into(categories::table)
            .values(categories::name.eq(category))
            .get_result(conn)?;
        Ok(c)
    }
    pub async fn new_sub(category: String, parent_name: String, conn: &mut PgConnection) -> Result<Category> {
        use self::schema::categories;
        let c = diesel::insert_into(categories::table)
            .values((categories::name.eq(category), categories::parent_name.eq(parent_name)))
            .get_result(conn)?;
        Ok(c)
    }
}

#[derive(Queryable, Debug)]
pub struct CategoryBrand {
    pub id: Uuid,
    pub category_id: Uuid,
    pub brand_id: Uuid,
}

#[derive(Queryable, Debug)]
pub struct Collection {
    pub id: Uuid,
    pub brand_id: Uuid,
    pub name: String,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub last_update: NaiveDateTime,
}


#[derive(Queryable, Debug)]
pub struct CategoryProduct {
    pub id: Uuid,
    pub category_id: Uuid,
    pub brand_id: Uuid,
}
#[derive(Queryable, Debug)]
pub struct Product {
    pub id: Uuid,
    pub collection_id: Uuid,
    pub product_name: String,
    pub country: String,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug)]
pub struct Modification {
    pub id: Uuid,
    pub name: String,
    pub sku: String,
    pub product_id: Uuid,
    pub active: bool,
    pub created_at: NaiveDateTime,
    pub last_update: NaiveDateTime,
}


