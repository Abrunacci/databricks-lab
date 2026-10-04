-- Databricks notebook source
-- databricks/setup/00_catalog.sql
CREATE CATALOG IF NOT EXISTS databricks_lab;
CREATE SCHEMA IF NOT EXISTS databricks_lab.bronze;
CREATE SCHEMA IF NOT EXISTS databricks_lab.silver;
CREATE SCHEMA IF NOT EXISTS databricks_lab.gold;
