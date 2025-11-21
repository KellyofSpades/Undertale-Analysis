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
                <h1>Behrend's Travel Adventures</h1>
                <section id="toc">
                    <h2>Contents</h2>
                    <table>
                        <tr>
                            <th>Letter Date</th><!--first column table heading-->
                            <th>People Mentioned</th><!--second column table heading-->
                            <th>Number of People</th>
                            <th>Places Mentioned</th><!--third column table heading-->
                            <th>Number of Places</th>
                        </tr>
                        
                        <!--ebb: Here we use our $travelColl variable pointing into the collection. -->
                        <xsl:apply-templates select="$travelColl//letter" mode="toc">
                            <xsl:sort select="(descendant::date/@when)[1] ! xs:date(.)"/>
                        </xsl:apply-templates>
                        <!-- ebb: Notice how we open up xsl:apply-templates to apply xsl:sort. 
                            This sorts the files in the collection based on the
                      very first available @when on a date element. We convert it to xs:date to be sure
                      that XSLT sorts it as the proper datatype. 
                      -->
                        
                    </table>
                </section>

                <section id="fulltext">
                    <h2 style="text-align: center;">Full Text</h2>
                    <xsl:apply-templates select="$travelColl//letter">
                        <xsl:sort select="(descendant::date/@when)[1]"/>
                    </xsl:apply-templates>
                </section>
            </body>
        </html>
    </xsl:template>
    
    <!-- ************************************************* -->
    <!-- ebb: TOC mode templates for the table of contents -->
    <!-- ************************************************* -->
   
   <xsl:template match="letter" mode="toc">
       <tr>
           <td><a href="#{substring-before(//headLine, ' ')}"><xsl:apply-templates select="descendant::headLine"/></a></td><!--first column data cell: to hold the date of the letter-->
           <td><xsl:apply-templates select="string-join(descendant::person, ', ')"/></td><!--second column data cell: to hold a sorted, string-joined list of persons mentioned. -->
           <td style="text-align: center;"><xsl:apply-templates select="count(descendant::person)"/></td>
           <td><xsl:apply-templates select="string-join(descendant::location, ', ')"/></td><!--third column data cell: to hold a sorted, string-joined list of locations mentioned.-->
           <td style="text-align: center;"><xsl:apply-templates select="count(descendant::location)"/></td>
       </tr>
   </xsl:template>
    


    <!-- ************************************************* -->
    <!-- ebb: templates for outputting the text of the letters -->
    <!-- ************************************************* -->
    
    <xsl:template match="letter">
        <section class="readingView" id="{substring-before(//headLine, ' ')}">
            <h3><xsl:apply-templates select="descendant::headLine"/></h3>
            <p>
                <xsl:apply-templates/>
            </p>
        </section>
        
    </xsl:template>

</xsl:stylesheet>
