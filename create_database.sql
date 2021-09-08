
create table company
(
    id         int auto_increment
        primary key,
    name       varchar(255)                          not null,
    deleted_at timestamp                             null,
    created_at timestamp default current_timestamp() not null,
    updated_at timestamp                             null,
    constraint name
        unique (name)
);

create table role
(
    id         int auto_increment
        primary key,
    name       enum ('Admin', 'Employee')            not null,
    slug       varchar(50)                           not null,
    deleted_at timestamp                             null,
    created_at timestamp default current_timestamp() not null,
    updated_at timestamp                             null
);

create table user
(
    id         int auto_increment
        primary key,
    name       varchar(150)                          not null,
    email      varchar(150)                          not null,
    role_id    int                                   not null,
    company_id int                                   not null,
    deleted_at timestamp                             null,
    created_at timestamp default current_timestamp() not null,
    updated_at timestamp                             null,
    constraint email
        unique (email),
    constraint user_company_id_fk
        foreign key (company_id) references company (id),
    constraint user_role_id_fk
        foreign key (role_id) references role (id)
);

create table inventoryitem
(
    id            int auto_increment
        primary key,
    name          varchar(150)                          not null,
    user_id       int                                   not null,
    serial_number varchar(20)                           not null,
    price         decimal(10, 2)                        not null,
    purchase_date timestamp default current_timestamp() not null,
    deleted_at    timestamp                             null,
    created_at    timestamp default current_timestamp() not null,
    updated_at    timestamp                             null,
    constraint serial_number
        unique (serial_number),
    constraint inventoryitem_user_id_fk
        foreign key (user_id) references user (id)
);
