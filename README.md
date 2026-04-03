The South Sudan LF Progress Report components:
- `raw_data/` contains the raw dataset 
- `code/` contains all code related to the descriptive analysis
	- `code/01_clean_data.R` produces the clean dataset
		- clean_data should be saved to `output/`
	- `code/02_make_table.R` produces the table for the report
		- table should be saved to `output/`
	- `code/03_make_graph.R` produces the graph/figure for the report
		- graph should be saved to `output/`
  -`code/04_render_report.R` is used for rendering the report from the command line

`South-Sudan-LF-Progress-Report.Rmd` reads in outputs from `output/` and creates the report

`Makefile` contains rules for building the report

This file uses renv to manage R packages dependencies. After cloning the repo,
restore all required pages from the lockfile using renv::re 
