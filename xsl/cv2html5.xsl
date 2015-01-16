<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output doctype-system="about:legacy-compat" indent="yes" />

  <!-- Main template -->
  <xsl:template match="/cv">
    <html>
      <xsl:attribute name="lang"><xsl:value-of select="@lang"/></xsl:attribute>
      <head>
	<meta name="author">
	  <xsl:attribute name="content"><xsl:value-of select="contact/name"/></xsl:attribute>
	</meta>
	<title>Curriculum Vitae - <xsl:value-of select="contact/name"/> - <xsl:value-of select="@lang"/></title> 
	<meta name="description" content="Curriculum Vitae" />
	<meta name="keywords">
	  <xsl:attribute name="content"><xsl:value-of select="contact/keywords"/></xsl:attribute>
	</meta>
	<link rel="stylesheet" type="text/css" href="css/style.css" />
      </head>
      <body>
	<header>
	  <nav>
	    <ul>
	      <li><a href="cv_fr.html">en Français</a></li>
	      <li><a href="cv_en.html">in English</a></li>
	      <li><a href="cv_es.html">en Español</a></li>
	      <li>
		 <a>
		  <xsl:attribute name="href">
		    <xsl:text>../pdf/cv_</xsl:text>
		    <xsl:value-of select="@lang"/>
		    <xsl:text>.pdf</xsl:text>
		  </xsl:attribute>
		  pdf
		</a>
	      </li>
	    </ul>
	  </nav>
	  <h1><xsl:value-of select="contact/name"/></h1>
	</header>

	<!-- There is only one contact case, but it must be parsed differently -->
	<xsl:for-each select="child::contact">
	  <section id="contact">
	    <p id="address">
	      <xsl:call-template name="string-replace-all">
		<xsl:with-param name="text" select="address/text() | address/*" />
	      </xsl:call-template>
	    </p>
	    <p>
	      <xsl:for-each select="phone"><!-- only to change context -->
		<xsl:call-template name="EnTitling"/>
		<xsl:value-of select="."/>
	      </xsl:for-each>
	      <br />
	      <xsl:for-each select="email"><!-- only to change context -->
		<xsl:call-template name="EnTitling"/>
	      </xsl:for-each>
	      <a>
		<xsl:attribute name="href">mailto:<xsl:value-of select="email"/></xsl:attribute>
		<xsl:value-of select="email"/>
	      </a><br />
	      <xsl:for-each select="homepage"><!-- only to change context -->
		<xsl:call-template name="EnTitling"/>
	      </xsl:for-each>
	      <a>
		<xsl:attribute name="href"><xsl:value-of select="homepage"/></xsl:attribute>
		<xsl:value-of select="homepage"/>
	      </a>
	    </p>
	    <img>
	      <xsl:attribute name="src"><xsl:value-of select="photo"/></xsl:attribute>
	      <xsl:attribute name="width"><xsl:value-of select="photo/@width"/></xsl:attribute>
	      <xsl:attribute name="height"><xsl:value-of select="photo/@height"/></xsl:attribute>
	      <xsl:attribute name="alt">Photographie</xsl:attribute>
	    </img>
	  </section>
	</xsl:for-each>

	<!-- Manage all sections -->
	<xsl:for-each select="child::section">
	  <section>
	    <h2><xsl:value-of select="@title"/></h2>
	    <xsl:if test="child::subsection">
	      <xsl:call-template name="WithSubSection"/>
	    </xsl:if>
	    <xsl:call-template name="WithoutSubSection"/>
	  </section>
	</xsl:for-each>

	<footer>
	    <a>
	      <xsl:attribute name="href"><xsl:value-of select="/cv/contact/homepage"/></xsl:attribute>
	      <xsl:value-of select="/cv/contact/homepage"/>
	    </a>
	</footer>

      </body>
    </html>
  </xsl:template>

  <!-- Template for content with subsection(s) -->
  <xsl:template name="WithSubSection">
    <ul>
      <xsl:for-each select="subsection">
      <li>
	<h3><xsl:value-of select="@title"/><span class="right"><xsl:value-of select="@date"/></span></h3>
	<xsl:apply-templates select="item"/>
      </li>
      </xsl:for-each>
      <xsl:apply-templates select="item"/>
    </ul>
  </xsl:template>

  <!-- Template for content without subsection -->
  <xsl:template name="WithoutSubSection">
      <xsl:apply-templates select="item"/>
  </xsl:template>

  <!-- Template for items -->
  <xsl:template match="item">
    <p>
    <xsl:call-template name="EnTitling"/>
    <xsl:copy-of select="text() | *"/>
    </p>
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

      <xsl:when test="contains($text, '[br]')">
        <xsl:value-of select="substring-before($text,'[br]')" />
        <br />
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
