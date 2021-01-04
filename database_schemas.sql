DROP TABLE IF EXISTS "group_lesson";
DROP SEQUENCE IF EXISTS group_lesson_id_group_lesson_seq;
CREATE SEQUENCE group_lesson_id_group_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS group_lesson_id_music_lesson_seq;
CREATE SEQUENCE group_lesson_id_music_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."group_lesson" (
    "id_group" integer DEFAULT nextval('group_lesson_id_group_lesson_seq') NOT NULL,
    "level" character varying(100),
    "number_of_participants" smallint DEFAULT '0',
    "type_instrument" character varying(100),
    "price" smallint default '0',
    "id_music_lesson" integer DEFAULT nextval('group_lesson_id_music_lesson_seq') NOT NULL,
    CONSTRAINT "group_lesson_pkey" PRIMARY KEY ("id_group")
) WITH (oids = false);

ALTER TABLE group_lesson ADD CONSTRAINT chk_group_instrument CHECK(type_instrument in('guitar','drums', 'base', 'trumpet', 'piano', 'violin', 'cello', 'saxophone'));
ALTER TABLE group_lesson ADD CONSTRAINT chk_group_participants CHECK (number_of_participants BETWEEN 3 AND 8);
ALTER TABLE group_lesson ADD CONSTRAINT chk_group_level CHECK(level in('beginner', 'intermediate','advanced'));

DROP TABLE IF EXISTS "scheduled_hour_group";
DROP SEQUENCE IF EXISTS scheduled_hour_group_id_group_lesson_seq;
CREATE SEQUENCE scheduled_hour_group_id_group_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."scheduled_hour_group" (
    "id_group" integer DEFAULT nextval('scheduled_hour_group_id_group_lesson_seq') NOT NULL,
    "date" timestamp,
    CONSTRAINT "scheduled_hour_group_pkey" PRIMARY KEY ("id_group"),
    CONSTRAINT "scheduled_hour_group_id_group_lesson_fkey" FOREIGN KEY (id_group) REFERENCES group_lesson(id_group) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "individual_lesson";
DROP SEQUENCE IF EXISTS individual_lesson_id_individual_lesson_seq;
CREATE SEQUENCE individual_lesson_id_individual_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS individual_lesson_id_music_lesson_seq;
CREATE SEQUENCE individual_lesson_id_music_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."individual_lesson" (
    "id_individual_lesson" integer DEFAULT nextval('individual_lesson_id_individual_lesson_seq') NOT NULL,
    "level" character varying(100),
    "type_instrument" character varying(100),
    "price" smallint default '0',
    "id_music_lesson" integer DEFAULT nextval('individual_lesson_id_music_lesson_seq') NOT NULL,
    CONSTRAINT "individual_lesson_pkey" PRIMARY KEY ("id_individual_lesson")
) WITH (oids = false);

ALTER TABLE individual_lesson ADD CONSTRAINT chk_individual_instrument CHECK(type_instrument in('guitar','drums', 'base', 'trumpet', 'piano', 'violin', 'cello', 'saxophone'));
ALTER TABLE individual_lesson ADD CONSTRAINT chk_individual_level CHECK(level in('beginner', 'intermediate','advanced'));

DROP TABLE IF EXISTS "ensemble_lesson";
DROP SEQUENCE IF EXISTS ensemble_lesson_id_ensemble_seq;
CREATE SEQUENCE ensemble_lesson_id_ensemble_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS ensemble_lesson_id_music_lesson_seq;
CREATE SEQUENCE ensemble_lesson_id_music_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."ensemble_lesson" (
    "id_ensemble" integer DEFAULT nextval('ensemble_lesson_id_ensemble_seq') NOT NULL,
    "genre" character varying(100),
    "level" character varying(100),
    "number_of_participants" smallint DEFAULT '0',
    "price" smallint default '0',
    "id_music_lesson" integer DEFAULT nextval('ensemble_lesson_id_music_lesson_seq') NOT NULL,
    CONSTRAINT "ensemble_lesson_pkey" PRIMARY KEY ("id_ensemble")
) WITH (oids = false);


ALTER TABLE ensemble_lesson ADD CONSTRAINT chk_ensemble_genre CHECK(genre in('rock','classic','jazz','blues','reggae','country','disco','funk'));
ALTER TABLE ensemble_lesson ADD CONSTRAINT chk_ensemble_participants CHECK (number_of_participants BETWEEN 3 AND 8);
ALTER TABLE ensemble_lesson ADD CONSTRAINT chk_ensemble_level CHECK(level in('beginner', 'intermediate','advanced'));

DROP TABLE IF EXISTS "scheduled_hour_ensemble";
DROP SEQUENCE IF EXISTS scheduled_hour_ensemble_id_ensemble_seq;
CREATE SEQUENCE scheduled_hour_ensemble_id_ensemble_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."scheduled_hour_ensemble" (
    "id_ensemble" integer DEFAULT nextval('scheduled_hour_ensemble_id_ensemble_seq') NOT NULL,
    "date" timestamp,
    CONSTRAINT "scheduled_hour_ensemble_pkey" PRIMARY KEY ("id_ensemble"),
    CONSTRAINT "scheduled_hour_ensemble_id_ensemble_fkey" FOREIGN KEY (id_ensemble) REFERENCES ensemble_lesson(id_ensemble) NOT DEFERRABLE
) WITH (oids = false);

DROP TABLE IF EXISTS "person";
DROP SEQUENCE IF EXISTS person_id_seq;
CREATE SEQUENCE person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."person" (
    "id" integer DEFAULT nextval('person_id_seq') NOT NULL,
    "first_name" character varying(100) NOT NULL,
    "last_name" character varying(100) NOT NULL,
    "personal_number" character varying(100) NOT NULL,
    CONSTRAINT "person_personal_number_key" UNIQUE ("personal_number"),
    CONSTRAINT "person_phone_no_key" UNIQUE ("phone_no"),
    CONSTRAINT "person_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "student";
DROP SEQUENCE IF EXISTS student_person_id_seq;
CREATE SEQUENCE student_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."student" (
    "student_id" character varying(100) NOT NULL,
    "level" character varying(100),
    "person_id" integer DEFAULT nextval('student_person_id_seq') NOT NULL,
    CONSTRAINT "add" PRIMARY KEY ("person_id"),
    CONSTRAINT "student_student_id_key" UNIQUE ("student_id"),
    CONSTRAINT "person_id" FOREIGN KEY (person_id) REFERENCES person(id) NOT DEFERRABLE
) WITH (oids = false);

DROP TABLE IF EXISTS "sibling";
DROP SEQUENCE IF EXISTS sibling_person_id_seq;
CREATE SEQUENCE sibling_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."sibling" (
    "person_id" integer DEFAULT nextval('sibling_person_id_seq') NOT NULL,
    "personal_id_sibling" character varying(100),
    CONSTRAINT "sibling_personal_id_sibling_key" UNIQUE ("personal_id_sibling"),
    CONSTRAINT "sibling_pkey" PRIMARY KEY ("person_id"),
    CONSTRAINT "sibling_person_id_fkey" FOREIGN KEY (person_id) REFERENCES student(person_id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "teacher";
DROP SEQUENCE IF EXISTS teacher_person_id_seq;
CREATE SEQUENCE teacher_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."teacher" (
    "teacher_id" smallint NOT NULL,
    "proficiency" character varying(100),
    "person_id" integer DEFAULT nextval('teacher_person_id_seq') NOT NULL,
    CONSTRAINT "teacher_teacher_id_key" UNIQUE ("teacher_id"),
    CONSTRAINT "person_id" FOREIGN KEY (person_id) REFERENCES person(id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "music_lesson";
DROP SEQUENCE IF EXISTS music_lesson_id_music_lesson_seq;
CREATE SEQUENCE music_lesson_id_music_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS music_lesson_person_id_seq;
CREATE SEQUENCE music_lesson_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."music_lesson" (
    "id_music_lesson" integer DEFAULT nextval('music_lesson_id_music_lesson_seq') NOT NULL,
    "level" character varying(100),
    "person_id" integer DEFAULT nextval('music_lesson_person_id_seq') NOT NULL,
    "teacher_id" smallint NOT NULL,
    CONSTRAINT "music_lesson_person_id_fkey" FOREIGN KEY (person_id) REFERENCES student(person_id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "instrument_rental";
DROP SEQUENCE IF EXISTS instument_rental_id_instrument_rental_seq;
CREATE SEQUENCE instument_rental_id_instrument_rental_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."instrument_rental" (
    "id_instrument_rental" integer DEFAULT nextval('instument_rental_id_instrument_rental_seq') NOT NULL,
    "type_of_instrument" character varying(100),
    "brands" character varying(100),
    "rented" boolean,
    "price" smallint,
    "person_id" integer,
    CONSTRAINT "instument_rental_pkey" PRIMARY KEY ("id_instrument_rental"),
    CONSTRAINT "instrument_rental_person_id_fkey" FOREIGN KEY (person_id) REFERENCES student(person_id) NOT DEFERRABLE
) WITH (oids = false);

DROP TABLE IF EXISTS "instrument_rental_period";
DROP SEQUENCE IF EXISTS instrument_rental_period_id_instrument_rental_seq;
CREATE SEQUENCE instrument_rental_period_id_instrument_rental_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."instrument_rental_period" (
    "id_instrument_rental" integer DEFAULT nextval('instrument_rental_period_id_instrument_rental_seq') NOT NULL,
    "rent_period_start" date,
    CONSTRAINT "instrument_rental_period_id_instrument_rental_fkey" FOREIGN KEY (id_instrument_rental) REFERENCES instrument_rental(id_instrument_rental) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "discount";
DROP SEQUENCE IF EXISTS discount_person_id_seq;
CREATE SEQUENCE discount_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."discount" (
    "percentage" numeric(3,2),
    "person_id" integer DEFAULT nextval('discount_person_id_seq') NOT NULL,
    CONSTRAINT "discount_person_id_fkey" FOREIGN KEY (person_id) REFERENCES sibling(person_id) NOT DEFERRABLE
) WITH (oids = false);

COMMENT ON COLUMN "public"."discount"."percentage" IS '0.10';


DROP TABLE IF EXISTS "contact_details";
DROP SEQUENCE IF EXISTS contact_details_person_id_seq;
CREATE SEQUENCE contact_details_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS contact_details_contact_details_id_seq;
CREATE SEQUENCE contact_details_contact_details_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."contact_details" (
    "person_id" integer DEFAULT nextval('contact_details_person_id_seq') NOT NULL,
    "address" character varying(100),
    "email" character varying(100),
    "phone_no" character varying(100),
    "contact_details_id" integer DEFAULT nextval('contact_details_contact_details_id_seq') NOT NULL,
    CONSTRAINT "contact_details_pkey" PRIMARY KEY ("contact_details_id"),
    CONSTRAINT "contact_details_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person(id) NOT DEFERRABLE
) WITH (oids = false);

DROP TABLE IF EXISTS "contact_details_parents";
DROP SEQUENCE IF EXISTS contact_details_parents_person_id_seq;
CREATE SEQUENCE contact_details_parents_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS contact_details_parents_contact_parents_id_seq;
CREATE SEQUENCE contact_details_parents_contact_parents_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."contact_details_parents" (
    "person_id" integer DEFAULT nextval('contact_details_parents_person_id_seq') NOT NULL,
    "phone_number" character varying(100),
    "contact_parents_id" integer DEFAULT nextval('contact_details_parents_contact_parents_id_seq') NOT NULL,
    "name_parent" character varying(100),
    CONSTRAINT "contact_details_parents_pkey" PRIMARY KEY ("contact_parents_id"),
    CONSTRAINT "contact_details_parents_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person(id) NOT DEFERRABLE
) WITH (oids = false);

DROP TABLE IF EXISTS "appointment";
DROP SEQUENCE IF EXISTS appointment_id_individual_lesson_seq;
CREATE SEQUENCE appointment_id_individual_lesson_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."appointment" (
    "id_individual_lesson" integer DEFAULT nextval('appointment_id_individual_lesson_seq') NOT NULL,
    "date" timestamp NOT NULL,
    "level" character varying(100),
    CONSTRAINT "appointment_pkey" PRIMARY KEY ("id_individual_lesson"),
    CONSTRAINT "appointment_id_individual_lesson_fkey" FOREIGN KEY (id_individual_lesson) REFERENCES individual_lesson(id_individual_lesson) NOT DEFERRABLE
) WITH (oids = false);

DROP TABLE IF EXISTS "application_form";
DROP SEQUENCE IF EXISTS application_form_person_id_seq;
CREATE SEQUENCE application_form_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS application_form_application_id_seq;
CREATE SEQUENCE application_form_application_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS application_form_contact_parents_id_seq;
CREATE SEQUENCE application_form_contact_parents_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

DROP SEQUENCE IF EXISTS application_form_contact_details_id_seq;
CREATE SEQUENCE application_form_contact_details_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."application_form" (
    "level" character varying(100) NOT NULL,
    "type_of_class" character varying(100) NOT NULL,
    "person_id" integer DEFAULT nextval('application_form_person_id_seq') NOT NULL,
    "id_application" integer DEFAULT nextval('application_form_application_id_seq') NOT NULL,
    "age" smallint NOT NULL,
    "contact_parents_id" integer DEFAULT nextval('application_form_contact_parents_id_seq') NOT NULL,
    "audition" boolean NOT NULL,
    "contact_details_id" integer DEFAULT nextval('application_form_contact_details_id_seq') NOT NULL,
    CONSTRAINT "application_form_pkey" PRIMARY KEY ("id_application"),
    CONSTRAINT "application_form_contact_details_id_fkey" FOREIGN KEY (contact_details_id) REFERENCES contact_details(contact_details_id) NOT DEFERRABLE,
    CONSTRAINT "application_form_contact_parents_id_fkey" FOREIGN KEY (contact_parents_id) REFERENCES contact_details_parents(contact_parents_id) NOT DEFERRABLE,
    CONSTRAINT "application_form_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person(id) NOT DEFERRABLE
) WITH (oids = false);

ALTER TABLE application_form ADD CONSTRAINT chk_application_level CHECK(level in('beginner', 'intermediate','advanced'));
ALTER TABLE application_form ADD CONSTRAINT chk_application_age CHECK(age>=18);

DROP TABLE IF EXISTS "payment";

DROP SEQUENCE IF EXISTS payment_person_id_seq;
CREATE SEQUENCE payment_person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;


CREATE TABLE "public"."payment" (
    "id_payment" integer DEFAULT nextval('payment_id_payment_seq') NOT NULL,
    "person_id" integer DEFAULT nextval('payment_person_id_seq') NOT NULL,
    "total_price" smallint,
    "total_rent" smallint,
    "month" varchar(100),
    CONSTRAINT "payment_pkey" PRIMARY KEY ("id_payment"),
    CONSTRAINT "payment_person_id_fkey" FOREIGN KEY (person_id) REFERENCES student(person_id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "month_salary";

CREATE TABLE "public"."month_salary" (
    "id_payment" integer,
    "total_price_lesson" smallint,
    "teacher_id" smallint
) WITH (oids = false);


DROP TABLE IF EXISTS "forms_applicants";
DROP SEQUENCE IF EXISTS forms_applicants_id_application_seq;
CREATE SEQUENCE forms_applicants_id_application_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."forms_applicants" (
    "id_application" integer DEFAULT nextval('forms_applicants_id_application_seq') NOT NULL,
    "application_time" DATE,
    CONSTRAINT "forms_applicants_pkey" PRIMARY KEY ("id_application"),
    CONSTRAINT "forms_applicants_id_application_fkey" FOREIGN KEY (id_application) REFERENCES application_form(id_application) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "forms_registered_students";
DROP SEQUENCE IF EXISTS forms_registered_students_id_application_seq;
CREATE SEQUENCE forms_registered_students_id_application_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."forms_registered_students"(
    "id_application" integer DEFAULT nextval('forms_registered_students_id_application_seq') NOT NULL,
    "application_time" DATE,
    CONSTRAINT "forms_registered_students_pkey" PRIMARY KEY ("id_application"),
    CONSTRAINT "forms_registered_students_id_application_fkey" FOREIGN KEY (id_application) REFERENCES application_form(id_application) NOT DEFERRABLE
) WITH (oids = false);


CREATE VIEW CHECK_STAFF_STATUS AS
SELECT "TeacherID","FirstName", "LastName", "Number of lessons" FROM
(
SELECT m1.teacher_id as "TeacherID",first_name as "FirstName", last_name as "LastName", count(distinct id_music_lesson) as "Number of lessons" FROM music_lesson as m1
INNER JOIN teacher ON teacher.teacher_id = m1.teacher_id
INNER JOIN person ON teacher.person_id = person.id
INNER JOIN scheduled_hour_group ON scheduled_hour_group.id_group = m1.id_music_lesson
WHERE date_part('month', (SELECT scheduled_hour_group.date)) = date_part('month', (SELECT CURRENT_TIMESTAMP))
GROUP BY "TeacherID", "FirstName", "LastName" HAVING count(DISTINCT id_music_lesson) >=2
UNION ALL
SELECT m2.teacher_id as "TeacherID",first_name as "FirstName", last_name as "LastName",  count(distinct id_music_lesson) as "Number of lessons" FROM  music_lesson as m2
INNER JOIN teacher ON teacher.teacher_id = m2.teacher_id
INNER JOIN person ON teacher.person_id = person.id
INNER JOIN scheduled_hour_ensemble ON scheduled_hour_ensemble.id_ensemble = m2.id_music_lesson
WHERE date_part('month', (SELECT scheduled_hour_ensemble.date)) = date_part('month', (SELECT CURRENT_TIMESTAMP))
GROUP BY "TeacherID","FirstName", "LastName" HAVING count(DISTINCT id_music_lesson) >=2
UNION ALL
SELECT m3.teacher_id as "TeacherID",first_name as "FirstName", last_name as "LastName", count(distinct id_music_lesson) as "Number of lessons" FROM music_lesson as m3
INNER JOIN teacher ON teacher.teacher_id = m3.teacher_id
INNER JOIN person ON teacher.person_id = person.id
INNER JOIN appointment ON appointment.id_individual_lesson = m3.id_music_lesson
WHERE date_part('month', (SELECT appointment.date)) = date_part('month', (SELECT CURRENT_TIMESTAMP))
GROUP BY "TeacherID","FirstName", "LastName" HAVING count(DISTINCT id_music_lesson) >=2
)AS dates
GROUP BY "TeacherID","FirstName", "LastName","Number of lessons" ORDER BY "Number of lessons" asc;
