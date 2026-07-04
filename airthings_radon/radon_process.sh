#!/bin/zsh

# Script to process radon csv file

# Usage: radon_process.sh input_file.csv

# Prerequisites
# mlr - for CSV file processing
# gnuplot - graph plotting

# CSV file format
# delimiter: semi-colon ;
# record (line) terminator: CR LF
# Fields
# 1: 'recorded' Date time stamp in ISO 8601
# 2: 'RADON_SHORT_TERM_AVG pCi/L' renamed to ST (sampled hourly)
# 3: 'RADON_LONG_TERM_AVG pCi/L' renamed to LT (sampled ??)
# 4: 'HUMIDITY %' renamed to HUM
# 5: 'TEMP °F' renamed to TEMP

# save input file name
filename=${1}
name=${filename%.*}
ext=${filename##*.}

# temporary filename
temp_filename="temp.csv"

# get start and end dates, generate date range (for output CSVs)
start_date=$(head -n 2 ${filename} | tail -n 1 | cut -d T -f 1)
end_date=$(tail -n 1 ${filename} | cut -d T -f 1)
date_range="${start_date}_${end_date}"

# output filenames
# short term
st_filename=radon_st_${date_range}.csv
st_stats_filename=radon_st_stats_${date_range}.txt
# short term graph PDF
st_graph=radon_st_${date_range}.pdf

# DEBUG
# echo "filename: ${filename}"
# echo "name: ${name}"
# echo "ext: ${ext}"
# echo "start_date: ${start_date}"
# echo "  end_date: ${end_date}"
# echo "date_range: ${date_range}"

# MAIN

echo "Processing input ${filename}"
echo "Date range: ${start_date} to ${end_date}"

# rename columns and save in temporary file
echo "Cleaning input"
mlr --csv --ifs semicolon --irs crlf \
    put '$[[2]] = "ST"; $[[3]] = "LT"; $[[4]] = "HUM"; $[[5]] = "TEMP"' ${filename} \
    > ${temp_filename}

# extract rows for which there are ST values
# then keep recorded and ST columns
# pass through sed to remove seconds
echo "Generating short term datafile ${st_filename}"
mlr --from ${temp_filename} --csv \
    filter 'is_not_empty($ST)' \
    then cut -f recorded,ST \
    | \
sed 's_\(T[0-9][0-9]:[0-9][0-9]\):[0-9][0-9]_\1_' > ${st_filename}

# calculate ST stats
echo "Generating short term statistics ${st_stats_filename}"
mlr --csv --from ${st_filename} --oxtab \
    stats1 -f ST -a count,max,min,mean,stddev \
    > ${st_stats_filename}

# set variable to the ST mean (rounded to 2 dec places using bc)
st_mean=$(echo "r($(grep 'ST_mean' ${st_stats_filename} | cut -w -f2), 2)" | bc -lz)
#echo "ST_mean is ${st_mean}"

# plot short term values
echo "Generating graph ${st_graph}"
gnuplot -c radon_st_plot.gnuplot ${st_filename} ${st_mean} > ${st_graph}
