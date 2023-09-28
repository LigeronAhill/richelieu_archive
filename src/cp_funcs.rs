use std::error::Error;

use diesel::prelude::*;
use diesel::RunQueryDsl;

use crate::cp_model::{CustomerGroup, CustomerStatus};
use crate::cp_schema::{customer_groups, customer_status};
use crate::establish_connection;

impl CustomerGroup {

    pub async fn new(s: String) -> Result<Self, Box<dyn Error>> {
        let conn = &mut establish_connection();

        let p = diesel::insert_into(customer_groups::table)
            .values(customer_groups::customer_group.eq(&s))
            .get_result(conn)?;
        Ok(p)
    }
}
impl CustomerStatus {
    pub async fn new(s: String) -> Result<Self, Box<dyn Error>> {
        let conn = &mut establish_connection();

        let p = diesel::insert_into(customer_status::table)
            .values(customer_status::status.eq(&s))
            .get_result(conn)?;
        Ok(p)
    }
}