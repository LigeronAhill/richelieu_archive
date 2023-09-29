mod schema;
mod models;
mod repository;
use models::products::*;


#[tokio::main]
async fn main() {
    let conn = &mut repository::pg_connection();
    let categories = vec![
        vec!["Из синтетических материалов".to_string(), "Циновки".to_string()],
        vec!["Из сизаля".to_string(), "Циновки".to_string()],
        vec!["ПВХ".to_string(), "Циновки".to_string()],
        vec!["Бытовой".to_string(), "Линолеум".to_string()],
    ];
    for category in &categories {
        let c = Category::new_sub(
            category[0].clone(), category[1].clone(), conn).await;
        println!("{:#?}", c)
    }
}