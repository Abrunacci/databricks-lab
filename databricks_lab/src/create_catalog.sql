-- Databricks notebook source
-- databricks/setup/00_catalog.sql
CREATE CATALOG IF NOT EXISTS IDENTIFIER(:catalog);
USE CATALOG IDENTIFIER(:catalog);

CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
