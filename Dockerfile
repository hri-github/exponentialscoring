FROM rocker/r-base

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"

# copy the app to the image
COPY exponentialscoring /app/exponentialscoring

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app/exponentialscoring')"]
