# Give the plot a title
set title "Reactance Nomograph"

set style line 12 lc rgb '#aa00aa' lt 1 lw 0.5
set style line 13 lc rgb '#ffaadd' lt 1 lw 0.5

# for help search 'format specifier' at pag.169
set format x2 '%.s %cHz' 
set format y  '%.s %cΩ' 

# set logscale xx2y
set logscale x2
set logscale x
set logscale y

set ytics 	10 textcolor '#aa00aa'rotate by 0 
set mytics	10
set x2tics 	10 textcolor '#aa00aa'
set mx2tics 10 

set x2range [1:1e10] 
show x2range

set xrange 	[1:1e10]
set yrange 	[1e-2:1e6]
#set xlabel "Frequency (Hz)"
#set ylabel "Impedance (Ohms)"

unset xtics 
unset grid
set grid  x2tics mx2tics  ytics mytics back ls 12, ls 13
show grid

# dimension of plot in x and y (pixels)
# for constant height make ydim constant
ydim = 800
xdim = 1100

set bmargin 5
set tmargin 0.1
set lmargin 12.0
set rmargin 0.1


# Plot Inductance on Y1 axis
do for [i=0:7] {
	j = 0.01*(10**i)
	bfit = gprintf("%.s %cH",j)
	set label bfit at 1,j*6 right rotate by 45 offset -1,0
}
# Plot Inductance on X1 axis
do for [i=0:9] {
	j = (10**i)
	bfit = gprintf("%.s %cH",0.001/j)
	set label bfit at j*1.4,0.01 right rotate by 45 offset 0,-1
}
# Plot Capacitance on X1 axis
do for [i=0:9] {
	j = (10**i)
	bfit = gprintf("%.s %cF",10.0/j)
	set label bfit at j*1.8,0.01 left rotate by -45 offset 0,-1
}
# Plot Capacitance on Y2 axis
do for [i=0:7] {
	j = 0.01*(10**i)
	bfit = gprintf("%.s %cF",0.01/(j*10**9))
	set label bfit at 10**10,j*1.5 left rotate by -45 offset 1,0
}

#--------------------------------------- Create release folder
system "mkdir -p release"

#--------------------------------------- PLOT to PNG
set terminal png font "sans,8" size 1169.3,826.8
set size 0.9,0.9
show terminal
set output "./release/impedance_plot.png"

plot for [j=1:20] for [i=1:10]  1/(100*x*6.28*i*(0.1**j)) lw 0.1 lc rgb 'black' notitle axis x2y1, \
	 for [j=1:20] for [i=1:10]	(1000000*x*6.28*i*(0.1**j)) lw 0.1 lc rgb 'black' notitle axis x2y1


#--------------------------------------- PLOT to SVG
set terminal svg size xdim,ydim
show terminal
set output "./release/impedance_plot.svg"

plot for [j=1:20] for [i=1:10] 1/(100*x*6.28*i*(0.1**j)) lw 0.1 lc rgb 'black' notitle axis x2y1, \
	for [j=1:20] for [i=1:10]	(1000000*x*6.28*i*(0.1**j)) lw 0.1 lc rgb 'black' notitle axis x2y1

#--------------------------------------- PLOT to PDF
set terminal pdfcairo font "sans,10" color  lw 0.1 size 11.693,8.268
show terminal
set output "./release/impedance_plot.pdf"

plot for [j=1:20] for [i=1:10] 1/(100*x*6.28*i*(0.1**j)) lw 0.1 lc rgb 'black' notitle axis x2y1, \
	for [j=1:20] for [i=1:10]	(1000000*x*6.28*i*(0.1**j)) lw 0.1 lc rgb 'black' notitle axis x2y1



