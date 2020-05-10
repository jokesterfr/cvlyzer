<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output doctype-system="about:legacy-compat" indent="yes" />
  <xsl:param name="pubdate" select="YYYYMMDD" />

  <!-- Main template -->
  <xsl:template match="/cv">
    <html>
      <xsl:attribute name="lang">
        <xsl:value-of select="@lang" />
      </xsl:attribute>
      <head>
        <meta name="author">
          <xsl:attribute name="content">
            <xsl:value-of select="contact/name" />
          </xsl:attribute>
        </meta>
        <title>Curriculum Vitae -
          <xsl:value-of select="contact/name" /> -
          <xsl:value-of select="contact/title" /> -
          <xsl:value-of select="@lang" />
        </title>
        <meta name="description" content="Curriculum Vitae" />
        <meta name="keywords">
          <xsl:attribute name="content">
            <xsl:value-of select="contact/keywords" />
          </xsl:attribute>
        </meta>
        <link rel="stylesheet" type="text/css" href="css/style.css" />
      </head>
      <body>
        <svg
           id="green-layout"
           xmlns="http://www.w3.org/2000/svg"
           xmlns:svg="http://www.w3.org/2000/svg"
           viewBox="0 0 200 30"
           width="100%"
           height="150px"
           preserveAspectRatio="none"
           version="1.1">
          <defs id="green-layout" />
          <g
             id="layer1"
             transform="translate(0,-266.98752)">
            <rect
               style="opacity:1;vector-effect:none;fill:#5fc28c;fill-opacity:1;stroke:none;stroke-width:0.22015916px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
               id="rect5188"
               width="200"
               height="30"
               x="0"
               y="267" />
            <path
               style="fill:#45a36f;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.26458332px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
               d="M 46.504896,267.06581 0,267.00001 V 297 h 200 z"
               id="path5192" />
            <path
               style="fill:#348656;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.26458332px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
               d="M 200,297 54.317782,266.98752 31.324258,267.06581 Z"
               id="path5190" />
          </g>
        </svg>
        <header>
          <nav>
            <ul id="locale-selector">
              <li><a href="cv_fr.html">en Français</a></li>
              <li><a href="cv_en.html">in English</a></li>
              <li><a href="cv_es.html">en Español</a></li>
              <li><a href="cv_it.html">in Italiano</a></li>
            </ul>
          </nav>
          <nav class="right">
            <ul>
              <li>
                <a class="pdf-download" title="Fichier PDF">
                  <xsl:attribute name="href">
                    <xsl:text>./pdf/cv_</xsl:text>
                    <xsl:value-of select="@lang" />
                    <xsl:value-of select="@suffix" />
                    <xsl:text>.pdf</xsl:text>
                  </xsl:attribute>
                </a>
              </li>
            </ul>
          </nav>
          <h1>
            <xsl:value-of select="contact/name" />
          </h1>
          <h1 class="subtitle">
            <xsl:value-of select="contact/title" />
          </h1>
        </header>
        <!-- There is only one contact case, but it must be parsed differently -->
        <xsl:for-each select="child::contact">
          <section id="contact">
            <xsl:if test="address">
            <p id="address">
              <xsl:call-template name="string-replace-all">
                <xsl:with-param name="text" select="address/text() | address/*" />
              </xsl:call-template>
            </p>
            </xsl:if>

            <xsl:if test="photo">
              <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="photo" />
                </xsl:attribute>
                <xsl:attribute name="width">
                  <xsl:value-of select="photo/@width" />
                </xsl:attribute>
                <xsl:attribute name="height">
                  <xsl:value-of select="photo/@height" />
                </xsl:attribute>
                <xsl:attribute name="alt">Photographie</xsl:attribute>
              </img>
            </xsl:if>

            <p class="info">
              <xsl:if test="info">
                <span class="details">
                <xsl:for-each select="info">
                  <xsl:call-template name="EnTitling" />
                  <xsl:value-of select="." />
                </xsl:for-each>
                </span>
              </xsl:if>
              <xsl:for-each select="phone">
                <span class="phone">
                  <xsl:call-template name="EnTitling" />
                  <xsl:value-of select="." />
                </span>
              </xsl:for-each>
              <xsl:for-each select="email">
                <xsl:call-template name="EnTitling" />
              </xsl:for-each>
              <span class="email">
                <a><xsl:attribute name="href">mailto:<xsl:value-of select="email" /></xsl:attribute><xsl:value-of select="email" />
                </a>
              </span>
              <xsl:for-each select="homepage">
                <!-- only to change context -->
                <xsl:call-template name="EnTitling" />
              </xsl:for-each>
              <span class="homepage">
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="homepage" />
                  </xsl:attribute>
                  <xsl:value-of select="homepage" />
                </a>
              </span>
            </p>
          </section>
        </xsl:for-each>
        <!-- Manage all sections -->
        <xsl:for-each select="child::section">
          <section>
            <h2>
              <xsl:value-of select="@title" />
            </h2>
            <xsl:if test="child::subsection">
              <xsl:call-template name="WithSubSection" />
            </xsl:if>
            <xsl:call-template name="WithoutSubSection" />
          </section>
        </xsl:for-each>
        <footer>
          <span class="last-updated">
            <xsl:if test="/cv/@lang='en'">Last updated: </xsl:if>
            <xsl:if test="/cv/@lang='de'">Letzte Aktualisierung: </xsl:if>
            <xsl:if test="/cv/@lang='it'">Ultimo aggiornamento: </xsl:if>
            <xsl:if test="/cv/@lang='es'">Últimas actualización : </xsl:if>
            <xsl:if test="/cv/@lang='fr'">Dernière mise à jour : </xsl:if>
            <xsl:value-of select="$pubdate" />
          </span>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="/cv/contact/homepage" />
            </xsl:attribute>
            <xsl:value-of select="/cv/contact/homepage" />
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
          <h3>
            <xsl:value-of select="@title" />
            <span class="right"><xsl:value-of select="@date" /></span>
          </h3>
          <xsl:apply-templates select="item" />
        </li>
      </xsl:for-each>
      <xsl:apply-templates select="item" />
    </ul>
  </xsl:template>
  <!-- Template for content without subsection -->
  <xsl:template name="WithoutSubSection">
    <xsl:apply-templates select="item" />
  </xsl:template>
  <!-- Template for items -->
  <xsl:template match="item">
    <p>
      <xsl:call-template name="EnTitling" />
      <xsl:copy-of select="text() | *" />
    </p>
  </xsl:template>
  <!-- Template to display the title like "bla: " in english, either "bla : " -->
  <xsl:template name="EnTitling">
    <xsl:if test="./@title != ''">
      <xsl:value-of select="./@title" />
      <xsl:if test="/cv/@lang!='en'">
        <xsl:text></xsl:text>
      </xsl:if>:
      <xsl:text></xsl:text>
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
