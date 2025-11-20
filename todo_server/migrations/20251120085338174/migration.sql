BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todos" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "isCompleted" boolean NOT NULL
);


--
-- MIGRATION VERSION FOR todo
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todo', '20251120085338174', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251120085338174', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
