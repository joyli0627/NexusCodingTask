NexusCodingTask
===============

This is a simple iOS applcation calling the per-built web services to return a list of production data which matches 
with the search word entered by the user.
Instead of using libraries such as SBJason and ASI, here I used self-supported functions decode Json-format data. The main
functions supported in this application are:
1. Allowing users to input a key word for searching;
2. Allowing users to remove the entered word by pressing "Cancel" button;
3. After the user pressing "Confirm" button, the application will call the web services to return matched product data;
4. If there is no matched product, the application will generate alert view saying "There is no matched product!";
5. If the connection fails, there will be an alert window showing the error message;
6. The table view, which is used to list product description info allows vertical scrolling;
