# Copyright 2012 Jeffrey Kegler
# This file is part of Marpa::R2.  Marpa::R2 is free software: you can
# redistribute it and/or modify it under the terms of the GNU Lesser
# General Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# Marpa::R2 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser
# General Public License along with Marpa::R2.  If not, see
# http://www.gnu.org/licenses/.

# See below for the list Debian packages required to 'make' this

.phony: all clean recce-indexes full travis

LATEX = pdflatex
MAKEINDEX = makeindex

.SUFFIXES:
.SUFFIXES: .pdf .ltx .ind .idx .ilg

all: recce.pdf

full: ah2002_notes.pdf recce.pdf finite.pdf

travis:
	$(LATEX) recce.ltx
	$(LATEX) recce.ltx
	$(LATEX) recce.ltx
	$(LATEX) recce.ltx
	$(LATEX) recce.ltx

clean:
	rm recce.out recce.aux recce.toc recce.tdo recce.loe \
	    recce.loa recce.lot recce.pdf
	for ix in general notation lemmas; do \
	    rm -f recce-$$ix.ind recce-$$ix.ilg; \
	done

recce.pdf: recce.ltx
	$(MAKE) recce-indexes
	$(LATEX) $?

recce-indexes:
	for ix in general lemmas notation; do \
	  if ! test -f recce-$$ix.idx ; then touch recce-$$ix.idx; fi; \
	  $(MAKEINDEX) -t recce-$$ix.ilg -o recce-$$ix.ind recce-$$ix.idx; \
	done

finite.pdf: finite.ltx
	$(LATEX) $?

ah2002_notes.pdf: ah2002_notes.ltx
	$(LATEX) $?

# Five years outdated, but anyway this is a start
# Requires these Debian packages (as of Thu Sep 17 10:11:18 PDT 2015)
# ii  texlive-base                    2014.20141024-2      all                  TeX Live: Essential programs and files
# ii  texlive-binaries                2014.20140926.35254- amd64                Binaries for TeX Live
# ii  texlive-extra-utils             2014.20141024-1      all                  TeX Live: TeX auxiliary programs
# ii  texlive-font-utils              2014.20141024-1      all                  TeX Live: Graphics and font utilities
# ii  texlive-fonts-extra             2014.20141024-1      all                  TeX Live: Additional fonts
# ii  texlive-fonts-extra-doc         2014.20141024-1      all                  TeX Live: Documentation files for texlive-fonts-extra
# ii  texlive-fonts-recommended       2014.20141024-2      all                  TeX Live: Recommended fonts
# ii  texlive-fonts-recommended-doc   2014.20141024-2      all                  TeX Live: Documentation files for texlive-fonts-recommended
# ii  texlive-generic-recommended     2014.20141024-2      all                  TeX Live: Generic recommended packages
# ii  texlive-lang-greek              2014.20141024-1      all                  TeX Live: Greek
# ii  texlive-latex-base              2014.20141024-2      all                  TeX Live: LaTeX fundamental packages
# ii  texlive-latex-base-doc          2014.20141024-2      all                  TeX Live: Documentation files for texlive-latex-base
# ii  texlive-latex-extra             2014.20141024-1      all                  TeX Live: LaTeX additional packages
# ii  texlive-latex-extra-doc         2014.20141024-1      all                  TeX Live: Documentation files for texlive-latex-extra
# ii  texlive-latex-recommended       2014.20141024-2      all                  TeX Live: LaTeX recommended packages
# ii  texlive-latex-recommended-doc   2014.20141024-2      all                  TeX Live: Documentation files for texlive-latex-recommended
# ii  texlive-pictures                2014.20141024-2      all                  TeX Live: Graphics, pictures, diagrams
# ii  texlive-pictures-doc            2014.20141024-2      all                  TeX Live: Documentation files for texlive-pictures
# ii  texlive-pstricks                2014.20141024-1      all                  TeX Live: PSTricks
# ii  texlive-pstricks-doc            2014.20141024-1      all                  TeX Live: Documentation files for texlive-pstricks
# ii  texlive-science                 2014.20141024-1      all                  TeX Live: Natural and computer sciences
# ii  texlive-science-doc             2014.20141024-1      all                  TeX Live: Documentation files for texlive-science
