FROM rocker/tidyverse

RUN apt-get update && apt-get install -y pandoc

RUN mkdir /report
WORKDIR /report

RUN mkdir code
RUN mkdir output
RUN mkdir raw_data
COPY raw_data/RSS_LF_Data.csv raw_data/
COPY code code 
COPY Makefile .
COPY South-Sudan-LF-Progress-Report.Rmd .

COPY .Rprofile . 
COPY renv.lock . 
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv

RUN Rscript -e "renv::restore(prompt = FALSE)"

RUN mkdir report

CMD make South-Sudan-LF-Progress-Report.html && mv South-Sudan-LF-Progress-Report.html report
