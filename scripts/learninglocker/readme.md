# LPG TODO
# Creating an Learning Locker Admin User
## Getting started
### Set up admin user using script
Pull the docker image for Learning Catalogue from either docker source
```
cshr/lpg-learning-locker:fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8
```
or
```
lpgregistry.azurecr.io/lpg-learning-locker:fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8 
```

Run the following on the command line to get into the docker container:
```
docker run -it -w /opt/learning-locker cshr/lpg-learning-locker:fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8 /bin/bash
```

Now you will be inside the LL docker container.

Run the following commands to create a Learning Locker UI admin user:
```
npm install 
MONGODB_PATH=[mongo_connection_string_here] 

node cli/dist/server createSiteAdmin [username] LPG [password]

e.g.
node cli/dist/server createSiteAdmin admin@example.com LPG password
```
This may throw an error, but should still create you an admin user for the Learning Locker UI.

### Learning Locker UI changes
Navigate to the Learning Locker UI (get URL from Azure)

With admin user created in the step above, log into Learning Locker UI with username password. e.g. admin@cslearning.gov.uk/admin

* Create a new store called ‘LPG Store’ (settings > store)
* Create a new client called ‘LPG Store client. 
	* Make a note of the Key and Secret values. These should be placed in env variables of Learner Record 
	* Select the xAPI LRS store as seen below. You’ll need to click the label for LPG store to populate the text box.
	* Set the scope checkbox as ALL