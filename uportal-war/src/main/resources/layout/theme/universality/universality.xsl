<?xml version="1.0" encoding="utf-8"?>
<!--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

-->

<!-- ============================= -->
<!-- ========== README =========== -->
<!-- ============================= -->
<!-- 
 | The theme is written in XSL. For more information on XSL, refer to [http://www.w3.org/Style/XSL/].
 | Baseline XSL skill is strongly recommended before modifying this file.
 |
 | This file has two purposes:
 | 1. To instruct the portal how to compile and configure the theme.
 | 2. To provide theme configuration and customization.
 |
 | As such, this file has a mixture of code that should not be modified, and code that exists explicitly to be modified.
 | To help make clear what is what, a RED-YELLOW-GREEN legend has been added to all of the sections of the file.
 |
 | RED: Stop! Do not modify.
 | YELLOW: Warning, proceed with caution.  Modifications can be made, but should not generally be necessary and may require more advanced skill.
 | GREEN: Go! Modify as desired.
 |
 | One of the intents of the theme structure is to provide one place for configuration and customization.
 | All configuration and customization should be done in this file, leaving all other theme files untouched.
 | Following this guideline will minimize impacts to your configuration and customization migration to future releases of uPortal.
 |
 | NEED LOCALIZATION NOTES AND INSTRUCTION.
-->


<!-- ============================================= -->
<!-- ========== STYLESHEET DELCARATION =========== -->
<!-- ============================================= -->
<!-- 
 | RED
 | This statement defines this document as XSL and declares the Xalan extension
 | elements used for URL generation and permissions checks.
 |
 | If a change is made to this section it MUST be copied to all other XSL files
 | used by the theme
-->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xalan="http://xml.apache.org/xalan" 
    xmlns:dlm="http://www.uportal.org/layout/dlm"
    xmlns:portal="http://www.jasig.org/uportal/XSL/portal"
    xmlns:portlet="http://www.jasig.org/uportal/XSL/portlet"
    xmlns:layout="http://www.jasig.org/uportal/XSL/layout"
    xmlns:upAuth="xalan://org.jasig.portal.security.xslt.XalanAuthorizationHelper"
    xmlns:upGroup="xalan://org.jasig.portal.security.xslt.XalanGroupMembershipHelper"
    xmlns:skin="http://www.jasig.org/uportal/web/skin"
    extension-element-prefixes="portal portlet layout skin" 
    exclude-result-prefixes="xalan portal portlet layout upAuth upGroup skin" 
    version="1.0">
  
  <!-- ============================= -->
  <!-- ========== IMPORTS ========== -->
  <!-- ============================= -->
  <!-- 
   | RED
   | Imports are the XSL files that build the theme.
   | Import statments and the XSL files they refer to should not be modified.
   | For customization of the theme, use the Varaiables and Parameters and Templates sections below.
  -->
  <xsl:import href="page.xsl" />        <!-- Templates for page structure -->
  <xsl:import href="navigation.xsl" />  <!-- Templates for navigation structure -->
  <xsl:import href="components.xsl" />  <!-- Templates for UI components (login, web search, etc.) -->
  <xsl:import href="columns.xsl" />     <!-- Templates for column structure -->
  <xsl:import href="content.xsl" />     <!-- Templates for content structure (i.e. portlets) -->
  <xsl:import href="preferences.xsl" /> <!-- Templates for preferences-specific structures -->
  <!-- ============================= -->

    <xalan:component prefix="portal" elements="url param">
        <xalan:script lang="javaclass" src="xalan://org.jasig.portal.url.xml.PortalUrlXalanElements" />
    </xalan:component>
    <xalan:component prefix="portlet" elements="url param">
        <xalan:script lang="javaclass" src="xalan://org.jasig.portal.url.xml.PortletUrlXalanElements" />
    </xalan:component>
    <xalan:component prefix="layout" elements="url param">
        <xalan:script lang="javaclass" src="xalan://org.jasig.portal.url.xml.LayoutUrlXalanElements" />
    </xalan:component>
<!-- ============================================= -->
  
  
  <!-- ========================================= -->
  <!-- ========== OUTPUT DELCARATION =========== -->
  <!-- ========================================= -->
  <!-- 
   | RED
   | This statement instructs the XSL how to output.
  -->
  <xsl:output method="xml" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" />
  <!-- ========================================= -->
  
  
  <!-- ============================================== -->
  <!-- ========== VARIABLES and PARAMETERS ========== -->
  <!-- ============================================== -->
  <!-- 
   | YELLOW - GREEN
   | These variables and parameters provide flexibility and customization of the user interface.
   | Changing the values of the variables and parameters signals the theme to reconfigure use and location of user interface components.
   | All text used within the theme is localized.  See notes above for customizing text.
  -->
  
  
  <!-- ****** SKIN SETTINGS ****** -->
  <!-- 
   | YELLOW
   | Skin Settings can be used to change the location of skin files.
  -->
  <xsl:param name="skin">uportal3</xsl:param>
  <xsl:param name="CONTEXT_PATH">/NOT_SET</xsl:param>
  <xsl:variable name="SKIN" select="$skin"/>
  <xsl:variable name="MEDIA_PATH">media/skins/universality</xsl:variable>
  <xsl:variable name="ABSOLUTE_MEDIA_PATH" select="concat($MEDIA_PATH,'/',$MEDIA_PATH)"/>
  <xsl:variable name="SKIN_RESOURCES_PATH" select="concat($MEDIA_PATH,'/',$SKIN)"/>
  <xsl:variable name="SKIN_PATH" select="concat($CONTEXT_PATH,'/',$MEDIA_PATH,'/',$SKIN)"/>
  <xsl:variable name="PORTAL_SHORTCUT_ICON" select="concat($CONTEXT_PATH,'/favicon.ico')" />
  <xsl:variable name="SKIN_CONFIG_URL" select="concat('../../../../../',$MEDIA_PATH,'/',$SKIN,'/skin.xml')"/>
  <xsl:variable name="FLUID_THEME" select="document($SKIN_CONFIG_URL)/skin:resources/css[@type='fss-theme']/@name"/>
  <xsl:variable name="FLUID_THEME_CLASS">
    <xsl:choose>
      <xsl:when test="$FLUID_THEME"><xsl:value-of select="$FLUID_THEME"/></xsl:when>
      <xsl:otherwise>fl-theme-uportal</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <!-- 
   | The unofficial "theme-switcher".
   | The INSTITUTION variable can be used to make logical tests and configure the theme on a per skin basis.
   | Allows the the theme to configure differently for a skin or group of skins, yet not break for other skins that might require a different configuration.
   | The implementation is hard-coded, but it works.
   | May require the addition of an xsl:choose statement around parameters, vairables, and template calls.
  -->
  <xsl:variable name="INSTITUTION">
    <xsl:choose>
      <xsl:when test="$SKIN='university' or $SKIN='university-div1' or $SKIN='university-div2'">university</xsl:when> <!-- Set all institution skins to a specific theme configuration  -->
      <xsl:when test="$SKIN='coal'">coal</xsl:when>
      <xsl:when test="$SKIN='ivy'">ivy</xsl:when>
	  <xsl:when test="$SKIN='hc'">hc</xsl:when>
      <xsl:otherwise>uportal</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <!-- ****** LOCALIZATION SETTINGS ****** -->
  <!-- 
   | GREEN
   | Locatlization Settings can be used to change the localization of the theme.
  -->
	<xsl:param name="MESSAGE_DOC_URL">messages.xml</xsl:param> <!-- Name of the localization file. -->
	<xsl:param name="USER_LANG">en</xsl:param> <!-- Sets the default user language. -->
  
  
  <!-- ****** PORTAL SETTINGS ****** -->
  <!-- 
   | YELLOW
   | Portal Settings should generally not be (and not need to be) modified.
  -->
  <xsl:param name="USER_ID">guest</xsl:param>
  <xsl:param name="userName">Guest User</xsl:param>
  <xsl:param name="USER_NAME"><xsl:value-of select="$userName"/></xsl:param>
  <xsl:param name="subscriptionsSupported">true</xsl:param>
  <xsl:param name="uP_productAndVersion">uPortal</xsl:param>
  <xsl:param name="UP_VERSION"><xsl:value-of select="$uP_productAndVersion"/></xsl:param>
  <xsl:param name="EXTERNAL_LOGIN_URL"></xsl:param>
  <xsl:param name="PORTAL_VIEW">
  	<xsl:choose>
  		<xsl:when test="//layout_fragment">detached</xsl:when>
      <xsl:when test="//focused">focused</xsl:when>
      <xsl:otherwise>dashboard</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="USE_AJAX" select="'true'"/>
  <xsl:param name="JS_LIBRARY_SKIN">
  	<xsl:choose>
  		<xsl:when test="$USE_AJAX='true'">jqueryui</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="AUTHENTICATED" select="'false'"/>
  <xsl:param name="LOGIN_STATE">
  	<xsl:choose>
  		<xsl:when test="$AUTHENTICATED='true'">logged-in</xsl:when>
      <xsl:otherwise>not-logged-in</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="COLUMNS" select="count(//content/column)"/>
  <xsl:variable name="TOKEN" select="document($MESSAGE_DOC_URL)/theme-messages/tokens[lang($USER_LANG) and (@institution=$INSTITUTION or not(@institution))]/token"/> <!-- Tells the theme how to find appropriate localized token. -->  
  <xsl:variable name="IS_FRAGMENT_ADMIN_MODE">
    <xsl:choose>
        <xsl:when test="//channel[@fname = 'fragment-admin-exit']">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  
  <!-- ****** INSTITUTION SETTINGS ****** -->
  <!-- 
   | GREEN
   | Institution Settings can be used to change intitution-specific parts of the theme.
   | Refer to localization notes above for changing text and labels used in the theme.
  -->
  <xsl:variable name="HELP_URL">http://www.jasig.org/uportal</xsl:variable>
  <xsl:variable name="LOGIN_HELP_URL">http://www.jasig.org/uportal</xsl:variable>
  <xsl:variable name="CAS_NEW_USER_URL">http://www.jasig.org/cas</xsl:variable>

  
  
  <!-- ****** NAVIGATION SETTINGS ****** -->
  <!-- 
   | GREEN
   | Navigation Settings can be used to change the navigation.
  -->
  <xsl:param name="USE_FLYOUT_MENUS" select="'true'" /> <!-- Sets the use of flyout menus.  Values are 'true' or 'false'. -->
  <xsl:param name="USE_ADD_TAB" select="'false'" /> <!-- UNDER DEVELOPMENT, not yet functional (leave false). Sets the use of a "+" button at the end of the tab list for adding a new tab.  Values are 'true' or 'false'. -->
  
  <!-- USE_SUBNAVIGATION_ROW
   | Sets the use of the sub navigation row, which lists out links to the portlets on the active tab.
   | Values are 'true' or 'false'
  -->
  <!-- Use the INSTITUTION parameter to configure the subnavigation row on a per skin/institution basis. -->
  <xsl:param name="USE_SUBNAVIGATION_ROW">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='uportal'">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- ****** LAYOUT SETTINGS ****** -->
  <!-- 
   | GREEN
   | Layout Settings can be used to change the main layout.
  -->
  
  <!-- SIDEBAR -->
  <!-- The sidebar is a persistent (across all tabs) fixed column (cannot be moved or deleted in the portal UI) on either the left or right side of the content area of the page layout that can contain UI components (navigation, quicklinks, etc.) and custom institution content (blocks), but not portlets.
  | USE_SIDEBAR - Sets the use of a sidebar in the logged in, dashboard view.  This sidebar can contain UI components (navigation, quicklinks, etc.) and custom institution content (blocks), but not portlets.  Values are 'true' or 'false'.
  | USE_SIDEBAR_FOCUSED - Sets the use of a sidebar when a portlet is focused.  Values are 'true' or 'false'.
  | USE_SIDEBAR_GUEST - Sets the use of a sidebar when logged out.  Values are 'true' or 'false'.
  | SIDEBAR_LOCATION - Sets the location of the sidebar - if used - in the logged in, dashboard view.  Values are 'left' or 'right'.
  | SIDEBAR_LOCATION_FOCUSED - Sets the location of the sidebar - if used - in the focused view.  Values are 'left' or 'right'.
  | SIDEBAR_LOCATION_GUEST - Sets the location of the sidebar - if used - when logged out.  Values are 'left' or 'right'.
  | SIDEBAR_WIDTH - Sets the pixel width of the sidebar, if used.  Values are '100', '150', '200', '250', or '300' and represent pixel widths.
  | SIDEBAR_WIDTH_FOCUSED - Sets the pixel width of the sidebar when a portlet is focused, if used.  Values are '100', '150', '200', '250', or '300' and represent pixel widths.
  | SIDEBAR_WIDTH_GUEST - Sets the pixel width of the sidebar when logged out, if used.  Values are '100', '150', '200', '250', or '300' and represent pixel widths.
  -->
  <!-- Use the INSTITUTION parameter to configure the sidebar on a per skin/institution basis. -->
  <xsl:param name="USE_SIDEBAR">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='ivy'">false</xsl:when>
      <xsl:otherwise>true</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="USE_SIDEBAR_FOCUSED">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='ivy'">false</xsl:when>
      <xsl:otherwise>true</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="USE_SIDEBAR_GUEST">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='ivy'">true</xsl:when>
      <xsl:otherwise>true</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="SIDEBAR_LOCATION">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='uportal' or $INSTITUTION='hc'">right</xsl:when>
      <xsl:otherwise>left</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="SIDEBAR_LOCATION_FOCUSED">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='uportal' or $INSTITUTION='hc'">right</xsl:when>
      <xsl:otherwise>left</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="SIDEBAR_LOCATION_GUEST">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='uportal'">left</xsl:when>
      <xsl:otherwise>left</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="SIDEBAR_WIDTH">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='uportal'">200</xsl:when>
      <xsl:otherwise>200</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="SIDEBAR_WIDTH_FOCUSED">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='uportal'">200</xsl:when>
      <xsl:otherwise>200</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="SIDEBAR_WIDTH_GUEST">
    <xsl:choose>
      <xsl:when test="$INSTITUTION='uportal'">250</xsl:when>
      <xsl:otherwise>250</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- ============================================ -->
  
  <!-- Debug Template
  <xsl:template match="/">
  	<h1>Debugging</h1>
  </xsl:template> -->
  
  <!-- =============================== -->
  <!-- ========== TEMPLATES ========== -->
  <!-- =============================== -->
  <!-- 
   | GREEN
   | Templates included in this file are for the purpose of customizing the portal.
   | PAGE CSS and PAGE JAVASCRIPT are provided as a means to override the theme defaults.
   | For those templates, the theme defaults are provided in the comments.
   | To override those templates, uncomment the defaults and make desired modifications.
   | Block templates are not overrides, but are content areas (blocks) called from the theme.
   | Some blocks have content (or call other templates) by default, and others are empty by default.
   | If custom content is desired, write in the contents into the appropriate block.
   | Changes to templates may require a restart of the portal server.
   | Template contents can be any valid XSL or XHTML.
  -->
  
  <!-- ========== TEMPLATE: ALERT BLOCK ========== -->
  <!-- ============================================ -->
  <!-- 
   | GREEN
   | This template renders content into an alert section at the very top of the page.
  -->
  	<xsl:template name="alert.block">
    	<!-- Fragment Administration mode banner and exit link. -->
    	<xsl:copy-of select="//channel[@fname = 'fragment-admin-exit']"/>
    </xsl:template>
  <!-- ============================================ -->
  
  
  <!-- ========== TEMPLATE: HEADER BLOCK ========== -->
  <!-- ============================================ -->
  <!-- 
   | GREEN
   | This template renders content into the page header.
   | Reordering the template calls and/or xhtml contents will change the order in the page markup.
   | Commenting out a template call will prevent that component's markup fom being written into the page markup.
   | Thus, to not use the quicklinks, simply comment out the quicklinks template call.
   | These components can be placed into other blocks, if desired.
   | To place a component into another block, copy the template call from this block and paste it into another block; then comment out the template call in this block 
   | Custom content can be inserted as desired.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="header.block">
  	<!-- Portal Page Bar -->
    <xsl:call-template name="portal.page.bar"/>
    <!-- Portal Page Bar -->
    
    <!-- Skip Navigation -->
    <div id="portalSkipNav">
      <a href="#mainNavigation" title="{$TOKEN[@name='SKIP_TO_NAV_TITLE']}" id="skipToNav" accesskey="N">
        <xsl:value-of select="$TOKEN[@name='SKIP_TO_NAV']"/>
      </a>
      <a href="#pageContent" title="{$TOKEN[@name='SKIP_TO_CONTENT_TITLE']}" id="skipToContent" accesskey="C">
        <xsl:value-of select="$TOKEN[@name='SKIP_TO_CONTENT']"/>
      </a>
    </div>
    <!-- Skip Navigation -->
    
    <!-- Logo -->
    <xsl:call-template name="logo"/>
    <!-- Logo -->
    
    <!-- ****** LOGIN ****** -->
    <!--
     | Use one of the login options: the login template (uP3 preferred), the login channel (from uP2.6), or CAS login.
     | By default, the login is rendered into the sidebar below.
    -->
    <!-- Login
    <xsl:call-template name="login"/> -->
    <!-- Login -->
    
    <!-- Login Channel -->
    <xsl:if test="$AUTHENTICATED='true'">
    	<xsl:call-template name="welcome"/> <!-- This login call is needed to render the welcome/logout statement into the header. -->
    </xsl:if>
    <!-- Login Channel -->
    
    <!-- CAS Login
    <xsl:call-template name="cas.login"/> -->
    <!-- CAS Login -->
    <!-- ****** LOGIN ****** -->
    
    <!-- Welcome
    <xsl:call-template name="welcome"/> -->
    <!-- Welcome -->
    
    <!-- Web Search -->
    <xsl:if test="$INSTITUTION != 'ivy'">
    	<xsl:call-template name="web.search"/>
    </xsl:if>
    <!-- Web Search -->
    
    <!-- Quicklinks
    <xsl:call-template name="quicklinks"/> -->
    <!-- Quicklinks -->
    
    <!-- SAMPLE:
    <div id="portalHeaderBlock">
    	<p>CUSTOM CONTENTS.</p>
    </div>
    -->
  </xsl:template>
  <!-- ============================================ -->
    
  
  <!-- ========== TEMPLATE: PORTAL PAGE BAR TITLE BLOCK ========== -->
  <!-- =========================================================== -->
  <!-- 
   | GREEN
   | This template renders content for the page bar title.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="portal.page.bar.title.block">
  	<!-- <h2><xsl:copy-of select="$TOKEN[@name='PORTAL_PAGE_TITLE']"/></h2> -->
  </xsl:template>
  <!-- =========================================================== -->
    
  
  <!-- ========== TEMPLATE: PORTAL PAGE BAR LINKS BLOCK ========== -->
  <!-- =========================================================== -->
  <!-- 
   | GREEN
   | This template renders content for the page bar title links.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="portal.page.bar.links.block">
  	<!-- Home Link -->
  	<xsl:call-template name="portal.page.bar.link.home" />
    <!-- Home Link -->
    
    <!-- Admin Link -->
    <xsl:if test="$INSTITUTION != 'uportal'">
  		<xsl:call-template name="portal.page.bar.link.admin" />
    </xsl:if>
    <!-- Admin Link -->
    
    <!-- Preferences Link -->
    <xsl:if test="$INSTITUTION != 'uportal'">
  		<xsl:call-template name="portal.page.bar.link.customize" />
    </xsl:if>
    <!-- Preferences Link -->
    
    <!-- Sitemap Link -->
  	<xsl:call-template name="portal.page.bar.link.sitemap" />
    <!-- Sitemap Link -->
    
    <!-- Help Link -->
  	<xsl:call-template name="portal.page.bar.link.help" />
    <!-- Help Link -->
    
    <!-- Logout Link -->
  	<xsl:call-template name="portal.page.bar.link.logout" />
    <!-- Logout Link -->
    
  </xsl:template>
  <!-- =========================================================== -->
    
  
  <!-- ========== TEMPLATE: LOGO BLOCK ========== -->
  <!-- ========================================== -->
  <!-- 
   | GREEN
   | This template renders content for the logo.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="logo.block">
  	<img src="{$SKIN_PATH}/images/portal_logo.png" alt="{$TOKEN[@name='LOGO']}"/>
    <!-- Text only: 
    <span><xsl:value-of select="$TOKEN[@name='LOGO']"/></span> -->
  </xsl:template>
  <!-- ========================================== -->
  
  
  <!-- ========== TEMPLATE: HEADER FOCUSED BLOCK ========== -->
  <!-- ==================================================== -->
  <!-- 
   | GREEN
   | This template renders custom content into the page header of the focused view.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="header.focused.block">
    <!-- Portal Page Bar -->
    <xsl:call-template name="portal.page.bar"/>
    <!-- Portal Page Bar -->
    
    <!-- Skip Navigation -->
    <div id="portalSkipNav">
      <a href="#mainNavigation" title="{$TOKEN[@name='SKIP_TO_NAV_TITLE']}" id="skipToNav">
        <xsl:value-of select="$TOKEN[@name='SKIP_TO_NAV']"/>
      </a>
      <a href="#startContent" title="{$TOKEN[@name='SKIP_TO_CONTENT_TITLE']}" id="skipToContent">
        <xsl:value-of select="$TOKEN[@name='SKIP_TO_CONTENT']"/>
      </a>
    </div>
    <!-- Skip Navigation -->
    
    <!-- Logo -->
    <xsl:call-template name="logo"/>
    <!-- Logo -->
    
    <!-- SAMPLE:
    <div id="portalHeaderFocusedBlock">
    	<p>CUSTOM CONTENTS.</p>
    </div>
    -->
  </xsl:template>
  <!-- ==================================================== -->
    
  
  <!-- ========== TEMPLATE: PORTAL PAGE BAR TITLE FOCUSED BLOCK ========== -->
  <!-- =================================================================== -->
  <!-- 
   | GREEN
   | This template renders content for the page bar title of the focused view.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="portal.page.bar.title.focused.block">
  	<!-- Text:
    <span><xsl:value-of select="$TOKEN[@name='LOGO']"/></span> -->
  </xsl:template>
  <!-- =================================================================== -->
  
  
  <!-- ========== TEMPLATE: PORTAL PAGE BAR LINKS FOCUSED BLOCK ========== -->
  <!-- =================================================================== -->
  <!-- 
   | GREEN
   | This template renders content for the page bar title links of the focused view.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="portal.page.bar.links.focused.block">
  	<!-- Home Link -->
  	<xsl:call-template name="portal.page.bar.link.home"/>
    <!-- Home Link -->
    
    <!-- Admin Link
  	<xsl:call-template name="portal.page.bar.link.admin"/> -->
    <!-- Admin Link -->
    
    <!-- Preferences Link
  	<xsl:call-template name="portal.page.bar.link.customize"/> -->
    <!-- Preferences Link -->
    
    <!-- Sitemap Link
  	<xsl:call-template name="portal.page.bar.link.sitemap"/> -->
    <!-- Sitemap Link -->
    
    <!-- Help Link -->
  	<xsl:call-template name="portal.page.bar.link.help" />
    <!-- Help Link -->
    
    <!-- Logout Link -->
  	<xsl:call-template name="portal.page.bar.link.logout" />
    <!-- Logout Link -->
  </xsl:template>
  <!-- =================================================================== -->
  
  
  <!-- ========== TEMPLATE: FOCUSED LOGO BLOCK ========== -->
  <!-- ================================================== -->
  <!-- 
   | GREEN
   | This template renders content for the focused logo.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="logo.focused.block">
  	<!-- Text:
    <span><xsl:value-of select="$TOKEN[@name='LOGO']"/></span> -->
    <!-- Image:  -->
    <img src="{$SKIN_PATH}/images/portal_logo_slim.png" alt="{$TOKEN[@name='LOGO']}"/>
  </xsl:template>
  <!-- ================================================== -->
  
  
  <!-- ========== TEMPLATE: MAIN NAVIGATION BLOCK ========== -->
  <!-- ================================================= -->
  <!-- 
   | GREEN
   | This template renders the navigation as tabs in below the header and above the body.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="main.navigation.block">
  	<!-- Main Navigation -->
    <xsl:apply-templates select="//navigation">
      <xsl:with-param name="CONTEXT" select="'header'"/>
    </xsl:apply-templates>
    <!-- Main Navigation -->
  </xsl:template>
  <!-- ================================================= -->
  
  
  <!-- ========== TEMPLATE: CONTENT TOP BLOCK ========== -->
  <!-- ================================================= -->
  <!-- 
   | GREEN
   | This template renders custom content into the page above the body.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="content.top.block">
  	<!-- SAMPLE:
    <div id="portalContentTopBlock">
    	<p>CUSTOM CONTENTS.</p>
    </div>
    -->
  </xsl:template>
  <!-- ================================================= -->
  
  
  <!-- ========== TEMPLATE: CONTENT BOTTOM BLOCK ========== -->
  <!-- ==================================================== -->
  <!-- 
   | GREEN
   | This template renders custom content into the page below the body.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="content.bottom.block">
  	<!-- SAMPLE:
    <div id="portalContentBottomBlock">
    	<p>CUSTOM CONTENTS.</p>
    </div>
    -->
  </xsl:template>
  <!-- ==================================================== -->
  
  
  <!-- ========== TEMPLATE: CONTENT TITLE BLOCK ========== -->
  <!-- =================================================== -->
  <!-- 
   | GREEN
   | This template renders content into the page body in the top row of the content layout table.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="content.title.block">
  	<!-- PAGE TITLE -->
    <xsl:call-template name="page.title"/>
    <!-- PAGE TITLE -->
    
    <!-- CUSTOMIZE LINKS: For these links to function, AJAX must be enabled by setting the USE_AJAX parameter above to 'true'. -->
    <xsl:if test="$USE_SIDEBAR != 'true' and $USE_AJAX='true'">
    	<xsl:call-template name="customize.links"/>
    </xsl:if>
    <!-- CUSTOMIZE LINKS -->
  </xsl:template>
  <!-- =================================================== -->
  
  
  <!-- ========== TEMPLATE: CONTENT TITLE FOCUSED BLOCK ========== -->
  <!-- =========================================================== -->
  <!-- 
   | GREEN
   | This template renders content into the page body in the top row of the content layout table of the focused view.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="content.title.focused.block">
  	<!-- BREADCRUMB -->
    <xsl:call-template name="breadcrumb"/>
    <!-- BREADCRUMB -->
    
    <!-- PAGE TITLE
    <xsl:call-template name="page.title"/> -->
    <!-- PAGE TITLE -->
  </xsl:template>
  <!-- =========================================================== -->
  
  
  <!-- ========== TEMPLATE: CONTENT SIDEBAR BLOCK ========== -->
  <!-- ================================================== -->
  <!-- 
   | GREEN
   | This template renders content into the page body in the sidebar of the content layout.
   | The sidebar must be enabled for this content to render.
   | Enable the sidebar by setting USE_SIDEBAR to 'true' in the Variables and Parameters section above.
   | Reordering the template calls will change the order in the page markup.
   | Commenting out a template call will prevent that component's markup fom being written into the page markup.
   | Thus, to not use the quicklinks, simply comment out the quicklinks template call.
   | These components can be placed into other blocks, if desired.
   | To place a component into another block, copy the template call from this block and paste it into another block; then comment out the template call in this block 
   | Custom content can be inserted as desired.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="content.sidebar.block">
    <!-- Web Search
    <xsl:call-template name="web.search"/> -->
    <!-- Web Search -->
    
    <!-- CUSTOMIZE LINKS: For these links to function, AJAX must be enabled by setting the USE_AJAX parameter above to 'true'. -->
    <xsl:if test="$USE_SIDEBAR = 'true' and $USE_AJAX='true'">
    	<xsl:call-template name="customize.links"/>
    </xsl:if>
    <!-- CUSTOMIZE LINKS -->
    
    <!-- Administration Links -->
    <xsl:call-template name="administration.links"/>
    <!-- Administration Links -->
    
    <!-- Fragment Administration -->
    <xsl:copy-of select="//channel[@fname = 'fragment-admin']"/>
    <!--<xsl:copy-of select="//channel[@fname = 'fragment-admin-exit']"/>-->

    <!-- Quicklinks -->
    <xsl:call-template name="quicklinks"/>
    <!-- Quicklinks -->
    
    <!-- Main Navigation
    <xsl:apply-templates select="//navigation">
      <xsl:with-param name="CONTEXT" select="'sidebar'"/>
    </xsl:apply-templates> -->
    <!-- Main Navigation -->
    
    <!-- SAMPLE:
    <div id="portalContentSidebarsBlock">
    	<p>CUSTOM CONTENTS.</p>
    </div>
    -->
  </xsl:template>
  <!-- ================================================== -->
  
  
  <!-- ========== TEMPLATE: CONTENT SIDEBAR FOCUSED BLOCK ========== -->
  <!-- ========================================================== -->
  <!-- 
   | GREEN
   | This template renders content into the page body in the sidebar of the content layout when a portlet is focused.
   | The sidebar must be enabled for this content to render.
   | Enable the sidebar by setting USE_SIDEBAR_FOCUSED to 'true' in the Variables and Parameters section above.
   | Reordering the template calls will change the order in the page markup.
   | Commenting out a template call will prevent that component's markup fom being written into the page markup.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="content.sidebar.focused.block">
    <!-- Main Navigation
    <xsl:apply-templates select="//navigation">
      <xsl:with-param name="CONTEXT" select="'focused'"/>
    </xsl:apply-templates> -->
    <!-- Main Navigation -->
    
    <!-- Portlet Navigation -->
    <xsl:call-template name="portlet.navigation"/>
    <!-- Portlet Navigation -->
    
    <!-- SAMPLE:
    <div id="portalContentSidebarFocusedBlock">
    	<p>CUSTOM CONTENTS.</p>
    </div>
    -->
  </xsl:template>
  <!-- ========================================================== -->
  
  
  <!-- ========== TEMPLATE: CONTENT SIDEBAR GUEST BLOCK ========== -->
  <!-- ======================================================== -->
  <!-- 
   | GREEN
   | This template renders content into the page body in the sidebar of the content layout when not logged in.
   | The sidebar must be enabled for this content to render.
   | Enable the sidebar by setting USE_SIDEBAR_GUEST to 'true' in the Variables and Parameters section above.
   | Reordering the template calls will change the order in the page markup.
   | Commenting out a template call will prevent that component's markup fom being written into the page markup.
   | Thus, to not use the quicklinks, simply comment out the quicklinks template call.
   | These components can be placed into other blocks, if desired.
   | To place a component into another block, copy the template call from this block and paste it into another block; then comment out the template call in this block 
   | Custom content can be inserted as desired.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="content.sidebar.guest.block">
		<!-- ****** LOGIN ****** -->
    <!--
     | Use one of the login options: the login template (uP3 preferred), the login channel (from uP2.6), or CAS login.
    -->
    <!-- Login
    <xsl:call-template name="login"/> -->
    <!-- Login -->
    
    <!-- Login Channel -->
    <xsl:call-template name="login"/>
    <!-- Login Channel -->
    
    <!-- CAS Login
    <xsl:call-template name="cas.login"/> -->
    <!-- CAS Login -->
    <!-- ****** LOGIN ****** -->
    
    <!-- Web Search, by default rendered in the header above.
    <xsl:call-template name="web.search"/> -->
    <!-- Web Search -->
    
    <!-- Quicklinks, by default rendered in the header above.
    <xsl:call-template name="quicklinks"/> -->
    <!-- Quicklinks -->
    
    <!-- Main Navigation
    <xsl:apply-templates select="//navigation">
      <xsl:with-param name="CONTEXT" select="'sidebar'"/>
    </xsl:apply-templates> -->
    <!-- Main Navigation -->
    
    <!-- SAMPLE:
    <div id="portalContentSidebarGuestBlock">
    	<p>CUSTOM CONTENTS.</p>
    </div>
    -->
  </xsl:template>
  <!-- ======================================================== -->
  
  
  <!-- ========== TEMPLATE: FOOTER BLOCK ========== -->
  <!-- ============================================ -->
  <!-- 
   | GREEN
   | This template renders custom content into the page footer.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="footer.block">

    <xsl:if test="$INSTITUTION='uportal' or $INSTITUTION='coal'">
      <!-- Footer Links -->
      <div id="portalPageFooterLinks">
        <a href="http://www.jasig.org/" target="_blank" title="{$TOKEN[@name='JASIG_LONG_LABEL']}">
          <xsl:value-of select="$TOKEN[@name='JASIG_LABEL']"/>
        </a>
        <xsl:call-template name="portal.pipe"/>
        <a href="http://www.jasig.org/uportal" target="_blank" title="{$TOKEN[@name='UPORTAL_LONG_LABEL']}">
          <xsl:value-of select="$TOKEN[@name='UPORTAL_LABEL']"/>
        </a>
        <xsl:call-template name="portal.pipe"/>
        <a href="http://www.jasig.org/uportal/download" target="_blank" title="{$TOKEN[@name='UPORTAL_DOWNLOAD_LONG_LABEL']}">
          <xsl:value-of select="$TOKEN[@name='UPORTAL_DOWNLOAD_LABEL']"/>
        </a>
        <xsl:call-template name="portal.pipe"/>
        <a href="http://www.jasig.org/uportal/community" target="_blank" title="{$TOKEN[@name='UPORTAL_COMMUNITY_LONG_LABEL']}">
          <xsl:value-of select="$TOKEN[@name='UPORTAL_COMMUNITY_LABEL']"/>
        </a>
      </div>
      
      <!-- uPortal Product Version -->
      <div id="portalProductAndVersion">
        <p><a href="http://www.jasig.org/uportal" title="Powered by ${UP_VERSION}" target="_blank">Powered by <xsl:value-of select="$UP_VERSION"/></a></p>
        <!-- It's a good idea to leave this in the markup, that way anyone who may be supporting your portal can get to this information quickly by simply using a browser.  If you don't want the statement to visibly render in the page, use CSS to make it invisible. -->
      </div>
      
      <!-- Copyright -->
      <div id="portalCopyright">
        <p><a href="http://www.jasig.org/uportal/about/license" title="uPortal" target="_blank">uPortal</a> is licensed under the <a href="http://www.apache.org/licenses/LICENSE-2.0" title="Apache License, Version 2.0" target="_blank">Apache License, Version 2.0</a> as approved by the Open Source Initiative (OSI), an <a href="http://www.opensource.org/docs/osd" title="OSI-certified" target="_blank">OSI-certified</a> ("open") and <a href="http://www.gnu.org/licenses/license-list.html" title="Gnu/FSF-recognized" target="_blank">Gnu/FSF-recognized</a> ("free") license.</p>
      </div>
      
      <!-- Icon Set Attribution -->
      <div id="silkIconsAttribution">
        <p><a href="http://www.famfamfam.com/lab/icons/silk/" title="Silk icon set 1.3" target="_blank">Silk icon set 1.3</a> courtesy of Mark James.</p>
        <!-- Silk icon set 1.3 by Mark James [ http://www.famfamfam.com/lab/icons/silk/ ], which is licensed under a Creative Commons Attribution 2.5 License. [ http://creativecommons.org/licenses/by/2.5/ ].  This icon set is free for use under the CCA 2.5 license, so long as there is a link back to the author's site.  If the Silk icons are used, this reference must be present in the markup, though not necessarily visible in the rendered page.  If you don't want the statement to visibly render in the page, use CSS to make it invisible. -->
      </div>
    </xsl:if>
    
  </xsl:template>
  <!-- ============================================ -->
  
  <!-- ========== TEMPLATE: PORTLET TOP BLOCK ========== -->
  <!-- ================================================= -->
  <!-- 
   | GREEN
   | This template renders custom content on the portlet container top for additional decoration, primarily for rounded corners.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="portlet.top.block">
    <div class="up-portlet-wrapper-top">
      <div class="up-portlet-wrapper-top-inner">
      </div>
    </div>
  </xsl:template>
  <!-- ================================================= -->
  
  
  <!-- ========== TEMPLATE: PORTLET BOTTOM BLOCK ========== -->
  <!-- ==================================================== -->
  <!-- 
   | GREEN
   | This template renders custom content on the portlet container bottom for additional decoration, primarily for rounded corners.
   | Template contents can be any valid XSL or XHTML.
  -->
  <xsl:template name="portlet.bottom.block">
    <div class="up-portlet-wrapper-bottom">
      <div class="up-portlet-wrapper-bottom-inner">
      </div>
    </div>
  </xsl:template>
  <!-- ==================================================== -->
		
</xsl:stylesheet>
