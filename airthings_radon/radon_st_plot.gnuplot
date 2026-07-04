# radon data ST plot
# x data is date & time in ISO8601 format
# y data is ST data

# command line - ARG1 is CSV file, ARG2 is short term mean

# output format
set terminal pdf size 20,10 enhanced font ",40"

# global formats
set timefmt "%Y-%m-%dT%H:%M"

# datafile
set datafile separator comma

# define the background grid
set grid linecolor rgb '#202020' linetype 0 linewidth 1
set border back 3 linecolor rgb '#000000' linetype 1
set tics nomirror in
set grid ytics xtics

# define the style of each line
set style line 1 dashtype 1 linecolor rgb '#0072bd' linewidth 3
set style line 2 dashtype 2 linecolor rgb '#7f7f7f' linewidth 3

# x data & axis
set xdata time
set xtics timedate
# Mon Yr (MMM YY)
set xtics format "%b %y"
set xlabel "Month / Year"

# y data & axis
set ylabel "pCi/L"

# plot
plot \
    ARG1 using "recorded":"ST" with lines linestyle 1 title "Short Term", \
    '' using 1:(@ARG2) with lines linestyle 2 title "Short Term Avg (" . ARG2 . ")"
