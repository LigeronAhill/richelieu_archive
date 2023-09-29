// @generated automatically by Diesel CLI.

diesel::table! {
    brands (id) {
        id -> Uuid,
        name -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        last_update -> Timestamp,
    }
}

diesel::table! {
    categories (id) {
        id -> Uuid,
        name -> Varchar,
        parent_name -> Nullable<Varchar>,
        active -> Bool,
        created_at -> Timestamp,
        last_update -> Timestamp,
    }
}

diesel::table! {
    category_brand (id) {
        id -> Uuid,
        category_id -> Uuid,
        brand_id -> Uuid,
    }
}

diesel::table! {
    category_product (id) {
        id -> Uuid,
        category_id -> Uuid,
        product_id -> Uuid,
    }
}

diesel::table! {
    collections (id) {
        id -> Uuid,
        brand_id -> Uuid,
        name -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        last_update -> Timestamp,
    }
}

diesel::table! {
    modifications (id) {
        id -> Uuid,
        name -> Varchar,
        sku -> Varchar,
        product_id -> Uuid,
        active -> Bool,
        created_at -> Timestamp,
        last_update -> Timestamp,
    }
}

diesel::table! {
    products (id) {
        id -> Uuid,
        collection_id -> Uuid,
        product_name -> Varchar,
        country -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        last_update -> Timestamp,
    }
}

diesel::joinable!(category_brand -> brands (brand_id));
diesel::joinable!(category_brand -> categories (category_id));
diesel::joinable!(category_product -> categories (category_id));
diesel::joinable!(category_product -> products (product_id));
diesel::joinable!(collections -> brands (brand_id));
diesel::joinable!(modifications -> products (product_id));
diesel::joinable!(products -> collections (collection_id));

diesel::allow_tables_to_appear_in_same_query!(
    brands,
    categories,
    category_brand,
    category_product,
    collections,
    modifications,
    products,
);
