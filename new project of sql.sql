create database new;
show databases;
use new;
select * from layoffs;
create table layoff_stagging
like layoffs;
show tables;
select * from layoff_stagging;
insert layoff_stagging
select * from layoffs;
with duplicates_cte as (
select * , row_number() OVER (partition by 
company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_stagging )
select * from duplicates_cte 
where row_num >1;
create table layoff_stagging2;
delete 
from duplicates_cte 
where row_num >1;
CREATE TABLE layoff_staggings (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from layoff_staggings;
insert into layoff_staggings 
select * , row_number() OVER (partition by 
company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_stagging ;
select * from layoff_staggings
where row_num>1 ;
delete from layoff_staggings
where row_num>1 ;




