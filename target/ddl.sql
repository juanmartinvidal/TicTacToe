alter table game drop constraint FK304BF2E0388D0D;
alter table game drop constraint FK304BF266EE337F;
alter table game drop constraint FK304BF2E03818AE;
alter table game drop constraint FK304BF2745E7135;
alter table user_role drop constraint FK143BF46AB56C4893;
alter table user_role drop constraint FK143BF46A5A970C73;
drop table game if exists;
drop table role if exists;
drop table user if exists;
drop table user_role if exists;
create table game (id bigint generated by default as identity, version bigint not null, finished boolean not null, next_turn_id bigint not null, player1_id bigint not null, player2_id bigint not null, winner_id bigint, class varchar(255) not null, board binary(255), primary key (id));
create table role (id bigint generated by default as identity, version bigint not null, authority varchar(255) not null unique, primary key (id));
create table user (id bigint generated by default as identity, version bigint not null, account_expired boolean not null, account_locked boolean not null, email varchar(255) not null, enabled boolean not null, full_name varchar(255) not null, "password" varchar(255) not null, password_expired boolean not null, username varchar(255) not null unique, primary key (id));
create table user_role (role_id bigint not null, user_id bigint not null, primary key (role_id, user_id));
alter table game add constraint FK304BF2E0388D0D foreign key (player2_id) references user;
alter table game add constraint FK304BF266EE337F foreign key (winner_id) references user;
alter table game add constraint FK304BF2E03818AE foreign key (player1_id) references user;
alter table game add constraint FK304BF2745E7135 foreign key (next_turn_id) references user;
alter table user_role add constraint FK143BF46AB56C4893 foreign key (role_id) references role;
alter table user_role add constraint FK143BF46A5A970C73 foreign key (user_id) references user;
