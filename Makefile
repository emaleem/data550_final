#R_LIBS_USER := C:/Users/EmaleeMartin/AppData/Local/R/win-library/4.5
#export R_LIBS_USER

## REPORT ASSOCIATED RULES ##
South-Sudan-LF-Progress-Report.html: South-Sudan-LF-Progress-Report.Rmd code/04_render_report.R clean_data table graph
	Rscript code/04_render_report.R

clean_data: code/01_clean_data.R raw_data/RSS_LF_Data.csv
	Rscript code/01_clean_data.R
	
table: code/02_make_table.R output/clean_data.rds 
	Rscript code/02_make_table.R
	
graph: code/03_make_graph.R output/clean_data.rds 
	Rscript code/03_make_graph.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f South-Sudan-LF-Progress-Report.html $$ rm -f report/South-Sudan-LF-Progress-Report.html
	
test:
	Rscript -e ".libPaths()"
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
## DOCKER ASSOCIATED RULES ##

## rule to build image
report_image: 
	docker build -t report_image .
	touch $@
	
##rule to build the report automatically in container
report/South-Sudan-LF-Progress-Report.html: report_image
	docker run -v "/$$(pwd)/report":/report/report report_image
