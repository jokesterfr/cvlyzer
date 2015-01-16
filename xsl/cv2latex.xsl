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

    \documentclass[letterpaper]{article}
    \usepackage[utf8]{inputenc}
    \usepackage[T1]{fontenc}
    <xsl:choose>
      <xsl:when test="@lang = 'fr'">
	\usepackage[frenchb]{babel}
	\frenchbsetup{ReduceListSpacing=false,CompactItemize=false} 
	\def\lastupdated{Dernière mise à jour : \today}
      </xsl:when>
      <xsl:when test="@lang = 'es'">
	\usepackage[english,spanish]{babel}
	\def\lastupdated{Últimas actualización : \today}
      </xsl:when>
      <xsl:when test="@lang = 'it'">
	\usepackage[italianb]{babel}
      </xsl:when>
      <xsl:when test="@lang = 'de'">
	\usepackage[germanb]{babel}
      </xsl:when>
      <xsl:otherwise>
	\usepackage[english]{babel}
	\def\lastupdated{Last updated: \today}
      </xsl:otherwise>
    </xsl:choose> 
    \usepackage{textcomp} 
    \DeclareUnicodeCharacter{B0}{\textdegree}
    \usepackage[usenames]{color}
    \usepackage{graphicx}
    \usepackage{wrapfig}
    \usepackage{hyperref}
    \usepackage{geometry}

    % Fonts
    \usepackage[T1]{fontenc}
    \usepackage{charter}

    % Set your name here
    \def\name{<xsl:value-of select="contact/name"/>}

    \definecolor{myurlcolor}{rgb}{0,0.06,0.35}

    % make "C++" look pretty when used in text by touching up the plus signs
    \newcommand{\CPP}
    {C\nolinebreak[4]\hspace{-.05em}\raisebox{.22ex}{\footnotesize\bf ++}}

    % Replace this with a link to your CV if you like, or set it empty
    % (as in \def\footerlink{}) to remove the link in the footer:
    \def\footerlink{<xsl:value-of select="contact/homepage"/>}

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
      body={6.5in, 8.5in},
      left=1.0in,
      top=1.0in
    }

    % Customize page headers
    \pagestyle{myheadings}
    \markright{\name}
    \thispagestyle{empty}

    % Custom section fonts
    \usepackage{sectsty}
    \sectionfont{\ttfamily\bfseries\Large}
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

    \begin{document}

    % Place name at left
    {\huge \name}

    \vspace{0.25in}

    <xsl:for-each select="child::contact">
      \begin{minipage}{0.45\linewidth}
      <xsl:call-template name="string-replace-all">
	<xsl:with-param name="text" select="address/text() | address/*" />
      </xsl:call-template>
      \end{minipage}
      \begin{minipage}{0.45\linewidth}
	\begin{tabular}{ll}
	  <xsl:for-each select="phone"><!-- only to change context -->
	    <xsl:call-template name="EnTitling"/>
	    <xsl:value-of select="."/>
	  </xsl:for-each> \\
	  <xsl:for-each select="email"><!-- only to change context -->
	    <xsl:call-template name="EnTitling"/>
	  </xsl:for-each>
	  \href{mailto:<xsl:value-of select="email"/>}{\tt <xsl:value-of select="email"/>} \\
	  <xsl:for-each select="homepage"><!-- only to change context -->
	    <xsl:call-template name="EnTitling"/>
	  </xsl:for-each>
	  \href{mailto:<xsl:value-of select="homepage"/>}{\tt <xsl:value-of select="homepage"/>} \\
	\end{tabular}
      \end{minipage}

      \begin{wrapfigure}[0]{r}{80pt}
	\includegraphics[width=80pt]{<xsl:value-of select="photo"/>}
      \end{wrapfigure}
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
	\href{\footerlink}{\texttt{\footerlink}}
      \end{footnotesize}
    \end{center}

    \end{document}
  </xsl:template>

  <!-- Template for content with subsection(s) -->
  <xsl:template name="WithSubSection">
      <xsl:for-each select="subsection">
	\item \textbf{<xsl:value-of select="@title"/> \hfill \em <xsl:value-of select="@date"/>}
	\begin{itemize}<xsl:apply-templates select="item"/>\end{itemize}
      </xsl:for-each>
      <xsl:apply-templates select="item"/>
  </xsl:template>

  <!-- Template for content without subsection -->
  <xsl:template name="WithoutSubSection">
      <xsl:apply-templates select="item"/>
  </xsl:template>

  <!-- Template for items -->
  <xsl:template match="item">
    \item <xsl:call-template name="EnTitling"/>
    <xsl:copy>
      <!--<xsl:copy-of select="@*" />-->
      <xsl:apply-templates />
    </xsl:copy>
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

  <!-- Template to display the title like "bla: " in english, either "bla : " -->
  <xsl:template name="EnTitling">
    <xsl:if test="./@title != ''">
      <xsl:value-of select="./@title"/><xsl:if test="/cv/@lang!='en'"><xsl:text> </xsl:text></xsl:if>:<xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

 <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:choose>

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
