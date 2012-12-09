#!/bin/bash

#     This file is a bash script to convert an image to .eps.gz (with additional .bb 
# 	file for the bounding box information). The reason I wrote this script
#     is because most conferences (at least in graphics/visualization areas) 
#     recommend compiling .tex file with LaTeX, which supports only .eps. Using 
#     .eps for rasterized images (.JPG or .PNG), nevertheless, can be space 
#     consuming. Although it is possible to use .eps.gz, additional setup is needed.

#     The following is the  procedure to use .eps.gz. My script is for the last three steps: 
#         1.Install grep.
#         2.Add the following rule at the beginning of the LaTeX files after the library graphix is included:
#         \DeclareGraphicsExtensions{.eps,.eps.gz}
#         \DeclareGraphicsRule{.eps.gz}{eps}{.bb}{}
#         3.Convert the image, for instance, img.png to .eps
#         convert img.png img.eps
#         4.Extract the BoundingBox
#         grep "%%BoundingBox" img.eps > img.bb
#         5.Compress the .eps file
#         gzip -9 img.eps

#     With this script, the later 3 steps can be done by a single command:
# 	    png2epsgz.sh img.png
    
#     Note that my program can also work for .eps file:
    
#     Teng-Yok Lee 
#     recheliu@gmail.com

E_BADARGS=65
if [ $# -ne 1 ]
then
  echo "Usage: `basename $0` <img_filename>"
  exit $E_BADARGS
fi

# save the 1st argument to p
p=$1

# extract the extension to e
e=${p##*.}

# extract the filename to n
n=${p%.*}

echo $n
echo $e

# conver the file to .eps if the extension is not .eps
if [ ! "$e" == "eps" ] 
then
	convert $p $n.eps
fi

grep "%%BoundingBox" $n.eps > $n.bb
gzip -9 -f $n.eps
echo "${p} is converted to ${n}.eps.gz"

