use std::env;

use diesel::{Connection, PgConnection};
use dotenv::dotenv;

use crate::cp_model::CustomerGroup;

mod cp_funcs;
mod cp_model;
mod cp_schema;
mod models;

#[tokio::main]
async fn main() {
    let groups = vec![
        "Розничный покупатель".to_string(),
        "Постоянный покупатель".to_string(),
        "Дизайнер/архитектор".to_string(),
        "Подрядчик".to_string(),
        "Дизайн-студия/архитектурное бюро".to_string(),
        "Снабженец".to_string(),
        "Новый клиент".to_string(),
        "Нежелательный клиент".to_string(),
        "Представитель заказчика".to_string(),
        "Посредник".to_string(),
    ];
    for s in groups {
        CustomerGroup::new(s).await.unwrap();
    }
}

pub fn establish_connection() -> PgConnection {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    PgConnection::establish(&database_url)
        .unwrap_or_else(|_| panic!("Error connecting to {}", database_url))
}
