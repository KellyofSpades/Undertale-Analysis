<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:variable name="maxHeight" select="count(//p[contains(text(), '...')])"/>
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 900" width="100%" height="100%">
            <!--            <xsl:variable name="maxHeight" select="count(//p[contains(text(), '...')])"/>-->
            <xsl:variable name="colors" select="('red','cyan','green','orange','violet','yellow')"/>
<!--            <xsl:variable name="pElCount" select="count(descendant::p[contains(text(), '...')])"/>-->
<!--            <xsl:variable name="totalPunc" select="count(descendant::p[contains(text(), '... | .')])"/>-->
            <xsl:variable name="tokenText" select="string-join(//p, '')"/>  
            <xsl:variable name="totalElPunc" select="count(tokenize($tokenText, '\.\.\.')) -1"/>
          
            <circle r="300" cx="50%" cy="50%" fill="pink"/>
            <text>Ellipses Distribution</text>
            
            <xsl:for-each select="//undertale">
                <xsl:sort select="@file" order="descending"/>
                
                <xsl:variable name="currentText" select="string-join(descendant::p, '')"/>
<!--                <xsl:variable name="previousText" select="string-join(preceding-sibling::undertale//p, '')"/>-->
                <xsl:variable name="currentElPunc" select="count(tokenize($currentText, '\.\.\.')) -1"/>
<!--                <xsl:variable name="previousElPunc" select="count(tokenize($previousText, '\.\.\.')) -1"/>-->
                
                <xsl:variable name="previousElPunc">
                    <xsl:value-of select="sum(
                        for $prev in preceding-sibling::undertale 
                        return count(tokenize(string-join($prev//p, ''), '\.\.\.')) - 1
                        )"/>
                </xsl:variable>
                
                <xsl:variable name="circumference" select="2 * 3.14159 * 150"/>
                <xsl:variable name="wedgeBuffer" select="$previousElPunc div $totalElPunc * 360"/>
                <xsl:variable name="wedge" select="$currentElPunc div $totalElPunc * 360"/>
                <xsl:variable name="position" select="((position()-1) mod count($colors) + 1)"/>
                
                <xsl:variable name="wedgeMid" select="$wedgeBuffer + ($wedge div 2)"/>
                <xsl:variable name="textRadius" select="450"/>
                <xsl:variable name="textX" select="600 + $textRadius * math:cos(($wedgeMid) * 3.14159 div 180)"/>
                <xsl:variable name="textY" select="450 + $textRadius * math:sin(($wedgeMid) * 3.14159 div 180)"/>
                
                
                <circle r="150" cx="50%" cy="50%" fill="transparent"
                    stroke="{$colors[$position]}"
                    stroke-width="300"
                    stroke-dasharray="{$currentElPunc div $totalElPunc * $circumference} {($totalElPunc - $currentElPunc) div $totalElPunc * $circumference}"
                    transform="rotate({$wedgeBuffer})"
                    transform-origin="50% 50%"/>
                
                
                <text x="{$textX}" y="{$textY}" 
                    text-anchor="middle" 
                    font-size="1.5rem" 
                    font-weight="bold"
                    fill="{$colors[$position]}">
                    <xsl:value-of select="@file"/>
                </text>
                
                <!-- Count label -->
                <text x="{$textX}" y="{$textY + 25}" 
                    text-anchor="middle" 
                    font-size="1.25rem"
                    fill="{$colors[$position]}">
                    <xsl:value-of select="$currentElPunc"/>
                </text>
            </xsl:for-each>
        </svg>
    </xsl:template>
</xsl:stylesheet>


<!--Punctuation distribution should go on histogram-->
<!--//act => count()-->
<!--//act[descendant::p[contains(text(), "...")]] => count()-->
<!--These count the ACTS not the individual uses...-->
<!--"A Sample of Punctuation Patterns in Undertale's Dialogue"-->