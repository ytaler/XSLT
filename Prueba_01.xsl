<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match='/'>
<html> 
   <head><title>Generado con tienda-html.xsl</title></head>
   <body>
      <h1> <xsl:apply-templates /> </h1>
   </body>
</html>
</xsl:template>
</xsl:stylesheet>
