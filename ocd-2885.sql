DROP SCHEMA IF EXISTS ff4j CASCADE;

CREATE SCHEMA ff4j
    AUTHORIZATION openchpl_dev;
GRANT ALL ON SCHEMA ff4j TO openchpl_dev;
GRANT USAGE ON SCHEMA ff4j TO openchpl;

CREATE TABLE ff4j.features (
	feat_uid VARCHAR(100),
	enable INTEGER NOT NULL,
	description VARCHAR(1000),
	strategy VARCHAR(1000),
	expression VARCHAR(255),
	groupname VARCHAR(100),
	PRIMARY KEY(feat_uid)
);

CREATE TABLE ff4j.roles (
	feat_uid VARCHAR(100) REFERENCES ff4j.features(feat_uid),
	role_name VARCHAR(100),
	PRIMARY KEY(feat_uid, role_name)
);

CREATE TABLE ff4j.custom_properties (
	property_id VARCHAR(100) NOT NULL,
	clazz VARCHAR(255) NOT NULL,
	currentvalue VARCHAR(255),
	fixedvalues VARCHAR(1000),
	description VARCHAR(1000),
	feat_uid VARCHAR(100) REFERENCES ff4j.features(feat_uid),
	PRIMARY KEY(property_id, feat_uid)
);

CREATE TABLE ff4j.properties (
	property_id VARCHAR(100) NOT NULL,
	clazz VARCHAR(255) NOT NULL,
	currentvalue VARCHAR(255),
	fixedvalues VARCHAR(1000),
	description VARCHAR(1000),
	PRIMARY KEY(property_id)
);

CREATE TABLE ff4j.audit (
	evt_uuid VARCHAR(40) NOT NULL,
	evt_time TIMESTAMP NOT NULL,
	evt_type VARCHAR(30) NOT NULL,
	evt_name VARCHAR(100) NOT NULL,
	evt_action VARCHAR(100) NOT NULL,
	evt_hostname VARCHAR(100) NOT NULL,
	evt_source VARCHAR(30) NOT NULL,
	evt_duration INTEGER,
	evt_user VARCHAR(30),
	evt_value VARCHAR(100),
	evt_keys VARCHAR(255),
	PRIMARY KEY(evt_uuid, evt_time)
);
