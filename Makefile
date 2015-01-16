#
#    CVlyser  Copyright (C) 2015 - Clément Désiles - main@jokester.fr
#
#    Commands to manage my curriculum vitae in different languages
#    requirements: xslt, latex
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
SRC=src
XSL=xsl
IMG=img
CSS=css
DIST_HTML=dist/html
DIST_PDF=dist/pdf

RM=rm -rf
MKDIR=mkdir -p
CP=cp -rf

LATEX=pdflatex
XSLT=xsltproc
PDFVIEWER=okular
BROWSER=firefox

all: en es fr
	$(RM) $(DIST_PDF)/*.log && $(RM) $(DIST_PDF)/*.out && $(RM) $(DIST_PDF)/*.aux && $(RM) $(DIST_PDF)/*.tex

en: $(DIST_PDF) $(DIST_HTML) update $(SRC)/cv_en.xml $(XSL)/cv2html5.xsl $(XSL)/cv2latex.xsl
	$(XSLT) $(XSL)/cv2latex.xsl $(SRC)/cv_en.xml > $(DIST_PDF)/cv_en.tex
	$(LATEX) -output-directory=$(DIST_PDF) $(DIST_PDF)/cv_en.tex 
	$(XSLT) $(XSL)/cv2html5.xsl $(SRC)/cv_en.xml > $(DIST_HTML)/cv_en.html

es: $(DIST_PDF) $(DIST_HTML) update $(SRC)/cv_es.xml $(XSL)/cv2html5.xsl $(XSL)/cv2latex.xsl
	$(XSLT) $(XSL)/cv2latex.xsl $(SRC)/cv_es.xml > $(DIST_PDF)/cv_es.tex
	$(LATEX) -output-directory=$(DIST_PDF) $(DIST_PDF)/cv_es.tex 
	$(XSLT) $(XSL)/cv2html5.xsl $(SRC)/cv_es.xml > $(DIST_HTML)/cv_es.html

fr: $(DIST_PDF) $(DIST_HTML) update $(SRC)/cv_fr.xml $(XSL)/cv2html5.xsl $(XSL)/cv2latex.xsl
	$(XSLT) $(XSL)/cv2latex.xsl $(SRC)/cv_fr.xml > $(DIST_PDF)/cv_fr.tex
	$(LATEX) -output-directory=$(DIST_PDF) $(DIST_PDF)/cv_fr.tex 
	$(XSLT) $(XSL)/cv2html5.xsl $(SRC)/cv_fr.xml > $(DIST_HTML)/cv_fr.html

$(DIST_PDF):
	$(MKDIR) $(DIST_PDF)

$(DIST_HTML):
	$(MKDIR) $(DIST_HTML)

update:
	$(CP) $(CSS)/ $(IMG)/ $(DIST_HTML)

clean-log:
	$(RM) $(DIST_PDF)/*.log && $(RM) $(DIST_PDF)/*.out && $(RM) $(DIST_PDF)/*.aux && $(DIST_PDF)/*.tex

clean:	
	$(RM) $(DIST_PDF)
	$(RM) $(DIST_HTML)

show-fr:
	$(BROWSER) $(DIST_HTML)/cv_fr.html
	$(PDFVIEWER) $(DIST_PDF)/cv_fr.pdf

show-en:
	$(BROWSER) $(DIST_HTML)/cv_en.html
	$(PDFVIEWER) $(DIST_PDF)/cv_en.pdf

show-es:
	$(BROWSER) $(DIST_HTML)/cv_es.html
	$(PDFVIEWER) $(DIST_PDF)/cv_es.pdf
