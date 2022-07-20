DROP SCHEMA IF EXISTS homelibrary CASCADE;
CREATE SCHEMA homelibrary;

DROP SCHEMA IF EXISTS homelibrary_stg CASCADE;
CREATE SCHEMA homelibrary_stg;

-- create user and group
DROP ROLE IF EXISTS homelibrary_group;
DROP ROLE IF EXISTS homelibrary_user;

CREATE ROLE homelibrary_user WITH login PASSWORD 'mylibrary';
CREATE ROLE homelibrary_group;

GRANT CONNECT ON DATABASE mylibrary TO homelibrary_group;
GRANT ALL ON SCHEMA homelibrary TO homelibrary_group;
GRANT ALL ON SCHEMA homelibrary_stg TO homelibrary_group;

GRANT homelibrary_group TO homelibrary_user;

ALTER SCHEMA homelibrary OWNER TO homelibrary_group;
ALTER SCHEMA homelibrary_stg OWNER TO homelibrary_group;