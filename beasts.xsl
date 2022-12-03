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
                <title>Behrend Travel Letters</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="beast.css"/>
                
            </head>
            <body>
                <h1><xsl:apply-templates select="$poemColl//bookTitle"/></h1>
                <section id="toc">
                    <h2>Table of Contents</h2>
                    
                    <table> 
                        <tr>
                            <th>Title</th>
                            <th>Unnamed Colume 2</th>
                            <th>Unnamed Colume 3</th>
                        </tr>
                    </table>
                </section>
                
                <section id="fulltext">
                    <xsl:apply-templates select="$poemColl//root"/>
                    
                </section>
                <section id="copyright">
                    <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="GNU Public License e" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />
                </section>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>