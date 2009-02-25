<?xml version='1.0'?>
<!--

    Copyright (c) 2000-2009, Jasig, Inc.
    See license distributed with this file and available online at
    https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:param name="locale">lv_LV</xsl:param>
    
    <xsl:template match="iframe">
        <iframe src="{url}" height="{height}" frameborder="0" width="100%">Šī pārlūkprogramma neatbalsta iekļautos kadrus.<br/>
            <a href="{url}" target="_blank">Nospiest šeit, lai apskatītu saturu </a> atsevišķā logā.</iframe>
    </xsl:template>
</xsl:stylesheet>
