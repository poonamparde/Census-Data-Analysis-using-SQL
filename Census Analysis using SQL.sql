--import dataset and see(dataset1 and datset2)

select * from Project_SQL..dataset1

select * from Project_SQL..dataset2


-- number of rows in dataset

select count(*) from Project_SQL..dataset1
select count(*) from Project_SQL..dataset2 


-- dataset for maharashtra and gujarat

select * from Project_SQL..dataset1 where State in ('Maharashtra','Gujarat')


-- to know the Total Population of India

select sum (Population) as Total_Population from Project_SQL..dataset2


-- avg growth 

select avg(growth)*100 as avg_growth from Project_SQL..dataset1


--avg growth by state states

select state, avg(growth)*100 as avg_growth_state from Project_SQL..dataset1 group by State


--avg sex ratio by states

select state, round (avg(sex_ratio),0) as avg_sex_ratio from Project_SQL..dataset1 group by State order by avg_sex_ratio desc


-- avg literacy rate

 select state, round (avg(literacy), 0) as avg_literacy_ratio from Project_SQL..dataset1 
 group by state   having  round (avg(literacy), 0)>90  order by avg_literacy_ratio desc
  

 -- top 3 state which have avg growth rate

 select top 3 state, avg(growth)*100 as avg_growth from Project_SQL..dataset1 group by state order by avg_growth desc 


 -- bottom 3 state showing lowest sex ratio

 select top 3 state, round( avg(sex_ratio),0) as avg_sex_ratio from Project_SQL..dataset1 group by state order by avg_sex_ratio


  -- top and bottom 3 state in literacy state (so create new table)
  -- top 3 most literate state 

  drop table if exists most_literate_state

  create table most_literate_state
  (state varchar (255), topstate float )

  insert into most_literate_state
  select state, round(avg(literacy),0) as avg_literacy_ratio from Project_SQL..dataset1
  group by State order by avg_literacy_ratio desc


  -- to see table 
  select  top 3* from most_literate_state order by most_literate_state.topstate desc



  --least literate bottom 3 state
  drop table if exists least_literate_state

  create table least_literate_state
  (state varchar (255), leaststate float )

  insert into least_literate_state
  select state, round(avg(literacy),0) as avg_literacy_ratio from Project_SQL..dataset1
  group by State order by avg_literacy_ratio desc


  -- to see table 
  select  top 3* from least_literate_state order by least_literate_state.leaststate asc



  -- combine this two table using union operator
  select * from (
  select  top 3* from most_literate_state order by most_literate_state.topstate desc) as a

  union

  select * from (
  select  top 3* from least_literate_state order by least_literate_state.leaststate asc) as b



  --state starting with letter 'a'

select distinct State from Project_SQL..dataset1 where lower(state) like 'a%'


  --joining both table (dataset1 and dataset2) (a, b, c and d are table alias)

  --find total no of males and females
 select d.state, sum(d.males) as total_males, sum(d.females) as total_females from
 (select c.district , c.state, round(c.population/(c.sex_ratio + 1),0) as males, round((c.population * c.sex_ratio)/(c.sex_ratio + 1),0) as females from 
 (select a.District, a.state, a.sex_ratio/1000 sex_ratio, b.population from Project_SQL..dataset1 as a  inner join Project_SQL..dataset2 as b  on a.District= b.District ) as c) as d
  group by d.State




  
