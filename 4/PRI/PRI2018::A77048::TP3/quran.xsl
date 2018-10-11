<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:result-document href="quran/index.html">
            <html>
                <head>
                    <meta charset="UTF-8"/>                    
                </head>
                <body>
                    <h1>The Quran</h1>
                    <hr/>
                    <xsl:apply-templates select="/tstmt/coverpg"/>
                    <hr/>
                    <xsl:apply-templates select="/tstmt/titlepg"/>
                    <hr/>
                    <xsl:apply-templates select="/tstmt/preface"/>
                    <hr/>
                    <h4>Index:</h4>
                    <xsl:apply-templates mode="indice" select="/tstmt/suracoll/sura">
                        <xsl:sort select="count(preceding-sibling::*)+1"/>
                    </xsl:apply-templates>
                </body>
            </html>
        </xsl:result-document>
        <xsl:apply-templates/> <!-- Geração das páginas individuais -->
    </xsl:template>
    
    <xsl:template match="coverpg">
        <h4><xsl:value-of select="title2"/></h4>
        <xsl:apply-templates select="subtitle/p"/>
    </xsl:template>
    
    <xsl:template match="p">
        <li><xsl:value-of select="."/></li>
    </xsl:template>
    
    <xsl:template match="titlepg">
        <h4><xsl:value-of select="title"/></h4>
        <p><xsl:value-of select="subtitle/p"/></p>
    </xsl:template>
    
    <xsl:template match="preface">
        <h4><xsl:value-of select="ptitle"/></h4>
        <xsl:apply-templates select="p"/>
    </xsl:template>
    
    <xsl:template match="sura" mode="indice">
        <li>
            <a href="sura{count(preceding-sibling::*)+1}.html">
                <xsl:value-of select="bktlong"/>
            </a>
        </li>
    </xsl:template>
    
    <xsl:template match="sura">
        <xsl:result-document href="quran/sura{count(preceding-sibling::*)+1}.html">
            <html>
                <head>
                    <meta charset="UTF-8"/>                    
                </head>
                <body>
                    <h1><xsl:value-of select="bktlong"/></h1>
                    [<a href="index.html">Voltar ao índice</a>]
                    <hr/>
                    <h4><xsl:value-of select="bktshort"/></h4>
                    <xsl:apply-templates select="v"/>
                    <p>
                    </p>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template> 
    
    <xsl:template match="v">
        <p><xsl:value-of select="."/></p>
    </xsl:template>
    
</xsl:stylesheet>