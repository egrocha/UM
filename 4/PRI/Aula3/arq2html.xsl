<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
            </head>
            <body>
                <h1>Arqueossítios do NW Português</h1>
                <table width="100%">
                    <tr>
                        <td width="20%" valign="top">
                            <h3><a name="indice"/>Índice</h3>
                            <ul>
                                <xsl:apply-templates mode="indice" select="/ARQSITS/ARQELEM">
                                    <xsl:sort select="IDENTI"/>
                                </xsl:apply-templates>
                            </ul>
                        </td>
                        <td width="80%">
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="text()" mode="indice" priority="-1"/>
    
    <xsl:template match="IDENTI" mode="indice">
        <li>
            <a href="#{generate-id()}">
                <xsl:value-of select="."/>
            </a>
        </li>
    </xsl:template>
  
    <xsl:template match="ARQELEM">
        <hr/>
        <h2>
            <a name="{generate-id(IDENTI)}">
                <xsl:value-of select="IDENTI"/>
            </a>
        </h2>
        <h3><xsl:value-of select="DESCRI"/></h3>
        <table border="1">
            <tr>
                <td>
                    Lugar:
                </td>
                <td>
                    <xsl:value-of select="LUGAR"/>
                </td>
            </tr>
            <tr>
                <td>
                    Freguesia:
                </td>
                <td>
                    <xsl:value-of select="FREGUE"/>
                </td>
            </tr>
            <tr>
                <td>
                    Concelho:
                </td>
                <td>
                    <xsl:value-of select="CONCEL"/>
                </td>
            </tr>
        </table>
        <p><xsl:value-of select="ACESSO"/></p>
        <p><xsl:value-of select="FREGUE"/></p>
        <p><xsl:value-of select="CONCEL"/></p>
        <h6>[<a href="#indice">Voltar ao índice</a>]</h6>
    </xsl:template>
    
</xsl:stylesheet>