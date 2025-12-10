<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:variable name="characterColl" as="document-node()+"
        select="collection('../XML/?select=*.xml')"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="$characterColl//undertale"/>
    </xsl:template>
    
    <xsl:template match="undertale">
        <undertale file="{base-uri(.)=> substring-after('XML/')}">
            <xsl:apply-templates/>
        </undertale>
    </xsl:template>
    
</xsl:stylesheet>