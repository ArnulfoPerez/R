install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'),type = "source")
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()