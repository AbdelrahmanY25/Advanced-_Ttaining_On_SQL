--CREATE DATABASE Barown Health
--GO

CREATE SCHEMA health
GO

CREATE TABLE health.Patients (
	UR_Number int not null,
	Name varchar(50) not null,
	age int not null,
	addresses varchar(100) not null,
	email varchar(100) not null,
	phone varchar(15) not null,
	doctor_id int not null,
	medical_card_num int null

	primary key (UR_Number)
);

ALTER TABLE health.Patients
ADD CONSTRAINT fk_doc_pat foreign key (doctor_id) REFERENCES health.Doctors(doctor_id);

CREATE TABLE health.Doctors (
	doctor_id int not null,
	Name varchar(50) not null,
	specialty varchar(100) not null,
	email varchar(100) not null,
	phone varchar(15) not null, 
	exp_of_years int not null

	primary key (doctor_id)
);

CREATE TABLE health.Prescriptions (
	doctor_id int not null,
	UR_Number int not null,
	pre_id varchar(100) not null,
	pre_date date not null,
	quantity int not null,
	drug_id int not null

	primary key (pre_id)
);

ALTER TABLE health.Prescriptions
ADD CONSTRAINT fk_pre_doc foreign key (doctor_id) REFERENCES health.Doctors(doctor_id);

ALTER TABLE health.Prescriptions
ADD CONSTRAINT fk_pre_pat foreign key (UR_Number) REFERENCES health.Patients(UR_Number);

ALTER TABLE health.Prescriptions
ADD CONSTRAINT fk_pre_drug foreign key (drug_id) REFERENCES health.Drugs(drug_id);

CREATE TABLE health.Pharma_comapnies (
	company_id int not null,
	Name varchar(50) not null,
	addresses varchar(100) not null,
	phone varchar(15) not null,

	primary key (company_id)
);

CREATE TABLE health.Drugs (
	drug_id int not null,
	company_id int not null,
	trade_name varchar(50) not null,
	drug_strength varchar(100) not null,

	primary key (drug_id)
);

ALTER TABLE health.Drugs
ADD CONSTRAINT fk_drug_comp foreign key (company_id) REFERENCES health.Pharma_comapnies(company_id);