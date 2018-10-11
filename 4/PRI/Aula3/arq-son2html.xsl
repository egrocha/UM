<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">

    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:result-document href="arq-son/index.html">
            <html>
                <head>
                    <meta charset="UTF-8"/>                    
                </head>
                <body>
                    <h1>Arquivo Sonoro de Ernesto Veiga de Oliveira</h1>
                    <hr/>
                    <xsl:apply-templates mode="indice" select="/arq/doc">
                        <xsl:sort select="tit"/>
                    </xsl:apply-templates>
                </body>
            </html>
        </xsl:result-document>
        <xsl:apply-templates/> <!-- Geração das páginas individuais -->
    </xsl:template>
    
    <xsl:template match="doc" mode="indice">
        <li>
            <a href="doc{count(preceding-sibling::*)+1}.html">
                <xsl:value-of select="tit"/>
            </a>    
        </li>
    </xsl:template>
    
    <xsl:template match="doc">
        <xsl:result-document href="arq-son/doc{count(preceding-sibling::*)+1}.html">
            <html>
                <head>
                    <meta charset="UTF-8"/>                    
                </head>
                <body>
                    <h1><xsl:value-of select="tit"/></h1>
                    <hr/>
                    <table border="1">
                        <tr>
                            <td>Província:</td>
                            <td><xsl:value-of select="prov"/></td>
                        </tr>
                        <tr>
                            <td>Local:</td>
                            <td><xsl:value-of select="local"/></td>
                        </tr>
                        <tr>
                            <td>Música:</td>
                            <td><xsl:value-of select="musica"/></td>
                        </tr>
                    </table>
                    <p>
                        [<a href="index.html">Voltar ao índice</a>]
                    </p>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>   
</xsl:stylesheet>