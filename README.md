[![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2FM-N-external-JSON&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2FM-N-external-JSON)

# M:N export with external JSON
Sample for SQL methods JSON_OBJECT and JSON_ARRAY

This package is inspired by the broken package [JSONExportManyToMany](https://openexchange.intersystems.com/package/JSONExportManyToMany)    
The major difference is that instead of adding %JSONAdaptor to each class   
I used SQL functions to create my JSON objects.   
By this approach, you can add JSON to any class - even deployed ones -   
without any need for change or recompile.   
Additional features    
- dockerfile to be version independent   
- added support for IPM  
- added installation guide   
- added quality tag  
- added demo server  
- added WebTerminal  
- added pretty JSON presentation    
- added significant test dataset    
- added this useful README     

### Prerequisites    
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.    
### Installation   
Clone/git pull the repo into any local directory  

````    
git https://github.com/rcemper/JSONExport-ManyToMany-AD.git
````    
   
Build the container with your project:   

````
docker compose --progress plain build
````

Run the container

 ````
docker compose up -d
````
To follow the startup you may use

````
docker compose logs -f
````
### Testing 

Demo-data are imported from a [previous package](https://github.com/rcemper/Dataset-Lightweight-M-N)    
Is an extract from members in the Developer Community and the Badges available in GlobalMasters  
Real names are scrambled. 
- Users have a collection of Badges and Levels    
- Badges have a collection of Users
        
Besides the straight projection of Members or Badges as Array of JSON objects    
There is also
- a JSON Object containing the Member Object and an Array of his Badge Objects    
- similar JSON Object containing a specific Badge Object and an Array of owning Member Objects
 
After installing this sample, the following two commands can be run from terminal or console

````
docker-compose exec iris iris session iris    
````
- Members and Badges in the demo are referred by their ID
- Suitable IDs could be found by straight SQL queries
````
  select top 10 %ID,BadgeCount from dc_data_rcc.DCmember  
  where BadgeCount>2 order by badgecount
  -
  select top 10 %ID,MbCnt from dc_data_rcc.GMbadge
  where MbCnt>3 order by 2
````

#### 1) JSON by Badge      
Provide ID and a Verbose switch for immediate display  
````
 set b=##class(dc.data.rcc.JSON).byBadge(47,1)
````
  ![demo1](https://github.com/rcemper/M-N-external-JSON/assets/31236645/5a0c61df-9c3c-44d3-9714-98555df14361)

#### 2) JSON by Member
Provide ID instead of Verbose switch use explicit view  
````
 set res=##class(dc.data.rcc.JSON).byMember(9976)
 zzjson res
````
![demo2](https://github.com/rcemper/M-N-external-JSON/assets/31236645/a5862782-be3a-40d4-92eb-bf4a2dc425c5)



[article in DC](void)

[Demo Server SMP](https://m-n-json.demo.community.intersystems.com/csp/sys/UtilHome.csp)    
[Demo Server WebTerminal](https://m-n-json.demo.community.intersystems.com/terminal/)   
