use diesel::prelude::*;
use diesel::r2d2::{ConnectionManager, PooledConnection};
use crate::models::*;
use crate::errors::{AppError,ErrorType};


type PooledPg = PooledConnection<ConnectionManager<PgConnection>>;

pub struct DBAccessManager {
    connection: PooledPg,
}

impl DBAccessManager {
    pub fn create_category(&mut self, dto: CreateCategory) -> Result<Category, AppError> {
        use super::schema::categories;

        diesel::insert_into(categories::table)
            .values(&dto)
            .get_result(&mut self.connection)
            .map_err(|err| {
                AppError::from_diesel_err(err, "while creating category")
            })
    }
    pub fn list_categories(&mut self) -> Result<Vec<Category>, AppError> {
        use super::schema::categories::dsl::*;

        categories
            .load(&mut self.connection)
            .map_err(|err| {
                AppError::from_diesel_err(err, "while listing categories")
            })
    }

    pub fn update_category_name(&mut self, category_id: uuid::Uuid, new_name: String) -> Result<usize, AppError> {
        use super::schema::categories::dsl::*;

        let updated = diesel::update(categories)
            .filter(id.eq(category_id))
            .set(name.eq(new_name))
            .execute(&mut self.connection)
            .map_err(|err| {
                AppError::from_diesel_err(err, "while updating category name")
            })?;

        if updated == 0 {
            return Err(AppError::new("Category not found", ErrorType::NotFound));
        }
        Ok(updated)
    }
    pub fn delete_category(&mut self, category_id: uuid::Uuid) -> Result<usize, AppError> {
        use super::schema::categories::dsl::*;

        let deleted = diesel::delete(categories.filter(id.eq(category_id)))
            .execute(&mut self.connection)
            .map_err(|err| {
                AppError::from_diesel_err(err, "while deleting category")
            })?;
        if deleted == 0 {
            return Err(AppError::new("Category not found", ErrorType::NotFound));
        }
        Ok(deleted)
    }
}