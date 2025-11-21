<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Sans</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="undertaleSANS.css"/>
            </head>
            
            <body>
                <div class="navbar">
                    <a href="index.html">Undertale Project</a>
                    <a href="research.html">Research</a>
                    <a href="sources.html">Sources</a>
                    <a href="about.html">About</a>
                </div>
                <h1>Undertale Scene Analysis</h1>
                <xsl:apply-templates select ="scene"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="scene">
        <h2>Route: <xsl:value-of select="@route"/></h2>
        <h3>Scene Type: <xsl:value-of select="@type"/></h3>
        
        <div>
            <h3>Dialouge</h3>
            <xsl:apply-templates select="act"/>
        </div>
    </xsl:template>
    <xsl:template match="act">
        
            <b>
                <xsl:variable name="sp" select="@speakerRef"/>
                <xsl:value-of select="/undertale/metadata/refList/name[@xml:id=$sp]"/>
            </b>
            <xsl:variable name="expr" select="bodyLang/@faceRef"/>
            <span class="expr"> Expression: (
                <xsl:value-of select="/undertale/metadata/refList/expr[@xml:id=$expr]"/> )
            </span>
            
            <div class="dialouge">
                <xsl:value-of select="bodyLang/p"/>
            </div>
        
    </xsl:template>
</xsl:stylesheet>