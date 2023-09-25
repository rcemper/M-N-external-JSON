[![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2FJSONExport-ManyToMany-AD&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2FJSONExport-ManyToMany-AD)  

# M:N export with external JSON
Sample for SQL methods JSON_OBJECT and JSON_ARRAY

This package is inspired by the broken package JSONExportManyToMany](https://openexchange.intersystems.com/package/JSONExportManyToMany) 
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
After installing this sample, the following two commands can be run from terminal or console

````
docker-compose exec iris iris session iris    
````
- The test output should appear as follows:

<pre>

{"Name":"Teacher3Name","Students":[{"ID":4,"Student":{"Name":"Nael"}}]}
</pre>

You will notice here that when exporting from Student (First 2 output lines),    
the relationship to Teacher is followed through TeacherStudent and details of the Teacher are exported.    

Likewise, when exporting from Teacher, the relationship to Student is followed through    
TeacherStudent and details of the Student are exported.   

[Demo Server SMP](https://json-export-many-many.demo.community.intersystems.com/csp/sys/UtilHome.csp)    
[Demo Server WebTerminal](https://json-export-many-many.demo.community.intersystems.com/terminal/)   
