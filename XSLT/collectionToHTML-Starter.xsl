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
                <title>Omega Flowey</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <div class="navbar">
                    <a href="index.html">Undertale Project</a>
                    <a href="research.html">Research</a>
                    <a href="sources.html">Sources</a>
                    <a href="about.html">About</a>
                </div>
                <h1>Omega Flowey</h1>
                <section class="content">
                    <xsl:apply-templates select="descendant::scene"/>
                    <xsl:apply-templates select="descendant::altScene"/>
                </section>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="scene">
        <div class="sceneBox">
            <h2><xsl:value-of select="@type"/></h2> 
                <xsl:apply-templates select="descendant::p"/>
        </div>
    </xsl:template>
    <xsl:template match="altScene">
        <div class="altSceneBox">
            <h2><xsl:value-of select="@choice"/></h2> 
                <xsl:apply-templates select="descendant::p"/>
        </div>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
</xsl:stylesheet>
