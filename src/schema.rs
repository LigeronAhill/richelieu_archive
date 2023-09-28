// @generated automatically by Diesel CLI.

diesel::table! {
    categories (id) {
        id -> Uuid,
        name -> Varchar,
        parent_id -> Nullable<Uuid>,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    modifications (id) {
        id -> Uuid,
        product_id -> Uuid,
        name -> Varchar,
        sku -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    products (id) {
        id -> Uuid,
        category_id -> Uuid,
        brand -> Varchar,
        collection -> Varchar,
        name -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::joinable!(modifications -> products (product_id));
diesel::joinable!(products -> categories (category_id));

diesel::allow_tables_to_appear_in_same_query!(
    categories,
    modifications,
    products,
);
