CREATE TABLE "eleves" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "NIE" varchar,
  "prenom" varchar NOT NULL,
  "nom" varchar NOT NULL,
  "sexe" varchar NOT NULL,
  "date_naissance" date NOT NULL,
  "adresse" text,
  "boursier" boolean DEFAULT false,
  "statut" varchar DEFAULT 'actif',
  "photo_profil_url" text,
  "cree_le" timestamp DEFAULT (now()),
  "mis_a_jour_a" timestamp
);

CREATE TABLE "contacts" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "eleve_id" uuid NOT NULL,
  "prenom" varchar NOT NULL,
  "nom" varchar NOT NULL,
  "telephone" varchar,
  "email" varchar NOT NULL,
  "relation" varchar NOT NULL,
  "cree_le" timestamp DEFAULT (now())
);

CREATE TABLE "documents_eleves" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "eleve_id" uuid NOT NULL,
  "type_document" varchar,
  "url_document" text NOT NULL,
  "cree_le" timestamp DEFAULT (now())
);

CREATE TABLE "classes" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "nom" varchar NOT NULL,
  "niveau" int UNIQUE NOT NULL,
  "frais_scolarite_annuel" numeric NOT NULL,
  "cree_le" timestamp DEFAULT (now())
);

CREATE TABLE "paiements" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "inscription_id" uuid NOT NULL,
  "montant" numeric NOT NULL,
  "date_paiement" date NOT NULL,
  "methode_paiement" varchar,
  "statut" varchar NOT NULL DEFAULT 'en_attente',
  "notes" text,
  "cree_le" timestamp DEFAULT (now())
);

CREATE TABLE "documents_paiements" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "paiement_id" uuid NOT NULL,
  "url_document" text NOT NULL,
  "cree_le" timestamp DEFAULT (now())
);

CREATE TABLE "utilisateurs" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "nom" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "mot_de_passe_hash" text NOT NULL,
  "role" varchar NOT NULL,
  "cree_le" timestamp DEFAULT (now())
);

CREATE TABLE "annees_scolaires" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "annee" varchar UNIQUE NOT NULL,
  "date_debut" date NOT NULL,
  "date_fin" date NOT NULL,
  "actif" boolean DEFAULT false,
  "cree_le" timestamp DEFAULT (now())
);

CREATE TABLE "inscriptions" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "eleve_id" uuid NOT NULL,
  "classe_id" uuid NOT NULL,
  "annee_scolaire_id" uuid NOT NULL,
  "cree_le" timestamp DEFAULT (now())
);

CREATE INDEX ON "contacts" ("eleve_id");

CREATE INDEX ON "documents_eleves" ("eleve_id");

CREATE INDEX ON "paiements" ("inscription_id");

CREATE INDEX ON "inscriptions" ("eleve_id");

CREATE INDEX ON "inscriptions" ("classe_id");

CREATE INDEX ON "inscriptions" ("annee_scolaire_id");

CREATE UNIQUE INDEX ON "inscriptions" ("eleve_id", "annee_scolaire_id");

ALTER TABLE "contacts" ADD FOREIGN KEY ("eleve_id") REFERENCES "eleves" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "paiements" ADD FOREIGN KEY ("inscription_id") REFERENCES "inscriptions" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "inscriptions" ADD FOREIGN KEY ("eleve_id") REFERENCES "eleves" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "inscriptions" ADD FOREIGN KEY ("annee_scolaire_id") REFERENCES "annees_scolaires" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "inscriptions" ADD FOREIGN KEY ("classe_id") REFERENCES "classes" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "documents_paiements" ADD FOREIGN KEY ("paiement_id") REFERENCES "paiements" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "documents_eleves" ADD FOREIGN KEY ("eleve_id") REFERENCES "eleves" ("id") DEFERRABLE INITIALLY IMMEDIATE;
