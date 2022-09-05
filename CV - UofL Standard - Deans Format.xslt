<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


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
      <xsl:when test="contains($pText, 'Kyle B. Brothers')">
        <xsl:value-of select="substring-before($pText, 'Kyle B. Brothers')" />
        <b>
          <u>
            <text>Kyle B. Brothers</text>
          </u>
        </b>
        <xsl:call-template name="bold-and-underline-me">
          <xsl:with-param name="pText" select="substring-after($pText, 'Kyle B. Brothers')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($pText, 'Kyle Brothers')">
        <xsl:value-of select="substring-before($pText, 'Kyle Brothers')" />
        <b>
          <u>
            <text>Kyle Brothers</text>
          </u>
        </b>
        <xsl:call-template name="bold-and-underline-me">
          <xsl:with-param name="pText" select="substring-after($pText, 'Kyle Brothers')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($pText, 'Brothers KB')">
        <xsl:value-of select="substring-before($pText, 'Brothers KB')" />
        <b>
          <u>
            <text>Brothers KB</text>
          </u>
        </b>
        <xsl:call-template name="bold-and-underline-me">
          <xsl:with-param name="pText" select="substring-after($pText, 'Brothers KB')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($pText, ',')">
        <xsl:if test="string-length(substring-after($pText, ',')) = 0">
          <xsl:value-of select="substring-before($pText, ',')" />
        </xsl:if>
        <xsl:if test="string-length(substring-after($pText, ',')) != 0">
          <xsl:value-of select="substring-before($pText, ',')" />
          <text>,</text>
          <xsl:call-template name="bold-and-underline-me">
            <xsl:with-param name="pText" select="substring-after($pText, ',')" />
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$pText" />
      </xsl:otherwise>
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

    <html>
      <head>
        <style type="text/css">
          body {
          color: black;
          font:12px;
          font-family: "Times New Roman", Times, serif; }
        </style>
        <style type="text/css">
          tbody {
          color: black;
          font:12px;
          font-family: "Times New Roman", Times, serif; }
        </style>
        <style type="txt/css">
          table {
          border="0"
          width="100%"
          align="left"
          cellpadding="0"
          cellspacing="0"; }
        </style>
        <style type="text/css">
          td {
          vertical-align:top; }
        </style>
        <style type="text/css">
          h1 {
          color: black;
          font:20px;
          font-family: "Times New Roman", Times, serif; }
        </style>
      </head>

      <body>

        <h1>
          EDUCATION
        </h1>
        <xsl:apply-templates select="Page/Template[Field='Education']">
          <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
        </xsl:apply-templates>
        <BR/>
        <h1>
          ACADEMIC APPOINTMENTS
        </h1>
        <xsl:apply-templates select="Page/Template[Field='Academic Appointments']">
          <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
        </xsl:apply-templates>
        <BR/>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Other Positions and Employment']])>0">
          <h1>
            OTHER POSITIONS AND EMPLOYMENT
          </h1>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Other Positions and Employment']]">
            <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
          </xsl:apply-templates>
          <BR/>
        </xsl:if>
        <h1>
          CERTIFICATION AND LICENSURE
        </h1>
        <xsl:apply-templates select="Page/Template[Field='Certification and Licensure']">
          <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
        </xsl:apply-templates>

        <BR/>
        <h1>
          PROFESSIONAL MEMBERSHIPS AND ACTIVITIES
        </h1>
        <xsl:apply-templates select="Page/Template[Field='Professional Memberships and Activities']">
          <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
        </xsl:apply-templates>
        <BR/>
        <h1>
          HONORS AND AWARDS
        </h1>
        <xsl:apply-templates select="Page/Template[Field='Honors and Awards']">
          <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
        </xsl:apply-templates>
        <BR/>
        <h1>
          COMMITTEE ASSIGNMENTS AND ADMINISTRATIVE SERVICES
        </h1>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Committee Assignments and Administrative Services'] and Field[@Name='Scope' and .='University']])>0">
          <h3>
            University (Intramural):
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Committee Assignments and Administrative Services'] and Field[@Name='Scope' and .='University']]">
            <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Committee Assignments and Administrative Services'] and Field[@Name='Scope' and .='Non-University']])>0">
          <h3>
            Non-University (Extramural):
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Committee Assignments and Administrative Services'] and Field[@Name='Scope' and .='Non-University']]">
            <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <BR/>
        <h1>
          EDUCATIONAL ACTIVITIES
        </h1>
        <xsl:for-each select="Page/Template[count(. | key('educational-activities-by-learner-type', Field[@Name='Learner Type'])[1]) = 1]">
          <xsl:if test="Field[@Name='Learner Type']" >
            <h2>
              <xsl:value-of select="Field[@Name='Learner Type']" />:
            </h2>
            <xsl:apply-templates select="key('educational-activities-by-learner-type', Field[@Name='Learner Type'])">
              <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
            </xsl:apply-templates>
          </xsl:if>
        </xsl:for-each>
        <BR/>
        <h1>
          CLINICAL ACTIVITIES
        </h1>
        <xsl:apply-templates select="Page/Template[Field='Clinical Activities']">
          <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
        </xsl:apply-templates>
        <BR/>
        <h1>
          GRANTS AND CONTRACTS
        </h1>
        <h2>
          GRANTS
        </h2>
        <h3>
          Current:
        </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Grants and Contracts'] and Field[@Name='Grant Status' and .='Current']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        <h3>
          Pending:
        </h3>
        <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Grants and Contracts'] and Field[@Name='Grant Status' and .='Pending']]">
          <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
        </xsl:apply-templates>
        <h3>
          Past:
        </h3>
        <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Grants and Contracts'] and Field[@Name='Grant Status' and .='Past']]">
          <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
        </xsl:apply-templates>
        <h3>
          Unfunded:
        </h3>
        <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Grants and Contracts'] and Field[@Name='Grant Status' and .='Unfunded']]">
          <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
        </xsl:apply-templates>
        <BR/>
        <h1>
          EDITORIAL WORK
        </h1>
        <xsl:apply-templates select="Page/Template[Field='Editorial Work']">
          <xsl:sort select="concat(substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9), substring(concat(Field[@Name='Event End Date'], '3000/01/01'), 1, 9))" order="ascending"/>
        </xsl:apply-templates>
        <BR/>
        <h1>
          ABSTRACTS AND PRESENTATIONS
        </h1>
        <h2>
          ORAL PRESENTATIONS
        </h2>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Oral'] and Field[@Name='Conference Scope' and (.='National' or .='International')]])>0">
          <h3>
            National/International Presentations:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Oral'] and Field[@Name='Conference Scope' and (.='National' or .='International')]]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Oral'] and Field[@Name='Conference Scope' and (.='Local' or .='Regional')]])>0">
          <h3>
            Local/Regional Presentations:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Oral'] and Field[@Name='Conference Scope' and (.='Local' or .='Regional')]]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <h2>
          POSTERS
        </h2>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Poster'] and Field[@Name='Conference Scope' and (.='National' or .='International')]])>0">
          <h3>
            National/International Presentations:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Poster'] and Field[@Name='Conference Scope' and (.='National' or .='International')]]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Poster'] and Field[@Name='Conference Scope' and (.='Local' or .='Regional')]])>0">
          <h3>
            Local/Regional Presentations:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Abstracts and Presentations'] and Field[@Name='Presentation Type' and .='Poster'] and Field[@Name='Conference Scope' and (.='Local' or .='Regional')]]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <BR/>
        <h1>
          PUBLICATIONS
        </h1>
        <h2>
          PEER-REVIEWED
        </h2>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and .='Print'] and Field[@Name='Author Role' and (.='Senior Author' or .='First Author')]])>0">
          <h3>
            Original Research Articles, Major Author:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and .='Print'] and Field[@Name='Author Role' and (.='Senior Author' or .='First Author')]]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and .='Print'] and Field[@Name='Author Role' and .='Co-Author']])>0">
          <h3>
            Original Research Articles, Co-Author:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and .='Print'] and Field[@Name='Author Role' and .='Co-Author']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Review'] and Field[@Name='Publication Status' and .='Print']])>0">
          <h3>
            Review Articles:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Review'] and Field[@Name='Publication Status' and .='Print']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and (.='Accepted' or .='In Press' or .='Online AHOP')]])>0">
          <h3>
            Journal Articles In Press:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR/Original'] and Field[@Name='Publication Status' and (.='Accepted' or .='In Press' or .='Online AHOP')]]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR Book/Chapter/Monograph']])>0">
          <h3>
            Books, Book Chapters, and Monographs:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='PR Book/Chapter/Monograph']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <h2>
          NON-PEER-REVIEWED
        </h2>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='Non-PR/Original']])>0">
          <h3>
            Original Research Articles:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='Non-PR/Original']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='Non-PR/Review']])>0">
          <h3>
            Review Articles:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='Non-PR/Review']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='Non-PR Book/Chapter/Monograph']])>0">
          <h3>
            Books, Book Chapters, and Monographs:
          </h3>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and .='Non-PR Book/Chapter/Monograph']]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="count(Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and (.='Educational Materials' or .='Non-Print')]])>0">
          <h2>
            DEVELOPMENT AND/OR PUBLICATION:
          </h2>
          <xsl:apply-templates select="Page/Template[Field[@Name='Event Section' and .='Publications'] and Field[@Name='Publication Type' and  (.='Educational Materials' or .='Non-Print')]]">
            <xsl:sort select="substring(concat(Field[@Name='Event Start Date'], Field[@Name='Event Date']), 1, 9)" order="ascending"/>
          </xsl:apply-templates>
        </xsl:if>
      </body>

    </html>
  </xsl:template>

  <xsl:template match="Page">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Education']]">

    <br/>
    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>

            <xsl:if test="not(Field[@Name='Degree Honors'])">
              <!-- will be instantiated if Degree Honors not present -->
              <br/>
            </xsl:if>
            <xsl:if test="Field[@Name='Degree Honors'] != ''">
              <!-- will be instantiated if Degree Honors is present and has something in it -->
              <text>, </text>
              <i>
                <xsl:apply-templates select="Field[@Name='Degree Honors']"/>
              </i>
              <br/>
            </xsl:if>

            <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/><br/>

            <xsl:if test="not(Field[@Name='Major Area'])">
              <!-- will be instantiated if Major Area no present -->
            </xsl:if>
            <xsl:if test="Field[@Name='Major Area'] != ''">
              <!-- will be instantiated if Major Area is present and has something in it -->
              Major/Focus: <xsl:apply-templates select="Field[@Name='Major Area']"/>
              <br/>
            </xsl:if>

            <xsl:apply-templates select="Field[@Name='City']"/>,
            <xsl:apply-templates select="Field[@Name='State']"/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Academic Appointments']]">

    <br/>
    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>

            <br/>
            <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/><br/>
            <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/><br/>


            <xsl:apply-templates select="Field[@Name='City']"/>,
            <xsl:apply-templates select="Field[@Name='State']"/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Other Positions and Employment']]">

    <br/>
    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>

            <br/>
            <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/><br/>
            <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/><br/>


            <xsl:apply-templates select="Field[@Name='City']"/>,
            <xsl:apply-templates select="Field[@Name='State']"/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Certification and Licensure']]">

    <br/>
    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>

            <xsl:if test="Field[@Name='Organization/Committee/Department/Journal Name']" >
              <br/>
              <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='Expiration Date']" >
              <br/>
              <i>
                Expiration Date: <xsl:apply-templates select="Field[@Name='Expiration Date']"/>
              </i>
            </xsl:if>

            <xsl:if test="Field[@Name='CVDescription']" >
              <br/>
              <i>
                <xsl:apply-templates select="Field[@Name='CVDescription']"/>
              </i>
            </xsl:if>
            <br/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Professional Memberships and Activities']]">

    <br/>
    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>,
            <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
            <xsl:if test="Field[@Name='Expiration Date']" >
              <br/>
              <i>
                Expiration Date: <xsl:apply-templates select="Field[@Name='Expiration Date']"/>
              </i>
            </xsl:if>
            <xsl:if test="Field[@Name='Sections']" >
              <br/>
              <i>
                Sections: <xsl:apply-templates select="Field[@Name='Sections']"/>
              </i>
            </xsl:if>
          </td>

        </tr>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Honors and Awards']]">

    <br/>
    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>,
            <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Committee Assignments and Administrative Services']]">

    <br/>

    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>,
            <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/><br/>
            <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/><br/>

          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>


  <xsl:template match="Template[Field[@Name='Event Section' and .='Educational Activities']]">

    <br/>

    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>
            <xsl:if test="Field[@Name='Title']">
              <br/>
              <i>
                <xsl:apply-templates select="Field[@Name='Title']"/>
              </i>
            </xsl:if>

            <xsl:if test="Field[@Name='Organization/Committee/Department/Journal Name']" >
              <br/>
              <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='Institution/School/Hospital']" >
              <br/>
              <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='CVDescription']" >
              <br/>
              <i>
                <xsl:apply-templates select="Field[@Name='CVDescription']"/>
              </i>
            </xsl:if>

            <br/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Clinical Activities']]">

    <br/>

    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>

            <xsl:if test="Field[@Name='Organization/Committee/Department/Journal Name']" >
              <br/>
              <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='Institution/School/Hospital']" >
              <br/>
              <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='CVDescription']" >
              <br/>
              <i>
                <xsl:apply-templates select="Field[@Name='CVDescription']"/>
              </i>
            </xsl:if>

            <br/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Grants and Contracts']]">

    <br/>

    <table>

      <tbody>
        <tr>
          <td width="100%">
            <xsl:value-of select="position()" />.
            <i>
              <xsl:apply-templates select="Field[@Name='Title']"/>
            </i>
            <br />
            <xsl:if test="Field[@Name='Event Date'] and (Field[@Name='Grant Status'] = 'Pending')" >
              Application Submitted: <xsl:apply-templates select="Field[@Name='Event Date']"/>
              <br />
            </xsl:if>
            <xsl:if test="Field[@Name='Grant PI']" >
              PI: <xsl:apply-templates select="Field[@Name='Grant PI']"/>
            </xsl:if>
            <xsl:if test="Field[@Name='Role/Degree'] and not(Field[@Name='Role/Degree'] = 'Principal Investigator')" >
              <br />
              My Role: <xsl:apply-templates select="Field[@Name='Role/Degree']"/>
              <xsl:if test="Field[@Name='Grant Percent Effort']" >
                (<xsl:value-of select="Field[@Name='Grant Percent Effort']"/>% effort)
              </xsl:if>
            </xsl:if>
            <br />
            Granting Agency: <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
            <xsl:if test="Field[@Name='Funder Grant Number'] and not(Field[@Name='Grant Status' and (.='Pending' or .='Unfunded')])" >
              <br />
              Funder Grant Number: <xsl:apply-templates select="Field[@Name='Funder Grant Number']"/>
            </xsl:if>
            <xsl:if test="Field[@Name='Funder Grant Number'] and Field[@Name='Grant Status' and (.='Pending' or .='Unfunded')]" >
              <br />
              Funding Mechanism: <xsl:apply-templates select="Field[@Name='Funder Grant Number']"/>
            </xsl:if>
            <xsl:if test="Field[@Name='UofL Office of Grants Management Number']" >
              <br />
              UofL Office of Grants Management Number: <xsl:apply-templates select="Field[@Name='UofL Office of Grants Management Number']"/>
            </xsl:if>
            <xsl:if test="Field[@Name='Expiration Date']" >
              <br />
              Expiration Date: <xsl:apply-templates select="Field[@Name='Expiration Date']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='Grant Direct Costs']" >
              <br />
              Direct Costs: <xsl:apply-templates select="Field[@Name='Grant Direct Costs']"/>
              <xsl:if test="Field[@Name='Grant Indirect Costs']" >
                Indirect Costs: <xsl:apply-templates select="Field[@Name='Grant Indirect Costs']"/>
              </xsl:if>
            </xsl:if>
          
            <xsl:if test="Field[@Name='Event Start Date'] and not(Field[@Name='Grant Status'] = 'Unfunded')" >
              <br />
              Dates: <xsl:call-template name="date_listing"/>
            </xsl:if>
          
            <xsl:if test="Field[@Name='Event Start Date'] and Field[@Name='Grant Status'] = 'Unfunded'" >
              <br />
              Submission Date: <xsl:apply-templates select="Field[@Name='Event Start Date']"/>
            </xsl:if>

          </td>
        </tr>

        <xsl:if test="Field[@Name='CVDescription'] and not(Field[@Name='Grant Status' and (.='Past' or .='Unfunded')])" >
          <tr>
            <td width="100%">
              <i>
                <xsl:apply-templates select="Field[@Name='CVDescription']"/>
              </i>
            </td>
          </tr>
        </xsl:if>

      </tbody>
    </table>

  </xsl:template>
  <xsl:template match="Template[Field[@Name='Event Section' and .='Editorial Work']]">

    <br/>

    <table>

      <tbody>
        <tr>
          <td width="150">
            <xsl:call-template name="date_listing"/>
          </td>

          <td>
            <xsl:apply-templates select="Field[@Name='Role/Degree']"/>,
            <i>
              <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
            </i>

            <xsl:if test="Field[@Name='Institution/School/Hospital']" >
              <br/>
              <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='CVDescription']" >
              <br/>
              <i>
                <xsl:apply-templates select="Field[@Name='CVDescription']"/>
              </i>
            </xsl:if>

            <br/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Abstracts and Presentations']]">

    <br/>

    <table>

      <tbody>
        <tr>
          <td width="100%">
            <xsl:value-of select="position()" />.

            <xsl:if test="Field[@Name='Role/Degree']" >
              <xsl:apply-templates select="Field[@Name='Role/Degree']"/>
              <text>, </text>
            </xsl:if>

            <xsl:if test="Field[@Name='Institution/School/Hospital']" >
              <xsl:apply-templates select="Field[@Name='Institution/School/Hospital']"/>
              <xsl:if test="Field[@Name='Invited Talk Boolean'] and Field[@Name='Invited Talk Boolean'] = 'Yes'">
                <text> (*Invited Talk)</text>
              </xsl:if>
            </xsl:if>

            <xsl:if test="Field[@Name='Organization/Committee/Department/Journal Name']" >
              <br />
              Symposium/Panel Title:
              <i>
                <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>
              </i>
            </xsl:if>

            <xsl:if test="Field[@Name='Title']">
              <br/>
              Presentation Title:
              <i>
                <xsl:apply-templates select="Field[@Name='Title']"/>
              </i>
            </xsl:if>



            <xsl:if test="Field[@Name='Authors']">
              <br/>
              Authors:
              <xsl:apply-templates select="Field[@Name='Authors']"/>
            </xsl:if>
              <xsl:if test="Field[@Name='Presenter Boolean'] and Field[@Name='Presenter Boolean'] = 'Yes' and Field[@Name='Organizer Boolean'] and Field[@Name='Organizer Boolean'] = 'Yes'">
                <br />
                  Role: Presenting Author and *Organizing Presenter
              </xsl:if>
              <xsl:if test="Field[@Name='Presenter Boolean'] and Field[@Name='Presenter Boolean'] = 'No' and Field[@Name='Organizer Boolean'] and Field[@Name='Organizer Boolean'] = 'Yes'">
                <br />
                Role: *Organizing Presenter
              </xsl:if>
              <xsl:if test="Field[@Name='Presenter Boolean'] and Field[@Name='Presenter Boolean'] = 'Yes' and Field[@Name='Organizer Boolean'] and Field[@Name='Organizer Boolean'] = 'No'">
                <br />
                Role: Presenting Author
              </xsl:if>
              <xsl:if test="Field[@Name='Presenter Boolean'] and Field[@Name='Presenter Boolean'] = 'No' and Field[@Name='Organizer Boolean'] and Field[@Name='Organizer Boolean'] = 'No'">
                <br />
                Role: Non-Presenting Author
              </xsl:if>


            <br/>
            <xsl:apply-templates select="Field[@Name='Event Date']"/>

            <xsl:if test="Field[@Name='City']" >
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:apply-templates select="Field[@Name='City']"/>,
              <xsl:apply-templates select="Field[@Name='State']"/>
            </xsl:if>

            <xsl:if test="Field[@Name='CVDescription']" >
              <br/>
              <i>
                <xsl:apply-templates select="Field[@Name='CVDescription']"/>
              </i>
            </xsl:if>

            <br/>
          </td>

        </tr>
      </tbody>
    </table>

  </xsl:template>

  <xsl:template match="Template[Field[@Name='Event Section' and .='Publications']]">
    <br/>

    <table>

      <tbody>
        <tr>
          <td width="100%">
            <xsl:value-of select="position()" />.

            <xsl:if test="Field[@Name='Authors']">
              <xsl:apply-templates select="Field[@Name='Authors']"/>.
            </xsl:if>

            <xsl:if test="Field[@Name='Title']">
              <xsl:apply-templates select="Field[@Name='Title']"/>.
            </xsl:if>

            <xsl:if test="Field[@Name='Organization/Committee/Department/Journal Name']" >
              <i>
                <xsl:apply-templates select="Field[@Name='Organization/Committee/Department/Journal Name']"/>.
              </i>
            </xsl:if>

            <xsl:if test="Field[@Name='Event Date']" >
              <xsl:value-of select="substring(Field[@Name='Event Date'], 1, 4)" />
              
            </xsl:if>

            <xsl:if test="Field[@Name='Volume Number']" >
              <text>; </text>
              <xsl:apply-templates select="Field[@Name='Volume Number']"/>
              <xsl:if test="Field[@Name='Issue Number']" >
                (<xsl:apply-templates select="Field[@Name='Issue Number']"/>
                <text>)</text>
              </xsl:if>
            </xsl:if>

            <xsl:if test="Field[@Name='Page Numbers']">
              <text>: </text>
              <xsl:apply-templates select="Field[@Name='Page Numbers']"/>
            </xsl:if>
            <text>.</text>

            <xsl:if test="Field[@Name='CVDescription']" >
              <br/>
              <i>
                <xsl:apply-templates select="Field[@Name='CVDescription']"/>
              </i>
            </xsl:if>

            <br/>
          </td>

        </tr>
      </tbody>
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

  <!--This template matches any blocks formatted as text (including CVDescription) to insert line breaks
  note that this will not be applied automatically if another custom template for that field
  is created above-->
  <xsl:template match="text()" name="insertBreaks">
    <xsl:param name="pText" select="."/>

    <xsl:choose>
      <xsl:when test="not(contains($pText, '&#xA;'))">
        <xsl:copy-of select="$pText"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-before($pText, '&#xA;')"/>
        <br />
        <xsl:call-template name="insertBreaks">
          <xsl:with-param name="pText" select=
           "substring-after($pText, '&#xA;')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



</xsl:stylesheet>
