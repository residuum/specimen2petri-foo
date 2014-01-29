<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:template match="child::beef">
		<Petri-Foo-Dish save-type="basic">
			<Master level="0,700000" samplerate="44100"/>
			<xsl:for-each select="patch">
				<xsl:element name="Patch">
					<xsl:attribute name="name">
						<xsl:value-of select="name"/>
					</xsl:attribute>
					<xsl:attribute name="mode">
						<xsl:choose>
							<xsl:when test="floor(play_mode div 32) &gt; 0">pingpong</xsl:when>
							<xsl:when test="floor(play_mode div 16) &gt; 0">loop</xsl:when>
							<xsl:when test="floor(play_mode div 8) &gt; 0">trim</xsl:when>
							<xsl:when test="floor(play_mode div 4) &gt; 0">singleshot</xsl:when>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="reverse">
						<xsl:choose>
							<xsl:when test="play_mode mod 2 = 1">false</xsl:when>
							<xsl:otherwise>true</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="to_end">false</xsl:attribute>
					<xsl:element name="Sample">
						<xsl:attribute name="name">Default</xsl:attribute>
						<xsl:attribute name="start"><xsl:value-of select="sample_start"/></xsl:attribute>
						<xsl:attribute name="stop"><xsl:value-of select="sample_stop"/></xsl:attribute>
						<xsl:attribute name="fade_samples">100</xsl:attribute>
						<xsl:element name="Loop">
							<xsl:attribute name="start"><xsl:value-of select="loop_start"/></xsl:attribute>
							<xsl:attribute name="stop"><xsl:value-of select="loop_stop"/></xsl:attribute>
							<xsl:attribute name="xfade_samples">0</xsl:attribute>
						</xsl:element>
						<xsl:element name="Note">
							<xsl:attribute name="root"><xsl:value-of select="note"/></xsl:attribute>
							<xsl:attribute name="lower"><xsl:value-of select="lower_note"/></xsl:attribute>
							<xsl:attribute name="upper"><xsl:value-of select="upper_note"/></xsl:attribute>
							<xsl:attribute name="velocity_lower">0</xsl:attribute>
							<xsl:attribute name="velocity_upper">127</xsl:attribute>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</Petri-Foo-Dish>
	</xsl:template>
</xsl:stylesheet>
