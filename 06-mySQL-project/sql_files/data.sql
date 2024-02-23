
-- Test data set for watch
insert into watch (
    brand, model, state_of_watch, price, date_of_watch
) values ("Rolex", "Explorer", "New", "100000", "2024-02-20");

insert into watch (
    brand, model, state_of_watch, price, date_of_watch
) values ("Seiko", "SKX", "Vintage", "25252", "2023-12-06");

-- Test data set for customer
insert into customer (
    first_name, last_name, address, email, phone_number
) values ("Mark", "Tan", "45 Awesome Street", "MTan@asd.com", "88889999");

insert into customer (
    first_name, last_name, address, email, phone_number
) values ("Dave", "Wong", "78 Hahah Street", "DWong@asd.com", "12345678");

-- Test data set for transaction 
insert into transaction (
    date_of_transaction, transaction_amount, customer_id, watch_id
) values ("2024-03-25", "110000", 1,1);

insert into transaction (
    date_of_transaction, transaction_amount, customer_id, watch_id
) values ("2024-03-31", "220000", 2,2);

-- Test data set for brand 
insert into brand (
    name, watch_id
) values ("Rolex", 1); 

insert into brand (
    name, watch_id
) values ("Seiko", 2); 
