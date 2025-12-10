<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
                <xsl:variable name="maxHeight" select="count(//p[contains(text(), '...')])"/>
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="-10 -250 {count(//undertale)*(60)} {$maxHeight + 40}" width="100%" height="100%">
<!--            <xsl:variable name="maxHeight" select="count(//p[contains(text(), '...')])"/>-->
            <xsl:variable name="colors" select="('red','blue','green','orange')"/>
            <xsl:variable name="pElCount" select="count(descendant::p[contains(text(), '...')])"/>
<!--            <g transform="translate(0,{$maxHeight + 20})">-->
<!--                <line x1="0" y1="0" x2="380" y2="0" stroke="purple" stroke-width="2"/>-->
<!--                <line x1="0" y1="-286" x2="0" y2="0" stroke="purple" stroke-width="2"/>-->
                <xsl:for-each select="//undertale">
                    <xsl:sort select="@file" order="descending"/>
                    <xsl:variable name="xPosition" select="(position() - 1) * 60"/>
                    <xsl:variable name="position" select="((position()-1) mod count($colors) + 1)"/>
                    <rect x="{$xPosition}" y="-{$pElCount}" height="{$pElCount}" width="35" 
                        fill="{$colors[$position]}"/>
                    <text x="{$xPosition}" y="15">
                        <xsl:value-of select="@file"/>
                    </text>
                    <text x="{$xPosition}" y="-{$pElCount + 5}">
                        <xsl:value-of select="$pElCount"/>
                    </text>
                </xsl:for-each>
            <!--</g>-->
        </svg>
    </xsl:template>
</xsl:stylesheet>

<!--//act => count()-->
<!--//act[descendant::p[contains(text(), "...")]] => count()-->
<!--These count the ACTS not the individual uses...-->
<!--"A Sample of Punctuation Patterns in Undertale's Dialogue"-->