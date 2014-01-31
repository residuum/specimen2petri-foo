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
					<xsl:element name="Sample">
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
						<xsl:attribute name="file"><xsl:value-of select="file"/></xsl:attribute>
						<xsl:element name="Play">
							<xsl:attribute name="start"><xsl:value-of select="sample_start"/></xsl:attribute>
							<xsl:attribute name="stop"><xsl:value-of select="sample_stop"/></xsl:attribute>
							<xsl:attribute name="fade_samples">100</xsl:attribute>
						</xsl:element>
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
						<xsl:choose>
							<xsl:when test="volume_env_on = 'yes'">
								<Env source="EG1"/>
							</xsl:when>
							<xsl:otherwise>
								<Env source="OFF"/>
							</xsl:otherwise>
						</xsl:choose>
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
						<xsl:element name="Portamento">
							<xsl:attribute name="active">
								<xsl:choose>
									<xsl:when test="portamento = 'yes'">true</xsl:when>
									<xsl:otherwise>false</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<Mod source="CC 65 - Portamento On/Off" threshold="0,500000"/>
						</xsl:element>
						<xsl:element name="Portamento_time">
							<xsl:attribute name="value"><xsl:value-of select="portamento_time"/>
							</xsl:attribute>
							<Mod source="CC 5 - Portamento Time" amount="1,000000"/>
						</xsl:element>
						<xsl:element name="Legato">
							<xsl:attribute name="active">
								<xsl:choose>
									<xsl:when test="legato = 'yes'">true</xsl:when>
									<xsl:otherwise>false</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<Mod source="CC 68 - Legato On/Off" threshold="0,500000"/>
						</xsl:element>
					</Voice>
					<xsl:element name="EG1">
						<xsl:attribute name="active">
							<xsl:choose>
								<xsl:when test="volume_env_on = 'yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="delay"><xsl:value-of select="volume_delay" /></xsl:attribute>
						<xsl:attribute name="attack"><xsl:value-of select="volume_a" /></xsl:attribute>
						<xsl:attribute name="hold"><xsl:value-of select="volume_hold" /></xsl:attribute>
						<xsl:attribute name="decay"><xsl:value-of select="volume_d" /></xsl:attribute>
						<xsl:attribute name="sustain"><xsl:value-of select="volume_s" /></xsl:attribute>
						<xsl:attribute name="release"><xsl:value-of select="volume_r" /></xsl:attribute>
						<xsl:attribute name="key_tracking"><xsl:value-of select="volume_amt" /></xsl:attribute>
					</xsl:element>
					<xsl:element name="EG2">
						<xsl:attribute name="active">
							<xsl:choose>
								<xsl:when test="panning_env_on = 'yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="delay"><xsl:value-of select="panning_delay" /></xsl:attribute>
						<xsl:attribute name="attack"><xsl:value-of select="panning_a" /></xsl:attribute>
						<xsl:attribute name="hold"><xsl:value-of select="panning_hold" /></xsl:attribute>
						<xsl:attribute name="decay"><xsl:value-of select="panning_d" /></xsl:attribute>
						<xsl:attribute name="sustain"><xsl:value-of select="panning_s" /></xsl:attribute>
						<xsl:attribute name="release"><xsl:value-of select="panning_r" /></xsl:attribute>
						<xsl:attribute name="key_tracking"><xsl:value-of select="panning_amt" /></xsl:attribute>
					</xsl:element>
					<xsl:element name="EG3">
						<xsl:attribute name="active">
							<xsl:choose>
								<xsl:when test="cutoff_env_on = 'yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="delay"><xsl:value-of select="cutoff_delay" /></xsl:attribute>
						<xsl:attribute name="attack"><xsl:value-of select="cutoff_a" /></xsl:attribute>
						<xsl:attribute name="hold"><xsl:value-of select="cutoff_hold" /></xsl:attribute>
						<xsl:attribute name="decay"><xsl:value-of select="cutoff_d" /></xsl:attribute>
						<xsl:attribute name="sustain"><xsl:value-of select="cutoff_s" /></xsl:attribute>
						<xsl:attribute name="release"><xsl:value-of select="cutoff_r" /></xsl:attribute>
						<xsl:attribute name="key_tracking"><xsl:value-of select="cutoff_amt" /></xsl:attribute>
					</xsl:element>
					<xsl:element name="EG4">
						<xsl:attribute name="active">
							<xsl:choose>
								<xsl:when test="resonance_env_on = 'yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="delay"><xsl:value-of select="resonance_delay" /></xsl:attribute>
						<xsl:attribute name="attack"><xsl:value-of select="resonance_a" /></xsl:attribute>
						<xsl:attribute name="hold"><xsl:value-of select="resonance_hold" /></xsl:attribute>
						<xsl:attribute name="decay"><xsl:value-of select="resonance_d" /></xsl:attribute>
						<xsl:attribute name="sustain"><xsl:value-of select="resonance_s" /></xsl:attribute>
						<xsl:attribute name="release"><xsl:value-of select="resonance_r" /></xsl:attribute>
						<xsl:attribute name="key_tracking"><xsl:value-of select="resonance_amt" /></xsl:attribute>
					</xsl:element>
					<xsl:element name="EG5">
						<xsl:attribute name="active">
							<xsl:choose>
								<xsl:when test="pitch_env_on = 'yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="delay"><xsl:value-of select="pitch_delay" /></xsl:attribute>
						<xsl:attribute name="attack"><xsl:value-of select="pitch_a" /></xsl:attribute>
						<xsl:attribute name="hold"><xsl:value-of select="pitch_hold" /></xsl:attribute>
						<xsl:attribute name="decay"><xsl:value-of select="pitch_d" /></xsl:attribute>
						<xsl:attribute name="sustain"><xsl:value-of select="pitch_s" /></xsl:attribute>
						<xsl:attribute name="release"><xsl:value-of select="pitch_r" /></xsl:attribute>
						<xsl:attribute name="key_tracking"><xsl:value-of select="pitch_amt" /></xsl:attribute>
					</xsl:element>
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
