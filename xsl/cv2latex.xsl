<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="utf-8" media-type="text/plain"/>

  <!-- Main template -->
  <xsl:template match="/cv">
    % LaTeX Curriculum Vitae Template
    %
    % Copyright (C) 2004-2009 Jason Blevins &lt;jrblevin@sdf.lonestar.org&gt;
    % http://jblevins.org/projects/cv-template/
    %
    % You may use use this document as a template to create your own CV
    % and you may redistribute the source code freely. No attribution is
    % required in any resulting documents. I do ask that you please leave
    % this notice and the above URL in the source code if you choose to
    % redistribute this file.
    %
    % Copyright (C) 2012-2020 Clément Désiles &lt;jobs@jokester.fr&gt;
    % https://github.com/jokesterfr/cvlyzer
    % For my rework licensed under MIT.

    \documentclass[letterpaper]{article}
    \usepackage[utf8x]{inputenc}
    \usepackage{fontspec}
    \usepackage{scalefnt}
    \setmainfont[Scale=0.9]{Roboto}
    \setmonofont[Scale=0.8]{DejaVu Sans Mono}
    <!-- \setmainfont{Liberation Sans} -->
    <xsl:choose>
      <xsl:when test="@lang = 'fr'">
        \usepackage[french]{babel}
        \frenchsetup{ReduceListSpacing=false,CompactItemize=false}
        \def\lastupdated{Dernière mise à jour : \today}
      </xsl:when>
      <xsl:when test="@lang = 'es'">
        \usepackage[english,spanish]{babel}
        \def\lastupdated{Últimas actualización : \today}
      </xsl:when>
      <xsl:when test="@lang = 'it'">
        \usepackage[italian]{babel}
        \def\lastupdated{Ultimo aggiornamento: \today}
      </xsl:when>
      <xsl:when test="@lang = 'de'">
        \usepackage[germanb]{babel}
        \def\lastupdated{Letzte Aktualisierung: \today}
      </xsl:when>
      <xsl:otherwise>
        \usepackage[english]{babel}
        \def\lastupdated{Last updated: \today}
      </xsl:otherwise>
    </xsl:choose>

    % Emoji handling
    \usepackage{newunicodechar}
    \newunicodechar{👤}{{\raisebox{-0.2em}{\includegraphics[height=1em]{assets/pdf/bust-in-silhouette_1f464}}}}
    \newunicodechar{📧}{{\raisebox{-0.2em}{\includegraphics[height=1em]{assets/pdf/e-mail-symbol_1f4e7.png}}}}
    \newunicodechar{📞}{{\raisebox{-0.2em}{\includegraphics[height=1em]{assets/pdf/telephone-receiver_1f4de.png}}}}
    \newunicodechar{🌐}{{\raisebox{-0.2em}{\includegraphics[height=1em]{assets/pdf/globe-with-meridians_1f310.png}}}}

    \newunicodechar{🧗}{{\raisebox{-0.2em}{\includegraphics[height=1em]{assets/pdf/person-climbing_1f9d7.png}}}}
    \newunicodechar{🎵}{{\raisebox{-0.2em}{\includegraphics[height=1em]{assets/pdf/musical-note_1f3b5.png}}}}
    \newunicodechar{🧳}{{\raisebox{-0.2em}{\includegraphics[height=1em]{assets/pdf/luggage_1f9f3.png}}}}

    \usepackage{textcomp}
    \usepackage[usenames]{color}
    \usepackage{graphicx}
    \usepackage{hyperref}
    \usepackage{geometry}
    \usepackage{wrapfig}
    \usepackage[absolute,overlay]{textpos}

    % Line height
    \linespread{0.98}

    % Set your name here
    \def\name{<xsl:value-of select="contact/name"/>}

    % The job title
    \def\title{<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="contact/title" /></xsl:call-template>}

    % Links color
    \definecolor{myurlcolor}{rgb}{0,0.06,0.35}

    % make "C++" look pretty when used in text by touching up the plus signs
    \newcommand{\CPP}
    {C\nolinebreak[4]\hspace{-.05em}\raisebox{.22ex}{\footnotesize\bf ++}}

    % Replace this with a link to your CV if you like, or set it empty
    % (as in \def\footerlink{}) to remove the link in the footer:
    \def\footerlink{<xsl:if test="contact/homepage"><xsl:value-of select="contact/homepage"/></xsl:if>}

    % The following metadata will show up in the PDF properties
    \hypersetup{
      colorlinks = true,
      urlcolor = myurlcolor,
      pdfauthor = {\name},
      pdfkeywords = {<xsl:value-of select="contact/keywords"/>},
      pdftitle = {\name: Curriculum Vitae},
      pdfsubject = {Curriculum Vitae},
      pdfpagemode = UseNone
    }

    \geometry{
      body={7.5in, 9.9in},
      left=0.5in,
      top=0.6in
    }

    % Customize page headers
    \pagestyle{myheadings}
    \markright{\name}
    \thispagestyle{empty}

    % Custom section fonts
    \usepackage{sectsty}
    \sectionfont{\ttfamily\mdseries\sffamily\Large}
    \subsectionfont{\ttfamily\mdseries\scshape\large}

    % Don't indent paragraphs.
    \setlength\parindent{0em}

    % Make lists without bullets
    \renewenvironment{itemize}{
      \begin{list}{}{
        \setlength{\leftmargin}{1.5em}
      }
    }{
      \end{list}
    }

    % Prepare background picture insertion
    \usepackage{eso-pic}
    \newcommand\BackgroundPic{%
      \put(0,0){%
        \parbox[b][\paperheight]{\paperwidth}{%
          \includegraphics[width=\paperwidth,height=\paperheight,%
          keepaspectratio]{assets/pdf/background.pdf}%
          \vfill
        }
      }
    }

    \begin{document}
    \AddToShipoutPicture*{\BackgroundPic}

    % Place name and title at top left of the page
    \begin{textblock*}{5cm}(1cm,1cm)
      { \huge \scalefont{1.1} \color{white} \name }
    \end{textblock*}

    \begin{textblock*}{15cm}(1cm,2cm)
      { \Large \color{white} \title }
    \end{textblock*}

    \hfill
    \vspace{4em}

    <xsl:for-each select="child::contact">

      <xsl:if test="photo">
        <!-- source: https://en.wikibooks.org/wiki/LaTeX/Picture -->
        \begin{picture}(0,0)(100,100)
         \put(540,70){\hbox{\includegraphics[width=100pt]{<xsl:value-of select="photo"/>}}}
        \end{picture}
      </xsl:if>
      \begin{tabular}{ll}
        <!-- Info -->
        \scalefont{1.1}👤 <xsl:value-of select="info" /> \hspace{0.4cm} &amp;

        <!-- Email -->
        \scalefont{1.1}📧 \href{mailto:<xsl:value-of select="email"/>}{\tt <xsl:value-of select="email"/>} \\[5pt]

        <!-- Phone -->
        \scalefont{1.1}📞 <xsl:value-of select="phone" /> \hspace{0.4cm} &amp;

        <!-- Homepage -->
        <xsl:if test="homepage">
          \scalefont{1.1}🌐 \href{mailto:<xsl:value-of select="homepage"/>}{\tt <xsl:value-of select="homepage"/>} \\
        </xsl:if>
      \end{tabular}
      \vspace{0.2cm}
    </xsl:for-each>

    <!-- Manage all sections -->
    <xsl:for-each select="child::section">
      \section*{<xsl:value-of select="@title"/>}
      \begin{itemize}
      <xsl:if test="child::subsection">
        <xsl:call-template name="WithSubSection"/>
      </xsl:if>
      <xsl:call-template name="WithoutSubSection"/>
      \end{itemize}
    </xsl:for-each>

    \vfill
    \bigskip

    % Footer
    \begin{center}
      \begin{footnotesize}
        \lastupdated \\
        <xsl:if test="contact/homepage">
         🌐 \href{\footerlink}{\texttt{\footerlink}}
       </xsl:if>
      \end{footnotesize}
    \end{center}

    \end{document}
  </xsl:template>

  <!-- Template for content with subsection(s) -->
  <xsl:template name="WithSubSection">
    <xsl:for-each select="subsection">
      \item \textbf{
        <xsl:value-of select="@title"/> \hfill \em <xsl:value-of select="@date"/>
      }
      <xsl:choose>
        <xsl:when test="@class='table'">
          \begin{tabular}{ll}
            \\[-0.75em]
            <xsl:apply-templates select="item"/>
          \end{tabular}
        </xsl:when>
        <xsl:otherwise>
          \begin{itemize}
            <xsl:apply-templates select="item"/>
          \end{itemize}
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates select="item"/>
  </xsl:template>

  <!-- Template for content without subsection -->
  <xsl:template name="WithoutSubSection">
    <xsl:apply-templates select="item"/>
  </xsl:template>

  <!-- Template for list items -->
  <xsl:template match="item">
    \item
    <xsl:copy>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <!-- Template for table items -->
  <xsl:template match="item[../@class='table']">
    <xsl:choose>
      <xsl:when test="position() mod 2 = 0">
        &#8226; <xsl:copy><xsl:apply-templates /></xsl:copy>\\[-0.75em] \\
      </xsl:when>
      <xsl:otherwise>
        &#8226; <xsl:copy><xsl:apply-templates /></xsl:copy> &amp;
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Template for br -->
  <xsl:template match="br">
    <xsl:text>\\</xsl:text><xsl:apply-templates />
  </xsl:template>

  <!-- Template for definitions -->
  <xsl:template match="dfn">
    <xsl:text>\texttt{</xsl:text>
        <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!-- Template for em -->
  <xsl:template match="em">
    <xsl:text>\textsl{</xsl:text>
        <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!-- Template for a -->
  <xsl:template match="a">
    <xsl:text>\href{</xsl:text>
    <xsl:value-of select="@href"/>
    <xsl:text>}{</xsl:text>
      <xsl:apply-templates />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="item//text()">
    <!--<xsl:copy-of select="." />-->
    <!-- Replace C++ expression -->
    <xsl:call-template name="string-replace-all">
      <xsl:with-param name="text" select="." />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="getTwoDots">
    <xsl:if test="/cv/@lang!='en'"><xsl:text> </xsl:text></xsl:if>:<xsl:text> </xsl:text>
  </xsl:template>

 <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:choose>

      <xsl:when test="contains($text, '&amp;')">
        <xsl:value-of select="substring-before($text,'&amp;')" />
        <xsl:value-of select="'\&amp;'" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,'&amp;')" />
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="contains($text, 'C#')">
        <xsl:value-of select="substring-before($text,'C#')" />
        <xsl:value-of select="'C\#'" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,'C#')" />
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="contains($text, 'LaTeX')">
        <xsl:value-of select="substring-before($text,'LaTeX')" />
        <xsl:value-of select="'\LaTeX'" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,'LaTeX')" />
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="contains($text, 'C++')">
        <xsl:value-of select="substring-before($text,'C++')" />
        <xsl:value-of select="'\CPP'" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,'C++')" />
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="contains($text, '°')">
        <xsl:value-of select="substring-before($text,'°')" />
        <xsl:value-of select="'\textdegree'" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,'°')" />
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="contains($text, '[br]')">
        <xsl:value-of select="substring-before($text,'[br]')" />
        <xsl:value-of select="'\\'" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,'[br]')" />
        </xsl:call-template>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
