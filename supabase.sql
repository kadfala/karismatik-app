-- ================================================================
-- KARISMATIK — Base de données Supabase
-- À coller dans Supabase :  SQL Editor  >  New query  >  Run
-- ================================================================

-- 1) Tables ------------------------------------------------------
create table if not exists plats (
  id          bigint generated always as identity primary key,
  nom         text    not null,
  description text,
  prix        integer not null,
  categorie   text,
  image       text,
  dispo       boolean not null default true,
  ordre       integer default 0
);

create table if not exists commandes (
  id         bigint generated always as identity primary key,
  cree_le    timestamptz default now(),
  prenom     text,
  contact    text,
  mode       text,
  type_lieu  text,
  lieu       text,
  articles   jsonb,
  total      integer,
  avant_1130 boolean
);

-- 2) Sécurité (Row Level Security) -------------------------------
alter table plats     enable row level security;
alter table commandes enable row level security;

-- Le public lit les plats
create policy "plats_lecture_publique" on plats
  for select using (true);

-- Seul un admin connecté modifie ou ajoute des plats
create policy "plats_maj_admin" on plats
  for update to authenticated using (true) with check (true);
create policy "plats_insert_admin" on plats
  for insert to authenticated with check (true);

-- Le public crée une commande
create policy "commandes_creation_publique" on commandes
  for insert with check (true);

-- Seul un admin connecté lit les commandes
create policy "commandes_lecture_admin" on commandes
  for select to authenticated using (true);

-- 3) Le menu de Karismatik --------------------------------------
insert into plats (nom, description, prix, categorie, image, ordre) values
 ('Foutou','Sauce au choix',1500,'pate','images/foutou.jpg',1),
 ('Riz gras carpe','Riz gras, carpe',1500,'riz','images/riz-gras-carpe.jpg',2),
 ('Riz gras poisson local','Riz gras, poisson local',800,'riz','images/riz-gras-poisson.jpg',3),
 ('Riz sauce feuille','Riz, sauce feuille',1000,'riz','images/riz-sauce-feuille.jpg',4),
 ('Sauce arachide','Servie avec riz ou to',800,'sauce','images/sauce-arachide.jpg',5),
 ('Sauce graine','Servie avec riz ou to',1000,'sauce','images/sauce-graine.jpg',6),
 ('Riz gras viande','Riz gras, viande',800,'riz',null,7),
 ('Riz sauce','Riz, sauce du jour',800,'riz',null,8),
 ('Atieke poisson carpe','Atieke, carpe',1500,'atieke','images/atieke-carpe.jpg',9),
 ('Atieke thon / local','Atieke, thon ou poisson',1000,'atieke','images/atieke-thon.jpg',10),
 ('Soupe de carpe','Soupe, carpe',1000,'soupe','images/soupe-carpe.jpg',11),
 ('Soupe de jarret','Soupe, jarret de boeuf',1000,'soupe','images/soupe-jarret.jpg',12),
 ('Soupe de tripes','Soupe de tripes',1000,'soupe','images/soupe-tripes.jpg',13),
 ('Patte de boeuf','Pied de boeuf mijote',1000,'viande','images/patte-boeuf.jpg',14),
 ('Pomme de terre + poisson','Pommes de terre, poisson',1500,'poisson',null,15),
 ('Frites aloco + poisson (simple)','Frites, aloco, poisson',2000,'aloco','images/aloco-poisson.jpg',16),
 ('Frites aloco + poisson (grande)','Grande portion',3000,'aloco','images/aloco-poisson.jpg',17),
 ('Haricot','Special vendredi',800,'haricot','images/haricot.jpg',18),
 ('Ragout de pomme de terre','Ragout, pommes de terre',1500,'ragout','images/ragout-pdt.jpg',19),
 ('To sauce oseille ou gombo','To, sauce oseille ou gombo',1000,'to','images/to-oseille-gombo.jpg',20),
 ('To petit lome, sauce gombo','To petit lome, sauce gombo',1000,'to','images/to-petit-lome.jpg',21);
