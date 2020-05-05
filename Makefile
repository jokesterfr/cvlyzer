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
CP=cp -rfL

LATEX=xelatex
XSLT=xsltproc

AUTHOR=clement_desiles
YEAR=`date +%Y`
SUFFIX=_${AUTHOR}_${YEAR}

# localize the current date
date_en="$(./getLocaleDate.js en)"
date_fr="$(./getLocaleDate.js fr)"
date_es="$(./getLocaleDate.js es)"
date_it="$(./getLocaleDate.js it)"

all: en fr es it tidy

en: $(DIST_PDF) $(DIST_HTML) update $(SRC)/cv_en.xml $(XSL)/cv2html5.xsl $(XSL)/cv2latex.xsl
	$(XSLT) -stringparam pubdate ${date_en} $(XSL)/cv2latex.xsl $(SRC)/cv_en.xml > $(DIST_PDF)/cv_en${SUFFIX}.tex
	$(LATEX) -output-directory=$(DIST_PDF) $(DIST_PDF)/cv_en${SUFFIX}.tex
	$(XSLT) -stringparam pubdate ${date_en} $(XSL)/cv2html5.xsl $(SRC)/cv_en.xml > $(DIST_HTML)/cv_en.html
	$(RM) $(DIST_PDF)/cv_en${SUFFIX}.log $(DIST_PDF)/cv_en${SUFFIX}.out $(DIST_PDF)/cv_en${SUFFIX}.aux $(DIST_PDF)/cv_en${SUFFIX}.tex

es: $(DIST_PDF) $(DIST_HTML) update $(SRC)/cv_es.xml $(XSL)/cv2html5.xsl $(XSL)/cv2latex.xsl
	$(XSLT) -stringparam pubdate ${date_es} $(XSL)/cv2latex.xsl $(SRC)/cv_es.xml > $(DIST_PDF)/cv_es${SUFFIX}.tex
	$(LATEX) -output-directory=$(DIST_PDF) $(DIST_PDF)/cv_es${SUFFIX}.tex
	$(XSLT) -stringparam pubdate ${date_es} $(XSL)/cv2html5.xsl $(SRC)/cv_es.xml > $(DIST_HTML)/cv_es.html
	$(RM) $(DIST_PDF)/cv_es${SUFFIX}.log $(DIST_PDF)/cv_es${SUFFIX}.out $(DIST_PDF)/cv_es${SUFFIX}.aux $(DIST_PDF)/cv_es${SUFFIX}.tex

fr: $(DIST_PDF) $(DIST_HTML) update $(SRC)/cv_fr.xml $(XSL)/cv2html5.xsl $(XSL)/cv2latex.xsl
	$(XSLT) -stringparam pubdate ${date_fr} $(XSL)/cv2latex.xsl $(SRC)/cv_fr.xml > $(DIST_PDF)/cv_fr${SUFFIX}.tex
	$(LATEX) -output-directory=$(DIST_PDF) $(DIST_PDF)/cv_fr${SUFFIX}.tex
	$(XSLT) -stringparam pubdate ${date_fr} $(XSL)/cv2html5.xsl $(SRC)/cv_fr.xml > $(DIST_HTML)/cv_fr.html
	$(RM) $(DIST_PDF)/cv_fr${SUFFIX}.log $(DIST_PDF)/cv_fr${SUFFIX}.out $(DIST_PDF)/cv_fr${SUFFIX}.aux $(DIST_PDF)/cv_fr${SUFFIX}.tex

it: $(DIST_PDF) $(DIST_HTML) update $(SRC)/cv_it.xml $(XSL)/cv2html5.xsl $(XSL)/cv2latex.xsl
	$(XSLT) -stringparam pubdate ${date_it} $(XSL)/cv2latex.xsl $(SRC)/cv_it.xml > $(DIST_PDF)/cv_it${SUFFIX}.tex
	$(LATEX) -output-directory=$(DIST_PDF) $(DIST_PDF)/cv_it${SUFFIX}.tex
	$(XSLT) -stringparam pubdate ${date_it} $(XSL)/cv2html5.xsl $(SRC)/cv_it.xml > $(DIST_HTML)/cv_it.html
	$(RM) $(DIST_PDF)/cv_it${SUFFIX}.log $(DIST_PDF)/cv_it${SUFFIX}.out $(DIST_PDF)/cv_it${SUFFIX}.aux $(DIST_PDF)/cv_it${SUFFIX}.tex

tidy:
	tidy -w 0 -q -m -i $(DIST_HTML)/*.html || true

$(DIST_PDF):
	$(MKDIR) $(DIST_PDF)

$(DIST_HTML):
	$(MKDIR) $(DIST_HTML)

update:
	$(CP) $(CSS)/ $(IMG)/ $(DIST_HTML)

clean:
	$(RM) $(DIST_PDF) $(DIST_HTML)

show-fr:
	xdg-open $(DIST_HTML)/cv_fr.html
	xdg-open $(DIST_PDF)/cv_fr${SUFFIX}.pdf

show-en:
	xdg-open $(DIST_HTML)/cv_en.html
	xdg-open $(DIST_PDF)/cv_en${SUFFIX}.pdf

show-es:
	xdg-open $(DIST_HTML)/cv_es.html
	xdg-open $(DIST_PDF)/cv_es${SUFFIX}.pdf
