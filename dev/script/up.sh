#!/bin/bash

# Start Supervisor service
service supervisor start

# Check status of Supervisor service
service supervisor status

# Run supervisorctl to start all processes in the supervisord.conf file
supervisorctl reread
supervisorctl update
supervisorctl status

# Other commands you want to run when the container is started

# End of the script