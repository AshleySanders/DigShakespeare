<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  exclude-result-prefixes="xd exsl estr edate a fo local rng tei teix"
  extension-element-prefixes="exsl estr edate" version="2.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:edate="http://exslt.org/dates-and-times"
  xmlns:estr="http://exslt.org/strings"
  xmlns:exsl="http://exslt.org/common"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:local="http://www.pantor.com/ns/local"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="rdg" select="'semiDiplomatic'"></xsl:variable>

<xsl:strip-space elements="*"/>
<xsl:preserve-space elements="tei:c"/>

<xsl:template match="/">
<html>
<head>
  <style>

h2 {
    overflow: hidden;
    text-align: center;
    color: gray;
    font-size: 10pt;
}
h2:before,
h2:after {
    background-color: gray;
    content: "";
    display: inline-block;
    height: 1px;
    position: relative;
    vertical-align: middle;

    width: 50%;
    width: 40%;
}
h2:before {
    right: 0.5em;
    margin-left: -50%;
}
h2:after {
    left: 0.5em;
    margin-right: -50%;
}

</style>
</head>
<body>
  <xsl:apply-templates/>
</body>
</html>
</xsl:template>


<xsl:template match="tei:teiHeader"></xsl:template>
<xsl:template match="tei:fw"></xsl:template>
<xsl:template match="tei:note"></xsl:template>
<xsl:template match="tei:div"><span style="left: 75px;"><xsl:apply-templates/><br/><br/></span></xsl:template>
<xsl:template match="tei:opener"><br/><xsl:value-of select="tei:opener"/><br/><xsl:apply-templates/></xsl:template>
<xsl:template match="tei:p"><xsl:apply-templates/></xsl:template>
<xsl:template match="tei:lb"><br/></xsl:template>
<xsl:template match="tei:lb[@break='no']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'"><br/></xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'"><br/></xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:lb[@break='reg']">
  <xsl:choose>
    <xsl:when test="$rdg='regularized'"><br/></xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:closer"><br/><div style="padding-left:40px;"><xsl:apply-templates/></div></xsl:template>
<xsl:template match="tei:note[@type='administrative' and @subtype='endorsement']"><span style="left: 75px; color:gray;"><xsl:apply-templates/><br/></span></xsl:template>
<xsl:template match="tei:note[@type='authorial']"><span style="left: 75px; color:gray;"><xsl:apply-templates/></span></xsl:template>
<xsl:template match="tei:figure/tei:desc"><span style="left: 75px; color:gray;">[<xsl:apply-templates/>]</span></xsl:template>

<xsl:template match="tei:ex">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'"></xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'">
      <span style="font-style:italic;"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:expan">
  <xsl:choose>
    <xsl:when test="$rdg='semiDiplomatic'"><xsl:apply-templates/></xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:g[@ref='#thorn']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'">y</xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'">
      <span style="font-style:italic;">th</span>
    </xsl:when>
    <xsl:otherwise>th</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:reg">
  <xsl:choose>
    <xsl:when test="$rdg='regularized'"><xsl:apply-templates/></xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:reg[@xml:lang]">
  <xsl:choose>
    <xsl:when test="$rdg='regularized'">
      <xsl:if test="@xml:lang = 'en'">
        <xsl:apply-templates/>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:orig">
  <xsl:choose>
    <xsl:when test="$rdg='regularized'"></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:hi[@rend='superscript']"><sup><xsl:apply-templates/></sup></xsl:template>
<xsl:template match="tei:del"><del><xsl:apply-templates/></del></xsl:template>
<xsl:template match="tei:add[@type='authorial']">
  <xsl:choose>
    <xsl:when test="$rdg='regularized'"><xsl:apply-templates/></xsl:when>
    <xsl:otherwise><sup><xsl:apply-templates/></sup></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:metamark[@function='insertion']">
  <xsl:choose>
    <xsl:when test="$rdg='regularized'"></xsl:when>
    <xsl:otherwise>
      <span style="position:relative; top:10px;"><xsl:apply-templates/></span>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:metamark[@function='expansion']">
  <xsl:choose>
    <xsl:when test="$rdg='regularized'"></xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'"></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:abbr[@type='abbreviation']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'"><xsl:apply-templates/></xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:abbr[@type='superscription']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'"><sup><xsl:apply-templates/></sup></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:abbr[@type='ordinal']//tei:abbr[@type='superscription']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'"><sup><xsl:apply-templates/></sup></xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'"><sup><xsl:apply-templates/></sup></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:abbr[@type='superscription' and @subtype='currency']">
  <sup><xsl:apply-templates/></sup>
</xsl:template>
<xsl:template match="tei:abbr[@type='macron']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'"><span style="text-decoration: overline;"><xsl:apply-templates/></span></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:abbr[@type='brevigraph']">
  <span style="font-style:italic;"><xsl:apply-templates/></span>
</xsl:template>
<xsl:template match="tei:abbr[@type='brevigraph' and @subtype='brev-p']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'"><span class="extended">&#xa751;</span></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:abbr[@type='brevigraph' and @subtype='brev-er']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'">{<xsl:apply-templates/>}</xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'"><span style="font-style:italic;"><xsl:apply-templates/></span></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:abbr[@type='brevigraph' and @subtype='brev-es']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'">{<xsl:apply-templates/>}</xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'"><span style="font-style:italic;"><xsl:apply-templates/></span></xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:supplied[@reason='missing']">
  <xsl:choose>
    <xsl:when test="$rdg='semiDiplomatic'">[<xsl:apply-templates/>]</xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:supplied[@reason='damaged']">
  <xsl:choose>
    <xsl:when test="$rdg='diplomatic'">[<xsl:value-of select="'&#9671;'"/>]</xsl:when>
    <xsl:when test="$rdg='semiDiplomatic'">[<xsl:apply-templates/>]</xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:gap">[<xsl:value-of select="'&#9671;'"/>]</xsl:template>

<!--
<xsl:template match="tei:name">
  <span style="background-color:#ffff99"><xsl:apply-templates/></span>
</xsl:template>
<xsl:template match="tei:placeName">
  <span style="background-color:#e6ff99"><xsl:apply-templates/></span>
</xsl:template>
-->

<xsl:template match="tei:pb">
  <anchor id="{@n}" name="{@n}"/>
  <h2><xsl:value-of select="@n"/></h2>
</xsl:template>

</xsl:stylesheet> 


