<?xml version='1.0'?>
<!--

    Copyright (c) 2000-2009, Jasig, Inc.
    See license distributed with this file and available online at
    https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="baseActionURL">Noklusējums</xsl:param>
<xsl:param name="locale">lv_LV</xsl:param>
<xsl:variable name="imageDir" select="'media/org/jasig/portal/channels/CUserPreferences'"/>

<xsl:template match="/">
  <table border="0" cellspacing="0" cellpadding="5" align="center">
    <tr><td>Lai pārvietotu izvēlētos elementus, izvēlēties mapi un tad nospiest "Pārvietot".</td></tr>
    <tr><td align="center">
      <table><tr><td>
        <form action="{$baseActionURL}" method="post">
      	  <input type="hidden" name="action" value="moveTo"/>
      	  <p align="center"><input type="submit" name="move" value="Pārvietot"/></p>
      	    <input type="radio" name="destination" value="top"/>
            <img src="{$imageDir}/folder_closed.gif" border="0" width="13" height="10"/>
            Mani kanāli<br/>      
            <xsl:apply-templates select="layout"/>      
      	  <p align="center"><input type="submit" name="move" value="Pārvietot"/></p>
        </form>
      </td></tr></table>
    </td></tr>
  </table>
</xsl:template>

<xsl:template match="folder">
  <!-- Indent according to position in hierarchy-->
  <xsl:for-each select="ancestor::*">
    <img src="{$imageDir}/transparent1x1.gif" width="20" height="1"/>
  </xsl:for-each>

  <input type="radio" name="destination" value="{@ID}"/>
  <img src="{$imageDir}/folder_closed.gif" border="0" width="13" height="10"/>
  <xsl:value-of select="@name"/><br/>
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
