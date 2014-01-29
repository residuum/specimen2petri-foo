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
					<xsl:element name="Amplitude">
						<xsl:attribute name="level"><xsl:value-of select="volume"/></xsl:attribute>
						<xsl:attribute name="velocity_sensing"><xsl:value-of select="volume_vel_amt"/></xsl:attribute>
						<xsl:attribute name="key_tracking">0,000000</xsl:attribute>
						<Mod1 source="CC 7 - Channel Volume" amount="1,000000"/>
						<Mod2 source="OFF" amount="0,000000"/>
						<Env source="EG1"/>
					</xsl:element>
					<xsl:element name="Pan">
						<xsl:attribute name="level"><xsl:value-of select="pan"/></xsl:attribute>
						<xsl:attribute name="velocity_sensing"><xsl:value-of select="panning_vel_amt"/></xsl:attribute>
						<xsl:attribute name="key_tracking">0,000000</xsl:attribute>
						<Mod1 source="CC 10 - Pan" amount="1,000000"/>
						<Mod2 source="OFF" amount="0,000000"/>
						<Mod3 source="OFF" amount="0,000000"/>
					</xsl:element>
					<xsl:element name="Pitch">
						<xsl:attribute name="level"><xsl:value-of select="pitch"/></xsl:attribute>
						<xsl:attribute name="tuning_range"><xsl:value-of select="pitch_steps"/></xsl:attribute>
						<xsl:attribute name="velocity_sensing"><xsl:value-of select="pitch_vel_amt"/></xsl:attribute>
						<xsl:attribute name="key_tracking">0,000000</xsl:attribute>
						<Mod1 source="Pitch Wheel" amount="1,000000"/>
						<Mod2 source="OFF" amount="0,000000"/>
						<Mod3 source="OFF" amount="0,000000"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</Petri-Foo-Dish>
	</xsl:template>
</xsl:stylesheet>
