# Use an official shiny as base image 
FROM rocker/shiny:latest

# Copy the current directory contents into the container at /app
COPY ./ /srv/shiny-server/

# Set the working directory to /app
WORKDIR /srv/shiny-server

# Copy shiny server configurations 
# COPY shiny-server.sh /usr/bin/shiny-server.sh

# Install any needed packages from CRAN
RUN sudo R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')"

#RUN chown -R shiny:shiny /srv/shiny-server/
RUN chmod -R 777 /srv/shiny-server/
RUN chmod -R 777 /var/log/shiny-server
    
# Make port 3838 available to the world outside this container
EXPOSE 3838

# Define environment variable

COPY /shiny-server.conf /etc/shiny-server/shiny-server.conf

ENV APP_ROOT=/usr/bin
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd
ENTRYPOINT [ "uid_entrypoint" ]
CMD run 

