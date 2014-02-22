<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Template de funcion que hace el reemplazo de strings -->
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
		<!-- Inicializacion de variables  -->
			<!-- 1) Lectura ID clausula  -->
			<xsl:variable name="Pkey" select='Pk_clau'/>
			<!-- 2) Concatenacion de string de inicio: <claus:linea Pkey="#" > -->
			<xsl:variable name="Inicio" select="concat('&lt;claus:linea Pkey=&#x22;',string($Pkey),'&#x22; &gt;')"/>
			<!-- 3) Concatenacion de string de cierre: </claus:linea> -->
			<xsl:variable name="Fin" select="'&lt;/claus:linea&gt;&#xa;'"/>
		<!-- Fin inicializacion  -->
		<!-- Mostramos la primer linea que es el titulo leido de detclau con su correspondiente pk -->
		<xsl:value-of select='string($Inicio)' />
		<xsl:value-of select='Detclau'/>
		<xsl:value-of select='string($Fin)' />
		<!-- Fin primer linea -->
		<!-- Luego mostramos lo correspondiente al campo detalle-->
		<xsl:value-of select='string($Inicio)' />
			<!-- Luego del titulo, recorremos en forma de bucle, aunque por ahora es un solo campo -->
			<xsl:for-each select='Detalle'>
				<!-- Llamado a funcion para reemplazar string, . = contenido actual de Detalle -->
				<xsl:variable name="myString" select='.'/>
				<xsl:variable name="myNewString">
					<xsl:call-template name="replaceCharsInString">
						<!-- Primer parametro, string leido a modificar -->
						<xsl:with-param name="stringIn" select="string($myString)"/>
						<!-- Segundo parametro, string a buscar: . + &#xa=LF -->
						<xsl:with-param name="charsIn" select="'.&#xa;'"/>
						<!-- Tercer parametro, concatenacion de string: .</linea>\n<linea Pkey="#" />  -->
						<xsl:with-param name="charsOut" select="concat(string($Fin),string($Inicio))"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="myNewRealString" select="string($myNewString)"/>
				<xsl:value-of select="string($myNewRealString)" />
				<!-- Fin funcion para reemplazar string -->
			</xsl:for-each>
		<xsl:value-of select='string($Fin)' />
	</xsl:template>
</xsl:stylesheet>
