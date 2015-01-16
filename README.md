# CVlyzer

Generates your CV out of simple xml syntax

## Requirements

This package has been sucessfully tested on a Debian/Ubuntu Linux OS, everything should work fine assuming you installed these libraries:

	# latex
	sudo apt-get install texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-lang-all

	# pdf
	sudo apt-get install pdflatex

	# xslt
	sudo apt-get install xsltproc

## Executing

A very simple `Makefile` is provided, modify the sources under `./src` and do:

	make

Magic happens, in your `./dest` file a surprise is waiting for you.

## Credits

Thanks to Jason Blevins &lt;jrblevin@sdf.lonestar.org&gt; for its [LaTeX template](http://jblevins.org/projects/cv-template/).

## Licence

GNU GPL V2 applies here, see LICENCE file.