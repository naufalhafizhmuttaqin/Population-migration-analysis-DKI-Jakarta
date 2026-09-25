# Population Migration Analysis to DKI Jakarta

> An end-to-end Data Analyst portfolio project analyzing population migration into DKI Jakarta in 2025, with a focus on migrant origins, destination areas, and major migration routes.

---

## 📌 Project Overview

Population migration is an important factor in understanding urban population distribution and movement.

This project analyzes data on people migrating into DKI Jakarta during 2025. The analysis focuses on identifying:

- Where migrants come from
- Which cities contribute the most migrants
- Which administrative areas in DKI Jakarta receive the most migrants
- Which districts and villages have the highest migrant concentrations
- Which migration routes have the highest number of migrants

The project was developed as an end-to-end Data Analyst case study, covering data cleaning, exploratory data analysis, SQL analysis, and interactive visualization using Power BI.

---

## 🎯 Business Problem

Population movement into DKI Jakarta can create different challenges for urban planning, housing, transportation, public services, and infrastructure.

However, aggregated migration data can be difficult to interpret without structured analysis.

The main business problem addressed in this project is:

> **How can migration data be analyzed to understand the origin, destination, and major migration routes of people moving into DKI Jakarta?**

By analyzing migration patterns, stakeholders can gain a clearer understanding of where migrants are coming from and which areas of Jakarta receive the highest number of migrants.

---

## 🔎 Objectives

The objectives of this project are to:

1. Measure the total number of migrants entering DKI Jakarta.
2. Identify the provinces contributing the most migrants.
3. Identify the cities contributing the most migrants.
4. Analyze migrant distribution across DKI Jakarta administrative cities.
5. Identify districts and villages with the highest number of migrants.
6. Identify the most common migration routes.
7. Build an interactive dashboard to communicate the findings.
8. Provide data-driven insights that can support further analysis and planning.

---

## ❓ Key Business Questions

This project aims to answer the following questions:

### Migrant Origins
- Which provinces contribute the most migrants to DKI Jakarta?
- Which cities contribute the most migrants?

### Migration Destinations
- Which administrative cities in DKI Jakarta receive the most migrants?
- Which districts have the highest number of incoming migrants?
- Which villages have the highest number of incoming migrants?

### Migration Routes
- What are the most common migration routes?
- Which origin city and destination city combinations account for the highest number of migrants?

---

# 📊 Dataset

### Dataset Information

**Dataset:** Data Penduduk Pendatang ke Provinsi DKI Jakarta  
**Period:** 2025  
**Source:** Satu Data Jakarta  
**Geographic Scope:** DKI Jakarta and migrant origins from other regions in Indonesia

The dataset contains aggregated information about people migrating into DKI Jakarta, including their origin and destination administrative areas.

### Dataset Source

The original dataset was obtained from the official Satu Data Jakarta portal:

👉 [Satu Data Jakarta]([https://satudata.jakarta.go.id/](https://satudata.jakarta.go.id/open-data/detail?kategori=dataset&page_url=data-penduduk-pendatang-ke-provinsi-dki-jakarta&data_no=1))

> Note: The dataset used in this project represents the 2025 period.

---

## 🗂️ Dataset Structure

The main columns used in the analysis include:

| Column | Description |
|---|---|
| `year` | Year of the migration data |
| `origin_province` | Province where migrants originated |
| `origin_city` | City/regency where migrants originated |
| `destination_city` | Administrative city in DKI Jakarta |
| `destination_district` | District (kecamatan) in DKI Jakarta |
| `destination_village` | Village (kelurahan) in DKI Jakarta |
| `total_migrants` | Number of migrants |

A derived column called `Migration Route` was also created for the analysis.

The route combines the origin city and destination city:

```text
Origin City → Destination City
