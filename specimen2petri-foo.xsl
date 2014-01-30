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
						<xsl:attribute name="file"><xsl:value-of select="file"/></xsl:attribute>
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
					<Lowpass>
						<Cutoff value="0,500000" velocity_sensing="0,000000" key_tracking="0,000000">
							<Mod1 source="CC 74 - Brightness" amount="1,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
							<Mod3 source="OFF" amount="0,000000"/>
						</Cutoff>
						<Resonance amount="0,000000" velocity_sensing="0,000000" key_tracking="0,000000">
							<Mod1 source="CC 71 - Timbre" amount="0,975000"/>
							<Mod2 source="OFF" amount="0,000000"/>
							<Mod3 source="OFF" amount="0,000000"/>
						</Resonance>
					</Lowpass>
					<Voice cut="0" cut_by="0" monophonic="false">
						<Portamento active="true">
							<Mod source="CC 65 - Portamento On/Off" threshold="0,500000"/>
						</Portamento>
						<Portamento_time value="0,050000">
							<Mod source="CC 5 - Portamento Time" amount="1,000000"/>
						</Portamento_time>
						<Legato active="true">
							<Mod source="CC 68 - Legato On/Off" threshold="0,500000"/>
						</Legato>
					</Voice>
					<EG1 active="true" delay="0,000000" attack="0,005000" hold="0,000000" decay="0,000000" sustain="1,000000" release="0,375000" key_tracking="-0,990000"/>
					<EG2 active="false" delay="0,000000" attack="0,005000" hold="0,000000" decay="0,000000" sustain="1,000000" release="0,025000" key_tracking="0,000000"/>
					<EG3 active="false" delay="0,000000" attack="0,005000" hold="0,000000" decay="0,000000" sustain="1,000000" release="0,025000" key_tracking="0,000000"/>
					<EG4 active="false" delay="0,000000" attack="0,005000" hold="0,000000" decay="0,000000" sustain="1,000000" release="0,025000" key_tracking="0,000000"/>
					<EG5 active="false" delay="0,000000" attack="0,005000" hold="0,000000" decay="0,000000" sustain="1,000000" release="0,025000" key_tracking="0,000000"/>
					<VLFO1 active="true">
						<Frequency hrtz="9,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false" delay="0,000000" attack="0,000000">
							<Mod1 source="CC 1 - Mod Wheel" amount="1,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</VLFO1>
					<VLFO2 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false" delay="0,000000" attack="0,000000">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</VLFO2>
					<VLFO3 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false" delay="0,000000" attack="0,000000">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</VLFO3>
					<VLFO4 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false" delay="0,000000" attack="0,000000">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</VLFO4>
					<VLFO5 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false" delay="0,000000" attack="0,000000">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</VLFO5>
					<GLFO1 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</GLFO1>
					<GLFO2 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</GLFO2>
					<GLFO3 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</GLFO3>
					<GLFO4 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</GLFO4>
					<GLFO5 active="false">
						<Frequency hrtz="1,000000" beats="1,000000" sync="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Frequency>
						<Amplitude shape="Sine" positive="false">
							<Mod1 source="OFF" amount="0,000000"/>
							<Mod2 source="OFF" amount="0,000000"/>
						</Amplitude>
					</GLFO5>
				</xsl:element>
			</xsl:for-each>
		</Petri-Foo-Dish>
	</xsl:template>
</xsl:stylesheet>
