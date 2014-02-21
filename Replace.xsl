<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- here is the template that does the replacement -->
<xsl:template name="replaceCharsInString">
<xsl:param name="stringIn"/>
<xsl:param name="charsIn"/>
<xsl:param name="charsOut"/>
<xsl:choose>
<xsl:when test="contains($stringIn,$charsIn)">
<xsl:value-of select="concat(substring-before($stringIn,$charsIn),$charsOut)"/>
<xsl:call-template name="replaceCharsInString">
<xsl:with-param name="stringIn" select="substring-after($stringIn,$charsIn)"/>
<xsl:with-param name="charsIn" select="$charsIn"/>
<xsl:with-param name="charsOut" select="$charsOut"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$stringIn"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

	<xsl:template match='Record'>
		<linea>
	  		<xsl:attribute name="Pkey">
	    			<xsl:value-of select='Pk_clau' />
			</xsl:attribute>
		</linea>
		<xsl:for-each select='Detalle'>
			<linea>

<!-- pretend this is in a template -->
<xsl:variable name="myString" select='.'/>
<xsl:variable name="myNewString">
<xsl:call-template name="replaceCharsInString">
<xsl:with-param name="stringIn" select="string($myString)"/>
<xsl:with-param name="charsIn" select="'premio'"/>
<xsl:with-param name="charsOut" select="'YAMIL'"/>
</xsl:call-template>
</xsl:variable>
<xsl:variable name="myNewRealString" select="string($myNewString)"/>
<xsl:value-of select="string($myNewRealString)" />

			</linea>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
