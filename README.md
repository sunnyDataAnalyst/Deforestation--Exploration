# Deforestation--Exploration
In this project, I do research in 3 different parts based on the data provided. 
1. Global Situation ( first I create the view that helps navigate data, I find the total forest area, and total land area each country has and I compare them with 26 years during how they grow in the world)
2. Regional Outlook ( I check the current percentage area and past forest area percentage and make a table for the top region)
3. Country-Level Detail ( I look for the top 5 country that has the highest growth in forest and forest percent devied on Quartile group)

In this all the different parts, they provided questions and I find answers using SQL postgre.

## Step > 1 Create VIEW for data
![image](https://user-images.githubusercontent.com/116772724/218319924-0b843d2b-91d2-4a05-a285-5698f65e35ea.png)

create view create the temporary table in SQL that help us to find the infomation
![image](https://user-images.githubusercontent.com/116772724/218320067-1272891c-0acf-4ac3-9696-58ba11cb07fe.png)

## Part > 1 Global Situation
In this part i have 5 questions and i need find answer form database.

### Q.1) What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record denoted as “World" in the region table.
![image](https://user-images.githubusercontent.com/116772724/218321035-dfbd2c33-0c66-4da7-a955-9cec907c61f5.png)

### Q.2)  What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.” 
![image](https://user-images.githubusercontent.com/116772724/218321245-7dfe2d93-018a-4fa2-a109-908148f537fa.png)

### Q.3) What was the change (in sq km) in the forest area of the world from 1990 to 2016?
![image](https://user-images.githubusercontent.com/116772724/218321332-26a65032-e5b2-4ff3-bf77-1b59daa8fe49.png)
![image](https://user-images.githubusercontent.com/116772724/218321362-3202339f-5434-48ee-bf69-9cd817b7a726.png)

### Q.4) What was the percent change in forest area of the world between 1990 and 2016?
![image](https://user-images.githubusercontent.com/116772724/218321587-b7c6019a-1c63-422d-985c-5ce63b11d379.png)
![image](https://user-images.githubusercontent.com/116772724/218321655-6af7499e-9dcd-46f8-adf3-b3d2b663943e.png)

### Q.5) If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
![image](https://user-images.githubusercontent.com/116772724/218321923-a74db537-b265-496d-bdec-c904f99ffb1b.png)
![image](https://user-images.githubusercontent.com/116772724/218321953-d7593d9e-7f52-4e9e-82d5-8b5a2226a677.png)




## Part > 2 Regional Outlook
In Regional outlook I have 3 questions to find answer form given data.

### Q.1) What was the percent forest of the entire world in 2016? Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?
![image](https://user-images.githubusercontent.com/116772724/218322552-728191fb-b5d6-4d19-858d-e13725c5fc58.png)

### Q.2) What was the percent forest of the entire world in 1990? Which region had the HIGHEST percent forest in 1990, and which had the LOWEST, to 2 decimal places?
![image](https://user-images.githubusercontent.com/116772724/218322624-a1b6ba21-03ab-443a-82bf-c76233432629.png)

### Q.3) Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?
![image](https://user-images.githubusercontent.com/116772724/218323288-87b7ffc5-cb33-4080-9627-68d881be7ee1.png)
![image](https://user-images.githubusercontent.com/116772724/218323334-7dea28fb-a2f0-429f-b825-aff6023b0747.png)





## Part > 3 Country-Level Detail
In this section I am working on 5 Questions to find answer form tables.

### Q.1) Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?



