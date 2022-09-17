Basic postfix gmail relay in a docker container. 

# A docker image of this can be found at 
https://hub.docker.com/r/ahmedirtza/postfix-ubuntu

# Use the below command (input e-mail & pass of your gmail account) to start the container.
docker run -d --rm -p 9025:25 -e EMAIL="YOUR_EMAIL@gmail.com" -e EMAILPASS="YOUR_PASS" ahmedirtza/postfix-ubuntu

# Use the following command to go inside the container.
docker exec -it <container_id> bash

# Use the below command to send email.
echo "Test email body" | mail -s "Testing Subject" recipient_email@gmail.com
