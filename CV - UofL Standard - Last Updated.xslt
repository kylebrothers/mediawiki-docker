<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <xsl:template name="get-month-abbreviation">
    <xsl:param name="month"/>

    <xsl:choose>
      <xsl:when test="$month = 1">January</xsl:when>
      <xsl:when test="$month = 2">February</xsl:when>
      <xsl:when test="$month = 3">March</xsl:when>
      <xsl:when test="$month = 4">April</xsl:when>
      <xsl:when test="$month = 5">May</xsl:when>
      <xsl:when test="$month = 6">June</xsl:when>
      <xsl:when test="$month = 7">July</xsl:when>
      <xsl:when test="$month = 8">August</xsl:when>
      <xsl:when test="$month = 9">September</xsl:when>
      <xsl:when test="$month = 10">October</xsl:when>
      <xsl:when test="$month = 11">November</xsl:when>
      <xsl:when test="$month = 12">December</xsl:when>
      <xsl:otherwise>
        error: <xsl:value-of select="$month"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:key name="educational-activities-by-learner-type" match="Template[Field[@Name='Learner Type']]" use="Field[@Name='Learner Type']"/>
  <xsl:key name="grants-by-grant-status" match="Template[Field[@Name='Grant Status']]" use="Field[@Name='Grant Status']"/>

  <xsl:variable name = "LatestUpdate">
    <xsl:for-each select="Pages/Category/Page/Template">
      <xsl:sort select="Field[@Name='Date Updated']" order="descending" />
      <xsl:if test="position() = 1">
        <xsl:call-template name="get-month-abbreviation">
          <xsl:with-param name="month" select="substring(Field[@Name='Date Updated'], 6, 2)" />
        </xsl:call-template>
        <xsl:value-of select="concat(' ', number(substring(Field[@Name='Date Updated'], 9, 2)))"/>
        <xsl:value-of select="concat(', ', substring(Field[@Name='Date Updated'], 1, 4))" />
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>


  <xsl:template match="Category">

    <html>
      <head>
      </head>

      <body>
        <xsl:value-of select="$LatestUpdate"/>
      </body>

    </html>
  </xsl:template>

  <xsl:template match="Page">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
