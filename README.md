# Layoffs Data Cleaning

This project focuses on cleaning a raw layoffs dataset using SQL to make it suitable for analysis.

## 🎯 Purpose of the Project
The goal is to take messy, unstructured data and transform it into a clean, consistent, and usable format. 
This sets the foundation for accurate analysis.

## 🛠️ Tools Used
- MySQL

## ⚙️ Actions Performed
- Create a working copy of the original table
- Remove duplicate records
- Standardize inconsistent entries
- Handle blank and NULL values
- Drop irrelevant columns

## 🗂️ Repository Structure

layoffs-data-cleaning/
│
├── README.md                  # Introduction and purpose      
│
├── layoffs_cleaning.sql       # SQL script for data cleaning 
│
└── layoffs                    # Raw Dataset


data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── etl.drawio                      # Draw.io file shows all different techniquies and methods of ETL
│   ├── data_architecture.drawio        # Draw.io file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io file for the data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
└── requirements.txt                    # Dependencies and requirements for the project
