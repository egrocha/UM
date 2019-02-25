<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="prizes/*"/>
        
        <xsl:apply-templates select="//element"/>
    </xsl:template>
    
    <xsl:template match="prizes/*">
        <xsl:variable name="prizeID" select="@id"/>
        
        ###  http://prc.di.uminho.pt/2019/prize#<xsl:value-of select="@id"/>
        :<xsl:value-of select="@id"/> rdf:type owl:NamedIndividual , :<xsl:value-of select="name(.)"/> ;
        :category "<xsl:value-of select="category"/>" ;
        :year "<xsl:value-of select="year"/>" ;
        <xsl:choose>
            <xsl:when test="overallMotivation"> 
                :overallMotivation <xsl:value-of select="overallMotivation"/>  .
            </xsl:when>
            <xsl:otherwise> 
                :overallMotivation "" .
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:for-each select="laureates/element">
            :<xsl:value-of select="$prizeID"/> :hasLaureate :<xsl:value-of select="@id"/> .
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="element">
        :<xsl:value-of select="@id"/> rdf:type owl:NamedIndividual, :Element ;
        :firstname "<xsl:value-of select="firstname"/>" ;
        :surname "<xsl:value-of select="surname"/>" ;
        <xsl:choose>
            <xsl:when test="motivation"> 
                :motivation <xsl:value-of select="motivation"/>  ;
            </xsl:when>
            <xsl:otherwise> 
                :motivation "" ;
            </xsl:otherwise>
        </xsl:choose>
        :share "<xsl:value-of select="share"/>" ;
        :id <xsl:value-of select="id"/> .
    </xsl:template>
    
</xsl:stylesheet>