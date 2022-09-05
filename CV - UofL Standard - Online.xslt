
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
       <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text"
          select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="bold-and-underline-me">
    <xsl:param name="pText"/>

    <xsl:choose>
      <xsl:when test="contains($pText, 'Kyle B. Brothers')"><xsl:value-of select="substring-before($pText, 'Kyle B. Brothers')" /><b><u>Kyle B. Brothers</u></b><xsl:call-template name="bold-and-underline-me"><xsl:with-param name="pText" select="substring-after($pText, 'Kyle B. Brothers')" /></xsl:call-template></xsl:when>
      <xsl:when test="contains($pText, 'Kyle Brothers')"><xsl:value-of select="substring-before($pText, 'Kyle Brothers')" /><b><u>Kyle Brothers</u></b><xsl:call-template name="bold-and-underline-me"><xsl:with-param name="pText" select="substring-after($pText, 'Kyle Brothers')" /></xsl:call-template></xsl:when>
      <xsl:when test="contains($pText, 'Brothers KB')"><xsl:value-of select="substring-before($pText, 'Brothers KB')" /><b><u>Brothers KB</u></b><xsl:call-template name="bold-and-underline-me"><xsl:with-param name="pText" select="substring-after($pText, 'Brothers KB')" /></xsl:call-template></xsl:when>
      <xsl:when test="contains($pText, ',')"><xsl:if test="string-length(substring-after($pText, ',')) = 0"><xsl:value-of select="substring-before($pText, ',')" /></xsl:if><xsl:if test="string-length(substring-after($pText, ',')) != 0"><xsl:value-of select="substring-before($pText, ',')" />, <xsl:call-template name="bold-and-underline-me"><xsl:with-param name="pText" select="substring-after($pText, ',')" /></xsl:call-template></xsl:if></xsl:when><xsl:otherwise><xsl:value-of select="$pText" /></xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="get-month-abbreviation">
    <xsl:param name="month"/>

    <xsl:choose>
      <xsl:when test="$month = 1">Jan</xsl:when>
      <xsl:when test="$month = 2">Feb</xsl:when>
      <xsl:when test="$month = 3">Mar</xsl:when>
      <xsl:when test="$month = 4">Apr</xsl:when>
      <xsl:when test="$month = 5">May</xsl:when>
      <xsl:when test="$month = 6">Jun</xsl:when>
      <xsl:when test="$month = 7">Jul</xsl:when>
      <xsl:when test="$month = 8">Aug</xsl:when>
      <xsl:when test="$month = 9">Sep</xsl:when>
      <xsl:when test="$month = 10">Oct</xsl:when>
      <xsl:when test="$month = 11">Nov</xsl:when>
      <xsl:when test="$month = 12">Dec</xsl:when>
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
        <xsl:value-of select="Field[@Name='Date Updated']"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>


  <xsl:template match="Category">
          

        <h2>Peer-Reviewed Publications:</h2>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and .='Print']])>0">
          <h3>Original Research Articles:</h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and .='Print']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Review'] and Field[@Name='Publication Status' and .='Print']])>0">
          <h3>Review Articles:</h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Review'] and Field[@Name='Publication Status' and .='Print']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
          </xsl:template>

  <xsl:template match="Page">
    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template match="Template[Field[@Name='Event Section' and .='Publications']]">
    <table>
      <tr>
    <xsl:value-of select="position()" />.<xsl:if test="Field[@Name='Authors']"><xsl:apply-templates select="Field[@Name='Authors']"/>. </xsl:if>
            <xsl:if test="Field[@Name='Title']"><xsl:apply-templates select="Field[@Name='Title']"/>. </xsl:if>
            <xsl:if test="Field[@Name='Organization/Committee/Department/Journal Name']" ><i><xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>. </i></xsl:if>
            <xsl:if test="Field[@Name='Event Date']" ><xsl:value-of select="substring(Field[@Name='Event Date'], 1, 4)" /></xsl:if>
            <xsl:if test="Field[@Name='Volume Number']" >; <xsl:apply-templates select="Field[@Name='Volume Number']"/><xsl:if test="Field[@Name='Issue Number']" > (<xsl:apply-templates select="Field[@Name='Issue Number']"/>) </xsl:if></xsl:if>
            <xsl:if test="Field[@Name='Page Numbers']">: <xsl:apply-templates select="Field[@Name='Page Numbers']"/></xsl:if>.
            <xsl:if test="Field[@Name='CVDescription']" >
              <br/>
              <i><xsl:apply-templates select="Field[@Name='CVDescription']"/></i>
            </xsl:if>
        </tr>
      </table>
        </xsl:template>

  <!--Custom Section Templates that will be reused in multiple "Template" blocks-->

  <!--Note: This date_listing template can only be called from a template for "Template" blocks-->
  <xsl:template name="date_listing">
    <xsl:if test="Field[@Name='Event Start Date']" >
      <xsl:apply-templates select="Field[@Name='Event Start Date']"/> -
      <xsl:if test="not(Field[@Name='Event End Date'])" >
        Present
      </xsl:if>
      <xsl:if test="Field[@Name='Event End Date'] != ''">
        <xsl:apply-templates select="Field[@Name='Event End Date']"/>
      </xsl:if>
    </xsl:if>
    <xsl:if test="not(Field[@Name='Event Start Date']) and not(Field[@Name='Event End Date']) and Field[@Name='Event Date'] != ''">
      <xsl:apply-templates select="Field[@Name='Event Date']"/>
    </xsl:if>
  </xsl:template>



  <!--Templates for "Field" blocks-->

  <xsl:template match="Field[@Name = 'Event Date' or @Name = 'Event Start Date' or @Name = 'Expiration Date' or @Name = 'Also Published Date']">
    <xsl:call-template name="get-month-abbreviation">
      <xsl:with-param name="month" select="substring(., 6, 2)" />
    </xsl:call-template>
    <xsl:value-of select="concat(' ', substring(., 1, 4))" />
  </xsl:template>

  <xsl:template match="Field[@Name = 'Event End Date']">
    <xsl:if test="concat(substring($LatestUpdate, 1, 4), substring($LatestUpdate, 6, 2))>concat(substring(., 1, 4),substring(., 6, 2))">
      <xsl:call-template name="get-month-abbreviation">
        <xsl:with-param name="month" select="substring(., 6, 2)" />
      </xsl:call-template>
      <xsl:value-of select="concat(' ', substring(., 1, 4))" />
    </xsl:if>
    <xsl:if test="concat(substring(.,1,4),substring(.,6,2))>concat(substring($LatestUpdate,1,4),substring($LatestUpdate,6,2))">
      (<xsl:call-template name="get-month-abbreviation">
        <xsl:with-param name="month" select="substring(., 6, 2)" />
      </xsl:call-template>
      <xsl:value-of select="concat(' ', substring(., 1, 4))" />)
    </xsl:if>
  </xsl:template>

  <xsl:template match="Field[@Name = 'Grant PI' or @Name = 'Authors']">
    <xsl:call-template name="bold-and-underline-me">
      <xsl:with-param name="pText">
        <xsl:value-of select="."/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

    
</xsl:stylesheet>
