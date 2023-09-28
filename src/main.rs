#[macro_use]
mod schema;
mod models;
mod dictionaries;
mod data_access;
mod errors;
mod api;

use data_access::DBAccessManager;
use errors::{AppError, ErrorType};


use std::env;
use warp::{Filter, reject};
use log::{info};
use diesel::pg::PgConnection;
use diesel::r2d2::{ConnectionManager, Pool};

type PgPool = Pool<ConnectionManager<PgConnection>>;

fn pg_pool(db_url: &str) -> PgPool {
    let manager = ConnectionManager::<PgConnection>::new(db_url);
    Pool::new(manager).expect("Failed to create pool")
}

fn with_db_access_manager(pool: PgPool) -> impl Filter<Extract = (DBAccessManager,), Error = warp::Rejection> + Clone {
    warp::any()
        .map(move || pool.clone())
        .and_then(|pool: PgPool| async move {  match pool.get() {
            Ok(conn) => Ok(DBAccessManager::new(conn)),
            Err(err) => Err(reject::custom(
                AppError::new(format!("Error getting connection from pool: {}", err.to_string()).as_str(), ErrorType::Internal))
            ),
        }})
}




#[tokio::main]
async fn main() {
    if env::var_os("RUST_LOG").is_none() {
        env::set_var("RUST_LOG", "info");
    }
    pretty_env_logger::init();

    let routes = warp::path!("hello").map(|| "Hello World!".to_string());

    info!("Starting server on port 3030...");

    // Start up the server...
    warp::serve(routes).run(([127, 0, 0, 1], 3030)).await;
}