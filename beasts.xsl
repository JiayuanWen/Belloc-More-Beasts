<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xhtml"
        html-version="5" 
        omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    <xsl:variable name="poemColl" 
        as="document-node()+" 
        select="collection('xml_document/?select=*.xml')"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>DIGIT 110 | <xsl:apply-templates select="$poemColl//bookTitle"/></title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="beast.css"/>
                
            </head>
            <body>
                <!-- Title -->
                <h1 id="top"><xsl:apply-templates select="$poemColl//bookTitle"/></h1>
                
                <!-- Table of Contents (Further implementation at ToC rules below) -->
                <section id="toc">
                    <h2>Table of Contents</h2>
                    <table> 
                        <tr>
                            <th>Title</th>
                            <th>Page</th>
                        </tr>
                        <xsl:apply-templates select="$poemColl//root" mode="toc">
                            
                        </xsl:apply-templates>
                    </table>
                </section>
                
                <!-- Text view -->
                <section id="fulltext">
                    <xsl:apply-templates select="$poemColl//root"/>
                </section>
                
                <!-- Creative Common print -->
                <section id="copyright">
                    <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="GNU Public License e" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />
                </section>
            </body>
        </html>
    </xsl:template>
    
    <!-- Text view rules -->
    <xsl:template match="root/pg/title"> <!-- <h1> on poem titles -->
        <h2><a href="#top"><xsl:apply-templates/></a></h2>
    </xsl:template>
    <xsl:template match="root/pg/lg"> <!-- Wrap every line group with <p> -->
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="root/pg/lg/l"> <!-- Line break after each line -->
        <xsl:apply-templates/><br/>
    </xsl:template>
    <xsl:template match="root/pg/pgNum"> <!-- Line break after page number to prevent content overlapping with that of next page-->
        <xsl:apply-templates/><br/><br/>
    </xsl:template>
    
    <!-- ToC rules-->
    <xsl:template match="root" mode="toc">
        <tr>
            <td class="table-title">
                <h2 id="#c-{count(preceding::root) + 1}">
                    <a href="#c-{count(preceding::root) + 1}"><xsl:apply-templates select="pg/title" mode="toc"/></a>
                </h2>
            </td>
            <td class="table-page">
                <xsl:apply-templates select="pg[1]/pgNum/@n => distinct-values() => sort() => string-join('')" mode="toc"/>
            </td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>