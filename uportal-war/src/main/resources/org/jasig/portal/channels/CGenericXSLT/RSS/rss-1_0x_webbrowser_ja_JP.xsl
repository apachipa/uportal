<?xml version='1.0' encoding='utf-8' ?>
<!--

    Copyright (c) 2000-2009, Jasig, Inc.
    See license distributed with this file and available online at
    https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                              xmlns:rss10="http://purl.org/rss/1.0/">

  <xsl:output indent="yes" method="html"/>

  <xsl:param name="locale">ja_JP</xsl:param>

  <xsl:variable name="mediaPath">media/org/jasig/portal/channels/CGenericXSLT</xsl:variable>

  <xsl:template match="rdf:RDF" name="documentNode">
    <!--<html>
      <head>
        <title>uPortal 2.0</title>
      </head>

      <body>-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr align="left">
        <td width="100%" valign="bottom" class="uportal-channel-subtitle">
          <xsl:value-of select="./rss10:channel/rss10:description" />
        </td>
		<xsl:if test="./rss10:image != ''">
        <td>
          <a target="_blank" href="{./rss10:image/rss10:link}">
            <img border="0" alt="{./rss10:image/rss10:title}" src="{./rss10:image/rss10:url}"/>
          </a>
        </td>
		</xsl:if>
      </tr>
    </table>
    <br />

    <xsl:apply-templates select="/rdf:RDF/rss10:item" />
    <br />

    <xsl:apply-templates select="/rdf:RDF/rss10:textinput" />
      <!--</body>
    </html>-->
  </xsl:template>


  <xsl:template match="rss10:item">
    <table width="100%" border="0" cellspacing="0" cellpadding="2">
      <tr>
        <td>
          <img alt="bullet item" src="{$mediaPath}/bullet.gif" width="16" height="16" />
        </td>

        <td width="100%" class="uportal-channel-subtitle-reversed">
          <a href="{rss10:link}" target="_blank">
            <xsl:value-of select="rss10:title" />
          </a>
        </td>
      </tr>

      <xsl:if test="rss10:description != ''">
      <tr class="uportal-channel-text">
        <td></td>
        <td width="100%">
          <xsl:value-of select="rss10:description" />
        </td>
      </tr>
      </xsl:if>
      
    </table>
  </xsl:template>

  <xsl:template match="rss10:textinput">
    <form action="{rss10:link}">
      <span class="uportal-label">
        <xsl:value-of select="rss10:description" />
      </span>

      <br />

      <input type="text" name="{rss10:name}" size="30" class="uportal-input-text" />

      <br />

      <input type="submit" name="Submit" value="送信" class="uportal-button" />
    </form>
  </xsl:template>

</xsl:stylesheet>



