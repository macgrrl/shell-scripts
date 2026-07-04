# Airthings Radon monitor scripts

## Generate graph of short term radon readings

### Prerequisites

* [miller](https://github.com/johnkerl/miller) - CSV processor
* [gnuplot](http://gnuplot.info) - graph plotter

### Files
#### radon_process.sh
Extracts short term radon readings from Airthings Radon monitor data export and generates graph plot.

Generates the following files:

* CSV file containing all short term radon readings with the name `radon_st_from-date_to_date.csv`.
* text file of statistical information (count, minimum, maximum, mean, and standard deviation) with the name `radon_st_stats_from-date_to_date.txt`.
* PDF file of the graph with the name `radon_st_from-date_to_date.pdf`.

Generates a temporary file `temp.csv`.

Usage: `radon_process.sh exported_data.csv`

#### radon_st_plot.gnuplot
gnuplot command file to generate the graph of the short term radon readings. Two arguments are passed to gnuplot:

* name of the short term radon readings CSV file
* mean value of the radon readings
