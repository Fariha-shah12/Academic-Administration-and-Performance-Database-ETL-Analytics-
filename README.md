## Academic Administration and Performance Database ETL & Analytics

Overview

This repository contains an end-to-end ETL pipeline and analytics framework for collecting, transforming, and visualizing academic administration and performance data. The goal is to provide actionable insights for administrators, faculty, and students through automated data workflows and dashboard visualizations.


## Project Structure
```

├── Mileston1.pdf/         # The Workflow of project (explaining logical, physical schema of database) 

├── Mileston2/  # Source code for ETL pipeline
│   ├── milestone2dump.sql/           # Sql script which is used to dumb data which is gathered from UOW API to mysql wrokbench
│   └── milestonequery.sql/     # Sql queries which perform typical EDA on UOW data
│   └── data.zip/     # python file scrapped the data from UOW api- which will then be used for analysis and creating dashboard -Data ingestion from various sources
│   └── milestone2pdf/     # A generic information about milestone 2 (from scrapping data from UOW API to Dumping data into database and exploratory data analysis with SQL queries)
├── Milestone3/               
│   ├── milstone3code.py     # UI code 
│   ├── milestonspec.pdf   # Generic information about mileston 3 (developing UI which retrives data from database and show user) - (Tableu dashboard)

└── README.md          # This file
```

## ⚙️ Features
- Robust ETL Pipeline

    Ingests raw academic and performance data
    
    Cleans, normalizes, and transforms datasets
    
    Loads processed data into a relational database (e.g., PostgreSQL, MySQL)

- Analytical Insights

    Interactive Jupyter notebook for analysis
    
    Performance trend charts (e.g. grades over time)
    
    Comparative analytics across departments or programs

- Modular & Configurable

    Independent modules for extract/transform/load stages
    
    Easy to extend to new data sources or metrics
