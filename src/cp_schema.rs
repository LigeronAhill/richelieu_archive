
diesel::table! {
    counterparties.companies (id) {
        id -> Uuid,
        entity_id -> Uuid,
        name -> Varchar,
        contact_person -> Uuid,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    counterparties.customer (id) {
        id -> Uuid,
        customer_status_id -> Uuid,
        customer_group_id -> Uuid,
        name -> Varchar,
        phone -> Int4,
        email -> Varchar,
        address -> Text,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    counterparties.customer_groups (id) {
        id -> Uuid,
        customer_group -> Varchar,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    counterparties.customer_status (id) {
        id -> Uuid,
        status -> Varchar,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    counterparties.payment_information (id) {
        id -> Uuid,
        customer_id -> Uuid,
        TIN -> Int4,
        full_name -> Text,
        legal_address -> Text,
        KPP -> Int4,
        OGRN -> Int4,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    counterparties.persons (id) {
        id -> Uuid,
        name -> Varchar,
        lastname -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    counterparties.suppliers (id) {
        id -> Uuid,
        name -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    counterparties.vendors (id) {
        id -> Uuid,
        name -> Varchar,
        active -> Bool,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::joinable!(companies -> customer (entity_id));
diesel::joinable!(companies -> persons (contact_person));
diesel::joinable!(companies -> suppliers (entity_id));
diesel::joinable!(companies -> vendors (entity_id));
diesel::joinable!(customer -> customer_groups (customer_group_id));
diesel::joinable!(customer -> customer_status (customer_status_id));
diesel::joinable!(payment_information -> companies (customer_id));
diesel::joinable!(payment_information -> persons (customer_id));

diesel::allow_tables_to_appear_in_same_query!(
    companies,
    customer,
    customer_groups,
    customer_status,
    payment_information,
    persons,
    suppliers,
    vendors,
);
