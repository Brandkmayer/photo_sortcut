# photo_sortcut
Auto sort and relocate photo files by starting and ending photo file name.

#Setup
Clone repository on your local computer. 

![A pretty Tiger](https://upload.wikimedia.org/wikipedia/commons/5/56/Tiger.50.jpg)

## Workflow
This script works under the assumption that you have access to the [Sorting log](https://docs.google.com/spreadsheets/d/1wera4XFmGMdztjZvAY5lXWEHg4LszraBr96a-KU1pp4/edit#gid=792627629). 

Through sorting log you can locate a site of interest and download the sorted file. This should be down when all of the sorting has been completed on a site for the season. Doing so in chunks might reduce the time need to copy files over but in the long run this time is pretty insignificant compared to moving over entire folders.  

![](https://imgur.com/9kn54QM.jpg)

Save the csv file to "sorting_log" folder in the cloned folder. (Current Rscript should have a pathway set up to the cloned folder should this should make the scripts use a bit easier)

------

When "proto_sort_consolidate.R" is loaded you'll need to change the pathways for:

* photo folder on either a server or an external harddrive
* three letter code for the sorting log file (Sorting Log - _@@@_.csv) 

	Enter in as 			"csv <- @@@""


![](https://imgur.com/emAep8z.jpg)
 
 After running steps in script to fill empty columns the csv should show up as shown above. 


 Should be able to follow everything else by reading the comments in the Rscript. 

 Cheers.  
